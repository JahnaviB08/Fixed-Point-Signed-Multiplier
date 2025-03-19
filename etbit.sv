`include "type_a1_lut.sv"
`include "type_a_lut.sv"
`include "type_b_lut.sv"

module etbit(input wire[7:0] a,
             input wire[2:0] b,
             output wire[10:0] pp,
             output wire sx,  output wire cx);
  
  type_a1_lut aone(b[0], b[1], b[2], a[0], pp[0], cx);
  type_a_lut a1(a[1], a[0], b[0], b[1], b[2], pp[1]);
  type_a_lut a2(a[2], a[1], b[0], b[1], b[2], pp[2]);
  type_a_lut a3(a[3], a[2], b[0], b[1], b[2], pp[3]);
  type_a_lut a4(a[4], a[3], b[0], b[1], b[2], pp[4]);
  type_a_lut a5(a[5], a[4], b[0], b[1], b[2], pp[5]);
  type_a_lut a6(a[6], a[5], b[0], b[1], b[2], pp[6]);
  type_a_lut a7(a[7], a[6], b[0], b[1], b[2], pp[7]);
  type_b_lut b1(b[0], b[1], b[2], a[7], 1'b1, pp[8]);
  assign sx = pp[8];
  
endmodule