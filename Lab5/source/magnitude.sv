// $Id: $
// File name:   magnitude.sv
// Created:     2/16/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: magnitude
module magnitude
(
	input  wire [16:0] in,
	output wire [15:0] out
);

assign out = in[16] ? (~in[15:0]+1) : in[15:0];

endmodule