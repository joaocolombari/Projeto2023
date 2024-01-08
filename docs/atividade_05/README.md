# Activity Statement 

The fifth task is to include the extend.vhd file in the project, define it as the top level, and make changes to the extend entity to replace the fields of the instruction (signal instr) with aliases, based on the following table (table 6 in the project statement document, available in "docs/ Projeto SEL5752 - 2023.pdf").

```
| ImmSrc | ImmExt                                                             | Type | Description                   |
|--------|--------------------------------------------------------------------|------|-------------------------------|
| 00     | {{20{Instr[31]}}, Instr[31:20]}                                    | I    | 12-bit signed immediate       |
| 01     | {{20{Instr[31]}}, Instr[31:25], Instr[11:7]}                       | S    | 12-bit signed immediate       |
| 10     | {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}       | B    | 13-bit signed immediate       |
| 11     | {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}     | J    | 21-bit signed immediate       |
```
**Source:** Digital Design and Computer Architecture - RISC-V Edition [https://doi.org/10.1016/C2019-0-00213-0](https://doi.org/10.1016/C2019-0-00213-0)

## Development 

The library was made visible for the riscv_pkg, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width.

This time, the architecture was aready done, remaining for the author the duty to add the alias intended to give the output "Immext" the right instruction. For that, a signal was created and its content referenced with an alias, as follows.

```
signal instruction_signal : BIT_VECTOR(WIDTH - 1 downto 0);

alias instruction : BIT_VECTOR(WIDTH - 1 downto 0) is instruction_signal;
```

Now, for each case of "immsrc" the signal is loaded with the instruction. In the end of the process, sensible to "instr" and "immsrc", the output is loaded with the signal alias, i.e., "instruction". The code works as before, but the instructions are now completely explicit, making the code more reliable. The continuous assignement of the architecture section of the modified version is the one that follows. 

```
begin
    process(instr, immsrc) begin
        case immsrc is
            -- I-type
            when "00" =>
                instruction_signal <= (WIDTH-1 downto 12 => instr(31)) & instr(31 downto 20);

            -- S-types (stores)
            when "01" =>
                instruction_signal <= (WIDTH-1 downto 12 => instr(31)) & instr(31 downto 25) & instr(11 downto 7);

            -- B-type (branches)
            when "10" =>
                instruction_signal <= (WIDTH-1 downto 12 => instr(31)) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';

            -- J-type (jal)
            when "11" =>
                instruction_signal <= (WIDTH-1 downto 20 => instr(31)) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0';

            when others => 
                instruction_signal <= (others => '0');
        end case;
    end process;

    immext <= instruction;

end behave;
```


The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.
