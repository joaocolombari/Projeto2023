--
--

entity top is
	port(
		clk, reset: in BIT;
		WriteData, DataAdr: buffer BIT_VECTOR(31 downto 0);
		MemWrite: buffer BIT
	);
end;

architecture test of top is
	
	signal PC, Instr, ReadData: BIT_VECTOR(31 downto 0);
begin
	-- instantiate processor and memories
	rvsingle: riscvsingle generic map (32) port map( clk, reset, PC, Instr,
									MemWrite, DataAdr,
									WriteData, ReadData);
	imem1: imem generic map (32) port map(PC, Instr);
	dmem1: dmem generic map (32) port map(clk, MemWrite, DataAdr, WriteData,
	ReadData);
end;