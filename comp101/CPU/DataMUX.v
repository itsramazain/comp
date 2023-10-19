// This module represents a data multiplexer that selects data from either the RAM or ALU result based on a control signal.

module DataMUX (
    input wire clk,                // Clock input
    input wire reset,              // Reset input (active high)
    input wire [31:0] ram_result,  // Data from RAM
    input wire [31:0] alu_result,  // Data from ALU
    input wire mux_select,         // MUX selection control (0 for ALU, 1 for RAM)
    output wire [31:0] data_output // Selected data output
);

    reg [31:0] data_output_reg;    // Register to hold the selected data

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the selected data to all zeros
            data_output_reg <= 32'b0;
        end else begin
            // Select data based on mux_select
            if (mux_select) begin
                // If mux_select is active, select data from RAM
                data_output_reg <= ram_result;
            end else begin
                // If mux_select is not active, select data from ALU
                data_output_reg <= alu_result;
            end
        end
    end

    // Output the selected data
    assign data_output = data_output_reg;

endmodule
