library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_vhdl_code is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        Cout : out STD_LOGIC;
        S    : out STD_LOGIC
    );
end full_adder_vhdl_code;

architecture gate_level of full_adder_vhdl_code is
begin
    S <= A XOR B XOR Cin;
    Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B);
end gate_level;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_vhdl_code is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cout : out STD_LOGIC;
        S    : out STD_LOGIC
    );
end half_adder_vhdl_code;

architecture gate_level of half_adder_vhdl_code is
begin
    S <= A XOR B;
    Cout <= A AND B;
end gate_level;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier is
    generic (
        Width : natural := 4
    );
    Port (
        A : in  STD_LOGIC_VECTOR (Width - 1 downto 0);
        B : in  STD_LOGIC_VECTOR (Width - 1 downto 0);
        S : out STD_LOGIC_VECTOR (2 * Width - 1 downto 0)
    );
end entity multiplier;

architecture Behavioral of multiplier is
    component full_adder_vhdl_code
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Cout : out STD_LOGIC;
            S    : out STD_LOGIC
        );
    end component;

    component half_adder_vhdl_code
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cout : out STD_LOGIC;
            S    : out STD_LOGIC
        );
    end component;

    type dataout is array (natural range <>) of std_logic_vector;
    signal AB : dataout(0 to 2 * Width - 1)( 0 to Width - 1);
    signal C  : dataout(0 to 2 * Width - 1)( 0 to Width - 1);
    signal P  : dataout(0 to 2 * Width - 1)( 0 to Width - 1);

begin
    -- Multiplier input
    generate_AB: for i in 0 to 2 * Width - 1 generate
        generate_AB_inner: for j in 0 to Width - 1 generate
            AB(i, j) <= A(j) and B(i);
        end generate generate_AB_inner;
    end generate generate_AB;

    -- Port Mapping Full Adders and Half Adders
    generate_FA: for i in 0 to 2 * Width - 1 generate
        generate_FA_inner: for j in 0 to Width - 1 generate
            generate_FA_if: if j = 0 generate
                FA: full_adder_vhdl_code port map (
                    A    => AB(i, j + 1),
                    B    => AB(i + 1, j),
                    Cin  => '0',
                    Cout => C(i + 1, j),
                    S    => P(i + 1, j)
                );
            else generate 
                FA: full_adder_vhdl_code port map (
                    A    => AB(i, j + 1),
                    B    => AB(i + 1, j - 1),
                    Cin  => C(i + 1, j),
                    Cout => C(i + 1, j),
                    S    => P(i + 1, j)
                );
            end generate generate_FA_if;
        end generate generate_FA_inner;
    end generate generate_FA;

        -- Additional Full Adder for the last element in each row
        generate_FA_last: for i in 0 to 2 * Width - 1 generate
            FA_last: full_adder_vhdl_code port map (
                A    => AB(i, Width - 1),
                B    => '0',
                Cin  => C(i, Width - 1),
                Cout => C(i + 1, Width - 1),
                S    => P(i + 1, Width - 1)
            );
        end generate generate_FA_last;


    -- Half Adders
    generate_HA: for i in 0 to 2 * Width - 1 generate
        generate_HA_if: if i mod 2 = 0 generate
            HA: half_adder_vhdl_code port map (
                A    => AB(i, 0),
                B    => AB(i + 1, 0),
                Cout => C(i + 1, 0),
                S    => P(i + 1, 0)
            );
        end generate generate_HA_if;
    end generate generate_HA;

    -- Multiplier output
    S(0 to Width - 1) <= (others => '0');
    S(Width to 2 * Width - 1) <= P(2 * Width - 1, Width - 1 downto 0) & C(2 * Width - 1, Width - 1);

end Behavioral;