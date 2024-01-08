-- 
--	Atividade 16 - Criar um projeto denominado riscvsingle, na ferramenta ModelSim 
-- (que servirá de base para simular todas as funcionalidades da arquitetura) e 
-- incluir todos os arquivos da pasta src e realize alterações nas entidades dmem, 
-- imem, top e testbench, de forma a:
--
-- i) incluir a solicitação de uso do pacote riscv_pkg, tornando visível todas as declarações;
--
-- ii) parametrizá-la em função de RISCV_Data_Width (da mesma forma que foi feito com a entidade riscvsingle);
--
-- iii) acrescentar ao pacote riscv_pkg a declaração de componente para as entidades top, imem e dmem.
-- 
-- iv) apresentar o resultado da simulação.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	12 de Dezembro de 2023 
--

library work;
use work.riscv_pkg.all;
use std.textio.all;

entity imem is

	generic(
        RISCV_Data_Width : natural := 32
    );
	 
	port(
		a: 				in 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		rd: 				out 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	);
	
end imem;

architecture behave of imem is
	type ramtype is array (63 downto 0) of BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
	-- initialize memory from file
	impure function init_ram_hex return ramtype is
		file text_file : text open read_mode is "C:\Users\eascarlet\Desktop\Projeto2023\src\riscvtest.txt";	--Alterar conforme sua estrutura de pastas--
		variable text_line : line;
		variable ram_content : ramtype;
		variable i : integer := 0;
		begin
		for i in 0 to 63 loop -- set all contents low
			ram_content(i) := (others => '0');
		end loop;
		while not endfile(text_file) loop -- set contents from file
			readline(text_file, text_line);
			hread(text_line, ram_content(i));		--******Compilar com VHDL-2008******--
			i := i + 1;
			exit when i=63;
		end loop;
		
		return ram_content;
	end function;
	
	signal mem : ramtype := init_ram_hex;
	begin
	-- read memory
	process(a) begin
		rd <= mem(to_uinteger(a(RISCV_Data_Width - 1 downto 2)));
	end process;
end;