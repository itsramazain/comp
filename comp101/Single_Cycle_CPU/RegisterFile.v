module RegisterFile (
    input wire clk,
    input wire reset,
    input wire [4:0] read_register_1,
    input wire [4:0] read_register_2,
    input wire [4:0] write_register,
    //input wire write_enable,
    input wire [31:0] write_data,
    input wire reg_write_enable,        // Control signal from ControlUnit for register write
    input wire [4:0] reg_write_address, // Control signal from ControlUnit for write address
    output reg [31:0] read_data_1,     // Change to reg
    output reg [31:0] read_data_2      // Change to reg
);

reg [31:0] registers [0:31];



integer i; // Declare 'i' as an integer
always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all registers to 0 except for register 0
        for (i = 0; i <= 31; i = i + 1) begin
            registers[i] <= 32'b0;
        end
    end else begin
        // Read data from registers based on read_register_1 and read_register_2
        read_data_1 <= (read_register_1 == 0) ? 32'b0 : registers[read_register_1];
        read_data_2 <= (read_register_2 == 0) ? 32'b0 : registers[read_register_2];
        
        // Write data to registers based on control signals
        if (reg_write_enable && (reg_write_address != 0)) begin
            registers[reg_write_address] <= write_data;
        end
    end
end

endmodule