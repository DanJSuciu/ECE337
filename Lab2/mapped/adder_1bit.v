/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Jan 21 14:14:46 2016
/////////////////////////////////////////////////////////////


module adder_1bit ( a, b, carry_in, sum, carry_out );
  input a, b, carry_in;
  output sum, carry_out;
  wire   n4, n5;

  XOR2X1 U6 ( .A(carry_in), .B(n4), .Y(sum) );
  INVX1 U7 ( .A(n5), .Y(carry_out) );
  MUX2X1 U8 ( .B(b), .A(carry_in), .S(n4), .Y(n5) );
  XOR2X1 U9 ( .A(b), .B(a), .Y(n4) );
endmodule

