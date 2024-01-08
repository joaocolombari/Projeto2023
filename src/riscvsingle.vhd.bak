--
-- A décima quinta atividade é incluir o arquivo riscvsingle.vhd ao projeto, defini-lo como toplevel, 
-- e realizar alterações na entidade riscvsingle de forma a:
--
-- i) parametrizá-la em função de RISCV_Data_Width (da mesma forma que foi feito com a entidade datapath);
-- 
-- ii) incluir a solicitação de uso do pacote riscv_pkg, tornando visível todas as declarações.
-- 
-- iii) acrescentar ao pacote riscv_pkg a declaração de componente para a entidade riscvsingle.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	30 de Novembro de 2023 
--

library work; 
use work.riscv_pkg.all;

entity riscvsingle is
	generic(
		Width : natural := 32
	);
	port(
		clk, reset: 		in 			BIT;
		PC: 				out 		BIT_VECTOR(Width - 1 downto 0);
		Instr: 				in 			BIT_VECTOR(Width - 1 downto 0);
		MemWrite: 			out 		BIT;
		ALUResult, WriteData: 
							out 		BIT_VECTOR(Width - 1 downto 0);
		ReadData: 			in 			BIT_VECTOR(Width - 1 downto 0)
	);
end riscvsingle;

architecture struct of riscvsingle is	
	signal ALUSrc, RegWrite, Jump, Zero, PCSrc: BIT;
	signal ResultSrc, ImmSrc: BIT_VECTOR(1 downto 0);
	signal ALUControl: BIT_VECTOR(2 downto 0);
begin
	c: controller 
		port map(
			op => Instr(6 downto 0), 
			funct3 => Instr(14 downto 12),
			funct7b5 => Instr(30), 
			Zero => Zero, 
			ResultSrc => ResultSrc, 
			MemWrite => MemWrite,
			PCSrc => PCSrc, 
			ALUSrc => ALUSrc, 
			RegWrite => RegWrite, 
			Jump => Jump,
			ImmSrc => ImmSrc, 
			ALUControl => ALUControl
		);
	dp: datapath 
		-- generic map (32)
		port map(
			clk => clk, 
			reset => reset, 
			ResultSrc => ResultSrc, 
			PCSrc => PCSrc, 
			ALUSrc => ALUSrc,
			RegWrite => RegWrite,
			ImmSrc => ImmSrc, 
			ALUControl => ALUControl, 
			Zero => Zero,
			PC => PC, 
			Instr => Instr, 
			ALUResult => ALUResult, 
			WriteData => WriteData,
			ReadData => ReadData
		);
end;