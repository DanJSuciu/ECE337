// $Id: $
// File name:   sensor_s.sv
// Created:     1/21/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Sensor Error Detector

module sensor_s
(
	input wire [3:0] sensors,
	output wire error
);

wire output_and23;
wire output_and24;

and AND23 (output_and23, sensors[1], sensors[2]);
and AND24 (output_and24, sensors[1], sensors[3]);
or ORall (error, output_and23, output_and24, sensors[0]);

endmodule