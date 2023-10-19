module PCtoROMAddress (
    input wire [31:0] program_counter,  // 32-bit program counter input
    output wire [4:0] rom_address       // 5-bit ROM address output
);

    // Assign the ROM address by taking bits [31:2] of the program counter and right-shifting them by 2 bits.
    // This effectively discards the two least significant bits, producing a 5-bit ROM address.
    assign rom_address = program_counter[31:2] >> 2;

endmodule
