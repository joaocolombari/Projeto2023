## Activity Statement 

The eleventh activity was to add the datapath.vhd file to the project, define it as toplevel, and make changes to the datapath entity in order to:
i) parameterize it based on Width (in the same way as was done with the flopr entity); 
ii) include the request to use the riscv_pkg package, making all declarations visible; 
iii) add the component declaration for the datapath entity to the riscv_pkg package.

### Development 

The riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
	 -- Datapath
	 component datapath is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			clk, reset: 			in 			BIT;
			ResultSrc: 			in 			BIT_VECTOR(1 downto 0);
			PCSrc, ALUSrc: 			in 			BIT;
			RegWrite: 			in 			BIT;
			ImmSrc: 			in 			BIT_VECTOR(1 downto 0);
			ALUControl: 			in 			BIT_VECTOR(2 downto 0);
			Zero: 				out 			BIT;
			PC: 				buffer 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			Instr: 				in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			ALUResult, WriteData: 
							buffer 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			ReadData: 			in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component datapath;
-----------------------------
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.
