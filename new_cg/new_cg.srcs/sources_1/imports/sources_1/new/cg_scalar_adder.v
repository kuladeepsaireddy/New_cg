`timescale 1ns / 1ps
`define i 1
`define N 2**`i
module cg_vector_adder(
input clk,
input [(32*`N)-1:0] i_data_vect_1,
input i_valid_vect_1,
input i_valid_vect_2,

input [(32*`N)-1:0] i_data_vect_2,    
output reg  [(32*`N)-1:0] o_data,
input i_ready,
output reg o_valid,
output o_ready_1,
output o_ready_2    

);
integer i;
integer k=0;
reg [31:0] i_data_1;
reg [31:0] i_data_2;
wire [31:0] result;


wire o_valid_result;
reg i_ready_result;

always@(posedge clk)
 begin
 if(i_valid_vect_1& i_valid_vect_2)
  begin
  for(i=0;i<`N;i=i+1)
    begin
    i_data_1<=i_data_vect_1[32*i+:32];
	i_data_2<=i_data_vect_2[32*i+:32];
	i_ready_result<=1;
	 if(o_valid_result)
      o_data[32*i+:32]<=result;
	  //k<=k+1;
   end
   if(i_ready)
    o_valid<=o_valid_result;
   else
    o_valid<=1'b0; 
 end 
end 
  adder scalar_adder_instance(
         .clk(clk),
          .i_data_1(i_data_1),
          .i_data_2(i_data_2),
          .o_data(result),
          .i_valid_1(i_valid_vect_1),
          .i_valid_2(i_valid_vect_2),
          .o_ready_1(o_ready_1),
          .o_ready_2(o_ready_2),
          .o_valid_result(o_valid_result),
          .i_ready_result(i_ready_result)
          );
    
endmodule
