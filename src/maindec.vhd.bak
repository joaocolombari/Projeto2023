--
-- A décima segunda atividade é incluir o arquivo maindec.vhd ao projeto, defini-lo como toplevel, 
-- e acrescentar ao pacote riscv_pkg a declaração de componente para a entidade maindec.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	8 de Novembro de 2023 
--

library work;
use work.riscv_pkg.all;

entity maindec is
	port(
		op: 			in 			BIT_VECTOR(6 downto 0);
		ResultSrc: 		out 		BIT_VECTOR(1 downto 0);
		MemWrite: 		out 		BIT;
		Branch, ALUSrc: out 		BIT;
		RegWrite, Jump: out 		BIT;
		ImmSrc: 		out 		BIT_VECTOR(1 downto 0);
		ALUOp: 			out 		BIT_VECTOR(1 downto 0)
	);
end maindec;

architecture behave of maindec is
	signal controls: BIT_VECTOR(10 downto 0);
begin
	process(op) begin
		case op is
			when "0000011" => controls <= "10010010000"; -- lw
			when "0100011" => controls <= "00111000000"; -- sw
			when "0110011" => controls <= "10000000100"; -- R-type	("1--00000100")
			when "1100011" => controls <= "01000001010"; -- beq
			when "0010011" => controls <= "10010000100"; -- I-type ALU
			when "1101111" => controls <= "11100100001"; -- jal
			when others => controls <= "00000000000"; -- not valid	("-----------")
		end case;
	end process;
	
	(RegWrite, ImmSrc(1), ImmSrc(0), ALUSrc, MemWrite,
	ResultSrc(1), ResultSrc(0), Branch, ALUOp(1), ALUOp(0),
	Jump) <= controls;
end;