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

entity top is

	generic(
        Width : natural := 32
    );
	 
	port(
		clk, reset: 			in 			BIT;
		WriteData, DataAdr: 	buffer 		BIT_VECTOR(Width - 1 downto 0);
		MemWrite: 				buffer 		BIT
	);
	
end;

architecture test of top is
	
	signal PC, Instr, ReadData: 			BIT_VECTOR(Width - 1 downto 0);
begin

	-- instantiate processor and memories
	
	rvsingle: riscvsingle	generic map (Width) port map( clk, reset, PC, Instr,
									MemWrite, DataAdr,
									WriteData, ReadData);
	imem1: imem 				generic map (Width) port map(PC, Instr);
	dmem1: dmem 				generic map (Width) port map(clk, MemWrite, DataAdr, WriteData,
	ReadData);
end;