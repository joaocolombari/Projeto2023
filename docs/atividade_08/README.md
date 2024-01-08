# First Part

## Activity Statement 

The eighth activity involved the inclusion of the alu.vhd file, designated as the toplevel. Changes had to be made to the entity "alu" to:

i) Simplify line 28.

ii) Parameterize the data bus with a generic parameter named "Width."

iii) Include the component declaration in the riscv_pkg package.

iv) Assess the possibility of proposing an improved implementation based on Figure 3.

### Development 

The library was made visible for the riscv_pkg, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width.

The 28th line had nothing to be simplified, but the 31st had a 31 bit long stream of zeros, and removing the initial comment, the 31st became the 28th, so it was understood as the one to be simplified. The simplification was adding a constant vector of 31 bits zero, as follows.

```
constant Short_Zero: 			BIT_VECTOR(Width - 2 downto 0) := (others => '0');
```

The component declaration was added into the riscv_pkg and it is as follows. 

```
-----------------------------
   -- Alu
component alu is
generic(
  	Width : natural := RISCV_Data_Width
);
   	port(
		a, b:           	in          BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		ALUControl:     	in          BIT_VECTOR(2 downto 0);
		ALUResult:      	out         BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		Zero: 			out 	    BIT
);
end component alu;
-----------------------------
```

A modification had to be done in the 36th line in order to Quartus II compiler works. The when statement used does not work in the early version of VHDL. Nevertheless, modifying the version to 2008 made no difference, thus the line had to be modified with an if-else statement, as follows:

```
if ALUResultTmp = Result_Zero then 
			Zero <= '1';
		else 
			Zero <= '0';
end if;
```

The final modification was to uncomment the overflow section and fix its indexes with the defined Width generic. The result of this modification is the one that follows.

```
	process(all) begin
		case ALUControl(1 downto 0) is
			when "01" => Overflow <=
						(a(Width - 1) and b(Width - 1) and (not (S(Width - 1)))) or
						((not a(Width - 1)) and (not b(Width - 1)) and S(Width - 1));
			when "11" => Overflow <=
						((not a(Width - 1)) and b(Width - 1) and S(Width - 1)) or
						(a(Width - 1) and (not b(Width - 1)) and (not S(Width - 1)));
			when others => Overflow <= '0';
		end case;
	end process;
end;
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The eighth activity was to include the alu.vhd file to the DE10_LITE project. To test it, the author should have replaced the code in Listing 4 with the code in Listing 5 in the toplevel entity (DE10_LITE_riscvsingle.v). This Verilog code would instantiate the alu entity and decode the result for the 7-segment displays. The input data would be mapped to the SW switches according to the table that follows and will also be displayed on the 7-segment displays.

```
| Sinal        | Chave                | Display          |
|--------------|----------------------|------------------|
| a            | SW[7:4]              | HEX5             |
| b            | SW[3:0]              | HEX4             |
| ALUControl   | KEY[1], SW[9], SW[8] | HEX3, HEX2, HEX1 |
| ALUResult    | -                    | HEX0             |
| Zero         | -                    | HEX0[7]          |
```

### Development 

'alu.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". In this location, there is also a video demonstrating its behaviour. 
