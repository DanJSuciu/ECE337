// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/5/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: test bench for flex counter

`timescale 1ns / 10ps

module tb_flex_counter
();
   
localparam CLK_PERIOD = 2.5;
localparam NUM_INPUT_BITS = 4;
localparam NUM_BITS = NUM_INPUT_BITS - 1;
      
reg clk;
reg reset;
reg count_enable;
reg clear;   
reg [NUM_BITS:0] tb_rollover_val;
reg [NUM_BITS:0] tb_count_out;    
reg flag;
     
always
begin : CLK_GEN
	clk = 1'b0;
	#(CLK_PERIOD/2);
        clk = 1'b1;
        #(CLK_PERIOD/2);
end
        
flex_counter DUT(.clk(clk), .n_rst(reset), .count_enable(count_enable), .clear(clear), .rollover_val(tb_rollover_val), .count_out(tb_count_out), .rollover_flag(flag));


initial 
begin
	clk = 0;
	reset = 1;
	clear = 1;
	count_enable = 1;
	tb_rollover_val = 2;

	#(CLK_PERIOD / 2);
	reset = 0;
	clear = 0;
	count_enable = 0;

	#(CLK_PERIOD * 3 / 2);
	reset = 1;

	#(CLK_PERIOD);
	count_enable = 1;

	#(CLK_PERIOD);
	clear = 1;

	#(CLK_PERIOD);
	clear = 0;

	#(CLK_PERIOD * 4);
	count_enable = 0;

	#(CLK_PERIOD);
	clear = 1;

	tb_rollover_val = 4;

	#(CLK_PERIOD);
	reset = 0;
	clear = 0;
	count_enable = 0;

	#(CLK_PERIOD * 3);
	reset = 1;

	#(CLK_PERIOD * 2);
	count_enable = 1;

	#(CLK_PERIOD * 2);
	clear = 1;

	#(CLK_PERIOD * 2);
	clear = 0;

	#(CLK_PERIOD * 8);
	count_enable = 0;

	#(CLK_PERIOD * 2);
	clear = 1;

	tb_rollover_val = 8;

	#(CLK_PERIOD * 2);
	reset = 0;
	clear = 0;
	count_enable = 0;

	#(CLK_PERIOD * 6);
	reset = 1;

	#(CLK_PERIOD * 4);
	count_enable = 1;

	#(CLK_PERIOD * 4);
	clear = 1;

	#(CLK_PERIOD * 4);
	clear = 0;

	#(CLK_PERIOD * 16);
	count_enable = 0;

	#(CLK_PERIOD * 4);
	clear = 1;      
      
end
        
endmodule