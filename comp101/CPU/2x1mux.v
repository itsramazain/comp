module mux_2x1(i0,i1,sel,out);
	paramter n=32;
	input [n-1:0]i0,i1;
	input sel;
	output reg [n-1:0]out;
	
	always@(*)
		if(sel)
			out=i1;
		else 
			out=i0;

endmodule
