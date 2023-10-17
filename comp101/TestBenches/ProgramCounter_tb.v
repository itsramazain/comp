module ProgramCounter_tb;

    // Define the signals
    reg clk;
    reg reset;
    reg enable_increment;
    wire [7:0] pc;

    // Instantiate the ProgramCounter module
    ProgramCounter pc_instance (
        .clk(clk),
        .reset(reset),
        .enable_increment(enable_increment),
        .pc(pc)
    );

    // Create a clock signal
    always begin
        #5 clk = ~clk; // Toggle the clock every 5 time units
    end

    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        enable_increment = 0;

        // Reset test
        reset = 1;
        #10 reset = 0;

        // Test case 1: Verify initial value
        #10;
        if (pc !== 8'b00000000) $display("Test case 1 failed");
        else $display("Test case 1 passed");

        // Test case 2: Verify increment
        enable_increment = 1;
        #10;
        if (pc !== 8'b00000001) $display("Test case 2 failed");
        else $display("Test case 2 passed");

        // Test case 3: Verify reset
        reset = 1;
        #10 reset = 0;
        if (pc !== 8'b00000000) $display("Test case 3 failed");
        else $display("Test case 3 passed");

        // Add more test cases as needed

        // Terminate simulation
        $finish;
    end

endmodule
