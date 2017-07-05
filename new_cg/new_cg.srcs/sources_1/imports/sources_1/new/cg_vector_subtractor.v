
`define i 1
`define N 2**`i
module cg_vector_subtractor(
input clk,
input [(32*`N)-1:0] i_data_vect_1,
input i_valid_vect_2,
input i_valid_vect_1,

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




    
    
vect_float_sub vect_sub (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(i_valid_vect_1),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(o_ready_1),            // output wire s_axis_a_tready
      .s_axis_a_tdata(i_data_1),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(i_valid_vect_2),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(o_ready_2),            // output wire s_axis_b_tready
      .s_axis_b_tdata(i_data_2),              // input wire [31 : 0] s_axis_b_tdata
      .m_axis_result_tvalid(o_valid_result),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(i_ready_result),  // input wire m_axis_result_tready
      .m_axis_result_tdata(result)    // output wire [31 : 0] m_axis_result_tdata
    );    
endmodule
