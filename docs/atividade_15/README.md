## Activity Statement 

The fifteenth activity was to add the riscvsingle.vhd file to the project, define it as toplevel, and make changes to the riscvsingle entity in order to:

i) parameterize it based on Width (in the same way as was done with the datapath entity); 

ii) include the request to use the riscv_pkg package, making all declarations visible;

iii) add the component declaration for the riscvsingle entity to the riscv_pkg package.

### Development 

The riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
	-- Riscvsingle
	component riscvsingle is
		generic(
			Width : natural := RISCV_Data_Width
		);
	port(
		clk, reset: 			in 		BIT;
		PC: 			   	out 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		Instr: 				in 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		MemWrite: 			out 		BIT;
		ALUResult, WriteData: 		out 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		ReadData: 			in 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	);
	end component riscvsingle;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.
