--
-- Implementar a instrução MUL, fazendo uso da resolução expandida do exercício 7.6.6.
-- Apresentar código com comentários e simulação da instrução.
--
-- Este programa resolve o exercicio 7.6.6
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	18 de Dezembro de 2023 
--

library work; 
use work.riscv_pkg.all;

entity mul is 
    generic(
        Width : natural := 32
    );

    port(
        a, b:           in          BIT_VECTOR(Width - 1 downto 0);
        y:              out         BIT_VECTOR(2 * Width - 1 downto 0)
    );
end mul;

architecture multiplication of mul is   

    -- Vou definir um tipo para criar matrizes para armazenar os resultados das operacoes
    -- AND, os carrys e as saidas 
    type matrix is array (natural range <>, natural range <>) of bit;

    -- Constants m e n 
    constant m: integer := a'length;
    constant n: integer := b'length;

    -- Mi,j
    signal AND_ARRAY:               matrix(0 to m-1, 0 to m+n-1);
    -- Ci,j
    signal CARRY_ARRAY:             matrix(0 to m-1, 0 to m+n);
    -- Pi,j
    signal OUTPUTS_ARRAY:           matrix(0 to m, 0 to m+n);
    -- Expandindo o vetor b
    signal blinha:                  bit_vector(m+n-1 downto 0);
	 
	 signal signal_a: 					bit_vector(Width - 1 downto 0);	
	 signal signal_b: 					bit_vector(Width - 1 downto 0);	

begin
	 
	 process(a,b)
	 	 variable temp: 	bit_vector(Width - 1 downto 0);
	 begin 
	 
		 signal_a <= a;
       signal_b <= b;
		 
		 if (a(Width - 1) = '1' and b(Width - 1) = '0') then 
			 temp := a;
			 signal_a <= b;
			 signal_b <= temp;
		 elsif (a(Width - 1) = '1' and b(Width - 1) = '1') then 
			 signal_a <= absolute(a);
			 signal_b <= absolute(b);
		 else 
			 signal_a <= a;
			 signal_b <= b;
		 end if;
	 end process;
	 
	 -- Inicializando o vetor b expandido com o bit mais significativo de b 
    -- para realizar a multiplicação em complemento de dois
    blinha <= (m+n-1 downto n => (signal_b(signal_b'left))) & signal_b; 
	 
	 
--    -- Inicializando a matriz AND_ARRAY
--    init_AND_ARRAY: for i in 0 to m generate 
--        AND_ARRAY(i,0) <= '0';
--    end generate init_AND_ARRAY;

    -- Inicializando a matriz CARRY_ARRAY
	 -- A primeira linha tem que ser carregada com o sinal 
    init_CARRY_ARRAY: for i in 0 to m-1 generate 
        CARRY_ARRAY(i,0) <= '0';
    end generate init_CARRY_ARRAY;

    -- Inicializando a matriz OUTPUTS_ARRAY
    init_OUTPUTS_ARRAY_coluna: for i in 0 to m generate
		  OUTPUTS_ARRAY(i,0) <= '0';
    end generate init_OUTPUTS_ARRAY_coluna;
	 
	 init_OUTPUTS_ARRAY_linha: for j in 1 to m+n-1 generate 
	     OUTPUTS_ARRAY(m,j) <= '0';
	 end generate init_OUTPUTS_ARRAY_linha;

    -- Carregando a matriz AND_ARRAY com os resultados das portas and
    AND_ARRAY_coluna: for i in m-1 downto 0 generate 
        AND_ARRAY_linha: for j in m+n-1 downto 0 generate 
            AND_ARRAY(i,j) <= signal_a(i) and blinha(j);
        end generate AND_ARRAY_linha;
    end generate AND_ARRAY_coluna;

    -- Interligando os componentes 
    OUTPUTS_ARRAY_coluna: for i in 0 to m-1 generate 
        OUTPUTS_ARRAY_linha: for j in 0 to m+n-1 generate
            adder_x : fulladder port map (
						a => OUTPUTS_ARRAY(i+1,j), 
						b => AND_ARRAY(i,j), 
						cin => CARRY_ARRAY(i,j), 
                  y => OUTPUTS_ARRAY(i,j+1), 
						cout => CARRY_ARRAY(i,j+1)
				);
        end generate OUTPUTS_ARRAY_linha;
    end generate OUTPUTS_ARRAY_coluna;
	 
    -- Ligando as saidas 
    gen_y: for i in m+n-1 downto 0 generate 
        y(i) <= OUTPUTS_ARRAY(0,i+1);
    end generate gen_y;

end multiplication;