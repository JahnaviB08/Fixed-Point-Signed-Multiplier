`include "mux_2x1_dt.sv" 
`include "booth_encoder.sv" 

module type_a1_lut(
  input wire bp, bz, bm, an, 
  output wire po, cx);
  
  wire s, c, z;
  wire alpha, beta, gamma, delta;
  
  booth_encoder booth(bp, bz, bm, s, c, z);
  mux_2x1_dt mux1(an, 1'b0, s, alpha);
  mux_2x1_dt mux2(1'b0, 1'b0, s, beta);
  mux_2x1_dt mux3(alpha, ~alpha, c, gamma);
  mux_2x1_dt mux4(beta, ~beta, c, delta);
  mux_2x1_dt mux5(gamma, 1'b0, z, po);
  mux_2x1_dt mux6(delta, 1'b0, z, cx);
  
endmodule