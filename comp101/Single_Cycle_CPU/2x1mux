module mux_2x1(i0,i1,sel,out);
	input [31:0]i0,i1;
	input sel;
	output reg [31:0]out;
	
	always@(*)
		if(sel)
			out=i1;
		else 
			out=i0;

endmodule
