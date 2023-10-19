module testbench_ProgramCounter;
    reg clk;                 // Clock input
    reg reset;               // Reset signal
    reg enable_increment;    // Input to enable increment
    wire [7:0] pc;           // Program counter output

    // Instantiate the ProgramCounter module
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .enable_increment(enable_increment),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    // Initialize signals
    initial begin
        reset = 1;             // Set reset high
        enable_increment = 0;  // Disable increment

        // Perform a hard test
        $display("Starting program counter test...");
        $display("================================");

        // Test with reset
        reset = 1;
        #100 reset = 0; 
        $display("Program counter with reset: %h", pc);
        $display("================================");


        // Test without reset, increment enabled
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset, increment enabled: %h", pc);

        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset, increment enabled: %h", pc);
        
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset, increment enabled: %h", pc);
        
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset, increment enabled: %h", pc);
        
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset, increment enabled: %h", pc);
        $display("==========================================================");
        
        
        // Test without reset, increment disabled
        enable_increment = 0;
        #100; 
        $display("Program counter without reset, increment disabled: %h", pc);
        
        enable_increment = 0;
        #100; 
        $display("Program counter without reset, increment disabled: %h", pc);
        
        enable_increment = 0;
        #100; 
        $display("Program counter without reset, increment disabled: %h", pc);
        
        enable_increment = 0;
        #100; 
        $display("Program counter without reset, increment disabled: %h", pc);
        $display("==========================================================");
        
        // Test without reset, increment enabled
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset again, increment enabled: %h", pc);

        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset again, increment enabled: %h", pc);
        
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset again, increment enabled: %h", pc);
        $display("==========================================================");
        
        
        // Test with reset
        reset = 1;
        #100 reset = 0; 
        $display("Program counter reset after run: %h", pc);
        $display("==========================================================");
        
        
        // Test without reset, increment enabled
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset again, increment enabled: %h", pc);

        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset again, increment enabled: %h", pc);
        
        reset = 0;
        enable_increment = 1;
        #100; 
        $display("Program counter without reset again, increment enabled: %h", pc);
        $display("==========================================================");
        

        $finish;
    end
endmodule
