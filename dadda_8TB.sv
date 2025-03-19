module dadda_8TB();


parameter M=8,N=8;

reg signed [N-1:0]A;
reg signed [M-1:0]B;
  wire signed [N+M-1:0]Y;


//---- Instantiation of main test module----
//Array_MUL_USign #(64,64) UUT(A,B,Y); //M=4,N=6
  dadda_8 UUT(.A(A),.B(B),.y(Y));


// initializing the inputs to the test module
// initial block executes only once
initial
  repeat(25)
begin
//   #10 A = 3 ; B = 2;
	#10 A = $random; B = $random;
	#100//give required simulation time to complete the operation one by one.
	#100
	#10
	//-----VERIFICATION OF THE OBTAINED RESULT WITH EXISTING RESULT------
  $display(" A=%b,B=%b,AxB=%b",(A),(B),(Y));
  $display(" A=%d,B=%d,AxB=%d",(A),(B),(Y));

	if( (A)*(B) != (Y)) 
		$display(" *ERROR* ");

end

endmodule