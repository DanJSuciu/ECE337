// $Id: $
// File name:   flex_counter.sv
// Created:     2/4/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flexible and scalable counter with rollover

module flex_counter
#(
	parameter NUM_CNT_BITS = 4
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [(NUM_CNT_BITS-1):0] rollover_val,
	output wire [(NUM_CNT_BITS-1):0] count_out,	
	output wire rollover_flag
);

reg [(NUM_CNT_BITS-1):0] count;
reg [(NUM_CNT_BITS-1):0] next_count;
reg flag;
reg nextflag;

always_ff @ (posedge clk, negedge n_rst)
begin
	if( n_rst == 0) begin
		count <= 0;
		flag <= 1'b0;     
	end else begin
		count <= next_count;
		flag <= nextflag;
	end
end

always_comb
begin
	if(clear == 1) begin
		next_count = 0;
		nextflag = 1'b0;
	end else begin 
		if(count_enable == 1) begin
			next_count = count + 1;
			nextflag = 1'b0;
			if(next_count == (rollover_val + 1))
				next_count = 1;
			if(next_count == rollover_val)
				nextflag = 1'b1;
		end else begin
			nextflag = flag;
			next_count = count;
		end      
	end
end
  
assign count_out = count;
assign rollover_flag = flag;

endmodule