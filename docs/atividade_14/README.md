## Activity Statement 

The fourteenth activity was to add the controller.vhd file to the project, define it as toplevel, and make changes to the controller entity in order to:

i) include the request to use the riscv_pkg package, making all declarations visible.

ii) add the component declaration for the controller entity to the riscv_pkg package.

### Development 

The riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
	 -- Controller
	 component controller is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			op: 			in 		BIT_VECTOR(6 downto 0);
			funct3: 		in 		BIT_VECTOR(2 downto 0);
			funct7b5, Zero: 	in 	  	BIT;
			ResultSrc: 		out 		BIT_VECTOR(1 downto 0);
			MemWrite: 		out 		BIT;
			PCSrc, ALUSrc: 	  	out 		BIT;
			RegWrite: 		out 		BIT;
			Jump: 			buffer 		BIT;
			ImmSrc: 		out 		BIT_VECTOR(1 downto 0);
			ALUControl: 		out 		BIT_VECTOR(2 downto 0)
		);
	end component controller;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.
