module Testbench_register;
    reg [31:0] D;         // 32-bit data input
    wire [31:0] Q;        // 32-bit data output
    reg Clock, Reset, E;  // Clock, Reset, and Enable signals

    // Instantiate the register module
    register reg (
        .D(D),
        .Clock(Clock),
        .Reset(Reset),
        .Q(Q),
        .E(E)
    );

    // Clock generation
    always begin
        Clock = 1'b0;
        #5 Clock = ~Clock;
    end

    // Reset generation
    initial begin
        Reset = 1; // Active high reset
        E = 1;     // Enable the register
        D = 0;     // Set initial data input
        #10 Reset = 0; // Release reset after 10 time units

        // Test all possible input values
        for (int i = 0; i < 32; i = i + 1) begin
            D = {i{i}}; // Set the input D with a single bit set to 1 at position i

            #5; // Wait for a few clock cycles

            // Check the output Q for the expected value
            if (Q !== D) begin
                $display("Error: Mismatch at bit %d", i);
            end
        end

        // End simulation
        $finish;
    end
endmodule
