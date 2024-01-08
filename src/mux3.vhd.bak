-- 
-- Atividade 2 - A segunda atividade é incluir o arquivo 
-- mux3.vhd ao projeto, defini-lo como toplevel, e realizar 
-- alterações na entidade mux3, de forma a implementar um 
-- multiplexador de 3 para 1, utilizando a construção when-else, 
-- e parametrizá-la em função de Width (da mesma forma que foi 
-- feito com a entidade mux2).
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	6 de Novembro de 2023 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3 is

    generic(
        Width : natural := 32
    );

	port(
		d0, d1, d2:     in      BIT_VECTOR(Width - 1 downto 0);
		s:              in      BIT_VECTOR(1 downto 0);
		y:              out     BIT_VECTOR(Width - 1 downto 0)
	);
end mux3;

architecture behave of mux3 is
begin
    y <= d0 when (s = "00") else
         d1 when (s = "01") else
         d2 when (s = "10") else
         (others => '0');
end;
