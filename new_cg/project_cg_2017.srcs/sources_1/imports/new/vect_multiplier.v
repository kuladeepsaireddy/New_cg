//`define i 3
//`define nx 2
//`define ny 4
//`define N `nx*`ny
`include "../../../../include_file.v"

//`define numloop $clog2(`N)
module vector_by_vector(
input wire clk,
input wire [(32*`N)-1:0] vect_A,
input wire [(32*`N)-1:0] vect_B,
output reg [31:0] main_o_data,
input wire main_i_valid_1,
input wire main_i_valid_2,
output  reg main_o_ready_1,
output  reg main_o_ready_2,
output reg o_valid_result,
input  wire i_ready_result

);
wire o_valid[3*`N-2:`N];
wire i_ready[3*`N-2:`N];
wire o_ready_1[`N-1:0];
wire o_ready_2[`N-1:0];



//parameter N= 2**`i;
wire [31:0] o_data[3*`N-2:`N];
reg [31:0] i_data_1[`N-1:0];
reg [31:0] i_data_2[`N-1:0];
reg test_1;
reg test_2;

reg valid_1;
reg valid_2;


integer i;
integer k;
integer m;
assign i_ready[3*`N -2]= i_ready_result;
parameter numloop=$clog2(`N);
parameter loop_ctrl=0;
reg check_reg;
reg check_reg_1;
//reg check_reg_2 = 1 ;
//reg check_reg_3 = 1;


initial 
 begin
  valid_1<=0;
  valid_2<=0;
 end

 reg valid_m_1;
(*dont_touch="true"*) reg valid_m_2;
 

always@(posedge clk)
begin
if(main_i_valid_1 & main_i_valid_2)
 begin
 for(i=0;i<`N;i=i+1)
  begin 
  i_data_1[i]<=vect_A[i*32+:32];
  i_data_2[i]<=vect_B[i*32+:32];
 
  end
  //valid_1<=1;
  //valid_2<=1;
  valid_m_1<=1;
  valid_m_2<=1;
 end
 else 
   begin
     //valid_1<=0;
     //valid_2<=0;
	 valid_m_1<=0;
     valid_m_2<=0;
   end   
end

always @(posedge clk)
  begin 
    main_o_data <= o_data[3*`N -2];
	o_valid_result<=o_valid[3*`N -2];
	main_o_ready_1<=o_ready_1[0];
	main_o_ready_2<=o_ready_2[0];
	//i_ready[3*`N -2]<=i_ready_result;
  end
  
reg valid_t_1;
reg  valid_t_2;

 



generate
genvar x, y, z; 
for (x=0;x<numloop+1;x=x+1) begin:xs
  if(x==0)
   begin: instnce
   for (y=0; y<`N; y=y+1) begin:ys    
		 	float_mult my_mult_instance(
             .aclk(clk),                                  // input wire aclk
             .s_axis_a_tvalid(valid_m_1),            // input wire s_axis_a_tvalid
             .s_axis_a_tready(o_ready_1[y]),            // output wire s_axis_a_tready
             .s_axis_a_tdata(i_data_1[y]),              // input wire [31 : 0] s_axis_a_tdata
             .s_axis_b_tvalid(valid_m_2),            // input wire s_axis_b_tvalid
             .s_axis_b_tready(o_ready_2[y]),            // output wire s_axis_b_tready
             .s_axis_b_tdata(i_data_2[y]),              // input wire [31 : 0] s_axis_b_tdata
             .m_axis_result_tvalid(o_valid[`N+y]),  // output wire m_axis_result_tvalid
             .m_axis_result_tready(i_ready[`N+y]),  // input wire m_axis_result_tready
             .m_axis_result_tdata(o_data[`N+y])    // output wire [31 : 0] m_axis_result_tdata
           );
		  end
		end

	else
     
     begin: instnce
      for(z=0;z< `N/(2**(x-1));z=z+2) begin:zs
	       float_add my_adder_instance (
           .aclk(clk),                                  // input wire aclk
           .s_axis_a_tvalid(o_valid[2**`i+2**(`i+1)-2**(`i+2-x)+z]),            // input wire s_axis_a_tvalid
           .s_axis_a_tready(i_ready[2**`i+2**(`i+1)-2**(`i+2-x)+z]),            // output wire s_axis_a_tready
           .s_axis_a_tdata(o_data[2**`i+2**(`i+1)-2**(`i+2-x)+z]),              // input wire [31 : 0] s_axis_a_tdata
           .s_axis_b_tvalid(o_valid[2**`i+2**(`i+1)-2**(`i+2-x)+z+1]),            // input wire s_axis_b_tvalid
           .s_axis_b_tready(i_ready[2**`i+2**(`i+1)-2**(`i+2-x)+z+1]),            // output wire s_axis_b_tready
           .s_axis_b_tdata(o_data[2**`i+2**(`i+1)-2**(`i+2-x)+z+1]),              // input wire [31 : 0] s_axis_b_tdata
           .m_axis_result_tvalid(o_valid[2**`i+2**(`i+1)-2**(`i-x+1)+(z/2)]),  // output wire m_axis_result_tvalid
           .m_axis_result_tready(i_ready[2**`i+2**(`i+1)-2**(`i-x+1)+(z/2)]),  // input wire m_axis_result_tready
           .m_axis_result_tdata(o_data[2**`i+2**(`i+1)-2**(`i-x+1)+(z/2)])    // output wire [31 : 0] m_axis_result_tdata
         );
	   
	   end
	end
   end

   

  endgenerate
endmodule