module Branch_Target_calculator(
		input [7:0]immediate,//immedate filed from the instruction
		input [7:0]program_counter, //nest instruction
		output reg[7:0]BT
		
		);
		/*becase the nextinstrction is saved in a word manner we dont need to shift it by 2*/
		always@(*)
		
			BT= immediate[7:0]+ program_counter;
		
endmodule

		
		
		
