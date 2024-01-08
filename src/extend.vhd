---- 
---- Atividade 5 - A segunda atividade é incluir o arquivo extend.vhd 
---- ao projeto, defini-lo como toplevel, e realizar alterações na 
---- entidade extend de forma a substituir os campos da instrução 
---- (signal) instr por alias, baseado na tabela 6.
----
---- Tabela 6 - Composição dos valores imediatos das instruções, de acordo com ImmSrc
---- ImmSrc		ImmExt																		Type				Description
---- 00			{{20{Instr[31]}}, Instr[31:20]}											I					12-bit signed immediate
---- 01			{{20{Instr[31]}}, Instr[31:25], Instr[11:7]}							S					12-bit signed immediate
---- 10			{{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}	B					13-bit signed immediate
---- 11			{{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}	J					21-bit signed immediate
----
---- Fonte: Digital Design and Computer Architecture - RISC-V Edition https://doi.org/10.1016/C2019-0-00213-0
----
----
----	Joao Victor Colombari Carlet - nro USP 5274502
----	
----	6 de Novembro de 2023 
----
--

library work;
use work.riscv_pkg.all;

entity extend is
    generic (
        WIDTH : natural := 32
    );

    port (
        instr:  in  BIT_VECTOR(WIDTH-1 downto 7);
        immsrc: in  BIT_VECTOR(1 downto 0);
        immext: out BIT_VECTOR(WIDTH-1 downto 0)
    );
end entity extend;

architecture behave of extend is

    signal instruction_signal : BIT_VECTOR(WIDTH - 1 downto 0);

    alias instruction : BIT_VECTOR(WIDTH - 1 downto 0) is instruction_signal;

begin
    process(instr, immsrc) begin
        case immsrc is
            -- I-type
            when "00" =>
                instruction_signal <= (WIDTH-1 downto 12 => instr(31)) & instr(31 downto 20);

            -- S-types (stores)
            when "01" =>
                instruction_signal <= (WIDTH-1 downto 12 => instr(31)) & instr(31 downto 25) & instr(11 downto 7);

            -- B-type (branches)
            when "10" =>
                instruction_signal <= (WIDTH-1 downto 12 => instr(31)) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';

            -- J-type (jal)
            when "11" =>
                instruction_signal <= (WIDTH-1 downto 20 => instr(31)) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0';

            when others => 
                instruction_signal <= (others => '0');
        end case;
    end process;

    immext <= instruction;

end behave;
