module sign_ext(
  input wire bp, bz, bm, an,
  output wire o);
  
  assign o = (~bm & bp & an) | (~bm & bz & an) | (bm & ~bz & ~an) | (bm & ~bp & ~an);
  
endmodule