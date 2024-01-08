--
-- A décima terceira atividade é incluir o arquivo aludec.vhd ao projeto, defini-lo como toplevel, 
-- e acrescentar ao pacote riscv_pkg a declaração de componente para a entidade aludec.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	30 de Novembro de 2023 
--

library work;
use work.riscv_pkg.all;

entity aludec is
	port(
		opb5: 			in 			BIT;
		funct3: 		in 			BIT_VECTOR(2 downto 0);
		funct7b5: 		in 			BIT;
		ALUOp: 			in 			BIT_VECTOR(1 downto 0);
		ALUControl: 	out 		BIT_VECTOR(2 downto 0)
	);
end aludec;

architecture behave of aludec is
	signal RtypeSub: BIT;
begin
	RtypeSub <= funct7b5 and opb5; -- TRUE for R-type subtract
	process(opb5, funct3, funct7b5, ALUOp, RtypeSub) begin
		case ALUOp is
			when "00" => ALUControl <= "000"; -- addition
			when "01" => ALUControl <= "001"; -- subtraction
			when others => case funct3 is -- R-type or I-type ALU
				when "000" => if RtypeSub = '1' then
									ALUControl <= "001"; -- sub
								else
									ALUControl <= "000"; -- add, addi
								end if;
				when "010" => ALUControl <= "101"; -- slt, slti
				when "110" => ALUControl <= "011"; -- or, ori
				when "111" => ALUControl <= "010"; -- and, andi
				when others => ALUControl <= "000"; -- unknown	("---")
			end case;
		end case;
	end process;
end;
