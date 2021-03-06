// $Id: $
// File name:   counter.sv
// Created:     2/16/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: counter
module counter
(
	input wire clk,
	input wire n_reset,
	input wire cnt_up,
	input wire clear,
	output wire one_k_samples
);

flex_counter #(10) COUNT
(
	.clk(clk),
	.n_rst(n_reset),
	.clear(clear),
	.count_enable(cnt_up),
	.rollover_val(10'b1111101000),
	.rollover_flag(one_k_samples)
);

endmodule