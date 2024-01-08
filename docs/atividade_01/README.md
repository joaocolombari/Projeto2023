# First Part

## Activity Statement 

Here the author was suposed to create a project named "riscvsingle" in the Quartus tool (which would serve as the foundation to test all architecture functionalities), then include the file "mux2.vhd" in the project, define it as the top level, and make changes to the "mux2" entity to implement a 2-to-1 multiplexer using the "with-select" construction. The data bus should have been parameterized with a generic parameter named "Width."

### Development 

The library was made visible for the riscv_pkg, which will make sense later on. 

```
library work;
use work.riscv_pkg.all;
```

A generic parameter named "Width" was added to the entity declaration. This allows the user to specify the width of the data bus when instantiating the multiplexer.

```
generic(
    Width : natural := 32
);
```

The port declarations were updated to use the generic Width for specifying the bit-vector sizes, making the multiplexer width-agnostic.

```
port(
    d0, d1: in     BIT_VECTOR(Width - 1 downto 0);
    s:      in     BIT;
    y:      out    BIT_VECTOR(Width - 1 downto 0)
);
```

The architecture was completely made. The with-select statement was added to use d0 when the select signal s was '0', and d1 when it was '1', accommodating the generic width.

```
architecture behave of mux2 is
begin
	with s select y <= 
			d0 when '0',
        	d1 when '1';
end;
```

The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file.

# Second Part

## Activity Statement 

The first task was to include the `mux2.vhd` file in the `DE10_LITE_riscvsingle` project. To test it, the author had to add the code from Listing 1 to the `toplevel` entity (`DE10_LITE_riscvsingle.v`). This Verilog code instantiates the `mux2` entity and decodes both the input data `d0`, `d1`, and `s`, as well as the output data `y`, for the 7-segment displays. The input data was mapped to the switches `SW` and `KEY` based on what follows.

<b> Important observation: </b> All the referenced ".v" files are available in "DE10_LITE/top_level_arquivos" named after its corresponding activity. "Listing 1" refers to a series of Verilog codes present on the project statement (/docs/Projeto SEL5752 - 2023 - Adendo.pdf).

```
| Sinal | Chave    | Display |
|-------|----------|---------|
| d1    | SW[7:4]  | HEX4    |
| d0    | SW[3:0]  | HEX3    |
| s     | KEY[0]   | HEX1    |
| y     | -        | HEX0    |
```

### Development 

After the DE10_LITE_riscvsingle project was created, both `mux2.vhd` and `DE10_LITE_riscvsingle.v` were added. The second was made 'top level' and the FPGA was loaded. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file inside of "/adendo". The video demonstrating its behaviour is available [here].

<!-- REFERENCES -->

[here]: https://drive.google.com/file/d/1cmBYGEAHN1HrErdjnMenWXZzEFrees5T/view?usp=share_link
