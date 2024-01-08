--
-- A décima primeira atividade é incluir o arquivo datapath.vhd ao projeto, defini-lo como 
-- toplevel, e realizar alterações na entidade datapath de forma a:
--
-- i) parametrizá-la em função de Width (da mesma forma que foi feito com a entidade flopr);
--
-- ii) incluir a solicitação de uso do pacote riscv_pkg, tornando visível todas as declarações;
--
-- iii) acrescentar ao pacote riscv_pkg a declaração de componente para a entidade datapath.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	8 de Novembro de 2023 
--

library work;
use work.riscv_pkg.all;

entity datapath is
	generic(
		Width : natural := 32
	);

	port(
		clk, reset: 	in 			BIT;
		ResultSrc: 		in 			BIT_VECTOR(1 downto 0);
		PCSrc, ALUSrc: 	in 			BIT;
		RegWrite: 		in 			BIT;
		ImmSrc: 		in 			BIT_VECTOR(1 downto 0);
		ALUControl: 	in 			BIT_VECTOR(2 downto 0);
		Zero: 			out 		BIT;
		PC: 			buffer 		BIT_VECTOR(Width - 1 downto 0);
		Instr: 			in 			BIT_VECTOR(Width - 1 downto 0);
		ALUResult, WriteData: 
						buffer 		BIT_VECTOR(Width - 1 downto 0);
		ReadData: 		in 			BIT_VECTOR(Width - 1 downto 0)
	);
end datapath;

architecture struct of datapath is	
	signal PCNext, PCPlus4, PCTarget: 
									BIT_VECTOR(Width - 1 downto 0);
	signal ImmExt: 					BIT_VECTOR(Width - 1 downto 0);
	signal SrcA, SrcB: 				BIT_VECTOR(Width - 1 downto 0);
	signal Result: 					BIT_VECTOR(Width - 1 downto 0);
begin
	-- next PC logic
	pcreg: flopr 
		-- generic map(32) 
		port map(
			clk => clk, 
			reset => reset, 
			d => PCNext, 
			q => PC
		);
	pcadd4: adder 
		-- generic map(32) 
		port map(
			a => PC, 
			b => X"00000004", 
			y => PCPlus4
		);
	pcaddbranch: adder 
		-- generic map(32) 
		port map(
			a => PC, 
			b => ImmExt, 
			y => PCTarget
		);
	pcmux: mux2 
		-- generic map(32) 
		port map(
			d0 => PCPlus4, 
			d1 => PCTarget, 
			s => PCSrc,
			y => PCNext
		);
	-- register file logic
	rf: regfile 
		-- generic map(32) 
		port map(
			clk => clk, 
			we3 => RegWrite, 
			a1 => Instr(19 downto 15),
			a2 => Instr(24 downto 20), 
			a3 => Instr(11 downto 7),
			wd3 => Result, 
			rd1 => SrcA, 
			rd2 => WriteData
		);
	ext: extend 
		-- generic map(32) 
		port map(
			instr => Instr(31 downto 7), 
			immsrc => ImmSrc, 
			immext => ImmExt
		);
	-- ALU logic
	srcbmux: mux2 
		-- generic map(32) 
		port map(
			d0 => WriteData, 
			d1 => ImmExt,
			s => ALUSrc, 
			y => SrcB
		);
	mainalu: alu 
		-- generic map(32) 
		port map(
			a => SrcA, 
			b => SrcB, 
			ALUControl => ALUControl, 
			ALUResult => ALUResult, 
			Zero => Zero
		);
	resultmux: mux3 
		-- generic map(32) 
		port map(
			d0 => ALUResult, 
			d1 => ReadData,
			d2 => PCPlus4, 
			s => ResultSrc,
			y => Result
		);
end;