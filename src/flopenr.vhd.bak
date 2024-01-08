-- 
-- Atividade 4 - A quarta atividade é incluir o arquivo flopenr.vhd 
-- ao projeto, defini-lo como toplevel, e realizar alterações na 
-- entidade flopenr de forma a parametrizá-la em função de Width 
-- (da mesma forma que foi feito com a entidade flopr). Este projeto 
-- deverá implementar um registrador de Width-1 bits, com transição 
-- positiva de clock, habilitador de clock em ‘1’ e reset assíncrono 
-- quando a entrada reset for igual a ‘1’.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	6 de Novembro de 2023 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopenr is

    generic(
        Width : natural := 32
    );

	port(
		clk, reset, en:     in      BIT;
		d:                  in      BIT_VECTOR(Width - 1 downto 0);
		q:                  out     BIT_VECTOR(Width - 1 downto 0)
	);
end flopenr;

architecture asynchronous of flopenr is
begin

    process (clk) is 
    begin
        if clk = '1' then
            if reset = '1' then
                q <= (others => '0');
            elsif en = '1' then 
                q <= d; 
            end if;
        end if;
    end process;

end architecture asynchronous;