-- 
--	Atividade 16 - Criar um projeto denominado riscvsingle, na ferramenta ModelSim 
-- (que servirá de base para simular todas as funcionalidades da arquitetura) e 
-- incluir todos os arquivos da pasta src e realize alterações nas entidades dmem, 
-- imem, top e testbench, de forma a:
--
-- i) incluir a solicitação de uso do pacote riscv_pkg, tornando visível todas as declarações;
--
-- ii) parametrizá-la em função de RISCV_Data_Width (da mesma forma que foi feito com a entidade riscvsingle);
--
-- iii) acrescentar ao pacote riscv_pkg a declaração de componente para as entidades top, imem e dmem.
-- 
-- iv) apresentar o resultado da simulação.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	12 de Dezembro de 2023 
--

library work;
use work.riscv_pkg.all;

entity testbench is

	generic(
        RISCV_Data_Width : natural := 32
    );
	 
end;

architecture test of testbench is
	component top
		port(clk, reset: 			in 	BIT;
			WriteData, DataAdr: 		out 	BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			MemWrite: 			out 	BIT);
	end component;
	
	signal WriteData, DataAdr: 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
	signal clk, reset, MemWrite: 			BIT;
begin
	-- instantiate device to be tested
	dut: top port map(clk, reset, WriteData, DataAdr, MemWrite);
	
	-- Generate clock with 10 ns period
	process begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;
	
	-- Generate reset for first two clock cycles
	process begin
		reset <= '1';
		wait for 22 ns;
		reset <= '0';
		wait;
	end process;
	
	-- check that 25 gets written to address 100 at end of program
	process(clk) begin
		if(clk'event and clk = '0' and MemWrite = '1') then
			if( to_uinteger(DataAdr) = 100 and
				to_uinteger(writedata) = 25) then
				report "NO ERRORS: Simulation succeeded" severity
				failure;
			elsif (to_uinteger(DataAdr) /= 96) then
				report "Simulation failed" severity failure;
			end if;
		end if;
	end process;
end;