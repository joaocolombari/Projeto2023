# First Part

## Activity Statement 

The tenth activity was to include the adder.vhd file to the project, using the overloaded function of the “+” operator (using the riscv_pkg package), define it as toplevel, and make changes to the adder entity in order to parameterize it in function of Width, and include the component declaration in the package.

### Development 

The riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
	 -- Adder 
    component adder is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			a, b: 		in 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			y: 		out 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component adder;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The tenth activity was to add the adder.vhd file to the DE10_LITE_riscvsingle project. To test it, the author had to replace the code from listing 6 with the code from listing 7, in the toplevel entity (DE10_LITE_riscvsingle.v). This code, written in Verilog, instantiates the adder entity and decodes both the input data a and b, as well as the output data y, for the 7-segment displays. The input is mapped to the SW keys, in the following fashion.

```
| Signal | Switch   | Display |
|--------|----------|---------|
| a      | SW[9:5]  | HEX4    |
| b      | SW[4:0]  | HEX2    |
| y      | -        | HEX0    |
```

### Development 

'adder.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". The video demonstrating its behaviour is available [here].

<!-- REFERENCES -->

[here]: https://drive.google.com/file/d/1IweVlx_XAq7VoUTY9kMxSmc6kd2OOll9/view?usp=share_link
