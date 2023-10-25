module mux2x1 (
	
    input [n-1:0] i0,  // Input data for '0' selector
    input [n-1:0] i1,  // Input data for '1' selector
    input sel,        // Selection control (0 for 'i0', 1 for 'i1')
    output reg [n-1:0] out  // Output data based on selection
);
parameter n=32;
    always @(*) begin
        if (sel) begin
            out = i1;  // When 'sel' is 1, output 'i1'
        end else begin
            out = i0;  // When 'sel' is 0, output 'i0'
        end
    end

endmodule
