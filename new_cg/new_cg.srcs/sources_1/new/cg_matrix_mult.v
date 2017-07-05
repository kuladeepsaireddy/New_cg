`timescale 1ns / 1ps
`define nx 4
`define ny 4
`define N `nx*`ny
`define M `nx*32

module cg_matrix_mult(
input clk,
input [(32*`N)-1:0] vector,
output [(32*`N)-1:0] o_data
);
parameter c =$clog2(`N); 
reg[c:0] count; 
reg[31:0] d0;
reg[31:0] d1;
reg[31:0] d2;
reg[31:0] d3;
reg[31:0] d4;
integer i;
integer j;

initial
begin
 i<=1;
 j<=1;
end
always@(posedge clk)
begin
 if(i==1&j!=`ny)
  begin
    d0<=0;
	d1<=u[(`M*(j-1)+i-1)+:32];
	d2<=u[(`M*(j-1)+i+1)+:32];
	d3<=u[(`M*(j-2)+i)+:32];
	d4<=u[(`M*j+i)+:32];
	j<=j+1;
  end 
 if(i==`nx)
  begin 
    d2<=0;
    d0<=u[(`M*(j-1)+i)+:32];
	d1<=u[(`M*(j-1)+i-1)+:32];
	d3<=u[(`M*(j-2)+i)+:32];
	d4<=u[(`M*j+i)+:32];
	
  end 

end



float_add my_adder (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_add),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_add),            // output wire s_axis_a_tready
  .s_axis_a_tdata(i_data_1_add),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_add),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_add),            // output wire s_axis_b_tready
  .s_axis_b_tdata(i_data_2_add),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_add),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_add),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_add)    // output wire [31 : 0] m_axis_result_tdata
);

float_mult my_mult(
  .aclk(aclk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_mult),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_mult),            // output wire s_axis_a_tready
  .s_axis_a_tdata(i_data_1_mult),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_mult),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_mult),            // output wire s_axis_b_tready
  .s_axis_b_tdata(i_data_2_mult),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_mult),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_mult),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_mult)    // output wire [31 : 0] m_axis_result_tdata
);



	
	
	
	
endmodule
