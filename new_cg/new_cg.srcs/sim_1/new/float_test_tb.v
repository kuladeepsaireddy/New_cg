`timescale 1ns / 1ps



module cg_float_test(	
);
reg clk;


reg [31:0] sol;

reg [31:0] count;
reg o_valid;
reg check_flag;
reg [31:0] count_1;
reg [31:0] count_2;
reg [31:0] value;
reg [31:0] expo;  
initial
 begin
  count<=0;
  count_1<=0;
  count_2<=0;
  sol<=0;
  value<=0;
  check_flag<=0;
  o_valid<=0;
  expo<=0;
 end
 
initial
begin
  clk = 1'b1;
  forever
  begin
      clk = ~clk;
		#5;
  end
end 

 initial
 begin
 @(posedge clk)
   sol<='h40000000;
   o_valid<=1;
  #20
 @(posedge clk)
   o_valid<=0; 
 end
 
  
integer i;
integer k;
/*
  
always@(posedge clk)
 begin
  if(o_valid)
   begin
    for(i=0;i<23;i=i+1)
     begin
	  if(sol[i]==1)
	    begin
         count<=count+2**(23-i);
		 //check_flag<=1;
 	    end  
      end
   	
    for(k=23;k<31;k=k+1)
     begin
       if(sol[k]==1)
	    begin
	    count_2<=count_2+ 2**(i-23);
		//check_flag<=1;
	     if(k==30)
		  begin
		   expo<=count_2-127;
		  end
		end
	value<= 2**(expo);	
     end	 
   end
 
 end
	*/
	
	
always@(posedge clk)
 begin
  if(o_valid)
   begin
     expo<=1.24;
   end
 
 end 
endmodule
