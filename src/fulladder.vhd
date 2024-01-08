--
-- Implementar a instrução MUL, fazendo uso da resolução expandida do exercício 7.6.6.
-- Apresentar código com comentários e simulação da instrução.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	30 de Novembro de 2023 
--

library work; 
use work.riscv_pkg.all;
 
entity fulladder is

    port( 
        a,b :           in          BIT;
        cin :           in          BIT;
        y :             out         BIT;
        cout :          out         BIT
    );
end fulladder;
 
architecture behave of fulladder is
begin
    y <= a XOR b XOR cin;
    cout <= (a AND b) OR (cin AND a) OR (cin AND b);
end;