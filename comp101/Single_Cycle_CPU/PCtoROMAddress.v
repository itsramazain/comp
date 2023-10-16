module PCtoROMAddress (
    input wire clk,                    // Clock input
    input wire reset,                  // Reset input
    input wire [31:0] program_counter, // 32-bit program counter input
    output wire [4:0] rom_address     // 5-bit ROM address output
);

    reg [4:0] rom_address_reg;  // Register to hold the ROM address

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the ROM address to a default value
            rom_address_reg <= 5'b0;
        end else begin
            // Calculate the ROM address based on the program_counter
            rom_address_reg <= program_counter[31:2] >> 2;
        end
    end

    // Output the ROM address
    assign rom_address = rom_address_reg;

endmodule
