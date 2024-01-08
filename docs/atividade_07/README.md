# Activity Statement 

The seventh activity involved incorporating the following functions into the riscv_pkg package:

i) A function named to_uinteger was added, that converts a bit_vector object to an unsigned integer.

ii) A function overloading the "+" operator, performing the addition of two bit_vector objects.

iii) Another function overloading the "-" operator, conducting the subtraction of two bit_vector objects by utilizing the previously overloaded "+" operator.

## Development 

Now the IEEE library had to be added in order to use the 'unsigned()' function:

```
library work; 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
```

In the package declaration, the functions were defined:

```
-- Declaracao das funcoes 
    -- i - to_uinteger 
    function to_uinteger(i0 : BIT_VECTOR) return natural;
    
    -- ii - +
    function "+" (left, right : BIT_VECTOR) return bit_vector;

    -- iii - -
    function "-" (left, right : BIT_VECTOR) return bit_vector;
```

The package body was now defined. It implements the functions as follows.

```
	 --------------------------------------
	 -- Corpo do pacote para a simulacao --
	 --------------------------------------

	 --------------------------------------
    -- i - function to_uinteger
    function to_uinteger(i0 : BIT_VECTOR) return natural is 

        variable result_integer : natural;

        begin 
            result_integer := to_integer(unsigned(to_stdlogicvector(i0)));
        return result_integer;
    end to_uinteger; 
	 --------------------------------------

	 --------------------------------------
    -- ii - function "+"
	 function "+"(left, right: bit_vector) return bit_vector is
        variable result: 	bit_vector(left'range);
        variable carry: 	bit := '0';
    begin
		  for i in 0 to (result'length - 1) loop
            result(i) := left(i) xor right(i) xor carry;
            carry := (left(i) and right(i)) or (left(i) and carry) or (right(i) and carry);
        end loop;

        return result;
    end "+";
	 --------------------------------------

	 --------------------------------------
    -- iii - funcion "-" por complemento de 2 usando "+" 
		function "-" (left, right: bit_vector) return bit_vector is
			 variable sub: bit_vector(left'range);
			 variable complemento: bit_vector(left'range) := (others => '0');
		begin
			 complemento(0) := '1';
			 
			 sub := left + (not right) + complemento;
			 
			 return sub;
		end function "-";

	 --------------------------------------
```

A version of this file can be found in this directory and it refers to the work done up to this point.

The compilation results available in the "error_log.txt" file show the error of having no entity declared, which was expected. The GHDL outputs are shown in the "error_log._ghdl.png" file.
