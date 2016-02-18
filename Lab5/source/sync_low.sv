// $Id: $
// File name:   sync_low.sv
// Created:     1/27/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: reset to low logic synchronizer

module sync_low
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output wire sync_out
);

reg signal;
reg signal2;
always_ff @ (posedge clk, negedge n_rst)
begin : flipflopblocklow
	if(1'b0 == n_rst)
	begin
		signal <= 0; 
		signal2 <= 0;
	end
	else
	begin
		signal <= async_in;
		signal2 <= signal;
	end
end

assign sync_out = signal2;

endmodule