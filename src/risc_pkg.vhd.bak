-- 
-- Atividade 7 - A sétima atividade é incluir no pacote riscv_pkg (arquivo riscv_pkg), na pasta src, as seguintes funções:
-- 
-- i - uma função chamada to_uinteger, que converte um objeto do tipo bit_vector para integer sem sinal.
--
-- ii - criar uma função sobrecarregando o operador “+”, que realize a soma de dois objetos do tipo bit_vector.
--
-- iii - criar uma função sobrecarregando o operador “-”, que realize a subtração de dois objetos do tipo bit_vector, 
-- fazendo uso do operador sobrecarregado “+”.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	8 de Novembro de 2023 
--

library work; 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

package riscv_pkg is

    -- Definicao da constante global
    constant RISCV_Data_Width : natural := 32;

    -- Declaracao das funcoes 
    -- i - to_uinteger 
    function to_uinteger(i0 : BIT_VECTOR) return natural;
    
    -- ii - +
    function "+" (left, right : BIT_VECTOR) return bit_vector;

    -- iii - -
    function "-" (left, right : BIT_VECTOR) return bit_vector;

    -- Definicao de componentes 
    -- Componente Mux2
    component mux2 is
        port(
		d0, d1: in 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		s: 		in 		BIT;
		y: 		out 	BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	    );
    end component mux2;

    -- Componente Mux3 
    component mux3 is
        port(
		d0, d1, d2:     in      BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		s:              in      BIT_VECTOR(1 downto 0);
		y:              out     BIT_VECTOR(RISCV_Data_Width- 1 downto 0)
	    );
    end component mux3;

    -- Componente flopr
    component flopr is
        port(
		clk, reset:     in      BIT;
		d:              in      BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		q:              out     BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	    );
    end component flopr;

    -- Componente flopenr
    component flopenr is
        port(
		clk, reset, en:     in      BIT;
		d:                  in      BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		q:                  out     BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	    );
    end component flopenr;

    -- Componente extend
    component extend is
        port(
		instr:      in      BIT_VECTOR(31 downto 7);
		immsrc:     in      BIT_VECTOR(1 downto 0);
		immext:     out     BIT_VECTOR(31 downto 0)
	    );
    end component extend;

end package riscv_pkg;

package body riscv_pkg is  -- Corpo do pacote para a simulacao

    -- i - function to_uinteger

    function to_uinteger(i0 : BIT_VECTOR) return natural is 

        variable result_integer : natural;

        begin 
            result_integer := to_integer(unsigned(to_stdlogicvector(i0)));
        return result_integer;
    end to_uinteger; 

    -- ii - function "+"

    function "+"(left, right: bit_vector) return bit_vector is

        variable sum : bit_vector(left'length downto 0);

        begin
            sum := ('0' & left) + ('0' & right);
        return sum;
    end function "+";

    -- iii - funcion "-" por complemento de 2 usando "+" 

    function "-" (left, right: bit_vector) return bit_vector is

        variable sub : bit_vector(left'length - 1 downto 0);
    
        begin
            sub := (not right) + "1";          
        return  "+"(left , sub); 
    end function "-";

end package body riscv_pkg;