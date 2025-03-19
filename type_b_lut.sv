`include "sign_ext.sv" 

module type_b_lut(
  input wire bp, bz, bm, an, pin, 
  output wire pout);
  
  wire out;
  
  sign_ext s1(bp, bz, bm, an, out);
  assign pout = ((~out) ^ pin);
  
endmodule