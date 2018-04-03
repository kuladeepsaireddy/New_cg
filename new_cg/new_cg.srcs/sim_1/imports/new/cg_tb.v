`include "../../../../include_file.v"



module cg_tb(	
);
reg clk;
reg[31:0] b;
reg i_valid;
wire [31:0] sol;
wire  o_valid;
wire [31:0] iter_num;
reg [31:0]   req_iter;
reg [31:0] count;
reg rst;
reg [31:0] i_data_1;
reg i_valid_1;
wire  o_ready_1;
reg [31:0] i_data_2;
reg i_valid_2;
wire  o_ready_2;
reg i_ready_res;
wire [31:0] o_data_res;
wire o_valid_res;
reg [31:0] buffer;
reg [31:0] send_count;
reg flag;
initial
 begin
  count<=0;
  buffer<=0;
  send_count<=0;
 end
 
initial
begin 
  rst<=0;
  #10
  rst<=1;
  #30
  @(posedge clk)
  //i_data_1<=0;
  //i_valid_1<=1;
  req_iter<='d26;
  i_data_2<=32'h3f800000;
  //i_valid_2<=1;
  flag<=1;
  i_ready_res<=1'b1; 
end 

initial
begin
  clk = 1'b0;
  forever
  begin
      clk = ~clk;
		#5;
  end
end 

always@(posedge clk)
 begin
   if(o_ready_1 & o_ready_2 & flag)
    begin
	  i_data_1<=buffer;
	  i_valid_1<=1;
	  i_valid_2<=1;
	  flag<=0;
	  send_count<=send_count+1;
	end
	else if(send_count==`N_size)
	 begin
	  i_valid_1<=0;
	  i_valid_2<=0;
	 end
	else if(o_ready_1 & o_ready_2 & o_valid_res)
    begin
	  i_data_1<=buffer;
	  i_valid_1<=1;
	  i_valid_2<=1;
	  flag<=0;
	  send_count<=send_count+1;
	end
  else
   begin
     i_valid_1<=0;
	 i_valid_2<=0;
   end   
 end

always@(*)
 begin
  if(o_valid_res)
    begin
	  buffer=o_data_res;
	end
 end
/*
initial
begin
@(posedge clk)
req_iter<='d6;
rst<=0;
b<=32'h3f800000;   //1
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //2
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //3
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //4
i_valid<=1'b1;
#10

@(posedge clk)
b<=32'h40a00000;   //5
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40c00000;   //6
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40e00000;  //7
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h41000000;  //8
i_valid<=1'b1;


#10
@(posedge clk);
b<=32'h3f800000;   //1
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //2
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //3
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //4
i_valid<=1'b1;
#10

@(posedge clk)
b<=32'h40a00000;   //5
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40c00000;   //6
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40e00000;  //7
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h41000000;  //8
i_valid<=1'b1;


#10


@(posedge clk);
i_valid<=1'b0;   
end

*/

always@(posedge clk)
 begin
  if(o_valid_res)
   begin
    b<=o_data_res;  //8
	i_valid<=1'b1;
   end
  else 
   begin
    i_valid<=1'b0;
   end
 end


always@(posedge clk)
 begin
   if(o_valid)
    begin
	 count<=count +1;
	end
 end 
 
 always@(posedge clk)
  begin
    if(count==`N_size-1)
	 begin
	  $stop;
	  //$fclose(file);
	 end
  end
  
generate_adder tb_instnce(
			 .aclk(clk),                                  // input wire aclk
			 .aresetn(rst), 
             .s_axis_a_tvalid(i_valid_1),            // input wire s_axis_a_tvalid
             .s_axis_a_tready(o_ready_1),            // output wire s_axis_a_tready
             .s_axis_a_tdata(i_data_1),              // input wire [31 : 0] s_axis_a_tdata
             .s_axis_b_tvalid(i_valid_2),            // input wire s_axis_b_tvalid
             .s_axis_b_tready(o_ready_2),            // output wire s_axis_b_tready
             .s_axis_b_tdata(i_data_2),              // input wire [31 : 0] s_axis_b_tdata
             .m_axis_result_tvalid(o_valid_res),  // output wire m_axis_result_tvalid
             .m_axis_result_tready(i_ready_res),  // input wire m_axis_result_tready
             .m_axis_result_tdata(o_data_res)    // output wire [31 	: 0] m_axis_result_tdata
); 
 

 
cg_top_main top_instnce(
.clk(clk),
.b(b),
.i_valid(i_valid),
.sol(sol),
.iter_num(iter_num),
//.o_ready(o_ready),
.o_valid_main(o_valid),
.req_iter(req_iter)
//.epsilon(epsilon)
 );	
	
	
endmodule
