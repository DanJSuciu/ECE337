/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Jan 27 21:18:26 2016
/////////////////////////////////////////////////////////////


module sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   signal;

  DFFSR signal_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(signal)
         );
  DFFSR signal2_reg ( .D(signal), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule

