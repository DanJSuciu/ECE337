// $Id: $
// File name:   sync_high.sv
// Created:     1/27/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: reset to high synchronizer
module sync_high
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output wire sync_out
);

reg signal;
reg signal2;
always_ff @ (posedge clk, negedge n_rst)
begin : flipflopblockhigh
	if(1'b0 == n_rst)
	begin
		signal <= 1; 
		signal2 <= 1;
	end
	else
	begin
		signal <= async_in;
		signal2 <= signal;
	end
end

assign sync_out = signal2;

endmodule