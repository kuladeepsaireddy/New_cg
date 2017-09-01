`define nx 4
`define ny 4
`define N `nx*`ny
module cg_vector_subtractor(
input wire clk,
input wire [31:0] i_data_vect_1,
input wire i_valid_vect_2,
input wire i_valid_vect_1,

input wire [31:0] i_data_vect_2,    
output wire [31:0] result,
input wire i_ready_result,
output wire o_valid_result,
output wire o_ready_1,
output wire o_ready_2    

);


    
    
vect_float_sub vect_sub (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(i_valid_vect_1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(o_ready_1),            // output wire s_axis_a_tready
      .s_axis_a_tdata(i_data_vect_1),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(i_valid_vect_2),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(o_ready_2),            // output wire s_axis_b_tready
      .s_axis_b_tdata(i_data_vect_2),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(o_valid_result),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(i_ready_result),  // input wire m_axis_result_tready
      .m_axis_result_tdata(result)    // output wire [31 : 0] m_axis_result_tdata
    );    
endmodule
