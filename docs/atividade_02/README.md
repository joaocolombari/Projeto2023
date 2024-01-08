# First Part

## Activity Statement 

The second task was to include the mux3.vhd file in the project, define it as the top level, and make changes to the mux3 entity to implement a 3-to-1 multiplexer using the when-else construct. It should also be parameterized based on the Width.

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
    d0, d1, d2: in BIT_VECTOR(Width - 1 downto 0);
    s: in BIT_VECTOR(1 downto 0);
    y: out BIT_VECTOR(Width - 1 downto 0)
);
```

The architecture was completely made. The when-else construct was used to implement a 3-to-1 multiplexer based on the select signal s, and the result was assigned to the output y.

```
architecture behave of mux3 is
begin
y <= d0 when (s = "00") else
     d1 when (s = "01") else
     d2 when (s = "10") else
     (others => '0');
end;
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The second task was to include the mux3.vhd file in the DE10_LITE_riscvsingle project. To test it, the author needed to replace the code from Listing 1 with the code from Listing 4 in the toplevel entity (DE10_LITE_riscvsingle.v). This Verilog code instantiated the mux3 entity and decoded both the input data d0, d1, d2, and s, as well as the output data y, for the 7-segment displays. The input data was mapped to the switches SW and KEY based on:

```
| Sinal | Chave          | Display |
|-------|----------------|---------|
| d2    | SW[8:6]        | HEX5    |
| d1    | SW[5:3]        | HEX4    |
| d0    | SW[2:0]        | HEX3    |
| s     | KEY[1], KEY[0] | HEX1    |
| y     | -              | HEX0    |
```

### Development 

'mux3.vhd' was added to DE10_LITE_riscvsingle project and the `DE10_LITE_riscvsingle.v` file was changed acording to what was specified and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". The video demonstrating its behaviour is available [here].

<!-- REFERENCES -->

[here]: https://drive.google.com/file/d/1zwYamj4BpEGpH85ZSGDywBfu4TBZ7DKQ/view?usp=share_link
