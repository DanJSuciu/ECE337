// $Id: $
// File name:   sensor_d.sv
// Created:     1/21/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Dataflow style sensor error detector

module sensor_d
(
	input wire [3:0] sensors,
	output wire error
);

assign and1 = ((sensors[1] && sensors[2]) == 1) ? (1): 0;
assign and2 = ((sensors[1] && sensors[3]) == 1) ? (1): 0;
assign error = (sensors[0] || and1 || and2) ? (1): 0;

endmodule