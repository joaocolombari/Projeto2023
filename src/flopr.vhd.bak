-- 
-- Atividade 3 - A terceira atividade é incluir o arquivo 
-- flopr.vhd ao projeto, defini-lo como toplevel, e realizar 
-- alterações na entidade flopr de forma a parametrizá-la em 
-- função de Width (da mesma forma que foi feito com a entidade mux3). 
-- Este projeto deverá implementar um registrador de Width-1 bits, 
-- com transição positiva de clock e reset assíncrono quando a entrada 
-- reset for igua a 1
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	6 de Novembro de 2023 
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr is

    generic(
        Width : natural := 32
    );

	port(
		clk, reset:     in      BIT;
		d:              in      BIT_VECTOR(Width - 1 downto 0);
		q:              out     BIT_VECTOR(Width - 1 downto 0)
	);
end flopr;

architecture asynchronous of flopr is
begin
    
    process (clk, reset)
    begin
        if reset = '1' then
            q <= (others => '0');                   -- Reset assincrono 
        elsif clk = '1' then                        -- Nao consigo rising_edge() por conta do tipo
            q <= d;
        end if;
    end process;
	
end asynchronous;