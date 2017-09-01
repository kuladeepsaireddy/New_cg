`timescale 1ns / 1ps
`define nx 2
`define ny 2
`define N `nx*`ny
`define size $clog2(`N)
//3f80000040000000
//4040000040800000
module cg_top(
input wire clk,
input wire [31:0] b,
input wire i_valid,
output reg [31:0] sol,
output reg  o_ready,
output reg o_valid,
input wire [31:0] epsilon
 );
//reg [31:0] r;
//reg [31:0] u;
//reg[31:0] w;
//reg[31:0] m;
reg[31:0] beta;
reg[31:0] gamma;
reg[31:0] gamma_old;
reg[31:0] delta;
reg[31:0] alpha;
reg  count;
reg [`size-1:0] op_counter;
reg [`size-1:0] op_counter_1;
reg [`size-1:0] op_counter_2;
reg [`size-1:0] op_counter_3;
reg [`size-1:0] op_counter_4;
reg [`size-1:0] op_counter_5;
reg [`size-1:0] op_counter_6;
reg [`size-1:0] op_counter_7;



reg result_counter;
reg final_reg;

 




reg[31:0] vect_mat_mult;
reg i_valid_mat_mult;
wire [31:0]o_data_mat_mult;
wire o_valid_mat_mult;
reg i_ready_mat_mult;
//wire end_sig_mat_mult;

reg wea_r;
reg[9:0]addra_r;
reg[31:0]r;
reg [9:0]addrb_r;
wire [31:0] doutb_r;

reg wea_u;
reg[9:0]addra_u;
reg[31:0]u;
reg [9:0]addrb_u;
wire [31:0] doutb_u;


reg wea_w;
reg[9:0]addra_w;
reg[31:0]w;
reg [9:0]addrb_w;
wire [31:0] doutb_w;

reg wea_m;
reg[9:0]addra_m;
reg[31:0]m;
reg [9:0]addrb_m;
wire [31:0] doutb_m;

reg wea_n;
reg[9:0]addra_n;
reg[31:0]n;
reg [9:0]addrb_n;
wire [31:0] doutb_n;


reg wea_z;
reg[9:0]addra_z;
reg[31:0]z;
reg [9:0]addrb_z;
wire [31:0] doutb_z;

reg wea_q;
reg[9:0]addra_q;
reg[31:0]q;
reg [9:0]addrb_q;
wire [31:0] doutb_q;

reg wea_s;
reg[9:0]addra_s;
reg[31:0]s;
reg [9:0]addrb_s;
wire [31:0] doutb_s;



reg wea_p;
reg[9:0]addra_p;
reg[31:0]p;
reg [9:0]addrb_p;
wire [31:0] doutb_p;

reg wea_x;
reg[9:0]addra_x;
reg[31:0]x;
reg [9:0]addrb_x;
wire [31:0] doutb_x;

reg wea_b;
reg[9:0]addra_b;
//reg[31:0]b;
reg [9:0]addrb_b;
wire [31:0] doutb_b;


//reg wea_r;
//reg[9:0]addra_r;
//reg[31:0]r;
reg [7:0]addrb_r_L;
wire [(32*`N)-1:0]  doutb_r_L; 

//reg wea_u;
//reg[9:0]addra_u;
//reg[31:0]u;
reg [7:0]addrb_u_L;
wire [(32*`N)-1:0]  doutb_u_L; 

//reg wea_w;
//reg[9:0]addra_w;
//reg[31:0]w;
reg [7:0]addrb_w_L;
wire [(32*`N)-1:0]  doutb_w_L; 
wire rstb;



reg [31:0] i_data_1_vect_1;
reg [31:0]i_data_2_vect_1;
reg[31:0] i_data_scalar_1;
reg i_data_1_valid_1;
reg i_data_2_valid_1;
reg i_data_scalar_valid_1;
wire o_ready_1_1;
wire o_ready_2_1;
wire o_ready_scalar_1;
wire o_data_1;
wire o_valid_1;
reg i_ready_1;


reg [31:0] i_data_1_vect_2;
reg [31:0]i_data_2_vect_2;
reg[31:0] i_data_scalar_2;
reg i_data_1_valid_2;
reg i_data_2_valid_2;
reg i_data_scalar_valid_2;
wire o_ready_1_2;
wire o_ready_2_2;
wire o_ready_scalar_2;
wire o_data_2;
wire o_valid_2;
reg i_ready_2;

reg [31:0] i_data_1_vect_3;
reg [31:0]i_data_2_vect_3;
reg[31:0] i_data_scalar_3;
reg i_data_1_valid_3;
reg i_data_2_valid_3;
reg i_data_scalar_valid_3;
wire o_ready_1_3;
wire o_ready_2_3;
wire o_ready_scalar_3;
wire o_data_3;
wire o_valid_3;
reg i_ready_3;


reg [31:0] i_data_1_vect_4;
reg [31:0]i_data_2_vect_4;
reg[31:0] i_data_scalar_4;
reg i_data_1_valid_4;
reg i_data_2_valid_4;
reg i_data_scalar_valid_4;
wire o_ready_1_4;
wire o_ready_2_4;
wire o_ready_scalar_4;
wire o_data_4;
wire o_valid_4;
reg i_ready_4;

reg [(32*`N)-1:0]vect_A_vect_mult;
reg [(32*`N)-1:0]vect_B_vect_mult;
wire [31:0] o_data_vect_mult;
reg i_valid_1_vect_mult;
reg i_valid_2_vect_mult;
wire o_ready_1_vect_mult;
wire o_ready_2_vect_mult;
wire o_valid_result_vect_mult;
reg i_ready_result_vect_mult;


reg [31:0]i_data_1_div_1;	
reg[31:0]i_data_2_div_1;
reg i_valid_1_div_1;
reg i_valid_2_div_1;
wire o_ready_1_div_1;
wire o_ready_2_div_1;	
wire [31:0] o_data_div_1;
wire o_valid_result_div_1;
reg i_ready_result_div_1;	
	
	
reg [31:0]i_data_1_div_2;	
reg[31:0]i_data_2_div_2;
reg i_valid_1_div_2;
reg i_valid_2_div_2;
wire o_ready_1_div_2;
wire o_ready_2_div_2;	
wire [31:0] o_data_div_2;
wire o_valid_result_div_2;
reg i_ready_result_div_2;


reg i_valid_1_sub_1;
wire o_ready_1_sub_1;
reg[31:0] i_data_1_sub_1;
reg i_valid_2_sub_1;
wire o_ready_2_sub_1;
reg [31:0] i_data_2_sub_1;
wire o_valid_sub_result_1;
wire  i_ready_sub_result_1;
wire [31:0] o_data_sub_result_1;




//reg o_valid_sub_result_1;
//wire i_ready_sub_result_1;
reg [31:0]_data_sub_result_1;
wire o_valid_result_reci;
reg i_ready_result_reci;
wire [31:0]o_data_result_reci;

	
reg i_valid_1_sub_2;
wire o_ready_1_sub_2;
reg[31:0] i_data_1_sub_2;
reg i_valid_2_sub_2;
wire o_ready_2_sub_2;
reg [31:0] i_data_2_sub_2;
wire o_valid_sub_result_2;
reg i_ready_sub_result_2;
wire [31:0] o_data_sub_result_2;


reg [`size:0] wr_addr;
reg [`size-1:0] wr_addr_2;
reg [`size-1:0] wr_addr_3;
reg [`size-1:0] wr_addr_4;
reg [`size-1:0] wr_addr_5;
reg [`size-1:0] wr_addr_6;
reg [`size-1:0] wr_addr_7;
reg [`size-1:0] wr_addr_8;
reg [`size-1:0] wr_addr_9;
reg [`size-1:0] wr_addr_r;
reg [`size-1:0] wr_addr_x;
reg [`size-1:0] wr_addr_q;
reg [`size-1:0] wr_addr_s;


reg flag_1;
reg flag_2;
reg flag_3;
reg flag_4;
reg flag_5;
reg flag_6;
reg flag_7;
reg flag_b;
reg flag_d;
reg flag_s;
reg flag_x;
reg flag_y;
reg flag_z;


reg final_flag;
reg check_flag;
reg [`size-1:0]check_reg;
reg [`size-1:0]sol_reg;
reg [`size-1:0] count_check;


reg end_flag_1;
reg end_flag_2;
reg end_flag_3;
reg end_flag_4;
reg end_flag_5;
reg end_flag_6;
reg end_flag_7;
reg end_flag_8;
reg end_flag_9;
reg end_flag_10;

initial
begin
 final_reg<=0;
  wr_addr<=0;
	 wr_addr_2<=0;
	 wr_addr_3<=0;
	 wr_addr_4<=0;
	 wr_addr_5<=0;
	 wr_addr_6<=0;
	 wr_addr_7<=0;
	 wr_addr_8<=0;
	 wr_addr_9<=0;
	 wr_addr_r<=0;
	 wr_addr_x<=0;
	 wr_addr_q<=0;
	 wr_addr_s<=0;
	 op_counter<=0;
	 op_counter_1<=0;
	 op_counter_2<=0;
	 op_counter_3<=0;
	 op_counter_4<=0;
	 op_counter_5<=0;
	 op_counter_6<=0;
	 op_counter_7<=0;
	 flag_1<=0;
	 flag_2<=0;
	 flag_3<=0;
	 flag_4<=0;
	 flag_5<=0;
	 flag_6<=0;
	 flag_7<=0;
	 flag_b<=0;
	 flag_d<=0;
	 flag_s<=0;
	 flag_x<=0;
	 flag_y<=0;
	 flag_z<=0;
	 count<=0;
	 final_flag<=0;
	 check_flag<=0;
	 check_reg<=0;
	 count_check<=0; 
	 sol_reg<=0;
	 end_flag_1<=0;
	 end_flag_2<=0;
	 end_flag_3<=0;
	 end_flag_4<=0;
	 end_flag_5<=0;
	 end_flag_6<=0;
	 end_flag_7<=0;
	 end_flag_8<=0;
	 end_flag_9<=0;
	 end_flag_10<=0;
	 i_valid_1_vect_mult<=1'b0;
	 i_valid_2_vect_mult<=1'b0;
	 addrb_r_L<=0;
end
always@(posedge clk)
begin
o_ready<=1'b1;
end

/*
always@(posedge clk)
 begin
   if(i_valid)
     begin
	  r<=b;
	 wea_r<=1;
	 wea_b<=1;
	 addra_r<= wr_addr;
	 addra_b<=wr_addr;
	 u<=r;
	 wea_u<=1;
	 addra_u<=wr_addr;
	 p<=u;
	 wea_p<=1'b1;
	 addra_p<=wr_addr;
     
	 wr_addr<=wr_addr+1;
	 //i_ready_mat_mult<=1'b1;
	 end
	 
	else
	  begin
        i_valid_mat_mult<=1'b0;
      end  
 end  

 */
always@(posedge clk)
 begin
  if(i_valid)
   begin
    wr_addr<=wr_addr+1;
   end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg)
   begin
    wr_addr<=0;
   end
 else if(final_flag & count_check==`N)
  begin 
   wr_addr<=0;
  end  
 end 
 
always@(posedge clk)
 begin
  if(o_valid_2 & !final_reg & !count)
   begin
     wr_addr_6<=wr_addr_6+1;
   end	
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg)
   begin
   wr_addr_6<=0;
   end
  else if(final_flag & count_check==`N)
   begin
    wr_addr_6<=0;
   end   
 end 
 
always@(posedge clk)
 begin
   if(!final_reg & count &o_valid_2 & !end_flag_4)
    begin
	 wr_addr_r<=wr_addr_r+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg)
   begin
     wr_addr_r<=0;
   end
  else if(final_flag & count_check==`N)
   begin
      wr_addr_r<=0;
   end   
 end 

always@(posedge clk)
 begin
   if(o_valid_3 &  !final_reg & !count)
    begin
	 wr_addr_7<=wr_addr_7+1;
	end 
  else if(o_valid_3 &  !final_reg & count & !end_flag_7)
   begin
    wr_addr_7<=wr_addr_7+1;
   end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_7<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_7<=0;
   end     
 end 
 

always@(posedge clk)
 begin
   if(!final_reg & count & o_valid_1 & !end_flag_1)
    begin
	 wr_addr_5<=wr_addr_5+1;
	end 
  else if(!final_reg & !count & o_valid_1)
   begin
    wr_addr_5<=wr_addr_5+1;
   end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_5<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_5<=0;
   end     
 end 

 
always@(posedge clk)
 begin
   if(!final_reg & !count & o_valid_mat_mult & !flag_3 )
    begin
	 wr_addr_2<=wr_addr_2+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_2<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_2<=0;
   end     
 end  
 
 
 always@(posedge clk)
 begin
   if(o_valid_4 & !final_reg & !count)
    begin
	 wr_addr_8<=wr_addr_8+1;
	end 
  else  if(o_valid_4 & !final_reg & count & !end_flag_10)
  begin
    wr_addr_8<=wr_addr_2+1;
  end  
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_8<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_8<=0;
   end     
 end  
 
 
 always@(posedge clk)
 begin
   if(o_valid_2 & !final_reg & count & !end_flag_3)
    begin
	 wr_addr_s<=wr_addr_s+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_s<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_s<=0;
   end     
 end  
 
 
 
  always@(posedge clk)
 begin
   if(!final_reg & count & o_valid_3 & !end_flag_6)
    begin
	 wr_addr_q<=wr_addr_q+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_q<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_q<=0;
   end     
 end  
 
   always@(posedge clk)
 begin
   if(!final_reg & !count & wr_addr_2==`N-1 & o_valid_mat_mult & flag_3)
    begin
	 wr_addr_4<=wr_addr_4+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_4<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_4<=0;
   end     
 end  
 
 
   always@(posedge clk)
 begin
   if(!final_reg & count & o_valid_4 & !end_flag_9)
    begin
	 wr_addr_9<=wr_addr_9+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_9<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_9<=0;
   end     
 end  
 
 
 
    always@(posedge clk)
 begin
   if(!final_reg & count & o_valid_1 & !end_flag_2)
    begin
	 wr_addr_x<=wr_addr_x+1;
	end 
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_x<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_x<=0;
   end     
 end  
 
 
 
 always@(posedge clk)
 begin
   if(!final_reg & !count & wr_addr_2==`N-1)
    begin
	 wr_addr_3<=wr_addr_3+1;
	end 
  else  if(!final_reg & count )
  begin
    wr_addr_3<=wr_addr_3+1;
  end  
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
   begin
      wr_addr_3<=0;
   end
   else if(!final_flag & count_check==`N )
   begin
      wr_addr_3<=0;
   end     
 end  
 
 
 
always@(posedge clk)    /// b block
 begin
  if(i_valid)
   begin
    wea_b<=1;
	addra_b<=addra_b+1;
    
   end
 else 
   begin
    wea_b<=0;
   end

 end 
 
 
 
always@(posedge clk)    /// r block
 begin
   if(i_valid)
    begin
	 r<=b;
	 wea_r<=1;
	 addra_r<= wr_addr;
	// wr_addr<=wr_addr+1;
	end
   else if(o_valid_2 & !final_reg & !count)
    begin
	  r<=o_data_2;
	  wea_r<=1'b1;
	  addra_r<=wr_addr_6;
	  //wr_addr_6<=wr_addr_6+1;
	
	end
  else if(!final_reg & count &o_valid_2 & !end_flag_4)
   begin
     r<=o_data_2;
	  wea_r<=1'b1;
	  addra_r<=wr_addr_r;
	  //wr_addr_r<=wr_addr_r+1;
   end   
 end 
 
 
always@(posedge clk)    /// u block
 begin
   if(i_valid)
    begin
	 u<=b;
	 wea_u<=1;
	 addra_u<=wr_addr;
	end
  else if(o_valid_3 &  !final_reg & !count )
   begin
      u<=o_data_3;
	  wea_u<=1'b1;
	  addra_u<=wr_addr_7;
	  //wr_addr_7<=wr_addr_7+1;
      
   end
  else if(o_valid_3 &  !final_reg & count & !end_flag_7 )
    begin
      u<=o_data_3;
	  wea_u<=1'b1;
	  addra_u<=wr_addr_7;
	  //wr_addr_7<=wr_addr_7+1;
    end		
 end 
 
 
  
always@(posedge clk)    /// p block
 begin
   if(i_valid)
    begin
	 p<=b;
	 wea_p<=1'b1;
	 addra_p<=wr_addr;
	end
  else if(!final_reg & count & o_valid_1 & !end_flag_1)
    begin
	  p<=o_data_1;
	  wea_p<=1'b1;
	  addra_p<=wr_addr_5;
	  //wr_addr_5<=wr_addr_5+1;
	 end 
 end 
 
 
  
always@(posedge clk)    /// w block
 begin
   if(!final_reg & !count & o_valid_mat_mult & !flag_3 )
     begin 
       w<=o_data_mat_mult;	                              //w=A*u
	   wea_w<=1'b1;
	   addra_w<=wr_addr_2;
	   //wr_addr_2<=wr_addr_2+1;
	end
  else if(o_valid_4 & !final_reg & !count)
   begin
      w<=o_data_4;
	  wea_w<=1'b1;     
	  addra_w<=wr_addr_8;
	  //wr_addr_8<=wr_addr_8+1;
   end
  else  if(o_valid_4 & !final_reg & count & !end_flag_10)
  begin
     w<=o_data_4;
	  wea_w<=1'b1;     
	  addra_w<=wr_addr_8;
	  //wr_addr_8<=wr_addr_8+1;
  end  
 end 
 
 
 
 
  
always@(posedge clk)    /// m block
 begin
   if(!final_reg & !count & o_valid_mat_mult & !flag_3)     //w=A*u
    begin
	 m<=o_data_mat_mult;	   
	   wea_m<=1'b1;
	   addra_m<=wr_addr_2;
	end
  else if(o_valid_4 & !final_reg & !count)
   begin
      m<=o_data_4;
	  wea_m<=1'b1;     
	  addra_m<=wr_addr_8;
	  //wr_addr_8<=wr_addr_8+1;
   end
   else  if(o_valid_4 & !final_reg & count & !end_flag_10)
  begin
     m<=o_data_4;
	  wea_m<=1'b1;     
	  addra_m=wr_addr_8;
	  //wr_addr_8<=wr_addr_8+1;
  end  
 end 
 
 
 always@(posedge clk)    /// s block
 begin
   if(!final_reg & !count & o_valid_mat_mult & !flag_3)   //w=A*u
    begin
	   s<=o_data_mat_mult;
	   wea_s<=1'b1;
	   addra_s<=wr_addr_2;
	end
  else if(o_valid_2 & !final_reg & count & !end_flag_3)
    begin
	  s<=o_data_2;
	  wea_s<=1'b1;
	  addra_s<=wr_addr_s;
	  //wr_addr_s<=wr_addr_s+1;
   end 
  end
 
always@(posedge clk)    /// q block
 begin
   if(!final_reg & !count & o_valid_mat_mult & !flag_3)   //w=A*u
    begin
	  q<=o_data_mat_mult;
	   wea_q<=1'b1;
	   addra_q<=wr_addr_2;
	end
  else if(!final_reg & count & o_valid_3 & !end_flag_6 )
   begin
      q<=o_data_3;
	   wea_q<=1'b1;
	   addra_q<=wr_addr_q;
	   //wr_addr_q<=wr_addr_q+1;
   end
 end 
  
  

 
always@(posedge clk)    /// z block
 begin
   if(!final_reg & !count & wr_addr_2==`N-1 & o_valid_mat_mult & flag_3)   //n=A*m
    begin
	 z<=o_data_mat_mult;
	 wea_z<=1'b1;
	 addra_z<=wr_addr_4;
	 //wr_addr_4<=wr_addr_4+1;
	end
  else if(!final_reg & count & o_valid_4 & !end_flag_9)
   begin
      z<=o_data_4;
	  wea_z<=1'b1;
	  addra_z<=wr_addr_9;
	  //wr_addr_9<=wr_addr_9+1;
   end
 end 
 
 
 
  
always@(posedge clk)    /// n block
 begin
   if(!final_reg & !count & wr_addr_2==`N-1 & o_valid_mat_mult & flag_3)    //n=A*m
    begin
	   n<=o_data_mat_mult;
	   wea_n<=1'b1;
	   addra_n<=wr_addr_4;
	   
	end
   if(!final_reg & count & o_valid_mat_mult& flag_3)   //n=A*m
    begin
	  n<=o_data_mat_mult;
	   wea_n<=1'b1;
	   addra_n<= wr_addr_4;
	end
 end 
 
 
 

 
always@(posedge clk)    /// x block
 begin
   if(!final_reg & !count & o_valid_1)
    begin
	  x<=o_data_1;
	  wea_x<=1'b1;
	  addra_x<=wr_addr_5;
	  //wr_addr_5<=wr_addr_5+1;
	end
  else if(!final_reg & count & o_valid_1 & !end_flag_2 )
   begin
     x<=o_data_1;
	 wea_x<=1'b1;
	 addra_x<=wr_addr_x;
	 //wr_addr_x<=wr_addr_x+1;
   
   end
 end   
 
 
 
 
 always@(posedge clk)                 ///  matrix multiplication block
  begin
   if(i_valid)                             //w=A*u
    begin
	 vect_mat_mult<=b;
	 i_valid_mat_mult<=1'b1;
	i_ready_mat_mult<=1'b1;
	end
   else if(!final_reg & !count & wr_addr_2==`N-1)                               //n=A*m
    begin
      vect_mat_mult<=doutb_m;
		addrb_m<=wr_addr_3;
		i_valid_mat_mult<=1'b1;
		i_ready_mat_mult<=1'b1; 
       //wr_addr_3<=wr_addr_3+1;
	   flag_3<=1;
    end
   else if (!final_reg & count )	  ////n= A*m
    begin
	   vect_mat_mult<=doutb_m;
		addrb_m<=wr_addr_3;
		i_valid_mat_mult<=1'b1;
		i_ready_mat_mult<=1'b1; 
       //wr_addr_3<=wr_addr_3+1;
	   flag_3<=1;
	
	end
	
	else if(!final_reg & count & o_valid_1 & !end_flag_2)  //final check A*x
	 begin
	     vect_mat_mult<=o_data_1;
	     i_valid_mat_mult<=1'b1;
		 i_ready_mat_mult<=1'b1; 
		 check_flag<=1;
	 end
	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
         check_flag<=0;
		 flag_3<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        check_flag<=0;
		 flag_3<=0;
      end	  
   else
     begin
	  i_valid_mat_mult<=1'b0;
	 end
  
  end
 
 
 /*
always@(posedge clk)
 begin
   if(!final_reg & !count & o_valid_mat_mult & !flag_3 )
     begin 
       w<=o_data_mat_mult;	   ///data coming from matrix multiplier is stored in block ram w and block ram w_L/////
	   wea_w<=1'b1;
	   addra_w<=wr_addr_2;    
	   m<=w;	   
	   wea_m<=1'b1;
	   addra_m<=wr_addr_2;
	   q<=m;
	   wea_q<=1'b1;
	   addra_q<=wr_addr_2;
	   s<=w;
	   wea_s<=1'b1;
	   addra_s<=wr_addr_2;
	   wr_addr_2<=wr_addr_2+1;
     end
  else if(!final_reg & !count & wr_addr_2==`N-1 & o_valid_mat_mult & flag_3)
   begin
        n<=o_data_mat_mult;
		z<=n;
	    wea_n<=1'b1;
		wea_z<=1'b1;
	    addra_n<=wr_addr_4;
		addra_z<=wr_addr_4;
        wr_addr_4<=wr_addr_4+1;
   
   end
 end  
 
 */
 
 
 
always@(posedge clk)            ////////for vector multiplication
 begin
  if(!final_reg & !count & wr_addr ==`N & o_ready_1_vect_mult& o_ready_2_vect_mult & !flag_1  )   ///gamma = r*u
   begin
     vect_A_vect_mult<=doutb_r_L;
		addrb_r_L<=0;
		vect_B_vect_mult<=doutb_u_L;
		addrb_u_L<=0;
		i_valid_1_vect_mult<=1'b1;
		i_valid_2_vect_mult<=1'b1;
		i_ready_result_vect_mult<=1'b1;
		flag_1<=1'b1;
		//wr_addr<=0;
   end
  
  else if(!final_reg & !count & wr_addr_2==`N-1 & o_ready_1_vect_mult& o_ready_2_vect_mult & wr_addr==`N-1) ///for vector mult delta =w*u
   begin
        vect_A_vect_mult<=doutb_w_L;
		addrb_w_L<=0;
		vect_B_vect_mult<=doutb_u_L;
		addrb_u_L<=0;
		i_valid_1_vect_mult<=1'b1;
		i_valid_2_vect_mult<=1'b1;
		i_ready_result_vect_mult<=1'b1;
        flag_2<=1'b1;
		//wr_addr_2<=0;
		//wr_addr<=0;
   end
   
   else if(!final_reg & count & o_ready_1_vect_mult& o_ready_2_vect_mult & !flag_1 & flag_4)  ///gamma=r*u
    begin
	   vect_A_vect_mult<=doutb_r_L;
		addrb_r_L<=0;
		vect_B_vect_mult<=doutb_u_L;
		addrb_u_L<=0;
		i_valid_1_vect_mult<=1'b1;
		i_valid_2_vect_mult<=1'b1;
		i_ready_result_vect_mult<=1'b1;
		flag_1<=1'b1;
	
	end
  else if(!final_reg & count & o_ready_1_vect_mult& o_ready_2_vect_mult & !flag_2)	 //delta = w*u
   begin
      vect_A_vect_mult<=doutb_w_L;
		addrb_w_L<=0;
		vect_B_vect_mult<=doutb_u_L;
		addrb_u_L<=0;
		i_valid_1_vect_mult<=1'b1;
		i_valid_2_vect_mult<=1'b1;
		i_ready_result_vect_mult<=1'b1;
		flag_2<=1'b1;
   end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        flag_1<=0; 
		flag_2<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     flag_1<=0;
	 flag_2<=0;
     end	   
  else
   begin
    i_valid_1_vect_mult<=1'b0;
	i_valid_2_vect_mult<=1'b0;
	//flag_1<=0;
	//flag_2<=0;
   end 
 end 
 
 
 
 
 
 
 always@(posedge clk)
  begin
    if(!final_reg & !count & flag_1 & o_valid_result_vect_mult)   ///asssingning gamma= r*u for 1st iteration
 	  begin
	   gamma<=o_data_vect_mult;
	   flag_4<=1;
	  end
	else if(!final_reg & count & !flag_4)
     begin
       gamma_old<=gamma;
	   flag_4<=1;
     end
    else if(!final_reg & count & flag_4 & flag_1 & o_valid_result_vect_mult)  ///gamma = r*u
     begin
        gamma<=o_data_vect_mult;
		flag_x<=1;
     end
	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
         flag_4<=0;
		 flag_x<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_4<=0;
		flag_x<=0;
      end	    
  end 
   
always@(posedge clk)                                                    //asssingning delta= w*u for 1st iteration
 begin
  if(!final_reg & !count & flag_2 & o_valid_result_vect_mult)
	  begin
	   delta<=o_data_vect_mult;
	   flag_5<=1;
	  end
  else if(!final_reg & count & flag_2 & o_valid_result_vect_mult)
   begin
     delta<=o_data_vect_mult;
	   flag_5<=1;
   end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
         flag_5<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_5<=0;
      end	  
 end 
 
 
 


 
always@(posedge clk)       ///////// division block---1
 begin
  if(!final_reg & !count & flag_4 & flag_5 & o_ready_1_div_1 & o_ready_2_div_1  )
	  begin
        i_data_1_div_1<=gamma;
		i_valid_1_div_1<=1'b1;
		i_data_2_div_1=delta;
		 i_valid_2_div_1<=1'b1;
		 i_ready_result_div_1<=1'b1; 
      end
 else if(!final_reg & count & flag_x & flag_5 & o_ready_1_div_1 & o_ready_2_div_1  )
    begin
        i_data_1_div_1<=delta;
		i_valid_1_div_1<=1'b1;
		i_data_2_div_1=gamma ;
		 i_valid_2_div_1<=1'b1;
		 i_ready_result_div_1<=1'b1;
         flag_d<=1;		 
    end
 else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
         flag_d<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_d<=0;	
      end 
 end
 
  always@(posedge clk)   ///division block ---2
  begin
    if(!final_reg & count & flag_4 & flag_x & o_ready_1_div_2 & o_ready_2_div_2  )   ///beta= gamma/gamma_old
	  begin 
        i_data_1_div_2<=gamma;
		i_valid_1_div_2<=1'b1;
		i_data_2_div_2=gamma_old;
		 i_valid_2_div_2<=1'b1;
		 i_ready_result_div_2<=1'b1; 
		 flag_y<=1;
      end
	else if(!final_reg & count & flag_b & o_ready_1_div_2 & o_ready_2_div_2)   // beta/alpha
      begin
        i_data_1_div_2<=beta;
		i_valid_1_div_2<=1'b1;
		i_data_2_div_2=alpha;
		 i_valid_2_div_2<=1'b1;
		 i_ready_result_div_2<=1'b1; 
		 flag_z<=1;

      end
	 else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
         flag_y<=0;
		 flag_z<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_y<=0;
	    flag_z<=0;		
      end  
    else 
	 begin
	  i_valid_1_div_2<=1'b0;
	   i_valid_2_div_2<=1'b0;
	 end
   
  end
 
 
 
 
 always@(posedge clk)                              // ----alpha block
  begin 
    if(!final_reg & !count & flag_4 & flag_5 & o_valid_result_div_1 )
	  begin
         alpha<=o_data_div_1;
		 //beta<=0;
		 flag_6<=1;
      end
	else if(!final_reg & count & flag_s & o_valid_result_reci )
     begin
      alpha<=o_data_result_reci;
	  flag_7<=1;
     end
     else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
         flag_6<=0;
		 flag_7<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_6<=0;
		flag_7<=0;
      end	 
  end
 
 
 always@(posedge clk)                         /// ----beta block
  begin
    if(!final_reg & count &flag_4 & flag_x & o_valid_result_div_2 & flag_y)
     begin
	   beta<=o_data_div_2;
	   flag_b<=1'b1;
	 end
   	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
        flag_b<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_b<=0;
      end	  
  end
 
 
 always@(posedge clk)         /// subtract block ---1
  begin
    if(!final_reg & count & flag_z & o_valid_result_div_2 & flag_d & o_valid_result_div_1 &o_ready_1_sub_1& o_ready_2_sub_1)
	  begin
	    i_data_1_sub_1<=o_data_div_1;
		i_data_2_sub_1<=o_data_div_2;
	   i_valid_1_sub_1<=1'b1;
	   i_valid_2_sub_1<=1'b1;
	   //i_ready_sub_result_1<=1'b1;
	   i_ready_result_reci<=1'b1;
	   flag_s<=1;
	  end
	 else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
      begin
        flag_s<=0;
      end
    else if(!final_flag & count_check==`N)
      begin
        flag_s<=0;
      end	 
    else 
	  begin
	    i_valid_1_sub_1<=1'b1;
	   i_valid_2_sub_1<=1'b1;
	  
	  end
  
  end
 
 always@(posedge clk)          /// subtract block ---2
  begin
    if(!final_reg & count & check_flag & o_valid_mat_mult )
	 begin
	   i_data_1_sub_2<=o_data_mat_mult;
		i_data_2_sub_2<=doutb_b;
		addrb_b<=check_reg;
		//check_reg<=check_reg+1;
	   i_valid_1_sub_2<=1'b1;
	   i_valid_2_sub_2<=1'b1;
	   i_ready_sub_result_2<=1'b1;
	 end
	 else 
	  begin
	     i_valid_1_sub_2<=1'b0;
	     i_valid_2_sub_2<=1'b0;
	  end
   end


 
 

always@(posedge clk)    // cg-op 1 block  for  p and x
  begin
     if(!final_reg & !count & flag_6 & o_ready_1_1 & o_ready_2_1& o_ready_scalar_1 &!end_flag_1  )
	  begin
        i_data_1_vect_1<=0;
	    i_data_2_vect_1<=doutb_p;
	    addrb_p<=op_counter;
	    i_data_scalar_1<=alpha;
	    //op_counter<=op_counter+1;
	    i_data_1_valid_1<=1'b1;
	    i_data_2_valid_1<=1'b1;
	    i_data_scalar_valid_1<=1'b1;
	    i_ready_1<=1'b1;
	   /*if(op_counter==`N)
	    begin
		 end_flag_1<=1;
		end*/
	   end	
		//op_flag_1
     
     else if(!final_reg & count &  o_ready_1_1 & o_ready_2_1& o_ready_scalar_1 & flag_b & !end_flag_1 )  //p
	   begin
	     i_data_1_vect_1<=doutb_u;
	    i_data_2_vect_1<=doutb_p;
	    addrb_p<=op_counter;
		addrb_u<=op_counter;
	    i_data_scalar_1<=beta;
	    //op_counter<=op_counter+1;
	    i_data_1_valid_1<=1'b1;
	    i_data_2_valid_1<=1'b1;
	    i_data_scalar_valid_1<=1'b1;
	    i_ready_1<=1'b1;
       /*if(op_counter==`N)
	    begin
		 end_flag_1<=1;
		end*/
	   end
	   
	  else if(!final_reg & count &  o_ready_1_1 & o_ready_2_1& o_ready_scalar_1 & flag_7  &!end_flag_2 & wr_addr_5>2) //x
	    begin
		  i_data_1_vect_1<=doutb_x;
	      i_data_2_vect_1<=doutb_p;
	      addrb_x<=op_counter_4;
		  addrb_p<=op_counter_4;
	       i_data_scalar_1<=alpha;
	      //op_counter_4<=op_counter_4+1;
	      i_data_1_valid_1<=1'b1;
	      i_data_2_valid_1<=1'b1;
	      i_data_scalar_valid_1<=1'b1;
	      i_ready_1<=1'b1;
         /*if(op_counter_4==`N)
	      begin
		   end_flag_2<=1;
		  end*/
	   end
		end
  

 
 always@(posedge clk)    // cg-op 2 block  for s and r 
  begin
    if(!final_reg & !count & flag_6 &  addra_s >1 & o_ready_1_2& o_ready_2_2& o_ready_scalar_2 & !end_flag_3)/////r
	  begin
	    i_data_1_vect_2<=doutb_r;
	    i_data_2_vect_2<=doutb_s;
	    addrb_r<=op_counter_1;
		addrb_s<=op_counter_1;
	    i_data_scalar_2<=alpha;
	    //op_counter_1<=op_counter_1+1;
	    i_data_1_valid_2<=1'b1;
	    i_data_2_valid_2<=1'b1;
	    i_data_scalar_valid_2<=1'b1;
	    i_ready_2<=1'b1;
	    /* if(op_counter_1==`N)
	    begin
		  end_flag_3<=1;
		end	*/
	
	  end
	  
	 else if(!final_reg & count &  o_ready_1_2 & o_ready_2_2& o_ready_scalar_2 & flag_b & !end_flag_3)///s
       begin
          i_data_1_vect_2<=doutb_w;
	    i_data_2_vect_2<=doutb_s;
	    addrb_w=op_counter_1;
		addrb_s<=op_counter_1;
	    i_data_scalar_2<=beta;
	    //op_counter_1<=op_counter_1+1;
	    i_data_1_valid_2<=1'b1;
	    i_data_2_valid_2<=1'b1;
	    i_data_scalar_valid_2<=1'b1;
	    i_ready_2<=1'b1;
       /*if(op_counter_1==`N)
	    begin
		  end_flag_3<=1;
		end*/
       end

     else if(!final_reg & count  &  wr_addr_s >1 & o_ready_1_2& o_ready_2_2& o_ready_scalar_2 & !end_flag_4 & flag_7)	   ////r
	  begin
	  i_data_1_vect_2<=doutb_r;
	    i_data_2_vect_2<=doutb_s;
	    addrb_r<=op_counter_5;
		addrb_s<=op_counter_5;
	    i_data_scalar_2<=alpha;
	    //op_counter_5<=op_counter_5+1;
	    i_data_1_valid_2<=1'b1;
	    i_data_2_valid_2<=1'b1;
	    i_data_scalar_valid_2<=1'b1;
	    i_ready_2<=1'b1;
	   /*if(op_counter_5 ==`N)
	    begin
		 end_flag_4<=1;
		end*/
	  end
  end 

 always@(posedge clk)    // cg-op 3 block  for q and u
  begin
    if(!final_reg & !count & flag_6 & addra_q >1 & o_ready_1_3& o_ready_2_3 & o_ready_scalar_3  & !end_flag_5) //u
	  begin
        i_data_1_vect_3<=doutb_u;
	    i_data_2_vect_3<=doutb_q;
	    addrb_u<=op_counter_2;
		addrb_q<=op_counter_2;
	    i_data_scalar_3<=alpha;
	    //op_counter_2<=op_counter_2+1;
	    i_data_1_valid_3<=1'b1;
	    i_data_2_valid_3<=1'b1;
	    i_data_scalar_valid_3<=1'b1;
	    i_ready_3<=1'b1;
		/*if(op_counter_2 ==`N)
	    begin
		 end_flag_5<=1;
		end*/
      end
	  
	else if (!final_reg & count & flag_b & o_ready_1_3& o_ready_2_3 & o_ready_scalar_3 & !end_flag_6)  //q
     begin
        i_data_1_vect_3<=doutb_m;
	    i_data_2_vect_3<=doutb_q;
	    addrb_m=op_counter_2;
		addrb_q<=op_counter_2;
	    i_data_scalar_3<=beta;
	   // op_counter_2<=op_counter_2+1;
	    i_data_1_valid_3<=1'b1;
	    i_data_2_valid_3<=1'b1;
	    i_data_scalar_valid_3<=1'b1;
	    i_ready_3<=1'b1;
		/*if(op_counter_2 ==`N)
	    begin
		 end_flag_6<=1;
		end*/
      
     end
   else if(!final_reg & count & flag_7 & o_ready_1_3& o_ready_2_3 & o_ready_scalar_3 & wr_addr_q>2 & !end_flag_7)  //u
    begin
      i_data_1_vect_3<=doutb_u;
	    i_data_2_vect_3<=doutb_q;
	    addrb_u<=op_counter_6;
		addrb_q<=op_counter_6;
	    i_data_scalar_3<=alpha;
	    //op_counter_6<=op_counter_6+1;
	    i_data_1_valid_3<=1'b1;
	    i_data_2_valid_3<=1'b1;
	    i_data_scalar_valid_3<=1'b1;
	    i_ready_3<=1'b1;
		/*if(op_counter_6 ==`N)
	    begin
		 end_flag_7<=1;
		end*/

    end	
  end 

 always@(posedge clk)    // cg-op 4 block  for z and w
  begin
    if(!final_reg & !count & flag_6 & addra_z >1 & o_ready_1_4 & o_ready_2_4 & o_ready_scalar_4 & !end_flag_8)///w
      begin
	    i_data_1_vect_4<=doutb_w;
	    i_data_2_vect_4<=doutb_z;
	    addrb_w<=op_counter_3;
		addrb_z<=op_counter_3;
	    i_data_scalar_4<=alpha;
	   // op_counter_3<=op_counter_3+1;
	    i_data_1_valid_4<=1'b1;
	    i_data_2_valid_4<=1'b1;
	    i_data_scalar_valid_4<=1'b1;
	    i_ready_4<=1'b1;
	  /*if(op_counter_3 ==`N)
	    begin
		 end_flag_8<=1;
		end*/	  
	end
   
   else if(!final_reg & count & flag_b & o_ready_1_4 & o_ready_2_4 & o_ready_scalar_4 & !end_flag_9)    ///z
     begin
	   i_data_1_vect_4<=doutb_n;
	    i_data_2_vect_4<=doutb_z;
	    addrb_n<=op_counter_3;
		addrb_z<=op_counter_3;
	    i_data_scalar_4<=beta;
	    //op_counter_3<=op_counter_3+1;
	    i_data_1_valid_4<=1'b1;
	    i_data_2_valid_4<=1'b1;
	    i_data_scalar_valid_4<=1'b1;
	    i_ready_4<=1'b1;
	 /* if(op_counter_3 ==`N)
	    begin
		 end_flag_9<=1;
		end*/
	 end
   else if(!final_reg & count & flag_7 & o_ready_1_4 & o_ready_2_4 & o_ready_scalar_4 & !end_flag_10& wr_addr_9>2) //w
     begin
	   i_data_1_vect_4<=doutb_w;
	    i_data_2_vect_4<=doutb_z;
	    addrb_w<=op_counter_7;
		addrb_z<=op_counter_7;
	    i_data_scalar_4<=alpha;
	    //op_counter_7<=op_counter_7+1;
	    i_data_1_valid_4<=1'b1;
	    i_data_2_valid_4<=1'b1;
	    i_data_scalar_valid_4<=1'b1;
	    i_ready_4<=1'b1;
	 /*if(op_counter_7 ==`N)
	    begin
		 end_flag_10<=1;
		end*/
	 end
  end   



always@(posedge clk)                   // b-ax
 begin
  if(!final_reg & count & o_valid_sub_result_2)
   begin
     if(o_data_sub_result_2 < epsilon)
      begin
        final_flag<=final_flag&1;
		count_check<=count_check+1;
      end	  
   else 
    begin
	 final_flag<=0;
	end
   end
 

 end 
 


always@(posedge clk)
 begin
   if(!final_reg & !count & flag_6 & o_ready_1_1 & o_ready_2_1& o_ready_scalar_1 & !end_flag_1  )
	  begin
	    op_counter<=op_counter+1;
		if(op_counter==`N)
	    begin
		 end_flag_1<=1;
		end
	  end
   else if(!final_reg & count &  o_ready_1_1 & o_ready_2_1& o_ready_scalar_1 & flag_b & !end_flag_1 )  //p
	   begin
        op_counter<=op_counter+1;
		if(op_counter==`N)
	    begin
		 end_flag_1<=1;
		end
	  end
	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter<=0; 
		end_flag_1<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter<=0;
	 end_flag_1<=0;
  
     end	 
 end 

 
 always@(posedge clk)
 begin
   if(!final_reg & !count & flag_6 &  addra_s >1 & o_ready_1_2& o_ready_2_2& o_ready_scalar_2 & !end_flag_3 )
	  begin
	    op_counter_1<=op_counter_1+1;
		if(op_counter_1==`N)
	    begin
		 end_flag_3<=1;
		end
	  end
   else if(!final_reg & count &  o_ready_1_2 & o_ready_2_2& o_ready_scalar_2 & flag_b & !end_flag_3 )  //p
	   begin
         op_counter_1<=op_counter_1+1;
		 if(op_counter_1==`N)
	      begin
		   end_flag_3<=1;
		  end
	  end
	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_1<=0; 
		end_flag_3<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_1<=0;
	 end_flag_3<=0;
  
     end	 
 end 
 
 
always@(posedge clk)
 begin
   if(!final_reg & !count & flag_6 & addra_q >1 & o_ready_1_3& o_ready_2_3 & o_ready_scalar_3  & !end_flag_5 )
	  begin
	    op_counter_2<=op_counter_2+1;
		if(op_counter_2==`N)
	      begin
		   end_flag_5<=1;
		  end
	  end
   else if(!final_reg & count & flag_b & o_ready_1_3& o_ready_2_3 & o_ready_scalar_3 & !end_flag_6)  //p
	   begin
         op_counter_2<=op_counter_2+1;
		 if(op_counter_2==`N)
	      begin
		   end_flag_6<=1;
		  end
	  end
	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_2<=0; 
		end_flag_6<=0;
		end_flag_5<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_2<=0;
     end_flag_6<=0;
     end_flag_5<=0;
     end	 
 end 
 
 
always@(posedge clk)
 begin
   if(!final_reg & !count & flag_6 & addra_z >1 & o_ready_1_4 & o_ready_2_4 & o_ready_scalar_4 & !end_flag_8 )
	  begin
	    op_counter_3<=op_counter_3+1;
		if(op_counter_3==`N)
	      begin
		   end_flag_8<=1;
		  end
	  end
   else if(!final_reg & count & flag_b & o_ready_1_4 & o_ready_2_4 & o_ready_scalar_4 & !end_flag_9)  //p
	   begin
         op_counter_3<=op_counter_3+1;
		 if(op_counter_3==`N)
	      begin
		   end_flag_9<=1;		 
		  end
	  end
	else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_3<=0; 
		end_flag_8<=0;
        end_flag_9<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_3<=0;
     end_flag_8<=0;
     end_flag_9<=0;
     end	 
 end 
 
 
always@(posedge clk)
 begin
  if(!final_reg & count &  o_ready_1_1 & o_ready_2_1& o_ready_scalar_1 & flag_7  &!end_flag_2 & wr_addr_5>2)
    begin
	  op_counter_4<=op_counter_4+1;
	  if(op_counter_4==`N)
	      begin
		   end_flag_2<=1;		 
		  end
	end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_4<=0; 
		end_flag_2<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_4<=0;
     end_flag_2<=0;
     end	 
 
 end
 
always@(posedge clk)
 begin
  if(!final_reg & count  &  wr_addr_s >1 & o_ready_1_2& o_ready_2_2& o_ready_scalar_2 & !end_flag_4 & flag_7)
    begin
	  op_counter_5<=op_counter_5+1;
	  if(op_counter_5==`N)
	      begin
		   end_flag_4<=1;		 
		  end
	end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_5<=0; 
		end_flag_4<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_5<=0;
	 end_flag_4<=0;
 
     end	 
 
 end
 
 
always@(posedge clk)
 begin
  if(!final_reg & count & flag_7 & o_ready_1_3& o_ready_2_3 & o_ready_scalar_3 & wr_addr_q>2 & !end_flag_7)
    begin
	  op_counter_6<=op_counter_6+1;
	  if(op_counter_6==`N)
	      begin
		   end_flag_7<=1;		 
		  end
	end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_6<=0; 
		 end_flag_7<=0;	
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_6<=0;
      end_flag_7<=0;
     end	 
 
 end
 
 
 
always@(posedge clk)
 begin
  if(!final_reg & count & flag_7 & o_ready_1_4 & o_ready_2_4 & o_ready_scalar_4 & !end_flag_10& wr_addr_9>2)
    begin
	  op_counter_7<=op_counter_7+1;
	   if(op_counter_7==`N)
	      begin
		   end_flag_10<=1;		 
		  end
	end
  else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
     begin
        op_counter_7<=0; 
		end_flag_10<=0;
     end
   else if(!final_flag & count_check==`N)	
     begin
     op_counter_7<=0;
     end_flag_10<=0;
     end	 
 
 end
 
 always@(posedge clk)          
  begin
    if(!final_reg & count & check_flag & o_valid_mat_mult )
	 begin
	  check_reg<=check_reg +1; 
	 end
    else if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg)
     begin
	  check_reg<=0;
	 end
    else if(!final_flag & count_check==`N)
	 begin
	   check_reg<=0;
	 end
   end
 
always@(posedge clk)
 begin
  if(wr_addr_5 == `N-1 &  wr_addr_6 == `N-1 &  wr_addr_7 == `N-1  & wr_addr_8 == `N-1 & !count & !final_reg )
    begin
	 count<=1;
	 //sol_reg<=0;
	end 
 end
  
 
 always@(posedge clk)
 begin
  if(final_flag & count_check==`N)
    begin
	 sol<=doutb_x;
	 addrb_x<=sol_reg;
	 sol_reg<=sol_reg+1;
	  if(sol_reg==`N)
	   begin
	    final_reg<=1;
	   end
	end
 else 
   begin
    //count<=1;
	 sol_reg<=0;
   end
 end 
 
 

 cg_matrix_mult matrix_mult_inst(
.clk(clk),
.vect(vect_mat_mult),
.i_valid(i_valid_mat_mult),
.o_data(o_data_mat_mult),
.o_valid(o_valid_mat_mult),
.i_ready(i_ready_mat_mult)
//.end_sig(end_sig_mat_mult)
);


blk_ram blk_ram_r(
  .clka(clk),    // input wire clka
  .wea(wea_r),      // input wire [0 : 0] wea
  .addra(addra_r),  // input wire [9 : 0] addra
  .dina(r),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_r),  // input wire [9 : 0] addrb
  .doutb(doutb_r)  // output wire [31 : 0] doutb
);


blk_ram blk_ram_u(
  .clka(clk),    // input wire clka
  .wea(wea_u),      // input wire [0 : 0] wea
  .addra(addra_u),  // input wire [9 : 0] addra
  .dina(u),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_u),  // input wire [9 : 0] addrb
  .doutb(doutb_u)  // output wire [31 : 0] doutb
);


blk_ram blk_ram_w(
  .clka(clk),    // input wire clka
  .wea(wea_w),      // input wire [0 : 0] wea
  .addra(addra_w),  // input wire [9 : 0] addra
  .dina(w),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_w),  // input wire [9 : 0] addrb
  .doutb(doutb_w)  // output wire [31 : 0] doutb
);


blk_ram blk_ram_m(
  .clka(clk),    // input wire clka
  .wea(wea_m),      // input wire [0 : 0] wea
  .addra(addra_m),  // input wire [9 : 0] addra
  .dina(m),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_m),  // input wire [9 : 0] addrb
  .doutb(doutb_m)  // output wire [31 : 0] doutb
);



blk_ram blk_ram_n(
  .clka(clk),    // input wire clka
  .wea(wea_n),      // input wire [0 : 0] wea
  .addra(addra_n),  // input wire [9 : 0] addra
  .dina(n),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_n),  // input wire [9 : 0] addrb
  .doutb(doutb_n)  // output wire [31 : 0] doutb
);


blk_ram blk_ram_z(
  .clka(clk),    // input wire clka
  .wea(wea_z),      // input wire [0 : 0] wea
  .addra(addra_z),  // input wire [9 : 0] addra
  .dina(z),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_z),  // input wire [9 : 0] addrb
  .doutb(doutb_z)  // output wire [31 : 0] doutb
);


blk_ram blk_ram_q(
  .clka(clk),    // input wire clka
  .wea(wea_q),      // input wire [0 : 0] wea
  .addra(addra_q),  // input wire [9 : 0] addra
  .dina(q),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_q),  // input wire [9 : 0] addrb
  .doutb(doutb_q)  // output wire [31 : 0] doutb
);




blk_ram blk_ram_s(
  .clka(clk),    // input wire clka
  .wea(wea_s),      // input wire [0 : 0] wea
  .addra(addra_s),  // input wire [9 : 0] addra
  .dina(s),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_s),  // input wire [9 : 0] addrb
  .doutb(doutb_s)  // output wire [31 : 0] doutb
);



blk_ram blk_ram_p(
  .clka(clk),    // input wire clka
  .wea(wea_p),      // input wire [0 : 0] wea
  .addra(addra_p),  // input wire [9 : 0] addra
  .dina(p),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_p),  // input wire [9 : 0] addrb
  .doutb(doutb_p)  // output wire [31 : 0] doutb
);



blk_ram blk_ram_x(
  .clka(clk),    // input wire clka
  .wea(wea_x),      // input wire [0 : 0] wea
  .addra(addra_x),  // input wire [9 : 0] addra
  .dina(x),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_x),  // input wire [9 : 0] addrb
  .doutb(doutb_x)  // output wire [31 : 0] doutb
);



blk_ram blk_ram_b(
  .clka(clk),    // input wire clka
  .wea(wea_b),      // input wire [0 : 0] wea
  .addra(addra_b),  // input wire [9 : 0] addra
  .dina(b),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .rstb(rstb),    // input wire rstb
  .addrb(addrb_b),  // input wire [9 : 0] addrb
  .doutb(doutb_b)  // output wire [31 : 0] doutb
);

 

 BRAM_r blk_ram_r_L (
  .clka(clk),    // input wire clka
  .wea(wea_r),      // input wire [0 : 0] wea
  .addra(addra_r),  // input wire [9 : 0] addra
  .dina(r),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .addrb(addrb_r_L),  // input wire [7 : 0] addrb
  .doutb(doutb_r_L)  // output wire [127 : 0] doutb
);
 
 




  BRAM_r blk_ram_u_L(
  .clka(clk),    // input wire clka
  .wea(wea_u),      // input wire [0 : 0] wea
  .addra(addra_u),  // input wire [9 : 0] addra
  .dina(u),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .addrb(addrb_u_L),  // input wire [5 : 0] addrb
  .doutb(doutb_u_L)  // output wire [511 : 0] doutb
);





  BRAM_r blk_ram_w_L(
  .clka(clk),    // input wire clka
  .wea(wea_w),      // input wire [0 : 0] wea
  .addra(addra_w),  // input wire [9 : 0] addra
  .dina(w),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .addrb(addrb_w_L),  // input wire [5 : 0] addrb
  .doutb(doutb_w_L)  // output wire [511 : 0] doutb
);


 cg_op op_block_inst_1(
.clk(clk),
.i_data_vect_1(i_data_1_vect_1),
.i_data_vect_2(i_data_2_vect_1),
.i_data_scalar(i_data_scalar_1),
.i_data_1_valid(i_data_1_valid_1),
.i_data_2_valid(i_data_2_valid_1),
.i_data_scalar_valid(i_data_scalar_valid_1),
.o_ready_1(o_ready_1_1),
.o_ready_2(o_ready_2_1),
.o_ready_scalar(o_ready_scalar_1),
.o_data(o_data_1),
.o_valid(o_valid_1),
.i_ready(i_ready_1)
    
);


 cg_op op_block_inst_2(
.clk(clk),
.i_data_vect_1(i_data_1_vect_2),
.i_data_vect_2(i_data_2_vect_2),
.i_data_scalar(i_data_scalar_2),
.i_data_1_valid(i_data_1_valid_2),
.i_data_2_valid(i_data_2_valid_2),
.i_data_scalar_valid(i_data_scalar_valid_2),
.o_ready_1(o_ready_1_2),
.o_ready_2(o_ready_2_2),
.o_ready_scalar(o_ready_scalar_2),
.o_data(o_data_2),
.o_valid(o_valid_2),
.i_ready(i_ready_2)
    
);




 cg_op op_block_inst_3(
.clk(clk),
.i_data_vect_1(i_data_1_vect_3),
.i_data_vect_2(i_data_2_vect_3),
.i_data_scalar(i_data_scalar_3),
.i_data_1_valid(i_data_1_valid_3),
.i_data_2_valid(i_data_2_valid_3),
.i_data_scalar_valid(i_data_scalar_valid_3),
.o_ready_1(o_ready_1_3),
.o_ready_2(o_ready_2_3),
.o_ready_scalar(o_ready_scalar_3),
.o_data(o_data_3),
.o_valid(o_valid_3),
.i_ready(i_ready_3)
    
);






 cg_op op_block_inst_4(
.clk(clk),
.i_data_vect_1(i_data_1_vect_4),
.i_data_vect_2(i_data_2_vect_4),
.i_data_scalar(i_data_scalar_4),
.i_data_1_valid(i_data_1_valid_4),
.i_data_2_valid(i_data_2_valid_4),
.i_data_scalar_valid(i_data_scalar_valid_4),
.o_ready_1(o_ready_1_4),
.o_ready_2(o_ready_2_4),
.o_ready_scalar(o_ready_scalar_4),
.o_data(o_data_4),
.o_valid(o_valid_4),
.i_ready(i_ready_4)
    
);


 vector_by_vector vect_mult_inst(
.clk(clk),
.vect_A(vect_A_vect_mult),
.vect_B(vect_B_vect_mult),
.main_o_data(o_data_vect_mult),
.main_i_valid_1(i_valid_1_vect_mult),
.main_i_valid_2(i_valid_2_vect_mult),
.main_o_ready_1(o_ready_1_vect_mult),
.main_o_ready_2(o_ready_2_vect_mult),
.o_valid_result(o_valid_result_vect_mult),
.i_ready_result(i_ready_result_vect_mult)

);




cg_scalar_division div_inst_alpha(
.clk(clk),
.i_data_1(i_data_1_div_1),
.i_data_2(i_data_2_div_1),
.i_valid_1(i_valid_1_div_1),
.i_valid_2(i_valid_2_div_1),
.o_ready_1(o_ready_1_div_1),
.o_ready_2(o_ready_2_div_1),
.o_data(o_data_div_1),
.o_valid_result(o_valid_result_div_1),
.i_ready_result(i_ready_result_div_1)
    );

cg_scalar_division div_inst_beta(
.clk(clk),
.i_data_1(i_data_1_div_2),
.i_data_2(i_data_2_div_2),
.i_valid_1(i_valid_1_div_2),
.i_valid_2(i_valid_2_div_2),
.o_ready_1(o_ready_1_div_2),
.o_ready_2(o_ready_2_div_2),
.o_data(o_data_div_2),
.o_valid_result(o_valid_result_div_2),
.i_ready_result(i_ready_result_div_2)
    );


	
/*	
cg_scalar_division div_inst_beta/alpha(
.clk(clk),
.i_data_1(o_data_div_2),
.i_data_2(alpha),
.i_valid_1(o_valid_result_div_2),
.i_valid_2(o_valid_result_div_1),
.o_ready_1(i_ready_result_div_2),
.o_ready_2(o_ready_2_div_2),
.o_data(o_data_div_3),
.o_valid_result(o_valid_result_div_3),
.i_ready_result(i_ready_result_div_3)
    );
cg_scalar_division div_inst_gamma/delta(
.clk(clk),
.i_data_1(gamma),
.i_data_2(delta),
.i_valid_1(i_valid_1_div_4),
.i_valid_2(i_valid_2_div_4),
.o_ready_1(o_ready_1_div_4),
.o_ready_2(o_ready_2_div_4),
.o_data(o_data_div_4),
.o_valid_result(o_valid_result_div_4),
.i_ready_result(i_ready_result_div_4)
    );*/
vect_float_sub sub_inst_1(                                         ///to find alpha
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_sub_1),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_sub_1),            // output wire s_axis_a_tready
  .s_axis_a_tdata(i_data_1_sub_1),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_sub_1),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_sub_1),            // output wire s_axis_b_tready
  .s_axis_b_tdata(i_data_2_sub_1),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_sub_result_1),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_sub_result_1),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_sub_result_1)    // output wire [31 : 0] m_axis_result_tdata
);


reciprocal reci_alpha (
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(o_valid_sub_result_1),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(i_ready_sub_result_1),            // output wire s_axis_a_tready
  .s_axis_a_tdata(o_data_sub_result_1),              // input wire [31 : 0] s_axis_a_tdata
  .m_axis_result_tvalid(o_valid_result_reci),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_reci),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_reci)    // output wire [31 : 0] m_axis_result_tdata
);


vect_float_sub sub_inst_2(                                         ///to find alpha
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_sub_2),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_sub_2),            // output wire s_axis_a_tready
  .s_axis_a_tdata(i_data_1_sub_2),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_sub_2),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_sub_2),            // output wire s_axis_b_tready
  .s_axis_b_tdata(i_data_2_sub_2),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_sub_result_2),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_sub_result_2),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_sub_result_2)    // output wire [31 : 0] m_axis_result_tdata
);	
endmodule
