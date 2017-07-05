`define i 1
`define N 2**`i

//`define numloop $clog2(`N)
module vector_by_vector(
input clk,
input wire [(32*`N)-1:0] vect_A,
input wire [(32*`N)-1:0] vect_B,
output reg [31:0] main_o_data,
input main_i_valid_1,
input main_i_valid_2,
output  main_o_ready_1,
output  main_o_ready_2,
output reg o_valid_result,
input  wire i_ready_result

);
wire o_valid[3*`N-2:`N];
wire i_ready[3*`N-2:`N];
wire o_ready_1[`N-1:0];
wire o_ready_2[`N-1:0];
//parameter N= 2**`i;
wire [31:0] o_data[3*`N-2:`N];
reg [31:0] i_data_1[`N-1:0];
reg [31:0] i_data_2[`N-1:0];
reg test_1;
reg test_2;


integer i;
integer k;
assign i_ready[3*`N -2]= i_ready_result;
parameter numloop=$clog2(`N);
parameter loop_ctrl=0;


always@(posedge clk)
begin
if(main_i_valid_1 & main_i_valid_2)
 begin
 for(i=0;i<`N;i=i+1)
  begin 
  i_data_1[i]<=vect_A[i*32+:32];
  i_data_2[i]<=vect_B[i*32+:32];
  

 end
end
end

always @(posedge clk)
  begin 
    main_o_data <= o_data[3*`N -2];
	o_valid_result<=o_valid[3*`N -2];
	//i_ready[3*`N -2]<=i_ready_result;
  end
/*
always@(posedge clk)
begin
 for(k=0;k<`N;k=k+1)
  begin
   if(o_ready_1[k]!=1'b1)
    begin
     test_1<=1'b0;
    end
  end
  if(test_1!=1'b0)
   main_o_ready_1<=1'b1;
end

always@(posedge clk)
begin
 for(k=0;k<`N;k=k+1)
  begin
   if(o_ready_1[k]!=1'b1)
    begin
     test_2<=1'b0;
    end
  end
  if(test_2!=1'b0)
   main_o_ready_2<=1'b1;
end
  */
generate
genvar x, y, z; 
for (x=0;x<numloop+1;x=x+1) begin:xs
  if(x==0)
   begin: instnce
   for (y=0; y<`N; y=y+1) begin:ys    
		     my_mult
			   my_mult_instance(
			 .clk(clk),
			.i_data_1(i_data_1[y]),
			.i_data_2(i_data_2[y]),
			.o_data(o_data[`N+y]),
			.i_valid_1(main_i_valid_1),
            .i_valid_2(main_i_valid_2),
            .o_ready_1(main_o_ready_1),
            .o_ready_2(main_o_ready_2),
            .o_valid_result(o_valid[`N+y]),
            .i_ready_result(i_ready[`N+y]) 
		);
		  end
		end
	
	else
     
     begin: instnce
      for(z=0;z< `N/(2**(x-1));z=z+2) begin:zs
	    adder
		  my_adder_instance(
		  .clk(clk),
		   .i_data_1(o_data[2**`i+2**(`i+1)-2**(`i+2-x)+z]),
		   .i_data_2(o_data[2**`i+2**(`i+1)-2**(`i+2-x)+z+1]),
		   .o_data(o_data[2**`i+2**(`i+1)-2**(`i-x+1)+(z/2)]),
		   .i_valid_1(o_valid[2**`i+2**(`i+1)-2**(`i+2-x)+z]),
           .i_valid_2(o_valid[2**`i+2**(`i+1)-2**(`i+2-x)+z+1]),
           .o_ready_1(i_ready[2**`i+2**(`i+1)-2**(`i+2-x)+z]),
           .o_ready_2(i_ready[2**`i+2**(`i+1)-2**(`i+2-x)+z+1]),
           .o_valid_result(o_valid[2**`i+2**(`i+1)-2**(`i-x+1)+(z/2)]),
           .i_ready_result(i_ready[2**`i+2**(`i+1)-2**(`i-x+1)+(z/2)])
		   );
	   
	   end
	end
   end

/*
generate
genvar x, y, z; 
for (x=0;x<numloop+1;x=x+1) begin:xs
  if(x==0)
   begin: instnce
   for (y=0; y<`N; y=y+1) begin:ys    
		     my_mult
			   my_mult_instance(
			.i_data_1(i_data_1[y]),
			.i_data_2(i_data_2[y]),
			.o_data(o_data[y]) 
		);
		  end
		end
		
	
	else
     
     begin: instnce
      for(z=0;z< `N/(2**(x-1));z=z+2) begin:zs

	   
	    adder
		  my_adder_instance(
		   .i_data_1(o_data[2*`N*(1-((1/2)^^(x-1)))+z]),
		   .i_data_2(o_data[2*`N*(1-((1/2)^^(x-1)))+z+1]),
		   .o_data(o_data[2*`N*(1-((1/2)^^x))+z/2])
		   );
	   
	   end
	end
   end
     
   
   */
  endgenerate
endmodule