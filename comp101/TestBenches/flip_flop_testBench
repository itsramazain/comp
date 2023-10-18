`timescale 1ns / 1ps
module test();
	reg CLOCK_50;
	reg D,Reset;
	wire Q,Qbar;
	d_flip_flop d(D,CLOCK_50,Reset,Q,Qbar);
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
	end
	
	

	
	
	
	initial
	begin
	#2;D=1;Reset=0;
	#2;D=0;Reset=0;
	#2;D=1;Reset=1;
	

	

		
	
	
	
	
	
	
	
	
	
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
