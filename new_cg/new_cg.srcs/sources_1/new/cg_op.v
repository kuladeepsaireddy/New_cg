`timescale 1ns / 1ps
`define nx 2
`define ny 2
`define N `nx*`ny


module cg_op(
input wire clk,
input wire [31:0]  i_data_vect_1,
input wire [31:0]  i_data_vect_2,
input wire [31:0] i_data_scalar,
input wire i_data_1_valid,
input wire i_data_2_valid,
input wire i_data_scalar_valid,
output wire o_ready_1,
output wire o_ready_2,
output wire o_ready_scalar,
output  wire [31:0] o_data,
output wire o_valid,
input wire i_ready
    
);

wire [31:0] o_data_result_mult;
wire  i_ready_result_mult;
wire o_valid_result_mult;

float_mult my_mult(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_data_scalar_valid),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_scalar),            // output wire s_axis_a_tready
  .s_axis_a_tdata(i_data_scalar),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_data_2_valid),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2),            // output wire s_axis_b_tready
  .s_axis_b_tdata(i_data_vect_2),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_mult),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_mult),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_mult)    // output wire [31 : 0] m_axis_result_tdata
);	
 


float_add adder_instnce (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_data_1_valid),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1),            // output wire s_axis_a_tready
  .s_axis_a_tdata(i_data_vect_1),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(o_valid_result_mult),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(i_ready_result_mult),            // output wire s_axis_b_tready
  .s_axis_b_tdata(o_data_result_mult),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data)    // output wire [31 : 0] m_axis_result_tdata
);
	
	
endmodule
