module type_a_lut(
  input wire an, anm1, bp, bz, bm,
  output wire pout);
  
  wire s, c, z;
  wire alpha, beta;
  
  booth_encoder booth(bp, bz, bm, s, c, z);
  mux_2x1_dt mux1(an, anm1, s, alpha);
  mux_2x1_dt mux2(alpha, ~alpha, c, beta);
  mux_2x1_dt mux3(beta, 1'b0, z, pout);
  
endmodule