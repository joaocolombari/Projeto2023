# Activity Statement 

The sixth task involved creating a package named riscv_pkg in the src directory. The task required including component declarations for the entities mux2, mux3, flopr, flopenr, and extend, taking into account implementations with generics. Additionally, a global constant named RISCV_Data_Width should have been defined within the same package, with a value set to 32.

## Development 

The package was made visible for the work library. A constant named RISCV_Data_Width was introduced with a default value of 32 as follows.

```
constant RISCV_Data_Width : natural := 32;
```

Both package and package body had to be entirely made. In the package, besides the constant, the components had to be instanciated. It was done in the following fashion, which shows mux2. The other four components follow the same structure. 

```
	 -----------------------------
    -- Definicao de componentes-- 
	 -----------------------------
	 
	 -----------------------------
    -- Mux2
    component mux2 is
		generic(
			Width : natural := RISCV_Data_Width
		);
      port(
			d0, d1:        	in 		    BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			s: 		in 		    BIT;
			y: 		out	 	    BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component mux2;
	 -----------------------------
```

For the package body, nothing had to be done yet, since the functions were not yet declared. 

**Important:** It is important to note that the "riscv_pkg.vhd" the reader finds in "../src" is the final version of the file, containing therefore all the following components and functions, to be declared and referenced in the following reports. A version of this file can be found in this directory and it refers to the work done up to this point.

The compilation results available in the "error_log.txt" file show the error of having no entity declared, which was expected. To check the sintax, the Open Source VHDL simulator, GHDL, was used. It is a terminal application and can be built by downloading the immage from [1]. The "$ ghdl -s --std=08 *.vhd" checks the sintax of the "*.vhd" file using VHDL vesion 2008. If there is no error, the compiler returns nothing. The comand "-a" analyses the file. If there is no error, no message is shown. The GHDL outputs are shown in the "error_log._ghdl.png" file.

<!-- REFERENCIAS -->
[1]: https://github.com/ghdl/ghdl
