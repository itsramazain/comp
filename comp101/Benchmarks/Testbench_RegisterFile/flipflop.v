// This module represents a D flip-flop with an asynchronous reset (active high).

module d_flip_flop(E, D, Clock, Reset, Q);
    input D, Clock, Reset, E;
    output Q;
    wire Qbar;
    wire Q_0;                // Q output from the previous clock cycle
    assign Q_0 = Q;

    wire Din;
    mux m(Din, D, Q_0, E);   // Multiplexer to select input (D) or previous state (Q_0)

    wire cbar, clkbar, s, r, rbar, sbar;

    not n11(cbar, Reset);     // Generate the complement of the reset signal
    not n22(clkbar, Clock);   // Generate the complement of the clock signal

    // Set up the NAND gates for SR latch functionality
    nand n1(sbar, s, rbar);
    nand n2(s, sbar, cbar, clkbar);
    nand n3(r, s, rbar, clkbar);
    nand n4(rbar, Din, cbar, r);

    // Set up the NAND gates for Q and Qbar outputs
    nand n5(Q, Qbar, s);
    nand n6(Qbar, Q, r, cbar);
endmodule

// This module represents a multiplexer.
module mux(Din, D, Q, E);
    input D, Q, E;
    output reg Din;

    always @(*)
        if (E)
            Din = D;   // If E is active, select input D
        else
            Din = Q;   // If E is inactive, select the previous state Q
endmodule
