--
-- A décima quarta atividade é incluir o arquivo controller.vhd ao projeto, defini-lo como toplevel, 
-- e realizar alterações na entidade controller de forma a:

-- i) incluir a solicitação de uso do pacote riscv_pkg, tornando visível todas as declarações.

-- ii) acrescentar ao pacote riscv_pkg a declaração de componente para a entidade controller.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	30 de Novembro de 2023 
--

-- Rodar com --std=08!!

library work;
use work.riscv_pkg.all;

entity controller is
	port(
		op: 			in 			BIT_VECTOR(6 downto 0);
		funct3: 		in 			BIT_VECTOR(2 downto 0);
		funct7b5, Zero: in 			BIT;
		ResultSrc: 		out 		BIT_VECTOR(1 downto 0);
		MemWrite: 		out 		BIT;
		PCSrc, ALUSrc: 	out 		BIT;
		RegWrite: 		out 		BIT;
		Jump: 			buffer 		BIT;
		ImmSrc: 		out 		BIT_VECTOR(1 downto 0);
		ALUControl: 	out 		BIT_VECTOR(2 downto 0)
	);
end controller;

architecture struct of controller is
	
	signal ALUOp: BIT_VECTOR(1 downto 0);
	signal Branch: BIT;
begin
	md: maindec 
	port map(
		op => op, 
		ResultSrc => ResultSrc, 
		MemWrite => MemWrite, 
		Branch => Branch,
		ALUSrc => ALUSrc, 
		RegWrite => RegWrite, 
		Jump => Jump, 
		ImmSrc => ImmSrc, 
		ALUOp => ALUOp
	);
	ad: aludec 
	port map(
		opb5 => op(5), 
		funct3 => funct3, 
		funct7b5 => funct7b5, 
		ALUOp => ALUOp, 
		ALUControl => ALUControl
	);
	PCSrc <= (Branch and Zero) or Jump;
end;