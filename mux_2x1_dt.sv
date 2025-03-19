module mux_2x1_dt(
  input I0,I1,S,
  output Y);
 
	assign Y = S?I1:I0;
                
endmodule