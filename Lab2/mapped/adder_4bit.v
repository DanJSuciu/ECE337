/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Jan 27 19:08:04 2016
/////////////////////////////////////////////////////////////


module adder_1bit_3 ( a, b, carry_in, sum, carry_out );
  input a, b, carry_in;
  output sum, carry_out;
  wire   n1, n2;

  XOR2X1 U1 ( .A(carry_in), .B(n1), .Y(sum) );
  INVX1 U2 ( .A(n2), .Y(carry_out) );
  AOI22X1 U3 ( .A(b), .B(a), .C(n1), .D(carry_in), .Y(n2) );
  XOR2X1 U4 ( .A(a), .B(b), .Y(n1) );
endmodule


module adder_1bit_2 ( a, b, carry_in, sum, carry_out );
  input a, b, carry_in;
  output sum, carry_out;
  wire   n1, n2;

  XOR2X1 U1 ( .A(carry_in), .B(n1), .Y(sum) );
  INVX1 U2 ( .A(n2), .Y(carry_out) );
  AOI22X1 U3 ( .A(b), .B(a), .C(n1), .D(carry_in), .Y(n2) );
  XOR2X1 U4 ( .A(a), .B(b), .Y(n1) );
endmodule


module adder_1bit_1 ( a, b, carry_in, sum, carry_out );
  input a, b, carry_in;
  output sum, carry_out;
  wire   n1, n2;

  XOR2X1 U1 ( .A(carry_in), .B(n1), .Y(sum) );
  INVX1 U2 ( .A(n2), .Y(carry_out) );
  AOI22X1 U3 ( .A(b), .B(a), .C(n1), .D(carry_in), .Y(n2) );
  XOR2X1 U4 ( .A(a), .B(b), .Y(n1) );
endmodule


module adder_1bit_0 ( a, b, carry_in, sum, carry_out );
  input a, b, carry_in;
  output sum, carry_out;
  wire   n1, n2;

  XOR2X1 U1 ( .A(carry_in), .B(n1), .Y(sum) );
  INVX1 U2 ( .A(n2), .Y(carry_out) );
  AOI22X1 U3 ( .A(b), .B(a), .C(n1), .D(carry_in), .Y(n2) );
  XOR2X1 U4 ( .A(a), .B(b), .Y(n1) );
endmodule


module adder_4bit_DW01_add_0 ( A, B, CI, SUM, CO );
  input [4:0] A;
  input [4:0] B;
  output [4:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13;

  INVX2 U1 ( .A(A[3]), .Y(n1) );
  INVX2 U2 ( .A(n7), .Y(n2) );
  INVX2 U3 ( .A(n10), .Y(n3) );
  INVX2 U4 ( .A(A[1]), .Y(n4) );
  INVX2 U5 ( .A(n11), .Y(n5) );
  INVX2 U6 ( .A(n13), .Y(n6) );
  OAI21X1 U7 ( .A(n7), .B(n1), .C(n8), .Y(SUM[4]) );
  OAI21X1 U8 ( .A(A[3]), .B(n2), .C(B[3]), .Y(n8) );
  AOI21X1 U9 ( .A(n9), .B(A[2]), .C(n3), .Y(n7) );
  OAI21X1 U10 ( .A(A[2]), .B(n9), .C(B[2]), .Y(n10) );
  OAI21X1 U11 ( .A(n11), .B(n4), .C(n12), .Y(n9) );
  OAI21X1 U12 ( .A(A[1]), .B(n5), .C(B[1]), .Y(n12) );
  AOI21X1 U13 ( .A(A[0]), .B(B[0]), .C(n6), .Y(n11) );
  OAI21X1 U14 ( .A(A[0]), .B(B[0]), .C(CI), .Y(n13) );
endmodule


module adder_4bit ( a, b, carry_in, sum, overflow );
  input [3:0] a;
  input [3:0] b;
  output [3:0] sum;
  input carry_in;
  output overflow;

  wire   [3:0] carrys;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3;

  adder_1bit_3 I00 ( .a(a[0]), .b(b[0]), .carry_in(carry_in), .sum(sum[0]), 
        .carry_out(carrys[0]) );
  adder_1bit_2 I01 ( .a(a[1]), .b(b[1]), .carry_in(carrys[0]), .sum(sum[1]), 
        .carry_out(carrys[1]) );
  adder_1bit_1 I02 ( .a(a[2]), .b(b[2]), .carry_in(carrys[1]), .sum(sum[2]), 
        .carry_out(carrys[2]) );
  adder_1bit_0 I03 ( .a(a[3]), .b(b[3]), .carry_in(carrys[2]), .sum(sum[3]) );
  adder_4bit_DW01_add_0 add_1_root_add_24_2 ( .A({1'b0, a}), .B({1'b0, b}), 
        .CI(carry_in), .SUM({overflow, SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, 
        SYNOPSYS_UNCONNECTED__3}) );
endmodule

