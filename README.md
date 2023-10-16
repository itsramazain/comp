# Single Cycle MIPS Processor Modules

This repository contains Verilog modules that collectively form a single-cycle MIPS processor. 
**Note:** We, the contributors to this repository, are computer engineers participating in the National Semiconductors Jordanian competition.
This README provides an overview of the modules and their functionalities.

## Modules Included

1. **ALU (Arithmetic Logic Unit):**
   - Implements arithmetic and logical operations, including addition, subtraction, bitwise AND, OR, and more.

2. **Control Unit:**
   - Manages the control signals for various processor components based on the opcode of the instruction.

3. **Data Memory:**
   - Represents the data memory in the processor, where data can be read from and written to.

4. **Instruction Memory:**
   - Models the instruction memory, responsible for storing and fetching instructions.

5. **MIPS CPU:**
   - Integrates all the above modules to create a complete single-cycle MIPS processor.

## How to Use

To use these modules and assemble them into a functional MIPS processor, follow these steps:

1. Clone this repository to your local machine using `git clone`.

2. Open your preferred Verilog development environment (e.g., ModelSim or Xilinx ISE).

3. Import the Verilog modules into your project.

4. Ensure that the modules are correctly connected to each other, and wire up the control signals.

5. Simulate or synthesize your MIPS processor design to test its functionality.

6. Write MIPS assembly code to test your processor. You can use any MIPS assembly code editor and then load the generated machine code into the instruction memory.

7. Run simulations or deploy the design on an FPGA board to observe the processor's behavior.

## Testing

The repository may include testbenches for some modules to help verify their correctness. You can run these testbenches to ensure that the modules are functioning as expected.

## Contributions

Contributions are welcome. If you find any issues or would like to enhance these modules, please fork the repository, make your changes, and create a pull request. Be sure to document any changes you make.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

This project draws inspiration from the MIPS architecture and various Verilog processor design tutorials and textbooks. We appreciate the open-source hardware community for their valuable contributions.

---

Feel free to update this README with specific details about your processor's modules and any other relevant information.
