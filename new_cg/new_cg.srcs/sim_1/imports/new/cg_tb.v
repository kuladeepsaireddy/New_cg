`include "../../../../include_file.v"



module cg_tb(	
);
reg clk;
reg[31:0] b;
reg i_valid;
wire [31:0] sol;
wire  o_ready;
wire  o_valid;
wire [`size-1:0] iter_num;
reg [31:0] epsilon;

reg [`size-1:0] count;
reg compare_flag;

reg[31:0] wire_1;
reg[31:0] wire_2;

initial
begin
 wire_1<=32'h3ac5e000;
 wire_2<=32'h3a83126f;

end
 always@(posedge clk)
  begin
    if(wire_1 > wire_2)
	 begin
	  compare_flag<=1;
	 end 
  else
   begin
    compare_flag<=0;
   end
  
  end
  
  
initial
 begin
  count<=0;
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

initial
begin
@(posedge clk)
epsilon<=32'h3a83126f;  //t=10e(-3)
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
b<=32'h3f800000;   //5
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //6
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //7
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //8
i_valid<=1'b1;

#10
@(posedge clk)
b<=32'h3f800000;   //9
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //10
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //11
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //12
i_valid<=1'b1;
#10

@(posedge clk)
b<=32'h3f800000;   //13
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //14
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //15
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //16
i_valid<=1'b1;
#10
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
b<=32'h3f800000;   //5
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //6
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //7
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //8
i_valid<=1'b1;

#10
@(posedge clk)
b<=32'h3f800000;   //9
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //10
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //11
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //12
i_valid<=1'b1;
#10

@(posedge clk)
b<=32'h3f800000;   //13
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //14
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //15
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //16
i_valid<=1'b1;
#10
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
b<=32'h3f800000;   //5
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //6
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //7
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //8
i_valid<=1'b1;

#10
@(posedge clk)
b<=32'h3f800000;   //9
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //10
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //11
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //12
i_valid<=1'b1;
#10

@(posedge clk)
b<=32'h3f800000;   //13
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //14
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //15
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //16
i_valid<=1'b1;
#10
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
b<=32'h3f800000;   //5
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //6
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //7
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //8
i_valid<=1'b1;

#10
@(posedge clk)
b<=32'h3f800000;   //9
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //10
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //11
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //12
i_valid<=1'b1;
#10

@(posedge clk)
b<=32'h3f800000;   //13
i_valid<=1'b1;

#10
@(posedge clk);
b<=32'h40000000;   //14
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40400000;  //15
i_valid<=1'b1;
#10
@(posedge clk);
b<=32'h40800000;  //16
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
.iter_num(iter_num),
.o_ready(o_ready),
.o_valid(o_valid),
.epsilon(epsilon)
 );	
	
	
endmodule
