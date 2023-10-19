//active high signal rest asynchronus 
module d_flip_flop(E,D,Clock,Reset,Q);
	input D,Clock,Reset,E;
	output Q;
	wire Qbar;
	wire Q_0;
	assign Q_0=Q;
	wire Din;
	mux m(Din,D,Q_0,E);
	
	wire cbar,clkbar,s,r,rbar,sbar;
	
	not n11(cbar,Reset);
	not n22(clkbar,Clock);
	
	
	nand n1(sbar,s,rbar);
	nand n2(s,sbar,cbar,clkbar);
	nand n3(r,s,rbar,clkbar);
	nand n4(rbar,Din,cbar,r);
	
	nand n5(Q,Qbar,s);
	nand n6(Qbar,Q,r,cbar);
endmodule


module mux(Din,D,Q,E);
	
	input D,Q,E;
	output reg Din;
	
	
	always@(*)
	
	if (E)
		Din =D;
	else 
		Din =Q;
		
endmodule
	
	
		