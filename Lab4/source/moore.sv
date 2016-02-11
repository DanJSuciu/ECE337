// $Id: $
// File name:   moore.sv
// Created:     2/10/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 1101 detector
module moore
(
	input wire clk,
	input wire n_rst,
	input wire i,
	output reg o
);

reg [2:0] state;
reg [2:0] newstate;

always_comb
begin
	newstate = state;
	case (state)
	3'b000 : begin
		if (i) begin
			newstate = 3'b001;
		end else begin
			newstate = 3'b000;
		end
		end
	3'b001 : begin
		if (i) begin
			newstate = 3'b010;
		end else begin
			newstate = 3'b000;
		end
		end
	3'b010 : begin
		if (i) begin
			newstate = 3'b010;
		end else begin
			newstate = 3'b011;
		end
		end
	3'b011 : begin
		if (i) begin
			newstate = 3'b100;
		end else begin
			newstate = 3'b000;
		end
		end
	3'b100 : begin
		if (i) begin
			newstate = 3'b010;
		end else begin
			newstate = 3'b000;
		end
		end
	default : newstate = 3'b000;
	endcase
end

always_ff @ (posedge clk, negedge n_rst)
begin
	if (n_rst == 0) begin
		state <= 3'b000;
	end else begin
		state <= newstate;
	end
end

assign o = (state == 3'b100);

endmodule