`timescale 1ns / 1ps

`include "../../../include_file.v"
`define super_scalarity 4

module cg_top_main(
input clk,
input [31:0] b,
input i_valid,
output [31:0] sol,
output o_valid_main,
output [31:0] iter_num,
input [31:0] req_iter
    );


	
	
parameter len= $clog2(`super_scalarity);	
reg [`i_size:0] send_reg;
 reg [len:0] x_cord;
 reg [`x_size:0] step_count;
 reg [`j_size:0] y_cord;
 
reg  [31:0] vect_left[`super_scalarity:1];
reg [31:0] vect_right[`super_scalarity:1];
reg [31:0] vect_top[`super_scalarity:1];
reg [31:0] vect_bottom[`super_scalarity:1];

reg vect_left_i_valid[`super_scalarity:1];
reg vect_right_i_valid[`super_scalarity:1];
reg vect_top_i_valid[`super_scalarity:1];
reg vect_bottom_i_valid[`super_scalarity:1];   
 
 
wire  o_valid_delta[3*`super_scalarity -4:`super_scalarity];
wire i_ready_delta[3*`super_scalarity -4:`super_scalarity];
wire [31:0] o_data_delta[3*`super_scalarity -4:`super_scalarity];

 
wire  o_valid[3*`super_scalarity -4:`super_scalarity];
wire i_ready[3*`super_scalarity -4:`super_scalarity];
wire [31:0] o_data[3*`super_scalarity -4:`super_scalarity];

wire [31:0]  gamma_local[`super_scalarity:1];
wire [31:0] delta_local[`super_scalarity:1];
wire i_valid_gamma_local[`super_scalarity:1] ;
wire i_valid_delta_local[`super_scalarity:1];


reg [31:0] gamma;
reg [31:0] delta;
reg o_valid_gamma;
reg o_valid_delta_top;


reg [31:0] top_b[`super_scalarity:1];
reg top_i_valid[`super_scalarity:1];
wire [31:0] top_sol[`super_scalarity:1];
wire top_o_valid[`super_scalarity:1]; 
 
 
wire o_ready_1[`super_scalarity:1];
wire o_ready_2[`super_scalarity:1];
wire o_ready_1_beta[`super_scalarity:1];
wire o_ready_2_beta[`super_scalarity:1];



wire [31:0] i_data_mult[`super_scalarity:1];
wire  i_valid_mult[`super_scalarity:1];

integer u;
integer m;
integer h;
integer g;
integer f;
integer r;
integer q;
integer w;

reg [31:0]  my_mem [`N:1][`super_scalarity:1];
reg [31:0] wr_addr[`super_scalarity:1];
reg [31:0] addr_left[`super_scalarity:1];
reg [31:0] addr_right[`super_scalarity-1:1];
reg [31:0] addr_bottom[`super_scalarity: `super_scalarity/2 +1];
reg [31:0] addr_top[`super_scalarity/2:1];

parameter left_len= $clog2(`s_y_count*`super_scalarity);
parameter top_len= $clog2(`s_x_count*`super_scalarity);
//reg [`n_size+1:0] check_reg;
reg[`size:0] check_reg;
reg[left_len:0] left_count;
reg[left_len:0] right_count;
reg[top_len:0] top_count;
reg[top_len:0] bottom_count;
reg start_mult;
initial
 begin
   x_cord<=1;
   y_cord<=1;
   send_reg<=0;
   step_count<=1;
   start_mult<=0;
   for(q=1;q<`super_scalarity+1;q=q+1)
     begin
	  wr_addr[q]<=1;
	  addr_left[q]<=`s_x_count;
	  addr_right[q]<=1;
	  addr_bottom[q]<=`N-`s_x_count+1;
	  addr_top[q]<=1;
	 end
	check_reg<=0; 
	left_count<=0;
	right_count<=0;
	top_count<=0;
	bottom_count<=0;
	
 end 
 
 always@(posedge clk)
 begin
 for(q=1;q<`super_scalarity+1;q=q+1)
     begin
       if(i_valid_mult[q])
        begin
          my_mem[q][wr_addr[q]]<=i_data_mult[q];
		  wr_addr[q]<=wr_addr[q]+1;
          check_reg=check_reg+1;
        end 		
	 end 
 end
 
 
always@(posedge clk)
 begin
  if(check_reg==`N_size)
   begin
     start_mult<=1'b1;
   end
  else if(left_count==`s_y_count*`super_scalarity & right_count ==`s_y_count*`super_scalarity & top_count==`s_x_count*`super_scalarity & bottom_count ==`s_x_count*`super_scalarity)
   begin
     start_mult<=1'b0;
	 check_reg<=0;
   end   
 end 
/*
always@(posedge clk)
 begin
  for(w=1;w<`super_scalarity+1;w=w+1)
     begin
	  if(w==`super_scalarity )
	   begin
	    if(wr_addr[w]==`N+1 )
		  begin
	       check_reg<=check_reg+1;
          end
		else
          begin
           check_reg<=0;
          end		  
	   end
	  else if(wr_addr[w]==`N+1)
	   begin
	     check_reg<=check_reg+1;
	   end
        	  
	 end
  if(check_reg==`super_scalarity)
	begin
	 start_mult<=1;
	end	
 
 end 
*/ 
 always@(posedge clk)
  begin
	if(send_reg==`nx-1 & i_valid)
	 begin
	  send_reg<=0;
	 end
    else if(i_valid)
	 begin
	   send_reg<=send_reg+1;
	 end
	else if(y_cord==`ny+1)
     begin
       send_reg<=0;
     end
  end
 
 
 always@(posedge clk)
  begin
   if(send_reg==`nx-1 & i_valid)
    begin
      step_count<='d1;
    end
   else if(i_valid & send_reg==`s_x_count*step_count-1)
    begin
	 step_count<=step_count+1;
	end
	else if(y_cord==`ny+1)
     begin
       step_count<=1;
     end
  
  end 
  
  
always@(posedge clk)
 begin
 
  if(i_valid & send_reg==`s_x_count*step_count-1 & send_reg !=`nx-1)
    begin
	 x_cord<=x_cord+1;
	end
  else if(i_valid & send_reg ==`nx-1 & y_cord >= `ny/2)
    begin
	 x_cord<= `super_scalarity/2  +1;
     y_cord <= y_cord+1;	 
	end   
   else if(send_reg==`nx-1 & i_valid)
    begin
      x_cord<='d1;
	  y_cord<=y_cord+1;
    end
   else if(y_cord==`ny+1)
     begin
       x_cord<=1;
	   y_cord<=1;
     end	 
 end 
 
always@(posedge clk)															///  matrix multiplication block
  begin
    if(i_valid)                                                                  //// w=A*b
        begin
          top_b[x_cord]<=b; 
        end		
	
  end	

  
 always@(posedge clk)
 begin
  if(i_valid)
   begin
    top_i_valid[x_cord]<=1'b1;
	for(m=1;m<`super_scalarity+1;m=m+1)
	 begin
	   if(m!=x_cord)
	    begin
		 top_i_valid[m]<=1'b0;
		end
	    
	 end
   end
   
  else
	  begin
	    for(u=1;u<`super_scalarity+1;u=u+1)
		  begin
		   top_i_valid[u]<=0;
		  end
	  end
 end 
  
 
always@(posedge clk)
  begin
   if(i_valid)
    begin
	  if(send_reg==0)
	   begin
	     vect_left[x_cord]<=0;
		 vect_left_i_valid[x_cord]<=1'b1;
         for(h=1;h<`super_scalarity+1;h=h+1)
		  begin
		   if(h!=x_cord)
			 begin
			  vect_left_i_valid[h]<=1'b0;
		     end
	      end 		 
	   end
	  else if(send_reg==`s_x_count*step_count-1 & send_reg!==`nx-1)
	   begin
	     vect_left[x_cord+1]<=b;
		 vect_left_i_valid[x_cord+1]<=1'b1;
         for(h=1;h<`super_scalarity+1;h=h+1)
		  begin
		   if(h!=x_cord+1)
			 begin
			  vect_left_i_valid[h]<=1'b0;
		     end
	      end 		 
	   end
	  else
       begin
	     for(h=1;h<`super_scalarity+1;h=h+1)
		  begin
           vect_left_i_valid[h]<=1'b0;
		   end
       end	   
	  
	end
	
 else if(start_mult)
   begin
     for(h=1;h<`super_scalarity+1;h=h+1)
	  begin
	    if(h==1 | h== `super_scalarity/2+1)
		 begin
		   vect_left[h]<=0;
		   vect_left_i_valid[h]<=1;
		   left_count=left_count+1;
		 end
		else if(addr_left[`super_scalarity]<=`N)
          begin
            vect_left[h]<=my_mem[h-1][addr_left[h]];
			addr_left[h]<=addr_left[h]+`s_x_count;
			vect_left_i_valid[h]<=1;
			left_count=left_count+1;
          end
		else
		  begin
           for(h=1;h<`super_scalarity+1;h=h+1)
		     begin
              vect_left_i_valid[h]<=1'b0;
		     end
          end		  
	  end
   end   
  
 else
       begin
         for(h=1;h<`super_scalarity+1;h=h+1)
		  begin
           vect_left_i_valid[h]<=1'b0;
		   end
       end
   end 
   

  
always@(posedge clk)
 begin
 if(i_valid)
  begin
   if(send_reg==`nx-1)
     begin
       vect_right[x_cord]<=0;
	   vect_right_i_valid[x_cord]<=1'b1;
	   for(g=1;g<`super_scalarity+1;g=g+1)
		  begin
		   if(g!=x_cord)
			 begin
			  vect_right_i_valid[g]<=1'b0;
		     end
	      end 	
     end	 
 
 
   else if(send_reg==`s_x_count*(step_count-1) & send_reg!=0)
	  begin
	     vect_right[x_cord-1]<=b;
		 vect_right_i_valid[x_cord-1]<=1'b1;
		 for(g=1;g<`super_scalarity+1;g=g+1)
		  begin
		   if(g!=x_cord-1)
			 begin
			  vect_right_i_valid[g]<=1'b0;
		     end
	      end 		 
	  end
   else
    begin
	  for(g=1;g<`super_scalarity+1;g=g+1)
		  begin
	       vect_right_i_valid[g]<=1'b0;
		  end
	end
   end 

  else if(start_mult)
   begin
    for(g=1;g<`super_scalarity+1;g=g+1)
	  begin
	    if(g==`super_scalarity | g== `super_scalarity/2)
		 begin
		   vect_right[g]<=0;
		   vect_right_i_valid[g]<=1;
		   right_count=right_count+1;
		 end
		else if(addr_right[`super_scalarity-1]<=`N)
          begin
            vect_right[g]<=my_mem[g+1][addr_right[g]];
			addr_right[g]<=addr_right[g]+`s_x_count;
			vect_right_i_valid[g]<=1;
			right_count=right_count+1;
          end
		 else
           begin
             for(g=1;g<`super_scalarity+1;g=g+1)
		      begin
	            vect_right_i_valid[g]<=1'b0;
		      end
           end		   
	  end
  
   end
   
 else 
  begin
     for(g=1;g<`super_scalarity+1;g=g+1)
		 begin
	       vect_right_i_valid[g]<=1'b0;
		  end
  end 
end 


always@(posedge clk)
 begin
  if(i_valid)
    begin
	  if(y_cord==1)
	    begin
		 vect_bottom[x_cord]<=0;
		 vect_bottom_i_valid[x_cord]<=1'b1;
		 for(f=1;f<`super_scalarity+1;f=f+1)
		  begin
		   if(f!=x_cord)
			 begin
			  vect_bottom_i_valid[f]<=1'b0;
		     end
	      end 	
		end
	  else if(y_cord==`ny/2)
       begin
         vect_bottom[x_cord+`super_scalarity/2]<=b;
         vect_bottom_i_valid[x_cord+`super_scalarity/2]<=1'b1;
		 for(f=1;f<`super_scalarity+1;f=f+1)
		  begin
		   if(f!=x_cord+`super_scalarity/2)
			 begin
			  vect_bottom_i_valid[f]<=1'b0;
		     end
	      end 	
	   end
	  else 
        begin
         for(f=1;f<`super_scalarity+1;f=f+1)
		  begin		
	       vect_bottom_i_valid[f]<=1'b0;
		  end 
		end  
	end
  
   else if(start_mult)
     for(f=1;f<`super_scalarity+1;f=f+1)
	  begin
	    if(f<`super_scalarity/2+1)
		 begin
		   vect_bottom[f]<=0;
		   vect_bottom_i_valid[f]<=1;
		   bottom_count=bottom_count+1;
		 end
		else if(addr_bottom[`super_scalarity]<=`N)
          begin
            vect_bottom[f]<=my_mem[f-`super_scalarity/2][addr_bottom[f]];
			addr_bottom[f]<=addr_bottom[f]+1;
			vect_bottom_i_valid[f]<=1;
			bottom_count=bottom_count+1;
          end
		 else
           begin
             for(f=1;f<`super_scalarity+1;f=f+1)
		      begin
	            vect_bottom_i_valid[f]<=1'b0;
		      end
           end		   
	  end
  
 	
  else 
    begin	  
	  for(f=1;f<`super_scalarity+1;f=f+1)
		  begin		
	       vect_bottom_i_valid[f]<=1'b0;
		  end 
    end 
 end

always@(posedge clk)
 begin
  if(i_valid)
   begin
     if(y_cord==`ny)
	  begin
	    vect_top[x_cord]<=0;
		vect_top_i_valid[x_cord]<=1'b1;
		for(r=1;r<`super_scalarity+1;r=r+1)
		  begin
		   if(r!=x_cord)
			 begin
			  vect_top_i_valid[r]<=1'b0;
		     end
	       end
		 end  
    else if(y_cord==`ny/2+1)
	 begin
	   vect_top[x_cord-`super_scalarity/2]<=b;
	   vect_top_i_valid[x_cord-`super_scalarity/2]<=1'b1;
	   for(r=1;r<`super_scalarity+1;r=r+1)
		  begin
		   if(r!=x_cord-`super_scalarity/2)
			 begin
			  vect_top_i_valid[r]<=1'b0;
		     end	 
	      end
	  end	  
	else
     begin
	  for(r=1;r<`super_scalarity+1;r=r+1)
		  begin
			vect_top_i_valid[r]<=1'b0;
		  end	
     end	 
   end
   
  else if(start_mult)
  begin
     for(r=1;r<`super_scalarity+1;r=r+1)
	  begin
	    if(r>`super_scalarity/2)
		 begin
		   vect_top[r]<=0;
		   vect_top_i_valid[r]<=1;
		   top_count=top_count+1;
		 end
		else if(addr_top[1]<=`s_x_count)
          begin
            vect_top[r]<=my_mem[r+`super_scalarity/2][addr_top[r]];
			addr_top[r]<=addr_top[r]+1;
			vect_top_i_valid[r]<=1;
			top_count=top_count+1;
          end
		 else
           begin
             for(r=1;r<`super_scalarity+1;r=r+1)
		      begin
	            vect_top_i_valid[r]<=1'b0;
		      end
           end		   
	  end


  end  
  
  
 else
     begin
       for(r=1;r<`super_scalarity+1;r=r+1)
		  begin
			vect_top_i_valid[r]<=1'b0;
		  end
     end
 end 

  /*
  
always@(posedge clk)
 begin
  for( k=1;k<`super_scalarity+1;k=k+2)
   begin
     if(i_valid_alpha[k] & o_ready_1 [k] & o_ready_2[k])
	  begin
	   i_data_1[k]<=alpha_local[k];
	   valid_m_1[k]<=1;
	   i_data_2[k+1]<=alpha_local[k+1];
	   valid_m_2[k+1]<=1;
	  end
    else if(i_valid_beta &  o_ready_1 [k] & o_ready_2[k])
	 begin
	  i_data_1[k]<=beta_local[k];
	   valid_m_1[k]<=1;
	   i_data_2[k+1]<=beta_local[k+1];
	   valid_m_2[k+1]<=1;
	 end
	else 
     begin
       valid_m_1[k]<=0;
	   valid_m_2[k]<=0;
     end	 
   end

 end 

 */
generate                                            //for adding gamma
genvar x, y, z; 
for (x=0;x<len;x=x+1) begin:xs
  if(x==0)
   begin: instnce
   for (y=1; y<`super_scalarity+1; y=y+2) begin:ys    
		 	float_add  my_top_adder_instnce(
             .aclk(clk),                                  // input wire aclk
             .s_axis_a_tvalid(i_valid_gamma_local[y]),            // input wire s_axis_a_tvalid
             .s_axis_a_tready(o_ready_1[y]),            // output wire s_axis_a_tready
             .s_axis_a_tdata(gamma_local[y]),              // input wire [31 : 0] s_axis_a_tdata
             .s_axis_b_tvalid(i_valid_gamma_local[y+1]),            // input wire s_axis_b_tvalid
             .s_axis_b_tready(o_ready_2[y+1]),            // output wire s_axis_b_tready
             .s_axis_b_tdata(gamma_local[y+1]),              // input wire [31 : 0] s_axis_b_tdata
             .m_axis_result_tvalid(o_valid[`super_scalarity+y-1]),  // output wire m_axis_result_tvalid
             .m_axis_result_tready(i_ready[`super_scalarity+y-1]),  // input wire m_axis_result_tready
             .m_axis_result_tdata(o_data[`super_scalarity+y-1])    // output wire [31 : 0] m_axis_result_tdata
           );
		  end
		end

	else
     
     begin: instnce
      for(z=0;z< `super_scalarity/(2**(x+1));z=z+1) begin:zs
	       float_add top_adder_instnce (
           .aclk(clk),                                  // input wire aclk
           .s_axis_a_tvalid(o_valid[2**len+2**(len+1)-2**(len+2-x)+4*z ]),            // input wire s_axis_a_tvalid
           .s_axis_a_tready(i_ready[2**len+2**(len+1)-2**(len+2-x)+4*z]),            // output wire s_axis_a_tready
           .s_axis_a_tdata(o_data[2**len+2**(len+1)-2**(len+2-x)+4*z]),              // input wire [31 : 0] s_axis_a_tdata
           .s_axis_b_tvalid(o_valid[2**len+2**(len+1)-2**(len+2-x)+4*z+2]),            // input wire s_axis_b_tvalid
           .s_axis_b_tready(i_ready[2**len+2**(len+1)-2**(len+2-x)+4*z+2]),            // output wire s_axis_b_tready
           .s_axis_b_tdata(o_data[2**len+2**(len+1)-2**(len+2-x)+4*z+2]),              // input wire [31 : 0] s_axis_b_tdata
           .m_axis_result_tvalid(o_valid[2**len+2**(len+1)-2**(len+1-x)+2*z]),  // output wire m_axis_result_tvalid
           .m_axis_result_tready(i_ready[2**len+2**(len+1)-2**(len+1-x)+2*z]),  // input wire m_axis_result_tready
           .m_axis_result_tdata(o_data[2**len+2**(len+1)-2**(len+1-x)+2*z])    // output wire [31 : 0] m_axis_result_tdata
         );
	   
	   end
	end
   end

 endgenerate



always@(posedge clk)
  begin 
    gamma <= o_data[3*`super_scalarity-4];
	o_valid_gamma<= o_valid[3*`super_scalarity-4];
	delta<= o_data_delta[3*`super_scalarity-4];
	o_valid_delta_top<= o_valid_delta[3*`super_scalarity-4];
  end

  
generate                                               //for adding delta
genvar a, d, c; 
for (a=0;a<len;a=a+1) begin:as
  if(a==0)
   begin: instnce
   for (d=1; d<`super_scalarity+1; d=d+2) begin:bs    
		 	float_add  my_top_adder_instnce(
             .aclk(clk),                                  // input wire aclk
             .s_axis_a_tvalid(i_valid_delta_local[d]),            // input wire s_axis_a_tvalid
             .s_axis_a_tready(o_ready_1_beta[d]),            // output wire s_axis_a_tready
             .s_axis_a_tdata(delta_local[d]),              // input wire [31 : 0] s_axis_a_tdata
             .s_axis_b_tvalid(i_valid_delta_local[d+1]),            // input wire s_axis_b_tvalid
             .s_axis_b_tready(o_ready_2_beta[d+1]),            // output wire s_axis_b_tready
             .s_axis_b_tdata(delta_local[d+1]),              // input wire [31 : 0] s_axis_b_tdata
             .m_axis_result_tvalid(o_valid_delta[`super_scalarity+d-1]),  // output wire m_axis_result_tvalid
             .m_axis_result_tready(i_ready_delta[`super_scalarity+d-1]),  // input wire m_axis_result_tready
             .m_axis_result_tdata(o_data_delta[`super_scalarity+d-1])    // output wire [31 : 0] m_axis_result_tdata
           );
		  end
		end

	else
     
     begin: instnce
      for(c=0;c< `super_scalarity/(2**(a+1));c=c+1) begin:cs
	       float_add top_adder_instnce (
           .aclk(clk),                                  // input wire aclk
           .s_axis_a_tvalid(o_valid_delta[2**len+2**(len+1)-2**(len+2-a)+4*c ]),            // input wire s_axis_a_tvalid
           .s_axis_a_tready(i_ready_delta[2**len+2**(len+1)-2**(len+2-a)+4*c]),            // output wire s_axis_a_tready
           .s_axis_a_tdata(o_data_delta[2**len+2**(len+1)-2**(len+2-a)+4*c]),              // input wire [31 : 0] s_axis_a_tdata
           .s_axis_b_tvalid(o_valid_delta[2**len+2**(len+1)-2**(len+2-a)+4*c+2]),            // input wire s_axis_b_tvalid
           .s_axis_b_tready(i_ready_delta[2**len+2**(len+1)-2**(len+2-a)+4*c+2]),            // output wire s_axis_b_tready
           .s_axis_b_tdata(o_data_delta[2**len+2**(len+1)-2**(len+2-a)+4*c+2]),              // input wire [31 : 0] s_axis_b_tdata
           .m_axis_result_tvalid(o_valid_delta[2**len+2**(len+1)-2**(len+1-a)+2*c]),  // output wire m_axis_result_tvalid
           .m_axis_result_tready(i_ready_delta[2**len+2**(len+1)-2**(len+1-a)+2*c]),  // input wire m_axis_result_tready
           .m_axis_result_tdata(o_data_delta[2**len+2**(len+1)-2**(len+1-a)+2*c])    // output wire [31 : 0] m_axis_result_tdata
         );
	   
	   end
	end
   end

 endgenerate
 
 


generate 
genvar i;
 for (i=1; i<`super_scalarity+1; i=i+1)begin:is
    cg_top top_instnce(
        .clk(clk),
		.b(top_b[i]),
		.i_valid(top_i_valid[i]),
		.sol(top_sol[i]),
		.o_valid(top_o_valid[i]),
		.iter_num(iter_num),
		.req_iter(req_iter),
		
		.gamma_local(gamma_local[i]),
		.delta_local(delta_local[i]),
		.o_valid_gamma_local(i_valid_gamma_local[i]),
		.o_valid_delta_local(i_valid_delta_local[i]),
		
		.i_vect_left(vect_left[i]),
		.i_vect_right(vect_right[i]),
		.i_vect_top(vect_top[i]),
		.i_vect_bottom(vect_bottom[i]),
		
		.i_valid_vect_left(vect_left_i_valid[i]),
		.i_valid_vect_right(vect_right_i_valid[i]),
		.i_valid_vect_bottom(vect_bottom_i_valid[i]),
		.i_valid_vect_top(vect_top_i_valid[i]),
		
		
		.gamma(gamma),
		.delta(delta),
		.i_valid_gamma_local(o_valid_gamma),
		.i_valid_delta_local(o_valid_delta_top),
		
		
		.o_data_mult(i_data_mult[i]),
		.o_valid_mult(i_valid_mult[i])
		
       );


 end
 endgenerate
  
endmodule
