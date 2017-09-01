`timescale 1ns / 1ps
`define i 1
`define nx 4
`define ny 4
`define N `nx*`ny


module test_tb(
 );
 reg clk;
reg[31:0] vect_mat_mult;
 reg i_valid_mat_mult;
 wire [31:0]o_data_mat_mult;
 wire o_valid_mat_mult;
 reg i_ready_mat_mult;
 
 

 initial
 begin
   clk = 1'b0;
   forever
   begin
       clk = ~clk;
         #5;
   end
 end 

initial
begin
//i_valid_mat_mult<=1'b0;
#10
@(posedge clk)
vect_mat_mult <='h3f800000;
i_valid_mat_mult<=1'b1;

#10
@(posedge clk)
vect_mat_mult <='h40000000;
i_valid_mat_mult<=1'b1;
i_ready_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40400000;
i_valid_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40800000;
i_valid_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h3f800000;
i_valid_mat_mult<=1'b1;

#10
@(posedge clk)
vect_mat_mult <='h40000000;
i_valid_mat_mult<=1'b1;
i_ready_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40400000;
i_valid_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40800000;
i_valid_mat_mult<=1'b1;
@(posedge clk)
vect_mat_mult <='h3f800000;
i_valid_mat_mult<=1'b1;

#10
@(posedge clk)
vect_mat_mult <='h40000000;
i_valid_mat_mult<=1'b1;
i_ready_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40400000;
i_valid_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40800000;
i_valid_mat_mult<=1'b1;
@(posedge clk)
vect_mat_mult <='h3f800000;
i_valid_mat_mult<=1'b1;

#10
@(posedge clk)
vect_mat_mult <='h40000000;
i_valid_mat_mult<=1'b1;
i_ready_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40400000;
i_valid_mat_mult<=1'b1;
#10
@(posedge clk)
vect_mat_mult <='h40800000;
i_valid_mat_mult<=1'b1;
#10
@(posedge clk)
i_valid_mat_mult<=1'b0; 
end

     
    
 cg_matrix_mult matrix_mult_inst(
.clk(clk),
.vect(vect_mat_mult),
.i_valid(i_valid_mat_mult),
.o_data(o_data_mat_mult),
.o_valid(o_valid_mat_mult),
.i_ready(i_ready_mat_mult)

);
   
endmodule
