`timescale 1ns / 1ps
`define i 1
`define N 2**`i
module cg_op(
input clk,
input [(32*`N)-1:0]  i_data_vect_1,
input [(32*`N)-1:0]  i_data_vect_2,
input [31:0] i_data_scalar,
input i_data_1_valid,
input i_data_2_valid,
input i_data_scalar_valid,
output o_ready_1,
output o_ready_2,
output o_ready_scalar,
output reg  [(32*`N)-1:0] o_data,
output o_valid,
input i_ready
    
);

wire [(32*`N)-1:0] o_data_mult;
reg i_ready_mult;
wire o_valid_mult;

cg_scalar_mult scalar_mult_instnce_1(
.clk(clk),
.i_data_vect(i_data_vect_1),
.i_valid_vect(i_data_1_valid),
.i_valid_scalar(i_data_scalar_valid),

.i_data_scalar(i_data_scalar),    
.o_data(o_data_mult),
.i_ready(i_ready_mult),
.o_valid(o_valid_mult),
.o_ready_1(o_ready_1),
.o_ready_2(o_ready_scalar)    

);

	
 cg_vector_adder adder_instnce(
.clk(clk),
.i_data_vect_1(o_data_mult),
.i_valid_vect_1(i_data_2_valid),
.i_valid_vect_2(o_valid_mult),

.i_data_vect_2(i_data_vect_2),    
.o_data(o_data),
.i_ready(i_ready),
.o_valid(o_valid),
.o_ready_1(i_ready_mult),
.o_ready_2(o_ready_2)    
);



	
	
endmodule
