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
		a, b: 			in 			BIT_VECTOR(Width - 1 downto 0);
		ALUControl: 	in 			BIT_VECTOR(2 downto 0);
		ALUResult: 		out 			BIT_VECTOR(Width - 1 downto 0);
		Overflow: 		out 			BIT;
		Zero: 			out 			BIT
	);
end alu;

architecture synth of alu is
	constant Result_Zero: 			BIT_VECTOR(Width - 1 downto 0) := (others => '0');
	constant Short_Zero: 			BIT_VECTOR(Width - 2 downto 0) := (others => '0');
	signal S, Bout, Carry: 			BIT_VECTOR(Width - 1 downto 0);
	signal ALUResultTmp_long: 		BIT_VECTOR(2 * Width - 1 downto 0) := Result_Zero & Result_Zero;

begin

	-- Adding the mul component instantiation
   multiply : mul generic map (Width) port map(a => a, b => b, y => ALUResultTmp_long);	


	Carry <= Short_Zero & ALUControl(2);
	Bout <= (not b) when (ALUControl(2) = '1') else b;
	S <= a + Bout + Carry;
	
	-- alu function
	process(all)
		variable ALUResultTmp: 			BIT_VECTOR(Width - 1 downto 0) := Result_Zero;
	begin
		case ALUControl(2 downto 0) is
			when "000" => ALUResultTmp := a + b;
			when "001" => ALUResultTmp := a - b;
			when "010" => ALUResultTmp := a and b;
			when "011" => ALUResultTmp := a or b;
			when "100" =>												-- Added the multiplication
					ALUResultTmp := ALUResultTmp_long(2 * Width - 1 downto Width);
			when "101" => ALUResultTmp := Short_Zero & S(Width - 1);
			when "110" =>												-- Which is redundant for all instructions
					ALUResultTmp := ALUResultTmp_long(2 * Width - 1 downto Width);
			when "111" => 												-- then only one operator is enouth
					ALUResultTmp := ALUResultTmp_long(2 * Width - 1 downto Width);
		end case;
		ALUResult <= ALUResultTmp;
		if ALUResultTmp = Result_Zero then 
			Zero <= '1';
		else 
			Zero <= '0';
		end if;
		--Zero <= '1' when (ALUResultTmp = Result_Zero) else '0';
	end process;
	-- overflow circuit
	process(all) begin
		case ALUControl(1 downto 0) is
			when "01" => Overflow <=
						(a(Width - 1) and b(Width - 1) and (not (S(Width - 1)))) or
						((not a(Width - 1)) and (not b(Width - 1)) and S(Width - 1));
			when "11" => Overflow <=
						((not a(Width - 1)) and b(Width - 1) and S(Width - 1)) or
						(a(Width - 1) and (not b(Width - 1)) and (not S(Width - 1)));
			when others => Overflow <= '0';
		end case;
	end process;
end;

-- Modifiquei o When pois ele funciona somente depois do 2008 e aqui no quartus sabe-se deus por que
-- mesmo mudando nao vira nada.

-- Modifiquei a linha 55 por que a coisa fica out of range (Result_Zero tem 32 bits e estava concatenando com mais um)