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

reg flag;
reg [(NUM_CNT_BITS-1):0] count;

always @ (posedge clk, negedge n_rst) begin
	if (n_rst == 0) begin
		count[(NUM_CNT_BITS-1):0] <= {NUM_CNT_BITS{1'b0}};
		flag <= 0;
	end else if (clear == 1) begin
 		count[(NUM_CNT_BITS-1):0] <= {NUM_CNT_BITS{1'b0}};
	end else begin
		if (count_enable == 1) begin
			if (count == rollover_val) begin
				flag <= 1;
			end else begin
				count <= count + 1;
			end
		end
	end
end

assign count_out[(NUM_CNT_BITS-1):0] = count[(NUM_CNT_BITS-1):0];
assign rollover_flag = flag;

endmodule