`timescale 1ns / 1ps
`define nx 2
`define ny 2
`define N `nx*`ny
`define n_size $clog2(`N)
`define i_size $clog2(`nx)
`define j_size $clog2(`ny)

module cg_matrix_mult(
input wire clk,
input wire [31:0] vect,
input wire i_valid,

output  wire [31:0] o_data,
output wire o_valid,
input wire i_ready
);

wire end_sig;
parameter c =$clog2(`N); 
reg[c:0] count; 
reg[31:0] d0;
reg[31:0] d1;
reg[31:0] d2;
reg[31:0] d3;
reg[31:0] d4;
//reg [9:0] addr;
reg[`i_size:0] i;
reg[`j_size:0] j;
reg start;
//integer count_reg;

//reg [31:0] dina;
//reg ena;
//reg wea;
//
//reg enb;
//reg [9:0] addrb;
//wire [31:0] doutb;

reg [`n_size:0] wr_addr;


reg i_valid_1_add_1;
wire o_ready_1_add_1;
reg i_valid_2_add_1;
wire o_ready_2_add_1;
wire o_valid_result_add_1;
wire i_ready_result_add_1;
wire [31:0] o_data_result_add_1;


reg i_valid_1_add_2;
wire o_ready_1_add_2;
reg i_valid_2_add_2;
wire o_ready_2_add_2;
wire o_valid_result_add_2;
wire i_ready_result_add_2;
wire [31:0] o_data_result_add_2;


wire o_valid_result_add;
wire i_ready_result_add;
wire[31:0] o_data_result_add; 


reg i_valid_1_mult;
wire o_ready_1_mult;
wire  i_valid_2_mult;
wire o_ready_2_mult;
reg [31:0] i_data_2_mult;



wire o_valid_result_mult;
wire i_ready_result_mult;
wire [31:0] o_data_result_mult;




initial
begin
 i<=1;
 j<=1;
 wr_addr<=1;
 //dina<='d1;//
 //addrb<=0;
 //count_reg<=0;
 //enb<=1'b1;
 i_valid_1_mult<=1'b0;
 i_valid_1_add_2<=1'b0;
 i_valid_2_add_2<=1'b0;
 i_valid_1_add_1<=1'b0;
 i_valid_2_add_1<=1'b0;
 d0<=0;
 d1<=0;
 d2<=0;
 d3<=0;
 d4<=0;
 start<=0;
 i_data_2_mult<=0;
end


reg [31:0] my_mem[`N:1];

always@(posedge clk)
begin

if(end_sig)
 begin
  wr_addr<=1;
 end
 
else if(i_valid)
  begin
   my_mem[wr_addr]<=vect;
   wr_addr<=wr_addr+1;
  /* if(wr_addr >=`nx +1)
    begin
	 start<=1;
	end*/
  end	


end







always@(*)
 begin
  if(i_valid)
   begin
    if(wr_addr >`nx +1)
    begin
	 start<=1;
	end
   end
 else if(end_sig)
  begin
    start<=0;
  end 
 end

assign end_sig = ((j==0 & i==0) == 1)? 1:0;

/*)
always@(posedge end_sig)
 begin
    start<=0;
  end
*/
always@(posedge clk)
begin
 if(end_sig)
  begin
    i_valid_1_mult<=0;
  end
  
 else if(start)
   begin
    if(i==1 & j==1)
     begin	
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_1_mult<=1'b1;
		end 
	   else if( i_valid_1_mult & o_ready_1_mult  )
         begin	 
		     i_valid_1_mult <=1'b0;
	     end
	 
	  end
	
	
   else if(i==1 & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if( i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end
	  
	
   else if(i==1 & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end			
	/////////////
   else if(i==`nx & j==1)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end

	////////////////////////////////////////////////////////////////////////////
   else if(i==`nx & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end
	 
		
	
   else if(i==`nx & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end
	 
	
   else if(i!=1 & j==1 & i!=`nx)
    begin
	   if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end
	  
	
	
	
	
   else if(j==`ny& i!=1 &i!=`nx)
    begin
	   if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end
	
 else
   begin
	  if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          i_valid_1_mult<=1'b1;	  
	    end
	   else if(i_valid_1_mult & o_ready_1_mult )
	    begin
		  i_valid_1_mult <=1'b0;
		end
	  end

	
end
 else if( end_sig & i_valid_1_mult & o_ready_1_mult)
     begin 
		  i_valid_1_mult <=1'b0;
     end  	 
end	 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin
 if(end_sig)
  begin
    i_valid_1_add_1<=1'b0;
	i_valid_1_add_2<=1'b0;
  end


 else if(start)
  begin
   if(i==1 & j==1)
    begin	
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	 
	  end		
	
   else if(i==1 & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end
	  
	 
	
   else if(i==1 & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end	
	
	/////////////
   else if(i==`nx & j==1)
    begin
	   if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end
	  

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   else if(i==`nx & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end
	 
		
	
   else if(i==`nx & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end
	  
	
	
   else if(i!=1 & j==1 & i!=`nx)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end
	  
	
	
	
	
   else if(j==`ny& i!=1 &i!=`nx)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end
	
 else
   begin
	  if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
	      i_valid_1_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		end 
	   else if(i_valid_1_add_1  & i_valid_1_add_2  & o_ready_1_add_2 )
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
	     end
	  end

	
end
 else if( end_sig & i_valid_1_add_1 &  i_valid_1_add_2  & o_ready_1_mult)
     begin
         i_valid_1_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
     end   

end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clk)
begin

if(end_sig)
  begin
    i_valid_2_add_1<=1'b0;
	i_valid_2_add_2<=1'b0;
  end


 else if(start)
  begin
   if(i==1 & j==1)
    begin	
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	 
	  end
	 
	
   else if(i==1 & j!=1 & j!=`ny)
    begin
	     if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	  
	
	
	
   else if(i==1 & j==`ny)
    begin
	     if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	
	/////////////
   else if(i==`nx & j==1)
    begin
	     if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	  	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   else if(i==`nx & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	 
		
	
   else if(i==`nx & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	  
	
   else if(i!=1 & j==1 & i!=`nx)
    begin
	     if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	  

	
   else if(j==`ny& i!=1 &i!=`nx)
    begin
	     if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end
	
	
 else
   begin
	  if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
		  i_valid_2_add_1<=1'b1;
		  i_valid_2_add_2<=1'b1;
		end 
	   else if( i_valid_2_add_1&i_valid_2_add_2 & o_ready_2_add_1  & o_ready_2_add_2)
         begin	 
		     i_valid_2_add_1<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end
	  end

	
end
 else if( end_sig & i_valid_2_add_1& i_valid_2_add_2 & o_ready_1_mult)
     begin
		  i_valid_2_add_1<=1'b0;
		  i_valid_2_add_2<=1'b0;
     end   
end	 




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always@(posedge clk)
begin

 if(end_sig)
  begin
   i<=1;
   j<=1;
   d0<=0;
   d1<=0;
   d2<=0;
   d3<=0;
   d4<=0;
  end


 else if(start)
  begin
   if(i==1 & j==1)
    begin	
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[1];
          d1<=0;
		  d2<=my_mem[2];
		  d3<=0;
		  d4<=my_mem[`nx+1];
	     /* i_valid_1_add_1<=1'b1;
		  i_valid_1_mult<=1'b1;
		  i_valid_2_add_1<=1'b1;
		  i_valid_1_add_2<=1'b1;
		  i_valid_2_add_2<=1'b1;*/
		  i<=i+1;
		end 
	   /*else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
         begin	 
	         i_valid_1_add_1<=1'b0;
		     i_valid_1_mult <=1'b0;
		     i_valid_2_add_1<=1'b0;
		     i_valid_1_add_2<=1'b0;
		     i_valid_2_add_2<=1'b0;
	     end*/
	 
	  end
	 
	
	
	
	
   else if(i==1 & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
          d1<=0;
	      d2<=my_mem[(j-1)*`nx+i+1];
          d3<=my_mem[(j-2)*`nx+i];
		  d4<=my_mem[j*`nx +i];
          /*i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1;*/
          i<=i+1;		  
	    end
	  /* else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end
	  
	  
	
     	
    
	


	
	
	
	
   else if(i==1 & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
		  d1<=0;
		  d2<=my_mem[(j-1)*`nx+i+1];
		  d3<=my_mem[(j-2)*`nx+i];
		  d4<=0;
         /*  i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1;*/
		  i<=i+1;	  
	    end
	  /* else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end
	
	
	
	
	
	
	
	
	
	
	
	
	/////////////
   else if(i==`nx & j==1)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[i];
		  d1<=my_mem[i-1];
		  d2<=0;
		  d3<=0;
		  d4<=my_mem[j*`nx +i];
          /*i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1;*/
          j<=j+1;
		  i<=1;	  
	    end
	  /* else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end
	  
	
	
	

	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   else if(i==`nx & j!=1 & j!=`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
		  d1<=my_mem[(j-1)*`nx+i-1];
		  d2<=0;
		  d3<=my_mem[(j-2)*`nx+i];
		  d4<=my_mem[j*`nx +i];
		  j<=j+1;
		  i<=1;
         /* i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1;*/
	    end
	   /*else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end
	 
		
	
   else if(i==`nx & j==`ny)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
		  d1<=my_mem[(j-1)*`nx+i-1];
		  d2<=0;
		  d3<=my_mem[(j-2)*`nx+i];
		  d4<=0;
		  i<=0;
		  j<=0;
          /*i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1;  */
	    end
	   else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		 /* i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	   end
	  end
	
   
	
	
	
	
	
	
	
	
	
   else if(i!=1 & j==1 & i!=`nx)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
		  d1<=my_mem[(j-1)*`nx+i-1];
		  d2<=my_mem[(j-1)*`nx+i+1];
		  d3<=0;
		  d4<=my_mem[j*`nx +i];
		  i<=i+1;
         /*  i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1; */  
	    end
	  /*  else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end
	  
	
	
	
	
   else if(j==`ny& i!=1 &i!=`nx)
    begin
	    if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
		  d1<=my_mem[(j-1)*`nx+i-1];
		  d2<=my_mem[(j-1)*`nx+i+1];
		  d3<=my_mem[(j-2)*`nx+i];
		  d4<=0;
          i<=i+1;
          /*i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1;  */
	    end
	  /* else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end

	  

	
	

	
	
 else
   begin
	  if(o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
 		 begin
          d0<=my_mem[(j-1)*`nx+i];
		  d1<=my_mem[(j-1)*`nx+i-1];
		  d2<=my_mem[(j-1)*`nx+i+1];
		  d3<=my_mem[(j-2)*`nx+i];
		  d4<=my_mem[j*`nx +i];
		  i<=i+1;
          /*i_valid_1_mult<=1'b1;
          i_valid_1_add_1<=1'b1;	
          i_valid_2_add_1<=1'b1;
          i_valid_1_add_2<=1'b1;
          i_valid_2_add_2<=1'b1; 	*/  
	    end
	  /* else if(i_valid_1_add_1 & i_valid_1_mult &i_valid_2_add_1& i_valid_1_add_2&i_valid_2_add_2& o_ready_1_mult & o_ready_2_add_1 & o_ready_1_add_2 & o_ready_2_add_2)
	    begin
		  i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
		end*/
	  end

	
end
 /*else
     begin
         i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
     end   */
end	 


assign i_valid_2_mult = i_valid_1_mult;
always@(posedge clk)
begin

if(end_sig)
 begin
   i_data_2_mult<=0;
 end
else if(o_ready_2_mult)
 begin
  //i_valid_2_mult<=1'b1;
  i_data_2_mult<=32'hc0800000;
 end/*
 else
  begin
    i_valid_2_mult<=1'b0;
  end  
*/
end


 /* 
 always@(posedge clk)
  begin
    if(!start)
	  begin
	   i_valid_1_add_1<=1'b0;
		  i_valid_1_mult <=1'b0;
		  i_valid_2_add_1<=1'b0;
		  i_valid_1_add_2<=1'b0;
		  i_valid_2_add_2<=1'b0;
      end
 end*/
/*
always@(posedge clk)
begin
  if(j==0 & i==0)
   begin
    end_sig<=1'b1;
	start<=0;
   end
  else
   end_sig<=1'b0;
   
end
*/

float_add my_adder_1(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_add_1),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_add_1),            // output wire s_axis_a_tready
  .s_axis_a_tdata(d1),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_add_1),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_add_1),            // output wire s_axis_b_tready
  .s_axis_b_tdata(d2),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_add_1),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_add_1),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_add_1)    // output wire [31 : 0] m_axis_result_tdata
);
float_add my_adder_2(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_add_2),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_add_2),            // output wire s_axis_a_tready
  .s_axis_a_tdata(d3),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_add_2),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_add_2),            // output wire s_axis_b_tready
  .s_axis_b_tdata(d4),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_add_2),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_add_2),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_add_2)    // output wire [31 : 0] m_axis_result_tdata
);

float_add my_adder_3(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(o_valid_result_add_1),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(i_ready_result_add_1),            // output wire s_axis_a_tready
  .s_axis_a_tdata(o_data_result_add_1),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(o_valid_result_add_2),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(i_ready_result_add_2),            // output wire s_axis_b_tready
  .s_axis_b_tdata(o_data_result_add_2),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_add),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_add),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_add)    // output wire [31 : 0] m_axis_result_tdata
);



float_mult my_mult(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(i_valid_1_mult),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(o_ready_1_mult),            // output wire s_axis_a_tready
  .s_axis_a_tdata(d0),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(i_valid_2_mult),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(o_ready_2_mult),            // output wire s_axis_b_tready
  .s_axis_b_tdata(i_data_2_mult),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid_result_mult),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready_result_mult),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data_result_mult)    // output wire [31 : 0] m_axis_result_tdata
);


/*
blk_ram your_instance_name (
  .clka(clk),    // input wire clka
 // .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [9 : 0] addra
  .dina(dina),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
   .enb(enb),      // input wire enb
  .addrb(addrb),  // input wire [9 : 0] addrb
  .doutb(doutb)  // output wire [31 : 0] doutb
);
*/

float_add out_adder(
  .aclk(clk),                                  // input wire aclk
  .s_axis_a_tvalid(o_valid_result_add),            // input wire s_axis_a_tvalid
  .s_axis_a_tready(i_ready_result_add),            // output wire s_axis_a_tready
  .s_axis_a_tdata(o_data_result_add),              // input wire [31 : 0] s_axis_a_tdata
  .s_axis_b_tvalid(o_valid_result_mult),            // input wire s_axis_b_tvalid
  .s_axis_b_tready(i_ready_result_mult),            // output wire s_axis_b_tready
  .s_axis_b_tdata(o_data_result_mult),              // input wire [31 : 0] s_axis_b_tdata
  .m_axis_result_tvalid(o_valid),  // output wire m_axis_result_tvalid
  .m_axis_result_tready(i_ready),  // input wire m_axis_result_tready
  .m_axis_result_tdata(o_data)    // output wire [31 : 0] m_axis_result_tdata
);


/*
cg_vector_subtractor sub_instnce(
.clk(clk),
.i_data_vect_1(o_data_result_add),
.i_valid_vect_2(o_valid_result_mult),
.i_valid_vect_1(o_valid_result_add),

.i_data_vect_2(o_data_result_mult),    
.result(o_data),
.i_ready_result(i_ready),
.o_valid_result(o_valid),
.o_ready_1(i_ready_result_add),
.o_ready_2(i_ready_result_mult)   	
);

*/	
endmodule
