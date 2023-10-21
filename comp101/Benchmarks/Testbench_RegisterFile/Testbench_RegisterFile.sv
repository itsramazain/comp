module Testbench_RegisterFile;

    reg clock, Reset, reg_write_enable;
    reg [4:0] read_register_1, read_register_2, reg_write_address;
    reg [31:0] write_data;
    wire [31:0] read_data_1, read_data_2;

    // Instantiate the RegisterFile module
    RegisterFile reg_file (
        .clock(clock),
        .Reset(Reset),
        .read_register_1(read_register_1),
        .read_register_2(read_register_2),
        .reg_write_enable(reg_write_enable),
        .write_data(write_data),
        .reg_write_address(reg_write_address),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    // Initialize signals
    initial begin
        clock = 0;
        Reset = 0;
        reg_write_enable = 0;
        read_register_1 = 0;
        read_register_2 = 0;
        reg_write_address = 0;
        write_data = 0;

        // Apply reset
        Reset = 1;
        #10 Reset = 0;

        // Test Scenario 1: Write data to register 1 and read from it
        write_data = 32'hABCDEF12;
        reg_write_enable = 1;
        reg_write_address = 1; // Register 1
        #10;
        $display("Scenario 1: Read data from register 1 = 0x%h (Expect 0xABCDEF12)", read_data_1);

        // Test Scenario 2: Read from an uninitialized register (e.g., register 0)
        read_register_1 = 0; // Read from register 0
        #10;
        $display("Scenario 2: Read data from register 0 (Uninitialized) = 0x%h (Expect 0x00000000)", read_data_1);

        // Add more test scenarios as needed

        // Finish simulation
        $finish;
    end

    // Clock generation
    always begin
        #5 clock = ~clock;
    end

endmodule
