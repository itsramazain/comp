module Mux2x1 (
    input [31:0] i0,  // Input data for '0' selector
    input [31:0] i1,  // Input data for '1' selector
    input sel,        // Selection control (0 for 'i0', 1 for 'i1')
    output reg [31:0] out  // Output data based on selection
);

    always @(*) begin
        if (sel) begin
            out = i1;  // When 'sel' is 1, output 'i1'
        end else begin
            out = i0;  // When 'sel' is 0, output 'i0'
        end
    end

endmodule
