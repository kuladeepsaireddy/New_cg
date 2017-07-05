`timescale 1ns / 1ps

`define i 1
`define N 2**`i
module cg_top(
input wire clk,
input wire [(32*`N)-1:0] b,
input wire [(32*`N)-1:0] A,
input wire i_valid,
output reg [(32*`N)-1:0] final_solution,
output o_ready,
input wire [31:0] epsilon
 );
	
reg [(32*`N)-1:0] r;
reg [(32*`N)-1:0]d;
reg [(32*`N)-1:0]q;	
reg [(32*`N)-1:0]x;
reg [31:0] delta_0;	
reg [31:0] delta_new;	
integer i=0;
reg[31:0] beta;

reg [3:0] sel_1;
reg [3:0] sel_2;


 
//assign vect_A=(sel_1=='h0) ? dout:(sel_1=='h1)? r:(sel_1=='h2)? b:d;
//assign vect_B=(sel_2=='h0) ? q:(sel_2=='h1)? r:(sel_2=='h2)? b:d;
integer count =0;
reg rd_en;
wire [63:0]dout;
wire full;
wire empty;

reg [(32*`N)-1:0]vect_A;
reg [(32*`N)-1:0]vect_B;
//wire [(32*`N)-1:0]vect_A=(sel_1=='h0) ? dout:(sel_1=='h1)? r:(sel_1=='h2)? b:d;
//wire [(32*`N)-1:0]vect_B =(sel_2=='h0) ? q:(sel_2=='h1)? r:(sel_2=='h2)? b:d;
wire [31:0]main_o_data;
reg main_i_valid_1;
reg main_i_valid_2;
wire main_o_ready_1;
wire main_o_ready_2;

wire o_valid_result;
reg i_ready_result;

reg [(32*`N)-1:0]i_vect_1_sub;
reg [(32*`N)-1:0]i_vect_2_sub;
reg i_valid_vect_2_sub;
reg i_valid_vect_1_sub;
wire [(32*`N)-1:0] o_data_sub;
reg i_ready_sub;
wire o_valid_sub;
wire o_ready_1_sub;
wire o_ready_2_sub;


reg [31:0] i_data_1_division; 
reg [31:0] i_data_2_division; 
wire [31:0] o_data_division; 
reg i_valid_1_division; 
reg i_valid_2_division;
wire o_ready_1_division;
wire o_ready_2_division;
wire o_valid_result_division;
reg i_ready_result_division;

reg [31:0] i_data_1_division_2; 
reg [31:0] i_data_2_division_2; 
wire [31:0] o_data_division_2; 
reg i_valid_1_division_2; 
reg i_valid_2_division_2;
wire o_ready_1_division_2;
wire o_ready_2_division_2;
wire o_valid_result_division_2;
reg i_ready_result_division_2;



wire s_axis_a_tready;
wire s_axis_b_tready;
wire m_axis_result_tvalid;
wire m_axis_a_tready;
wire [31:0] m_axis_result_tdata;
wire s_axis_b_tready_2;
wire m_axis_result_tvalid_2;
wire [31:0] tolerance;


  
 reg count_1;
 initial
 begin
  count_1<=0;
 end
 
 always@(posedge clk)
 begin
 if(count_1==0)
   begin
    d<=b;
	r<=b;
	sel_1<='h1;
	sel_2<='h1;
	 if(main_o_ready_1& main_o_ready_2)
	  begin
	    main_i_valid_1<=1'b1;
		main_i_valid_2<=1'b1;
		
		if(o_valid_result)
			begin
            i_ready_result<=1'b1;			
			delta_0<=main_o_data;
			end
		delta_new<=delta_0;
		count_1<=1;
	  end
   end
if(delta_new< tolerance & count_1==1 )
 begin
  
	  
 end
////
	else
	  begin
       final_solution<=x;
	   count_1<=0;
      end

end

vector_by_vector vect_by_vect_inst(
  .clk(clk),
  .vect_A(vect_A),
  .vect_B(vect_B),
  .main_o_data(main_o_data),
  .main_i_valid_1(main_i_valid_1),
  .main_i_valid_2(main_i_valid_2),
  .main_o_ready_1(main_o_ready_1),
  .main_o_ready_2(main_o_ready_2),
  .o_valid_result(o_valid_result),
  .i_ready_result(i_ready_result)
    
    );  

cg_vector_subtractor  sub_instnce(    
    .clk(clk),
    .i_data_vect_1(i_vect_1_sub),
    .i_valid_vect_2(i_valid_vect_2_sub),
    .i_valid_vect_1(i_valid_vect_1_sub),
    
    .i_data_vect_2(i_vect_2_sub),    
    .o_data(o_data_sub),
    .i_ready(i_ready_sub),
    .o_valid(o_valid_sub),
    .o_ready_1(o_ready_1_sub),
    .o_ready_2(o_ready_2_sub)        
      );
	

 cg_scalar_division division_instnce(
.clk(clk),
.i_data_1(i_data_1_division),
.i_data_2(i_data_2_division),
.i_valid_1(i_valid_1_division),
.i_valid_2(i_valid_2_division),
.o_ready_1(o_ready_1_division),
.o_ready_2(o_ready_2_division),
.o_data(o_data_division),
.o_valid_result(o_valid_result_division),
.i_ready_result(i_ready_result_division)
    );



	
 cg_scalar_division division_instnce_2(
.clk(clk),
.i_data_1(i_data_1_division_2),
.i_data_2(i_data_2_division_2),
.i_valid_1(i_valid_1_division_2),
.i_valid_2(i_valid_2_division_2),
.o_ready_1(o_ready_1_division_2),
.o_ready_2(o_ready_2_division_2),
.o_data(o_data_division_2),
.o_valid_result(o_valid_result_division_2),
.i_ready_result(i_ready_result_division_2)
    );	

cg_op cg_op_1(
.clk(clk),
.i_data_vect_1(i_vect_1_data_1),
.i_data_vect_2(i_vect_2_data_1),
.i_data_scalar(i_scalar_data_1),
.i_data_1_valid(i_data_1_valid_1),
.i_data_2_valid(i_data_2_valid_1),
.i_data_scalar_valid(i_data_scalar_valid_1),
.o_ready_1(o_ready1_1),
.o_ready_2(o_ready2_1),
.o_ready_scalar(o_ready_scalar_1),
.o_data(o_data_1),
.o_valid(o_valid_1),
.i_ready(i_ready_1)
    
);
cg_op cg_op_2(
.clk(clk),
.i_data_vect_1(i_vect_1_data_2),
.i_data_vect_2(i_vect_2_data_2),
.i_data_scalar(i_scalar_data_2),
.i_data_1_valid(i_data_1_valid_2),
.i_data_2_valid(i_data_2_valid_2),
.i_data_scalar_valid(i_data_scalar_valid_2),
.o_ready_1(o_ready1_2),
.o_ready_2(o_ready2_2),
.o_ready_scalar(o_ready_scalar_2),
.o_data(o_data_2),
.o_valid(o_valid_2),
.i_ready(i_ready_2)
    
);
cg_op cg_op_3(
.clk(clk),
.i_data_vect_1(i_vect_1_data_3),
.i_data_vect_2(i_vect_2_data_3),
.i_data_scalar(i_scalar_data_3),
.i_data_1_valid(i_data_1_valid_3),
.i_data_2_valid(i_data_2_valid_3),
.i_data_scalar_valid(i_data_scalar_valid_3),
.o_ready_1(o_ready1_3),
.o_ready_2(o_ready2_3),
.o_ready_scalar(o_ready_scalar_3),
.o_data(o_data_3),
.o_valid(o_valid_3),
.i_ready(i_ready_3)
    
);
cg_op cg_op_4(
.clk(clk),
.i_data_vect_1(i_vect_1_data_4),
.i_data_vect_2(i_vect_2_data_4),
.i_data_scalar(i_scalar_data_4),
.i_data_1_valid(i_data_1_valid_4),
.i_data_2_valid(i_data_2_valid_4),
.i_data_scalar_valid(i_data_scalar_valid_4),
.o_ready_1(o_ready1_4),
.o_ready_2(o_ready2_4),
.o_ready_scalar(o_ready_scalar_4),
.o_data(o_data_4),
.o_valid(o_valid_4),
.i_ready(i_ready_4)
    
);

wire fifo_o_valid;
fifo_matrix_A matrix_fifo (
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(1'b1),          // input wire s_aresetn
  .s_axis_tvalid(i_valid),  // input wire s_axis_tvalid
  .s_axis_tready(o_ready),  // output wire s_axis_tready
  .s_axis_tdata(A),    // input wire [63 : 0] s_axis_tdata
  .m_axis_tvalid(fifo_o_valid),  // output wire m_axis_tvalid
  .m_axis_tready(rd_en),  // input wire m_axis_tready
  .m_axis_tdata(dout)    // output wire [63 : 0] m_axis_tdata
);

ephsilon_mult square_eph(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(1'b1),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(s_axis_a_tready),            // output wire s_axis_a_tready
  .s_axis_a_tdata(epsilon),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'b1),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(s_axis_b_tready),            // output wire s_axis_b_tready
  .s_axis_b_tdata(epsilon),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(m_axis_result_tvalid),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(m_axis_a_tready),  // input wire m_axis_result_tready
  .m_axis_result_tdata(m_axis_result_tdata)    // output wire [31 : 0] m_axis_result_tdata
	  );
ephsilon_mult mult_eph(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(m_axis_result_tvalid),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(m_axis_a_tready),            // output wire s_axis_a_tready
  .s_axis_a_tdata(m_axis_result_tdata),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(1'b1),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(s_axis_b_tready_2),            // output wire s_axis_b_tready
  .s_axis_b_tdata(delta_0),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(m_axis_result_tvalid_2),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(1'b1),  // input wire m_axis_result_tready
  .m_axis_result_tdata(tolerance)    // output wire [31 : 0] m_axis_result_tdata
	  );
endmodule
