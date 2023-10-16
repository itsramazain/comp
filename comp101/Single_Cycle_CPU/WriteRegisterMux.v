module WriteRegisterMux (
    input wire clk,                // Clock input
    input wire reset,              // Reset input
    input wire [4:0] write_register,
    input wire [4:0] read_register_2,
    input wire reg_write_enable,
    output wire [4:0] selected_register
);

    reg [4:0] selected_register_reg;  // Register to hold the selected register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the selected register to a default value (all zeros)
            selected_register_reg <= 5'b0;
        end else begin
            // Select the write register if reg_write_enable is active, otherwise select read_register_2
            selected_register_reg <= (reg_write_enable == 1'b0) ? write_register : read_register_2;
        end
    end

    // Output the selected register
    assign selected_register = selected_register_reg;

endmodule
