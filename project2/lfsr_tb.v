`timescale 1ns/1ns
module lfsr_tb();
	reg clk, check;
	wire [8:0] Q;
	integer Qbin, i;
	integer count[0:198];
	
	lfsr U0(Q,'b101000000000000000000,clk,'b1,check);
	
	initial begin
	  clk = 0;
	  check = 0;
	  for(i=0;i<199;i=i+1)
	     count[i] = 0;
	  #2 check = 1;
	end
	
	always #1 clk = ~clk;
	always #2 begin
	  if(Q[8]) Qbin = -10 * Q[7:4] + Q[3:0];
	  else Qbin = 10 * Q[7:4] + Q[3:0];
	  if(Qbin > -100 && Qbin < 100) count[Qbin+99] = count[Qbin+99] + 1;
	end
	
	always #1000000
	  for(i=0; i<199; i = i+1)
	     $display ("%d - %d",i-99,count[i]);
endmodule