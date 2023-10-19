module Mux_2x1 (
    input wire i0,                 // Input 0
    input wire i1,                 // Input 1
    input wire sel,                // Multiplexer select input
    output wire out                // Multiplexer output
);

    // The multiplexer selects i0 when sel is 0, and i1 when sel is 1.
    assign out = (sel) ? i1 : i0;

endmodule