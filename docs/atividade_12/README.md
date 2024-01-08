# First Part

## Activity Statement 

The twelfth activity was to add the maindec.vhd file to the project, define it as toplevel, and add the component declaration for the maindec entity to the riscv_pkg package.

### Development 

The riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
	 -- Maindec
	 component maindec is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			op: 		 	in 			BIT_VECTOR(6 downto 0);
			ResultSrc: 		out 			BIT_VECTOR(1 downto 0);
			MemWrite: 		out 			BIT;
			Branch, ALUSrc: 	out 			BIT;
			RegWrite, Jump: 	out 			BIT;
			ImmSrc: 		out 			BIT_VECTOR(1 downto 0);
			ALUOp: 			out 			BIT_VECTOR(1 downto 0)
		);
    end component maindec;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The twelfth activity was to add the maindec.vhd file to the DE10_LITE_riscvsingle project. To test it, the author should have replaced the code from listing 7 with the code from listing 8, in the toplevel entity (DE10_LITE_riscvsingle.v). This code, written in Verilog, instantiates the maindec entity and decode both the op input data and the output data RegWrite, ImmSrc[1:0], ALUSrc, MemWrite, ResultSrc[1:0], Branch, ALUOp [1:0] and Jump, for segment a of the HEX0 7-segment display and for the LEDs (LEDR[9:0]), respectively. The input data was mapped to the SW keys, in the following fashion.

```
| Signal        | Switch   | Display     |
|---------------|----------|-------------|
| op            | SW[9:0]  |             |
| ImmSrc[1:0]   |          |  LEDR[9:8]  |
| ALUSrc        |          |  LEDR[7]    |
| MemWrite      |          |  LEDR[6]    |
| ResultSrc[1:0]|          |  LEDR[5:4]  |
| Branch        |          |  LEDR[3]    |
| ALUOp[1:0]    |          |  LEDR[2:1]  |
| RegWrite      |          |  HEX0[0]    |
| Jump          |          |  LEDR[0]    |
```

The outputs should behave as the secont table available in "/Projeto SEL5752 - 2023.pdf" file. 

### Development 

'maindec.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". In this location, there is also a video demonstrating its behaviour. 
