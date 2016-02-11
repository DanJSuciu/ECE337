// $Id: $
// File name:   mealy.sv
// Created:     2/11/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: mealy 1101 detector
module mealy
(
	input wire clk,
	input wire n_rst,
	input wire i,
	output reg o
);

reg [1:0] state;
reg [1:0] newstate;

always_comb
begin
	o = 0;
	newstate = state;
	case (state)
	2'b00 : begin
		if (i) begin
			newstate = 2'b01;
		end else begin
			newstate = 2'b00;
		end
		end
	2'b01 : begin
		if (i) begin
			newstate = 2'b10;
		end else begin
			newstate = 2'b00;
		end
		end
	2'b10 : begin
		if (i) begin
			newstate = 2'b10;
		end else begin
			newstate = 2'b11;
		end
		end
	2'b11 : begin
		if (i) begin
			o = 1;
			newstate = 2'b01;
		end else begin
			newstate = 2'b00;
		end
		end
	default : newstate = 2'b00;
	endcase
end

always_ff @ (posedge clk, negedge n_rst)
begin
	if (n_rst == 0) begin
		state <= 2'b00;
	end else begin
		state <= newstate;
	end
end

endmodule