// $Id: $
// File name:   tb_moore.sv
// Created:     2/11/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for moore 1101 detector

`timescale 1ns / 10ps

module tb_moore();

parameter CLK_PERIOD = 2.5;

reg clk, n_rst, i, o, expected_o;

moore DUT (.clk(clk), .n_rst(n_rst), .i(i), .o(o));

always
begin : CLK_GEN
	clk = 1'b0;
	#(CLK_PERIOD/2);
        clk = 1'b1;
        #(CLK_PERIOD/2);
end

initial
begin
	n_rst = 0;
	i = 0;
	expected_o = 0;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 000");
	else
		$error("Incorrect output from state 000");
	@(negedge clk);
	n_rst = 1;
	i = 1;
	expected_o = 0;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 001");
	else
		$error("Incorrect output from state 001");
	@(negedge clk);
	i = 1;
	expected_o = 0;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 010");
	else
		$error("Incorrect output from state 010");
	@(negedge clk);
	i = 0;
	expected_o = 0;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 011");
	else
		$error("Incorrect output from state 011");
	@(negedge clk);
	i = 1;
	expected_o = 1;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 100");
	else
		$error("Incorrect output from state 100");
	@(negedge clk);
	i = 1;
	expected_o = 0;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 010");
	else
		$error("Incorrect output from state 010");
	@(negedge clk);
	i = 0;
	expected_o = 0;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 011");
	else
		$error("Incorrect output from state 011");
	@(negedge clk);
	i = 1;
	expected_o = 1;
	@(posedge clk);
	#(1)
	assert (o == expected_o)
		$info("Correct output of 0 from state 100");
	else
		$error("Incorrect output from state 100");
end

endmodule