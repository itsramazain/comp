module jump_addresscal_culator(output [7:0]Jump_addr,
			input [25:0] addr,
			

);
			assign Jump_addr=addr[7:0]<<2;

endmodule 
