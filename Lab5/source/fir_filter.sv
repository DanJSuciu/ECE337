// $Id: $
// File name:   fir_filter.sv
// Created:     2/16/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: top level module fir filter

module fir_filter
(
	input  wire clk,
	input  wire n_reset,
	input  wire [15:0] sample_data,
	input  wire [15:0] fir_coefficient,
	input  wire data_ready,
	input  wire load_coeff,
	output wire one_k_samples,
	output wire modwait,
	output wire [15:0] fir_out,
	output wire err
);

logic lc;
logic dr;
logic cnt_up;
logic overflow;
logic clear;
logic [2:0] op;
logic [3:0] src1;
logic [3:0] src2;
logic [3:0] dest;
logic [16:0] outreg;

sync SYNCDR
(
	.clk(clk),
	.n_rst(n_reset),
	.async_in(data_ready),
	.sync_out(dr)
);

sync SYNCLC
(
	.clk(clk),
	.n_rst(n_reset),
	.async_in(load_coeff),
	.sync_out(lc)
);

controller CONTROLLER
(
	.clk(clk),
	.n_reset(n_reset),
	.dr(dr),
	.lc(lc),
	.overflow(overflow),
	.cnt_up(cnt_up),
	.clear(clear),
	.modwait(modwait),
	.op(op),
	.src1(src1),
	.src2(src2),
	.dest(dest),
	.err(err)
);

datapath DATAPATH
(
	.clk(clk),
	.n_reset(n_reset),
	.op(op),
	.src1(src1),
	.src2(src2),
	.dest(dest),
	.ext_data1(sample_data),
	.ext_data2(fir_coefficient),
	.outreg_data(outreg),
	.overflow(overflow)
);

counter COUNTER
(
	.clk(clk),
	.n_reset(n_reset),
	.cnt_up(cnt_up),
	.clear(clear),
	.one_k_samples(one_k_samples)
);

magnitude MAGNITUDE
(
	.in(outreg),
	.out(fir_out)
);

endmodule