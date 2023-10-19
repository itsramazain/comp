module Branch_Target_calculator(
		input [15:0]immediate,//immedate filed from the instruction
		input [31:0]program_counter, //nest instruction
		output reg[31:0]BT
		
		);
		/*becase the nextinstrction is saved in a word manner we dont need to shift it by 2*/
		always@(*)
			BT={immediate[15],immediate}+program_counter;
		
endmodule

		
		
		
