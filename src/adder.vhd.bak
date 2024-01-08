--
-- A décima atividade é incluir o arquivo adder.vhd ao projeto, utilizando a função sobrecarregada do 
-- operador “+” (fazendo uso do pacote riscv_pkg), defini-lo como toplevel, e realizar alterações na 
-- entidade adder de forma a parametrizá-la em função de Width, e incluir sua declaração de componente
-- no pacote.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	8 de Novembro de 2023 
--

library work; 
use work.riscv_pkg.all;

entity adder is
	port(
		a, b: 			in 			BIT_VECTOR(31 downto 0);
		y: 				out 		BIT_VECTOR(31 downto 0)
	);
end adder;

architecture behave of adder is
begin
	y <= a + b;
end;