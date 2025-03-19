 timescale 1ns / 1ps

// dadda multiplier
// A - 8 bits , B - 8bits, y(output) - 16bits
`include "HA.sv"
`include "csa_dadda.sv"
`include "booth_redix4.sv"
module dadda_8(A,B,y);
    
    input signed [7:0] A;
    input signed [7:0] B;
    output wire signed [15:0] y;
  wire [10:0] gen_pp_0, gen_pp_1, gen_pp_2, gen_pp_3;
  wire sx1,sx2,sx3,sx4, cx1,cx2,cx3,cx4;
// stage-1 sum and carry
    wire [0:5]s1,c1;
// stage-2 sum and carry
  wire [0:9]s2,c2;   
// stage-3 sum and carry
  wire [0:13]s3,c3;
 
// stage-4 sum and carry
  wire [0:15] cy;
 

  mult m1(.a(A), .b(B), .arr0(gen_pp_0) , .arr1(gen_pp_1) , .arr2(gen_pp_2) , .arr3(gen_pp_3), .sx1(sx1), .sx2(sx2), .sx3(sx3),
          .sx4(sx4), .cx1(cx1), .cx2(cx2) , .cx3(cx3), .cx4(cx4));
  
 
 
//Reduction by stages.
// di_values = 2,3,4,6,8,13...
 
 
//Stage 1 - reducing fom 5 to 4  
 
 
  HA h1(.a(gen_pp_0[6]),.b(gen_pp_1[4]),.Sum(s1[0]),.Cout(c1[0]));
  HA h2(.a(gen_pp_0[7]),.b(gen_pp_1[5]),.Sum(s1[1]),.Cout(c1[1]));
  HA h3(.a(gen_pp_0[8]),.b(gen_pp_1[6]),.Sum(s1[2]),.Cout(c1[2]));
  HA h4(.a(sx1),.b(gen_pp_1[7]),.Sum(s1[3]),.Cout(c1[3]));
  HA h5(.a(sx1),.b(gen_pp_1[8]),.Sum(s1[4]),.Cout(c1[4]));
  HA h6(.a(!sx1),.b(!sx2),.Sum(s1[5]),.Cout(c1[5]));

    
//Stage 2 - reducing fom 4 to 3
 
  HA h7(.a(gen_pp_0[4]),.b(gen_pp_1[2]),.Sum(s2[0]),.Cout(c2[0]));
  HA h8(.a(gen_pp_0[5]),.b(gen_pp_1[3]),.Sum(s2[1]),.Cout(c2[1]));
 
 
  csa_dadda c21(.A(s1[0]),.B(gen_pp_2[2]),.Cin(gen_pp_3[0]),.Y(s2[2]),.Cout(c2[2]));
  
  csa_dadda c22(.A(s1[1]),.B(gen_pp_2[3]),.Cin(gen_pp_3[1]),.Y(s2[3]),.Cout(c2[3]));
  
  csa_dadda c23(.A(s1[2]),.B(gen_pp_2[4]),.Cin(gen_pp_3[2]),.Y(s2[4]),.Cout(c2[4]));
  
  csa_dadda c24(.A(s1[3]),.B(gen_pp_2[5]),.Cin(gen_pp_3[3]),.Y(s2[5]),.Cout(c2[5]));
  
  csa_dadda c25(.A(s1[4]),.B(gen_pp_2[6]),.Cin(gen_pp_3[4]),.Y(s2[6]),.Cout(c2[6]));
  
  csa_dadda c26(.A(s1[5]),.B(gen_pp_2[7]),.Cin(gen_pp_3[5]),.Y(s2[7]),.Cout(c2[7]));
  
  csa_dadda c27(.A(1'b1),.B(gen_pp_2[8]),.Cin(gen_pp_3[6]),.Y(s2[8]),.Cout(c2[8]));
  
 
    
//Stage 3 - reducing fom 3 to 2
 
  HA h9(.a(gen_pp_0[2]),.b(gen_pp_1[0]),.Sum(s3[0]),.Cout(c3[0]));
 
  HA h10(.a(gen_pp_0[3]),.b(gen_pp_1[1]),.Sum(s3[1]),.Cout(c3[1]));
 
  csa_dadda c31(.A(s2[0]),.B(gen_pp_2[0]),.Cin(cx3),.Y(s3[2]),.Cout(c3[2]));
  
  csa_dadda c32(.A(c2[0]),.B(s2[1]),.Cin(gen_pp_2[1]),.Y(s3[3]),.Cout(c3[3]));

  csa_dadda c33(.A(c2[1]),.B(s2[2]),.Cin(cx4),.Y(s3[4]),.Cout(c3[4]));
  csa_dadda c34(.A(c2[2]),.B(c1[0]),.Cin(s2[3]),.Y(s3[5]),.Cout(c3[5]));
  
  csa_dadda c35(.A(c2[3]),.B(c1[1]),.Cin(s2[4]),.Y(s3[6]),.Cout(c3[6]));
  
  csa_dadda c36(.A(c2[4]),.B(c1[2]),.Cin(s2[5]),.Y(s3[7]),.Cout(c3[7]));
  
  csa_dadda c37(.A(c2[5]),.B(c1[3]),.Cin(s2[6]),.Y(s3[8]),.Cout(c3[8]));
  
  csa_dadda c38(.A(c2[6]),.B(c1[4]),.Cin(s2[7]),.Y(s3[9]),.Cout(c3[9]));
  
  csa_dadda c39(.A(c2[7]),.B(c1[5]),.Cin(s2[8]),.Y(s3[10]),.Cout(c3[10]));
  
  csa_dadda c310(.A(c2[8]),.B(!sx3),.Cin(gen_pp_3[7]),.Y(s3[11]),.Cout(c3[11]));
  
  HA h11(.a(1'b1),.b(gen_pp_3[8]),.Sum(s3[12]),.Cout(c3[12]));
  

   
//Stage 4 - reducing fom 2 to 1
    // adding total sum and carry to get final output
 
  HA h12(.a(gen_pp_0[0]),.b(cx1),.Sum(y[0]),.Cout(cy[0]));
  HA h13(.a(cy[0]),.b(gen_pp_0[1]),.Sum(y[1]),.Cout(cy[1]));
 
 
  csa_dadda c41(.A(cy[1]),.B(s3[0]),.Cin(cx2),.Y(y[2]),.Cout(cy[2]));
  
  csa_dadda c42(.A(cy[2]),.B(c3[0]),.Cin(s3[1]),.Y(y[3]),.Cout(cy[3]));
  
  csa_dadda c43(.A(cy[3]),.B(c3[1]),.Cin(s3[2]),.Y(y[4]),.Cout(cy[4]));
  
  csa_dadda c44(.A(cy[4]),.B(c3[2]),.Cin(s3[3]),.Y(y[5]),.Cout(cy[5]));
  
  csa_dadda c45(.A(cy[5]),.B(c3[3]),.Cin(s3[4]),.Y(y[6]),.Cout(cy[6]));
  
  csa_dadda c46(.A(cy[6]),.B(c3[4]),.Cin(s3[5]),.Y(y[7]),.Cout(cy[7]));
  
  csa_dadda c47(.A(cy[7]),.B(c3[5]),.Cin(s3[6]),.Y(y[8]),.Cout(cy[8]));
  
  csa_dadda c48(.A(cy[8]),.B(c3[6]),.Cin(s3[7]),.Y(y[9]),.Cout(cy[9]));
  
  csa_dadda c49(.A(cy[9]),.B(c3[7]),.Cin(s3[8]),.Y(y[10]),.Cout(cy[10]));
  
  csa_dadda c410(.A(cy[10]),.B(c3[8]),.Cin(s3[9]),.Y(y[11]),.Cout(cy[11]));
  
  csa_dadda c411(.A(cy[11]),.B(c3[9]),.Cin(s3[10]),.Y(y[12]),.Cout(cy[12]));
  
  csa_dadda c412(.A(cy[12]),.B(c3[10]),.Cin(s3[11]),.Y(y[13]),.Cout(cy[13]));
  
  csa_dadda c413(.A(cy[13]),.B(c3[11]),.Cin(s3[12]),.Y(y[14]),.Cout(cy[14]));
  
  csa_dadda c414(.A(!sx4),.B(cy[14]),.Cin(c3[12]),.Y(y[15]),.Cout(cy[15]));
  

    
  
    
endmodule 