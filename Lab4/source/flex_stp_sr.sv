// $Id: $
// File name:   flex_stp_sr.sv
// Created:     2/4/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: flexible and scalable sequential designs
module flex_stp_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1
)
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire serial_in,
	output wire [(NUM_BITS-1):0] parallel_out
);

reg [(NUM_BITS-1):0] temp;

always @ (posedge clk, negedge n_rst) begin
	if (n_rst == 0) begin
		temp[(NUM_BITS-1):0] <= {NUM_BITS{1'b1}};
	end else if (shift_enable == 1) begin
		if (SHIFT_MSB == 1) begin
			temp[(NUM_BITS-1):0] <= {temp[(NUM_BITS-2):0],serial_in};
		end else begin
			temp[(NUM_BITS-1):0] <= {serial_in,temp[(NUM_BITS-1):1]};
		end
	end
end

assign parallel_out[(NUM_BITS-1):0] = temp[(NUM_BITS-1):0];

endmodule