# First Part

## Activity Statement 

The fourth task was to include the flopenr.vhd file in the project, define it as the top level, and make changes to the flopenr entity to parameterize it based on Width, similar to what was done with the flopr entity. The project should implement a register of Width-1 bits with a positive clock transition, clock enable when the clock enable input is equal to '1', and asynchronous reset when the reset input is equal to '1'.

### Development 

The library was made visible for the riscv_pkg. 

```
library work;
use work.riscv_pkg.all;
```

The generic parameter named "Width" was added to the entity declaration.

```
generic(
    Width : natural := 32
);
```

The port declarations were updated to use the generic Width.

```
port(
    clk, reset, en:     in      BIT;
    d:                  in      BIT_VECTOR(Width - 1 downto 0);
    q:                  out     BIT_VECTOR(Width - 1 downto 0)
);
```

The architecture was completely made. The process was modified to implement a register with a positive clock transition, clock enable, and asynchronous reset when the reset input is equal to '1'.

```
process (clk,reset,en) is 
begin
    if clk = '1' then
        if reset = '1' then
            q <= (others => '0');           -- Asynchronous reset
        elsif en = '1' then 
            q <= d;                         -- Positive clock transition with clock enable
        end if;
    end if;
end process;
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The fourth task was to include the flopenr.vhd file in the DE10_LITE_riscvsingle project. To test it, you needed to replace the code from Listing 3 with the code from Listing 4 in the toplevel entity (DE10_LITE_riscvsingle.v). This Verilog code instantiated the flopenr entity and decoded both the input data clk, reset, a, and b, as well as the output data q, for the 7-segment displays. The input data was mapped to the switches SW and KEY based on:

```
| Sinal | Chave   | Display      |
|-------|---------|--------------|
| clk   | KEY[0]  | -            |
| reset | KEY[1]  | -            |
| en    | SW[9]   | -            |
| d     | SW[7:0] | HEX4, HEX3   |
| q     | -       | HEX1, HEX0   |
```

### Development 

'flopenr.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". The video demonstrating its behaviour is available [here].

<!-- REFERENCES -->

[here]: https://drive.google.com/file/d/16ac3UKfkrTwPLFVUZ4CXXbBd5GaGwvfr/view?usp=share_link
