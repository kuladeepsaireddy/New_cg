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


/*
initial
 begin
  count<=0;
 end
 */
 
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


/*
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
	  //$fclose(file);
	 end
  end
  */


 
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
