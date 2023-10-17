module ProgramCounter (
    input wire clk,                          // Clock input
    input wire reset,                        // Reset signal (active high)
    input wire enable_increment,             // Input selector from the control unit to enable increment
    output reg [7:0] pc = 8'b00000000        // Program counter output to fetch instructions memory (ROM)
);

    // initial value of the program counter
    reg [7:0] initial_pc = 8'b00000000;     // 8-bits address - 256 locations in ROM 32 bits each location (8192 bits) - 1 M9K block used  

    // synchronous always block to increment the program counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= initial_pc;   // Reset the program counter to the initial value
        end else if(enable_increment) begin
            pc <= pc + 1;       // Increment the program counter by 1 every cycle if fetch signal is 1 
        end
    end

endmodule
