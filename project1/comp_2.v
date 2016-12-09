module comp_2(x,y,GTi,EQi,LTi,GTo,EQo,LTo);
	input [1:0] x;
	input [1:0] y;
	input GTi;
	input EQi;
	input LTi;
	output GTo;
	output EQo;
	output LTo;
	
	assign GTo = GTi | (EQi & ((x[1]&~y[1]) | (x[0]&~y[1]&~y[0]) | (x[1]&x[0]&~y[0])));
	assign EQo = EQi & ((~x[1]&~x[0]&~y[1]&~y[0]) | (~x[1]&x[0]&~y[1]&y[0]) | (x[1]&~x[0]&y[1]&~y[0]) | (x[1]&x[0]&y[1]&y[0]));
	assign LTo = LTi | (EQi & ((~x[1]&y[1]) | (~x[1]&~x[0]&y[0]) | (~x[0]&y[1]&y[0])));
	
endmodule
