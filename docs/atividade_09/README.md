# First Part

## Activity Statement 

The ninth activity was to include the regfile.vhd file in the project, define it as toplevel, and make changes to the regfile entity in order to parameterize it based on Width (in the same way as was done with the flopr entity), making use of from the riscv_pkg package, and include your component declaration in the package.

### Development 

The library was made visible for the riscv_pkg, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width.

The component declaration was added into the riscv_pkg and it is as follows. 

```
 -----------------------------
	 -- Regfile
    component regfile is 
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			clk: 			in 		BIT;
			we3: 			in 		BIT;
			a1, a2, a3: 		in 		BIT_VECTOR(4 downto 0);
			wd3: 			in 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			rd1, rd2: 		out 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component regfile;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The ninth activity was to add the regfile.vhd file to the DE10_LITE_riscvsingle project. To test it, the author had to replace the code from listing 5 with the code from listing 6, in the toplevel entity (DE10_LITE_riscvsingle.v). This code, written in Verilog, will instantiate the regfile entity and decode both the input data wd3, which will be written to the register bank, at the address indicated by a3, and the output data rd1 and rd2, addressed by a1 and a2 , on 7-segment displays. The input data will be mapped into the SW and KEY keys, according to:.

```
| Signal   | Switch   | Display |
|----------|----------|---------|
| clk      | KEY[0]   | HEX5[7] |
| we3      | KEY[1]   | HEX4[7] |
| a3       | SW[5:4]  | HEX5    |
| a2       | SW[3:2]  | HEX3    |
| a1       | SW[1:0]  | HEX1    |
| wd3      | SW[9:6]  | HEX4    |
| rd2      | -        | HEX2    |
| rd1      | -        | HEX0    |
```

### Development 

'regfile.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". The video demonstrating its behaviour is available [here].

<!-- REFERENCES -->

[here]: https://drive.google.com/file/d/1mDCGlVONKCic8_DCeyc_gyx0y7_BBRXv/view?usp=share_link
