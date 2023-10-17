module register(D,Clock,Reset,Q,E);
	input [31:0]D;
	output [31:0]Q;
	input Clock,Reset,E;
	wire En;
	
	
	 d_flip_flop f0(En,D[0],Clock,Reset,Q[0]);
	 d_flip_flop f1(En,D[1],Clock,Reset,Q[1]);
	 d_flip_flop f2(En,D[2],Clock,Reset,Q[2]);
	 d_flip_flop f3(En,D[3],Clock,Reset,Q[3]);
	 d_flip_flop f4(En,D[4],Clock,Reset,Q[4]);
	 d_flip_flop f5(En,D[5],Clock,Reset,Q[5]);
	 d_flip_flop f6(En,D[6],Clock,Reset,Q[6]);
	 d_flip_flop f7(En,D[7],Clock,Reset,Q[7]);
	 d_flip_flop f8(En,D[8],Clock,Reset,Q[8]);
	 d_flip_flop f9(En,D[9],Clock,Reset,Q[9]);
	 d_flip_flop f10(En,D[10],Clock,Reset,Q[10]);
	 d_flip_flop f11(En,D[11],Clock,Reset,Q[11]);
	 d_flip_flop f12(En,D[12],Clock,Reset,Q[12]);
	 d_flip_flop f13(En,D[13],Clock,Reset,Q[13]);
	 d_flip_flop f14(En,D[14],Clock,Reset,Q[14]);
	 d_flip_flop f15(En,D[15],Clock,Reset,Q[15]);
	 d_flip_flop f16(En,D[16],Clock,Reset,Q[16]);
	 d_flip_flop f17(En,D[17],Clock,Reset,Q[17]);
	 d_flip_flop f18(En,D[18],Clock,Reset,Q[18]);
	 d_flip_flop f19(En,D[19],Clock,Reset,Q[19]);
	 d_flip_flop f20(En,D[20],Clock,Reset,Q[20]);
	 d_flip_flop f21(En,D[21],Clock,Reset,Q[21]);
	 d_flip_flop f22(En,D[22],Clock,Reset,Q[22]);
	 d_flip_flop f23(En,D[23],Clock,Reset,Q[23]);
	 d_flip_flop f24(En,D[24],Clock,Reset,Q[24]);
	 d_flip_flop f25(En,D[25],Clock,Reset,Q[25]);
	 d_flip_flop f26(En,D[26],Clock,Reset,Q[26]);
	 d_flip_flop f27(En,D[27],Clock,Reset,Q[27]);
	 d_flip_flop f28(En,D[28],Clock,Reset,Q[28]);
	 d_flip_flop f29(En,D[29],Clock,Reset,Q[29]);
	 d_flip_flop f30(En,D[30],Clock,Reset,Q[30]);
	 d_flip_flop f31(En,D[31],Clock,Reset,Q[31]);
	 
	 
	 
	 
	
	
	

endmodule 