--
-- A décima quinta atividade é incluir o arquivo riscvsingle.vhd ao projeto, defini-lo como toplevel, 
-- e realizar alterações na entidade riscvsingle de forma a:
--
-- i) parametrizá-la em função de RISCV_Data_Width (da mesma forma que foi feito com a entidade datapath);
-- 
-- ii) incluir a solicitação de uso do pacote riscv_pkg, tornando visível todas as declarações.
-- 
-- iii) acrescentar ao pacote riscv_pkg a declaração de componente para a entidade riscvsingle.
--
--	Joao Victor Colombari Carlet - nro USP 5274502
--	
--	30 de Novembro de 2023 
--

library work; 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

package riscv_pkg is

    -- Definicao da constante global
    constant RISCV_Data_Width : natural := 32;

    -- Declaracao das funcoes 
    -- i - to_uinteger 
    function to_uinteger(i0 : BIT_VECTOR) return natural;
    
    -- ii - +
    function "+" (left, right : BIT_VECTOR) return bit_vector;

    -- iii - -
    function "-" (left, right : BIT_VECTOR) return bit_vector;
	 
	 -- Funcao absoluto para fazer o mul funcionar 
	 function absolute(i0 : BIT_VECTOR) return bit_vector;

	 -----------------------------
    -- Definicao de componentes-- 
	 -----------------------------
	 
	 -----------------------------
    -- Mux2
    component mux2 is
		generic(
			Width : natural := RISCV_Data_Width
		);
      port(
			d0, d1:         	in 		    BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			s: 		        	in 		    BIT;
			y: 		        	out	 	    BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component mux2;
	 -----------------------------
	
	 -----------------------------
    -- Mux3 
    component mux3 is
		generic(
			Width : natural := RISCV_Data_Width
		);
        port(
		d0, d1, d2:     		in          BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		s:              		in          BIT_VECTOR(1 downto 0);
		y:              		out         BIT_VECTOR(RISCV_Data_Width- 1 downto 0)
	    );
    end component mux3;
	 -----------------------------

	 -----------------------------
    -- Flopr
    component flopr is
		generic(
			Width : natural := RISCV_Data_Width
		);
      port(
			clk, reset:     	in          BIT;
			d:              	in          BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			q:              	out         BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	   );
    end component flopr;
	 -----------------------------

	 -----------------------------
    -- Flopenr
    component flopenr is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			clk, reset, en: 	in          BIT;
			d:              	in          BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			q:              	out         BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	    );
    end component flopenr;
	 -----------------------------

	 -----------------------------
    -- Extend
    component extend is
		generic(
			Width : natural := RISCV_Data_Width
		);
      port(
			instr:          	in          BIT_VECTOR(31 downto 7);
			immsrc:         	in          BIT_VECTOR(1 downto 0);
			immext:         	out         BIT_VECTOR(31 downto 0)
	    );
    end component extend;
	 -----------------------------

	 -----------------------------
    -- Alu
    component alu is
		generic(
			Width : natural := RISCV_Data_Width
		);
    	port(
			a, b:           	in          BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			ALUControl:     	in          BIT_VECTOR(2 downto 0);
			ALUResult:      	out         BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			Zero: 				out 			BIT
		);
    end component alu;
	 -----------------------------

	 -----------------------------
	 -- Regfile
    component regfile is 
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			clk: 					in 			BIT;
			we3: 					in 			BIT;
			a1, a2, a3: 		in 			BIT_VECTOR(4 downto 0);
			wd3: 					in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			rd1, rd2: 			out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component regfile;
	 -----------------------------

	 -----------------------------
	 -- Adder 
    component adder is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			a, b: 				in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			y: 					out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component adder;
	 -----------------------------
	 
	 -----------------------------
	 -- Datapath
	 component datapath is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			clk, reset: 		in 			BIT;
			ResultSrc: 			in 			BIT_VECTOR(1 downto 0);
			PCSrc, ALUSrc: 	in 			BIT;
			RegWrite: 			in 			BIT;
			ImmSrc: 				in 			BIT_VECTOR(1 downto 0);
			ALUControl: 		in 			BIT_VECTOR(2 downto 0);
			Zero: 				out 			BIT;
			PC: 					buffer 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			Instr: 				in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			ALUResult, WriteData: 
									buffer 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			ReadData: 			in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
    end component datapath;
	 -----------------------------
	 
	 -----------------------------
	 -- Maindec
	 component maindec is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			op: 					in 			BIT_VECTOR(6 downto 0);
			ResultSrc: 			out 			BIT_VECTOR(1 downto 0);
			MemWrite: 			out 			BIT;
			Branch, ALUSrc: 	out 			BIT;
			RegWrite, Jump: 	out 			BIT;
			ImmSrc: 				out 			BIT_VECTOR(1 downto 0);
			ALUOp: 				out 			BIT_VECTOR(1 downto 0)
		);
    end component maindec;
	 -----------------------------
	 
	 -----------------------------
	 -- Aludec
	 component aludec is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			opb5: 				in 			BIT;
			funct3: 				in 			BIT_VECTOR(2 downto 0);
			funct7: 				in 			BIT_VECTOR(6 downto 0);
			ALUOp: 				in 			BIT_VECTOR(1 downto 0);
			ALUControl: 		out 			BIT_VECTOR(2 downto 0)
		);
    end component aludec;
	 -----------------------------
	 
	 -----------------------------
	 -- Controller
	 component controller is
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			op: 					in 			BIT_VECTOR(6 downto 0);
			funct3: 				in 			BIT_VECTOR(2 downto 0);
			funct7: 				in 			BIT_VECTOR(6 downto 0);
			Zero: 				in 			BIT;
			ResultSrc: 			out 			BIT_VECTOR(1 downto 0);
			MemWrite: 			out 			BIT;
			PCSrc, ALUSrc: 	out 			BIT;
			RegWrite: 			out 			BIT;
			Jump: 				buffer 		BIT;
			ImmSrc: 				out 			BIT_VECTOR(1 downto 0);
			ALUControl: 		out 			BIT_VECTOR(2 downto 0)
		);
	end component controller;
	-----------------------------
	
	-----------------------------
	-- Riscvsingle
	component riscvsingle is
		generic(
			Width : natural := RISCV_Data_Width
		);
	port(
		clk, reset: 			in 			BIT;
		PC: 						out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		Instr: 					in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		MemWrite: 				out 		 	BIT;
		ALUResult, WriteData: 
									out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
		ReadData: 				in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	);
	end component riscvsingle;
	-----------------------------
	
	-----------------------------
	-- Top
	component top is
		generic(
			RISCV_Data_Width : natural := 32
		);
		port(
			clk, reset: 		in 			BIT;
			WriteData, DataAdr: 	
									buffer 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			MemWrite: 			buffer 		BIT
		);
	end component top;
	-----------------------------
	
	-----------------------------
	-- Testbench
	component testbench is
		generic(
			RISCV_Data_Width : natural := 32
		);
	end component testbench;
	-----------------------------
	
	-----------------------------
	-- Imem
	component imem is
		generic(
			RISCV_Data_Width : natural := 32
		);
		port(
			a: 					in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			rd: 					out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
	);
	end component imem;
	-----------------------------
	
	-----------------------------
	-- Dmem
	component dmem is
		generic(
			RISCV_Data_Width : natural := 32
		);
		port(
			clk, we: 			in 			BIT;
			a, wd: 				in 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			rd: 					out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
		);
	end component dmem;
	-----------------------------
	
	-----------------------------
	-- FullAdder
	component fulladder is
	
		port( 
			a,b :           in          BIT;
			cin :           in          BIT;
			y :             out         BIT;
			cout :          out         BIT
		);
	end component fulladder;
	-----------------------------
	
	-----------------------------
	-- Mul
	component mul is 
		generic(
			Width : natural := RISCV_Data_Width
		);
		port(
			a, b:           in          BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
			y:              out         BIT_VECTOR(2 * RISCV_Data_Width - 1 downto 0)
		);
	end component mul;
	-----------------------------
	
	component mul_tb is
		generic(
			RISCV_Data_Width : natural := 32
		);
	end component mul_tb;

end package riscv_pkg;

package body riscv_pkg is  
	 --------------------------------------
	 -- Corpo do pacote para a simulacao --
	 --------------------------------------

	 --------------------------------------
    -- i - function to_uinteger
    function to_uinteger(i0 : BIT_VECTOR) return natural is 

        variable result_integer : natural;

        begin 
            result_integer := to_integer(unsigned(to_stdlogicvector(i0)));
        return result_integer;
    end to_uinteger; 
	 --------------------------------------

	 --------------------------------------
    -- ii - function "+"
	 function "+"(left, right: bit_vector) return bit_vector is
        variable result: 	bit_vector(left'range);
        variable carry: 	bit := '0';
    begin
		  for i in 0 to (result'length - 1) loop
            result(i) := left(i) xor right(i) xor carry;
            carry := (left(i) and right(i)) or (left(i) and carry) or (right(i) and carry);
        end loop;

        return result;
    end "+";
	 --------------------------------------

	 --------------------------------------
    -- iii - funcion "-" por complemento de 2 usando "+" 
		function "-" (left, right: bit_vector) return bit_vector is
			 variable sub: bit_vector(left'range);
			 variable complemento: bit_vector(left'range) := (others => '0');
		begin
			 complemento(0) := '1';
			 
			 sub := left + (not right) + complemento;
			 
			 return sub;
		end function "-";

	 --------------------------------------
	 
	 --------------------------------------
    -- function abolute
    function absolute(i0 : BIT_VECTOR) return bit_vector is 

        variable temp : bit_vector(i0'range);
		  variable one  : bit_vector(i0'range) := (others => '0');

        begin 
		  
				one(0) := '1';
				
				if i0(i0'left) = '1' then 
					 temp := (not i0) + one;
				else 
					 temp := i0;
				end if;
				
				return temp;
				
    end function absolute; 
	 --------------------------------------

end package body riscv_pkg;