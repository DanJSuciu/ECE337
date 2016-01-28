// $Id: $
// File name:   adder_8bit.sv
// Created:     1/27/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 8 bit adder instance of n bit adder

module adder_8bit
(
	input wire [7:0] a,
	input wire [7:0] b,
	input wire carry_in,
	output wire [7:0] sum,
	output wire overflow
);

	adder_nbit #(.BIT_WIDTH(8)) IX (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));

endmodule