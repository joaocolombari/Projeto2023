library work;
use work.riscv_pkg.all;

entity mul_tb is

	generic(
        Width : natural := 32
    );

end entity mul_tb;

architecture sim of mul_tb is

    component mul  
    port(a, b:           in          BIT_VECTOR(Width - 1 downto 0);
         y:              out         BIT_VECTOR(2 * Width - 1 downto 0));
    end component mul;

    signal a, b    : bit_vector(Width - 1 downto 0);
    signal y       : bit_vector(2 * Width - 1 downto 0);

begin

    -- Instantiate the mul component
    mul_inst : mul port map (a => a, b => b, y => y);

    process begin
        -- 1111111111111111
        -- 0000000000000000

        -- Test Case 1: 3 * 3
        a <= "00000000000000000000000000000011";
        b <= "00000000000000000000000000000011";
        wait for 10 ns;
        assert y = "0000000000000000000000000000000000000000000000000000000000001001" 
						report "Test Case 1 failed" severity error;
						-- Aqui da certo

        -- Test Case 1: 3 * -3
        a <= "00000000000000000000000000000011";
        b <= "11111111111111111111111111111101";
        wait for 10 ns;
        assert y = "1111111111111111111111111111111111111111111111111111111111110111" 
						report "Test Case 2 failed" severity error;
						-- Aqui tambem da certo 
						
		  -- Test Case 1: -3 * 3
        b <= "00000000000000000000000000000011";
        a <= "11111111111111111111111111111101";
        wait for 10 ns;
        assert y = "1111111111111111111111111111111111111111111111111111111111110111" 
						report "Test Case 3 failed" severity error;
						-- Erro. O resultado é 0000000000000000000000000000001011111111111111111111111111110111
						
		  -- Test Case 1: -3 * -3
        a <= "11111111111111111111111111111101";
        b <= "11111111111111111111111111111101";
        wait for 10 ns;
        assert y = "0000000000000000000000000000000000000000000000000000000000001001" 
						report "Test Case 4 failed" severity error;
						-- Erro. O resultado é 1111111111111111111111111111110100000000000000000000000000001001

        -- Add more test cases as needed...

        wait;
    end process;

end architecture sim;
