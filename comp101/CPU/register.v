module register(D, Clock, Reset, Q, E);
    input [31:0] D;         // 32-bit data input
    output [31:0] Q;        // 32-bit data output
    input Clock, Reset, E;  // Clock, Reset, and Enable signals

	
	
	 d_flip_flop f0(E,D[0],Clock,Reset,Q[0]);
	 d_flip_flop f1(E,D[1],Clock,Reset,Q[1]);
	 d_flip_flop f2(E,D[2],Clock,Reset,Q[2]);
	 d_flip_flop f3(E,D[3],Clock,Reset,Q[3]);
	 d_flip_flop f4(E,D[4],Clock,Reset,Q[4]);
	 d_flip_flop f5(E,D[5],Clock,Reset,Q[5]);
	 d_flip_flop f6(E,D[6],Clock,Reset,Q[6]);
	 d_flip_flop f7(E,D[7],Clock,Reset,Q[7]);
	 d_flip_flop f8(E,D[8],Clock,Reset,Q[8]);
	 d_flip_flop f9(E,D[9],Clock,Reset,Q[9]);
	 d_flip_flop f10(E,D[10],Clock,Reset,Q[10]);
	 d_flip_flop f11(E,D[11],Clock,Reset,Q[11]);
	 d_flip_flop f12(E,D[12],Clock,Reset,Q[12]);
	 d_flip_flop f13(E,D[13],Clock,Reset,Q[13]);
	 d_flip_flop f14(E,D[14],Clock,Reset,Q[14]);
	 d_flip_flop f15(E,D[15],Clock,Reset,Q[15]);
	 d_flip_flop f16(E,D[16],Clock,Reset,Q[16]);
	 d_flip_flop f17(E,D[17],Clock,Reset,Q[17]);
	 d_flip_flop f18(E,D[18],Clock,Reset,Q[18]);
	 d_flip_flop f19(E,D[19],Clock,Reset,Q[19]);
	 d_flip_flop f20(E,D[20],Clock,Reset,Q[20]);
	 d_flip_flop f21(E,D[21],Clock,Reset,Q[21]);
	 d_flip_flop f22(E,D[22],Clock,Reset,Q[22]);
	 d_flip_flop f23(E,D[23],Clock,Reset,Q[23]);
	 d_flip_flop f24(E,D[24],Clock,Reset,Q[24]);
	 d_flip_flop f25(E,D[25],Clock,Reset,Q[25]);
	 d_flip_flop f26(E,D[26],Clock,Reset,Q[26]);
	 d_flip_flop f27(E,D[27],Clock,Reset,Q[27]);
	 d_flip_flop f28(E,D[28],Clock,Reset,Q[28]);
	 d_flip_flop f29(E,D[29],Clock,Reset,Q[29]);
	 d_flip_flop f30(E,D[30],Clock,Reset,Q[30]);
	 d_flip_flop f31(E,D[31],Clock,Reset,Q[31]);
	 
	 
	 
	 
	
	
	

endmodule 
