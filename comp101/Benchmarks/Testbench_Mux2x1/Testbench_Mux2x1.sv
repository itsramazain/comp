module Testbench_Mux2x1;

    reg [31:0] i0, i1;  // Input data
    reg sel;            // Selection control
    wire [31:0] out;    // Output data

    // Instantiate the mux_2x1 module
    Mux2x1 uut (
        .i0(i0),
        .i1(i1),
        .sel(sel),
        .out(out)
    );

    // Initialize signals
    initial begin
        $display("Testing mux_2x1 module...");
        $display("==========================================");

        // Test case 1: Select 'i0'
        i0 = 32'h12345678;
        i1 = 32'h87654321;
        sel = 0;
        #10;  // Wait a few time units
        $display("Test Case 1: Select 'i0' (sel = 0)");
        $display("Input i0 = %h", i0);
        $display("Input i1 = %h", i1);
        $display("Output = %h", out);
        $display("==========================================");

        // Test case 2: Select 'i1'
        sel = 1;
        #10;  // Wait a few time units
        $display("Test Case 2: Select 'i1' (sel = 1)");
        $display("Input i0 = %h", i0);
        $display("Input i1 = %h", i1);
        $display("Output = %h", out);
        $display("==========================================");

        $finish;  // Finish simulation
    end

endmodule
