// $Id: $
// File name:   adder_16bit.sv
// Created:     1/28/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 16 bit adder wrapper for adder_nbit

module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);

	adder_nbit #(.BIT_WIDTH(16)) IX (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));

endmodule