library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

entity multiplier is
	
	generic(
		Width : natural := 32
	);

	port(
		a, b: 		in 		STD_LOGIC_VECTOR(Width - 1 downto 0);
		y: 			out 		STD_LOGIC_VECTOR(2 * width - 1 downto 0)
	);
end multiplier;

architecture behave of multiplier is
begin
	y <= a * b;
end;