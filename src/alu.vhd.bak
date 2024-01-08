-- A oitava atividade é incluir o arquivo alu.vhd, que deverá ser definido como toplevel. Realize alterações na entidade alu de forma a:
--
-- i) simplificar a linha 28;
--
-- ii) parametrizar o barramento de dados com um parâmetro genérico de nome Width;
--
-- iii) incluir sua declaração de componente no pacote riscv_pkg;
--
-- iv) indicar se é possível propor uma melhor implementação, baseado na figura 3.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	8 de Novembro de 2023 
--

library work; 
use work.riscv_pkg.all;

entity alu is
	generic(
        Width : natural := 32
    );

	port(
		a, b: 			in 			BIT_VECTOR(Width downto 0);
		ALUControl: 	in 			BIT_VECTOR(2 downto 0);
		ALUResult: 		out 		BIT_VECTOR(Width downto 0);
		Overflow: 		out 		BIT;
		Zero: 			out 		BIT
	);
end alu;

architecture synth of alu is
	constant Result_Zero: 			BIT_VECTOR(31 downto 0) := (others => '0');
	signal S, Bout, Carry: 			BIT_VECTOR(31 downto 0);

begin
	Carry <= Result_Zero & ALUControl(2);
	Bout <= (not b) when (ALUControl(2) = '1') else b;
	S <= a + Bout + Carry;

	-- alu function
	process(a, b, ALUControl, S)
		variable ALUResultTmp: BIT_VECTOR(31 downto 0) := Result_Zero;
	begin
		case ALUControl(2 downto 0) is
			when "000" => ALUResultTmp := a + b;
			when "001" => ALUResultTmp := a - b;
			when "010" => ALUResultTmp := a and b;
			when "011" => ALUResultTmp := a or b;
			when "101" => ALUResultTmp := Result_Zero & S(31);

			when others => ALUResultTmp := Result_Zero;
		end case;
		ALUResult <= ALUResultTmp;
		Zero <= '1' when (ALUResultTmp = Result_Zero) else '0';
	end process;
	-- overflow circuit
	process(all) begin
		case ALUControl(2 downto 1) is
			when "01" => Overflow <=
						(a(31) and b(31) and (not (S(31)))) or
						((not a(31)) and (not b(31)) and S(31));
			when "11" => Overflow <=
						((not a(31)) and b(31) and S(31)) or
						(a(31) and (not b(31)) and (not S(31)));
			when others => Overflow <= '0';
		end case;
	end process;
end;