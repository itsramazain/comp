module Testbench_flipflop;
    reg D, Clock, Reset, E;
    wire Q;

    // Instantiate the D flip-flop module
    d_flip_flop DFF (
        .E(E),
        .D(D),
        .Clock(Clock),
        .Reset(Reset),
        .Q(Q)
    );

    // Clock generation
    always begin
        Clock = 1'b0;
        #5 Clock = ~Clock;
    end

    // Reset generation
    initial begin
        Reset = 1; // Active high reset
        E = 1;     // Enable D input
        D = 0;     // Set initial D input
        #10 Reset = 0; // Release reset after 10 time units

        // Scenario 1: Testing D input when E is active
        $display("Scenario 1: Testing D input with E active");
        D = 1;
        #5 D = 0;
        $display("Q = %b", Q);

        // Scenario 2: Testing D input when E is inactive
        $display("Scenario 2: Testing D input with E inactive");
        E = 0;
        D = 1;
        #5 D = 0;
        $display("Q = %b", Q);

        // Scenario 3: Testing D input with reset (E active)
        $display("Scenario 3: Testing D input with reset (E active)");
        Reset = 1;
        #5 Reset = 0;
        D = 1;
        #5 D = 0;
        $display("Q = %b", Q);

        // Scenario 4: Testing D input with reset (E inactive)
        $display("Scenario 4: Testing D input with reset (E inactive)");
        E = 0;
        Reset = 1;
        #5 Reset = 0;
        D = 1;
        #5 D = 0;
        $display("Q = %b", Q);

        // Add more scenarios as needed

        // End simulation
        $finish;
    end
endmodule
