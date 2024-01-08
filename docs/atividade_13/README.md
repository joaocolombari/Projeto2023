# First Part

## Activity Statement 

The thirteenth activity was to add the aludec.vhd file to the project, define it as toplevel, and add the component declaration for the aludec entity to the riscv_pkg package.

### Development 

The riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
	 -- Aludec
	 component aludec is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			opb5: 			in 			BIT;
			funct3: 		in 			BIT_VECTOR(2 downto 0);
			funct7b5: 		in 			BIT;
			ALUOp: 			in 			BIT_VECTOR(1 downto 0);
			ALUControl: 		out 			BIT_VECTOR(2 downto 0)
		);
    end component aludec;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The thirteenth activity was to add the aludec.vhd file to the DE10_LITE_riscvsingle project. To test it, the author had to replace the code from listing 8 with the code from listing 9, in the toplevel entity (DE10_LITE_riscvsingle.v). This code, written in Verilog, instantiates the aludec entity and decodes both the opb5, funct3, funct7b5 and ALUOp input data, as well as the ALUControl output data for the LEDs (LEDR[2:0]). The input data will be mapped to the SW keys, according to what follows.

```
| Signal      | Switch    | Display     |
|-------------|-----------|-------------|
| ALUOp       | SW[6:5]   |             |
| funct3      | SW[4:2]   |             |
| opb5        | SW[1]     |             |
| funct7b5    | SW[0]     |             |
| ALUControl  |           |  LEDR[2:0]  |
```

### Development 

'aludec.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". In this location, there is also a video demonstrating its behaviour. 
