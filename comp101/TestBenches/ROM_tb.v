// Code your testbench here
module testbench_ROM32x256;
    reg [7:0] address;        // Address input
    reg clock;                // Clock input
    wire [31:0] q;            // Output data

    // Initialize expected_data array with expected data values
    reg [31:0] expected_data[0:1];

    // Instantiate the ROM module
    ROM32x256 ROM32x256_instance (
        .address(address),
        .clock(clock),
        .q(q)
    );

    // Clock generation (for example, 10 MHz clock)
    reg clk = 0;
    always begin
        #5 clk = ~clk;
    end

    // Initialize signals
    initial begin
        address = 8'b00000000;  // Start reading from address 0
        clock = 0;

        // Fill expected_data with the data you expect at each address
        expected_data[0] = 32'h01234567; // Address 0
        expected_data[1] = 32'h89ABCDEF; // Address 1

        // Read and verify data
        repeat (2) begin
            #1 address = address + 1; // Increment address
            if (q !== expected_data[address]) begin
                $display("Mismatch at address %d: Expected %h, Got %h", address, expected_data[address], q);
                $finish;
            end
        end

        $display("ROM test passed.");
        $finish;
    end
endmodule
