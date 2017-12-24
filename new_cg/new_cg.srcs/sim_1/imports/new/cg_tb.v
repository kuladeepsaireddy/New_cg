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
reg [`size-1:0]  req_iter;
reg [`size-1:0] count;

reg [`size-1:0] count_1;
reg [`size-1:0] count_2;
reg [31:0] value;
integer file;
initial
 begin
  count<=0;
  count_1<=0;
  count_2<=0;
  value<=0;
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
file=$fopen("../../../../results.txt","w");
epsilon<=32'h3a83126f;  //t=10e(-3)
req_iter<='d13;
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
	 $fwrite(file,"%s",sol);
	end
 end 
 
 always@(posedge clk)
  begin
    if(count==`N-1)
	 begin
	  $stop;
	  $fclose(file);
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
.req_iter(req_iter),
.epsilon(epsilon)
 );	
	
	
endmodule
