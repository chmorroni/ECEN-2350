module comp_2n(x,y,GTo,EQo,LTo,NEG);
	parameter n = 2;
   input [2*(n-1) + 1:0] x;
	input [2*(n-1) + 1:0] y;
	output GTo, EQo, LTo;
	input NEG;
	
	wire [n:0] GT;
	wire [n:0] EQ;
	wire [n:0] LT;
	wire flip;
	
	assign GT[n] = 0;
	assign EQ[n] = 1;
	assign LT[n] = 0;
	
	genvar i;
	generate
		for(i=n; i>0; i=i-1)
		begin : gen_loop
			comp_2 comp_2_inst(x[2*(i-1) + 1:2*(i-1)],y[2*(i-1) + 1:2*(i-1)],GT[i],EQ[i],LT[i],GT[i-1],EQ[i-1],LT[i-1]);
		end
	endgenerate
	
	assign flip = NEG & (x[2*(n-1) + 1]^y[2*(n-1) + 1]);
	
	assign GTo = GT[0] ^ flip;
	assign EQo = EQ[0];
	assign LTo = LT[0] ^ flip;
	
endmodule
