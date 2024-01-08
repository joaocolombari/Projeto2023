# First Part

## Activity Statement 

The third task was to include the flopr.vhd file in the project, define it as the top level, and make changes to the flopr entity to parameterize it based on Width, similar to what was done with the mux3 entity. The project should implement a register of Width-1 bits with a positive clock transition and asynchronous reset when the reset input is equal to '1'.

### Development 

The library was also made visible for the riscv_pkg. 

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
    clk, reset: in BIT;
    d: in BIT_VECTOR(Width - 1 downto 0);
    q: out BIT_VECTOR(Width - 1 downto 0)
);
```

The architecture was completely made. A process was made to implement a register with a positive clock transition and asynchronous reset when the reset input is equal to '1'. The register stores the input d when the clock signal is in a rising edge.

```
process (clk, reset)
begin
    if reset = '1' then
        q <= (others => '0');                   -- Asynchronous reset 
    elsif clk = '1' then                        -- Unable to use rising_edge() due to type
        q <= d;
    end if;
end process;
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The third task was to include the flopr.vhd file in the DE10_LITE_riscvsingle project. To test it, you needed to replace the code from Listing 2 with the code from Listing 3 in the toplevel entity (DE10_LITE_riscvsingle.v). This Verilog code instantiated the flopr entity and decoded both the input data clk, reset, a, and b, as well as the output data q, for the 7-segment displays. The input data was mapped to the switches SW and KEY based on:

```
| Sinal | Chave   | Display          |
|-------|---------|------------------|
| clk   | KEY[0]  | HEX5, HEX4, HEX3 |
| reset | KEY[1]  | -                |
| d     | SW[9:0] | -                |
| q     | -       | HEX2, HEX1, HEX0 |

```

### Development 

'flopr.vhd' was added to DE10_LITE_riscvsingle project, the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". The video demonstrating its behaviour is available [here].

<!-- REFERENCES -->

[here]: https://drive.google.com/file/d/1xRaFEMzjW-TQreRTovwdQJ3PleaLpuWR/view?usp=share_link
