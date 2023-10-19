module PCtoROMAddress (
    input wire [31:0] program_counter,  // 32-bit program counter input
    output wire [4:0] rom_address      // 5-bit ROM address output
);

assign rom_address = program_counter[31:2] >> 2;

endmodule
