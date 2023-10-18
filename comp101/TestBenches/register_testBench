`timescale 1ns / 1ps
module test();
	reg CLOCK_50;
	reg [31:0]D;
	reg Reset,E;
	wire [31:0]Q;
	
	register rr(D,CLOCK_50,Reset,Q,E);
	parameter CLOCK_PERIOD=2;
	
	
	initial begin
			CLOCK_50 <= 1'b1;
		end // initial
		always @ (*)
		begin : Clock_Generator
			#((CLOCK_PERIOD) / 2) 
			CLOCK_50 <= ~CLOCK_50;
		end
	
	
	initial
	begin
	
	Reset=0;
	E=1;
	end
	
	

	
	
	
	initial
	begin
	#2;D=1;Reset=0;
	#2;D=11;Reset=0;
	#2;D=20;Reset=0;
	#2;D=1000;Reset=0;
	#2;D=100;Reset=0;
	#2;D=1;Reset=0;E=1;
	#2;D=20;E=1; Reset=1;
	#2;D=1;Reset=0;E=1;
	

	

		
	
	
	
	
	
	
	
	
	
	end
	
	
	
	initial
	begin
	#1000 $stop;
	end
	initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
	
	

endmodule
