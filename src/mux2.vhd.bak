-- 
--	Atividade 1 - implementar um multiplexador de 2 para 1, 
--	utilizando a construção with-select, e parametrizando o 
--	barramento de dados com um parâmetro genérico de nome Width.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	6 de Novembro de 2023 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is

	generic(
        Width : natural := 32
    );

	port(
		d0, d1: in 		BIT_VECTOR(Width - 1 downto 0);
		s: 		in 		BIT;
		y: 		out 	BIT_VECTOR(Width - 1 downto 0)
	);
end mux2;

architecture behave of mux2 is
begin
	with s select y <= 
			d0 when '0',
        	d1 when '1';
end;