`include "etbit.sv"

 module mult(
  input wire[7:0] a,
  input wire[7:0] b,
  output wire[10:0] arr0,
  output wire[10:0] arr1,
  output wire[10:0] arr2,
  output wire[10:0] arr3,
  output wire sx1, sx2, sx3, sx4,cx1, cx2, cx3, cx4);
  wire [2:0] new_b = {b[1], b[0], 1'b0};
  wire [2:0] new_b2 = {b[3], b[2], b[1]};
  wire [2:0] new_b3 = {b[5], b[4], b[3]};
  wire [2:0] new_b4 = {b[7], b[6], b[5]};
  wire[10:0] pp; wire[10:0] pp2; wire[10:0] pp3; wire[10:0] pp4;
 
  etbit e1(a,new_b , pp, sx1, cx1);
  assign arr0 = pp;
  etbit e2(a,new_b2 , pp2, sx2, cx2);
  assign arr1 = pp2;
  etbit e3(a,new_b3 , pp3, sx3, cx3);
  assign arr2 = pp3;
  etbit e4(a,new_b4 , pp4, sx4, cx4);
  assign arr3 = pp4;
  
endmodule