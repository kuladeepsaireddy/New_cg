`timescale 1ns / 1ps
`define nx 2
`define ny 2
`define N `nx*`ny
`define size $clog2(`N)

module cg_tb(	
);
reg clk;
reg[31:0] b;
reg i_valid;
wire [31:0] sol;
wire  o_ready;
wire  o_valid;
reg [31:0] epsilon;

reg [`size-1:0] count 
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
b<=32'h3f800000;   //1
i_valid<=1'b1;
epsilon<=32'h3a83126f;  //t=10e(-3)
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
@(posedge clk);
i_valid<=1'b0;   
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
    if(count==`N-1)
	 begin
	  $stop;
	 end
  end
cg_top top_instnce(
.clk(clk),
.b(b),
.i_valid(i_valid),
.sol(sol),
.o_ready(o_ready),
.o_valid(o_valid),
.epsilon(epsilon)
 );	
	
	
endmodule
