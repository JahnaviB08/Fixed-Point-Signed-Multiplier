module booth_encoder(
  input wire bp, bz, bm,
  output wire s, c, z);
  
  assign s = (~bm & bz & bp) | (bm & ~bz & ~bp);
  assign c = (bm & ~bz) | (bm & ~bp);
  assign z = (~bm & ~bz & ~bp) | (bm & bz & bp);
  
endmodule