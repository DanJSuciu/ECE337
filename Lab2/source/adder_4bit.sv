// $Id: $
// File name:   adder_4bit.sv
// Created:     1/21/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 4 bit adder

module adder_4bit
(
	input wire [3:0] a,
	input wire [3:0] b,
	input wire carry_in,
	output wire [3:0] sum,
	output wire overflow
);
wire [3:0] carrys;

adder_1bit I00 (.a(a[0]), .b(b[0]), .carry_in(carry_in), .sum(sum[0]), .carry_out(carrys[0]));
adder_1bit I01 (.a(a[1]), .b(b[1]), .carry_in(carrys[0]), .sum(sum[1]), .carry_out(carrys[1]));
adder_1bit I02 (.a(a[2]), .b(b[2]), .carry_in(carrys[1]), .sum(sum[2]), .carry_out(carrys[2]));
adder_1bit I03 (.a(a[3]), .b(b[3]), .carry_in(carrys[2]), .sum(sum[3]), .carry_out(carrys[3]));

assign overflow = ((a + b + carry_in) / (2 ** 4));

endmodule