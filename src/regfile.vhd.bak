--
-- A nona atividade é incluir o arquivo regfile.vhd ao projeto, defini-lo como toplevel, e realizar alterações 
-- na entidade regfile de forma a parametrizá-la em função de Width (da mesma forma que foi feito com a entidade 
-- flopr), fazendo uso do pacote riscv_pkg, e incluir sua declaração de componente no pacote.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	8 de Novembro de 2023 
--

library work; 
use work.riscv_pkg.all;

entity regfile is
	generic(
        Width : natural := 32
    );

	port(
		clk: 				in 			BIT;
		we3: 				in 			BIT;
		a1, a2, a3: 		in 			BIT_VECTOR(4 downto 0);
		wd3: 				in 			BIT_VECTOR(Width - 1 downto 0);
		rd1, rd2: 			out 		BIT_VECTOR(Width - 1 downto 0)
	);
end regfile;

architecture behave of regfile is
	type ramtype is array (Width - 1 downto 0) of BIT_VECTOR(Width - 1 downto 0);
	signal mem: ramtype;
begin
	-- three ported register file
	-- read two ports combinationally (A1/RD1, A2/RD2)
	-- write third port on rising edge of clock (A3/WD3/WE3)
	-- register 0 hardwired to 0
	process(clk) begin
		if (clk'event and clk='1') then
			if we3 = '1' then mem(to_uinteger(a3)) <= wd3;
			end if;
		end if;
	end process;
	process(a1, a2, mem) begin
		if (to_uinteger(a1) = 0) then rd1 <= (others => '0');
		else rd1 <= mem(to_uinteger(a1));
		end if;
		if (to_uinteger(a2) = 0) then rd2 <= (others => '0');
		else rd2 <= mem(to_uinteger(a2));
		end if;
	end process;
end;