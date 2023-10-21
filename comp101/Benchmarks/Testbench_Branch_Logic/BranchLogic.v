module BranchLogic (
    input wire brancheq,                   // Input for branch if equal
    input wire branchnotequal,             // Input for branch if not equal
    input wire brachlessthat,              // Input for branch if less than
    input wire branchgreaterthanorequal,   // Input for branch if greater than or equal
    input wire branchlessthanorequal,      // Input for branch if less than or equal
    input wire jal,                        // Input for jump and link
    input wire zero,                       // Input for zero flag
    input wire less,                       // Input for less flag
    output wire branch_or_not              // Output for the branch or not logic
);

assign branch_or_not = 
    (brancheq & zero) ||                  // Branch if equal and zero flag is true
    (branchnotequal & ~zero) ||           // Branch if not equal and zero flag is false
    (brachlessthat & less) ||             // Branch if less than and less flag is true
    (branchgreaterthanorequal & (zero & ~less)) ||  // Branch if greater than or equal and zero flag is true but less flag is false
    (branchlessthanorequal & (zero & less)) ||     // Branch if less than or equal and both zero and less flags are true
    (jal);                                // Jump and link

endmodule
