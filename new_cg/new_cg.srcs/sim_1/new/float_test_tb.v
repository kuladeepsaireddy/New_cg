`timescale 1ns / 1ps



module cg_float_test(	
);
reg clk;
reg [31:0] top_b;
reg top_i_valid;
wire[31:0] top_sol;
wire top_o_valid;
wire [31:0]iter_num;
reg [31:0]req_iter;

wire [31:0]alpha_local;
wire i_valid_alpha;
wire [31:0]beta_local;
wire i_valid_beta;

reg [31:0]vect_left;
reg [31:0]vect_right;
reg [31:0]vect_top;
reg [31:0]vect_bottom;

reg vect_left_i_valid;
reg vect_right_i_valid;
reg vect_bottom_i_valid;
reg vect_top_i_valid;

wire [31:0] alpha;
wire o_valid_alpha;
wire [31:0] beta;
wire o_valid_beta_top;



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
@(posedge clk)
req_iter<='d13;
top_b<=32'h3f800000;   //1
top_i_valid<=1'b1;



#10
@(posedge clk);
top_b<=32'h40000000;   //2
top_i_valid<=1'b1;

#10
@(posedge clk);  //2
top_i_valid<=1'b0;


#50
@(posedge clk)
top_b<=32'h40a00000;   //5
top_i_valid<=1'b1;


#10


@(posedge clk);
top_i_valid<=1'b0;   
end


cg_top check_tb_top(
        .clk(clk),
		.b(top_b),
		.i_valid(top_i_valid),
		.sol(top_sol),
		.o_valid(top_o_valid),
		.iter_num(iter_num),
		.req_iter(req_iter),
		
		.alpha_local(alpha_local),
		.o_valid_alpha(i_valid_alpha),
		.beta_local(beta_local),
		.o_valid_beta(i_valid_beta),
		
		.i_vect_left(vect_left),
		.i_vect_right(vect_right),
		.i_vect_top(vect_top),
		.i_vect_bottom(vect_bottom),
		
		.i_valid_vect_left(vect_left_i_valid),
		.i_valid_vect_right(vect_right_i_valid),
		.i_valid_vect_bottom(vect_bottom_i_valid),
		.i_valid_vect_top(vect_top_i_valid),
		
		
		.alpha(alpha),
		.i_valid_alpha(o_valid_alpha),
		.beta(beta),
		.i_valid_beta(o_valid_beta_top)
       );

endmodule
