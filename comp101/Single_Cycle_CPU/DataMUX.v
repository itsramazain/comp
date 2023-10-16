module DataMUX (
    input wire clk,                // Clock input
    input wire reset,              // Reset input
    input wire [31:0] ram_result,
    input wire [31:0] alu_result,
    input wire mux_select,         // MUX selection control
    output wire [31:0] data_output
);

    reg [31:0] data_output_reg;    // Register to hold the selected data

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the selected data to all zeros
            data_output_reg <= 32'b0;
        end else begin
            // Select data based on mux_select
            if (mux_select) begin
                data_output_reg <= ram_result;
            end else begin
                data_output_reg <= alu_result;
            end
        end
    end

    // Output the selected data
    assign data_output = data_output_reg;

endmodule
