# Activity Statement 

The seventeenth activity was to modify the implemented architecture by adding the MULDIV instruction for the multiplication of two 32-bit signed values. The MUL function performs multiplication of XLEN bits by XLEN bits and stores the least significant XLEN bits in the destination register. MULH, MULHU, and MULHSU perform the same multiplication but return the most significant XLEN bits of the complete 2xXLEN bits product for signed x signed, unsigned x unsigned, and signed x unsigned multiplication, respectively [1].

In the following table, the instruction format for MULDIV is presented, and in next one, the corresponding opcodes are provided.

| funct7 |  rs2   |  rs1   | funct3 |   rd   | opcode |
|--------|--------|--------|--------|--------|--------|
| 31-25  | 24-20  | 19-15  | 14-12  | 11-7   |  6-0   |

| funct7 | rs2 | rs1 | funct3 | rd | Opcode  | Instruction |
|--------|-----|-----|--------|----|---------|-------------|
| 0000001| rs2 | rs1 |   000  | rd | 0110011 |     MUL     |
| 0000001| rs2 | rs1 |   001  | rd | 0110011 |     MULH    |
| 0000001| rs2 | rs1 |   010  | rd | 0110011 |     MULHSU  |
| 0000001| rs2 | rsl |   011  | rd | 0110011 |     MULHU   |
| 0000001| rs2 | rs1 |   100  | rd | 0110011 |     DIV     |
| 0000001| rs2 | rsl |   101  | rd | 0110011 |     DIVU    |
| 0000001| rs2 | rs1 |   110  | rd | 0110011 |     REM     |
| 0000001| rs2 | rs1 |   111  | rd | 0110011 |     REMU    |

## Development 

### Creating the Multiplier 

The resolution of this exercise was intended to be done using the extended resolution of Exercise 7.6.6 of [2], which statement is the one available in tghe following figure. Or, directly translating - "The multiplication operation between two positive integers can be implemented by a set of full adders. Figure 7.6.5 illustrates the case of a 3-bit multiplier, where "a" and "b" are the input signals, and "p" is the output signal. Provide a description of the proposed multiplier".

<p align="center">
 
  <img src="https://github.com/joaocolombari/Projeto2023/assets/105496210/873b268d-2382-4af3-a36f-f5e40b493f69" width="600">

</p>

Based on such exercise, the professor sugested a method for expanding the solution in order to acheive a parameterized solution, which was very helpfull. Together with this solution, the author implemented the full adder, which is available in this directory as "fulladder.vhd" and instantiated it within the mul architecture just as it is shown in the exercise and the mul was almost successfully implemented. This first version is available here as "mul_1.vhd" together with a testbench, named "mul_1_testbench.vhd".

The testbench tests for unsigned x unsigned, unsigned  x signed, signed x unsigned and signed x signed in the following way.

```
begin
    mul_proc: process
    begin
        -- 1111111111111111
        -- 0000000000000000

        -- Test Case 1: 3 * 3
        a <= "00000000000000000000000000000011";
        b <= "00000000000000000000000000000011";
        wait for 10 ns;
        assert y = "0000000000000000000000000000000000000000000000000000000000001001" report "Test Case 1 failed" severity error;

        -- Test Case 1: 3 * -3
        a <= "00000000000000000000000000000011";
        b <= "11111111111111111111111111111101";
        wait for 10 ns;
        assert y = "1111111111111111111111111111111111111111111111111111111111110111" report "Test Case 1 failed" severity error;

        -- Test Case 1: -3 * 3
        a <= "11111111111111111111111111111101";
        b <= "00000000000000000000000000000011";
        wait for 10 ns;
        assert y = "1111111111111111111111111111111111111111111111111111111111110111" report "Test Case 1 failed" severity error;

        -- Test Case 1: -3 * 3
        a <= "11111111111111111111111111111101";
        b <= "11111111111111111111111111111101";
        wait for 10 ns;
        assert y = "0000000000000000000000000000000000000000000000000000000000001001" report "Test Case 1 failed" severity error;

        wait;
    end process mul_proc;
```

Running a ModelSim simulation, it can be seen that tests one and two are successful and three and four are not. 

Test 3 returns:

```
0000000000000000000000000000001011111111111111111111111111110111
```

And test 4 returns:

```
1111111111111111111111111111110100000000000000000000000000001001
```

Thus only the 32 most significant bits are right. The author tryied several forms to fix this issue but hadn't have succeeded. Nevertheless, there was another way of making it work. Once signed x unsigned equals unsigned x signed, and signed x signed equals unsigned x unsigned, the fix could be only a matter of switching and unsigning numbers. Thus, the author made a piece of logic within the mul architecture. The implemented process statement is the one that follows.

```
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
```
The "absolute()" function was implemented in the package and does the two`s complement in order to make the negative numbers positive. Its code is the one that follows.

```
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
```

Making these changes and running a ModelSim simulation with the same testbench, the mul finally seemed to work.

### Creating the instruction

The R-type instructions are described in the following table. An attentive reader should have already notted that there is a problem in the decodification of the instructions for the processor as is so far. Cheking the second table of this file, the inputs of the main decoder and the alu decoder, it is clear that there will be multiple instructions decoded for a same input. If it is not clear, it will be soon. 

| funct7 | rs2 | rs1 | funct3 | rd | Opcode  | Instruction |
|--------|-----|-----|--------|----|---------|-------------|
| 0000000| rs2 | rs1 |   000  | rd | 0110011 |     ADD     |
| 0100000| rs2 | rs1 |   000  | rd | 0110011 |     SUB     |
| 0000000| rs2 | rs1 |   001  | rd | 0110011 |     SLL     |
| 0000000| rs2 | rs1 |   010  | rd | 0110011 |     SLT     |
| 0000000| rs2 | rsl |   011  | rd | 0110011 |     SLTU    |
| 0000000| rs2 | rs1 |   100  | rd | 0110011 |     XOR     |
| 0000000| rs2 | rsl |   101  | rd | 0110011 |     SRL     |
| 0100000| rs2 | rs1 |   101  | rd | 0110011 |     SRA     |
| 0000000| rs2 | rs1 |   110  | rd | 0110011 |     OR      |
| 0000000| rs2 | rs1 |   111  | rd | 0110011 |     AND     |

The following code extract shows how the main decoder uses the opcode to select the R-type instructions and then feed '10' into the ALUOp signal.

```
architecture behave of maindec is
	signal controls: BIT_VECTOR(10 downto 0);
begin
	process(op) begin
		case op is
			when "0000011" => controls <= "10010010000"; -- lw
			when "0100011" => controls <= "00111000000"; -- sw
			when "0110011" => controls <= "10000000100"; -- R-type	("1--00000100")
			when "1100011" => controls <= "01000001010"; -- beq
			when "0010011" => controls <= "10010000100"; -- I-type ALU
			when "1101111" => controls <= "11100100001"; -- jal
			when others => controls <= "00000000000"; -- not valid	("-----------")
		end case;
	end process;
	
	(RegWrite, ImmSrc(1), ImmSrc(0), ALUSrc, MemWrite,
	ResultSrc(1), ResultSrc(0), Branch, ALUOp(1), ALUOp(0),
	Jump) <= controls;
end;
```

Then, in the ALU decoder, ALUOp is used to select between the operations, that are fed into ALUControl to be decoded in ALU file itself. 

```
process(opb5, funct3, funct7b5, ALUOp, RtypeSub) begin
		case ALUOp is
			when "00" => ALUControl <= "000"; -- addition
			when "01" => ALUControl <= "001"; -- subtraction
			when others => case funct3 is -- R-type or I-type ALU
				when "000" => if RtypeSub = '1' then
									ALUControl <= "001"; -- sub
								else
									ALUControl <= "000"; -- add, addi
								end if;
				when "010" => ALUControl <= "101"; -- slt, slti
				when "110" => ALUControl <= "011"; -- or, ori
				when "111" => ALUControl <= "010"; -- and, andi
				when others => ALUControl <= "000"; -- unknown	("---")
			end case;
		end case;
	end process;
```

Now, since the R-type instructions with opcode "0110011" have the same format but different funct7 values, and the standard RISC operations (add, sub, etc.) can have various funct3 values, it's not possible to uniquely identify the MUL operation solely based on the opcode, funct3 and funct7b5 bit, that is the second MSB from funct7. In summary, without additional bits or a unique opcode, it's impossible to distinguish between MUL and other R-type instructions solely based on opcode and funct3 in the standard RISC-V ISA. 

To address this, one may need to introduce additional control signals or modify the instruction format to uniquely identify the MUL operation. This could involve extending the opcode or introducing additional bits to convey the specific operation. A quick look on the tables suggest that the easiest choice is to use the LSB from funct7 as a distinguisher. 

The controller defines funct7b5 as an input and riscvsingle conects it to the 31st bit of the instruction (double check R-type instruction structure). The controler then conects it to the ALU decoder, where it is also defined as an input and uses it to differ a certain type of subtraction. There are two options, first is to create another variable and second is to use funct7 entirelly, which the author perceives to be the most sensible decision, since it opens doors to further modifications. 

So the author opted on using funct7 vector enterelly. The first change was in riscvsingle:

```
c: controller 
		generic map (Width) 
		port map(
			op => Instr(6 downto 0), 
			funct3 => Instr(14 downto 12),
			funct7 => Instr(31 downto 25), 	-- changed here!! from 5th bit to funct7 
			Zero => Zero, 
			ResultSrc => ResultSrc, 
			MemWrite => MemWrite,
			PCSrc => PCSrc, 
			ALUSrc => ALUSrc, 
			RegWrite => RegWrite, 
			Jump => Jump,
			ImmSrc => ImmSrc, 
			ALUControl => ALUControl
		);
```

Then the controller also needed to be changed, as follows.

```
entity controller is
	
   generic(
      Width : natural := 32
   );

	port(
		op: 			in 			BIT_VECTOR(6 downto 0);
		funct7: 		in 			BIT_VECTOR(6 downto 0);		-- added funct7 declaration as vector here
		funct3: 		in 			BIT_VECTOR(2 downto 0);
		Zero: 			in 			BIT;
		ResultSrc: 		out 			BIT_VECTOR(1 downto 0);
		MemWrite: 		out 			BIT;
		PCSrc, ALUSrc: 		out 			BIT;
		RegWrite: 		out 			BIT;
		Jump: 			buffer 			BIT;
		ImmSrc: 		out 			BIT_VECTOR(1 downto 0);
		ALUControl: 		out 			BIT_VECTOR(2 downto 0)
	);
end controller;
```

Aludec input was changed as in the controller, and then the following logic was added to the architecture.

```
architecture behave of aludec is
	signal RtypeSub: BIT;
	signal funct7b5: BIT := funct7(5);		-- defined funct7b5 as was and
	signal funct7b0: BIT := funct7(0);	  	-- defined funct7b0 to decode MUL
begin
	RtypeSub <= funct7b5 and opb5; -- TRUE for R-type subtract
	process(opb5, funct3, funct7b5, ALUOp, RtypeSub) begin
		case ALUOp is
			when "00" => ALUControl <= "000"; -- addition
			when "01" => ALUControl <= "001"; -- subtraction
			when others => 
				if funct7b0 = '1' then				-- MUL case
					case funct3 is 
					when "001" => ALUControl <= "100";	-- MULH
					when "011" => ALUControl <= "110";	-- MULHU
					when "010" => ALUControl <= "111";	-- MULHSU
					when others => ALUControl <= "000"; -- unknown	("---")
					end case;
				
				else						-- std riscvsingle case
					case funct3 is -- R-type or I-type ALU
					when "000" => if RtypeSub = '1' then
										ALUControl <= "001"; -- sub
									else
										ALUControl <= "000"; -- add, addi
									end if;
					when "010" => ALUControl <= "101"; -- slt, slti
					when "110" => ALUControl <= "011"; -- or, ori
					when "111" => ALUControl <= "010"; -- and, andi
					when others => ALUControl <= "000"; -- unknown	("---")
					end case;
				end if;
		end case;
	end process;
end;
```

Reaffirming, the MUL function performs a multiplication of XLEN bits by XLEN bits and places the least significant XLEN bits in the register of destination. MULH, MULHU and MULHSU perform the same multiplication, but return the XLEN bits most significant of the complete product of 2xXLEN bits, for a multiplication of signed x signed, unsigned x unsigned and signed x unsigned, respectively. Since the MUL component sorts the signed position by its own, all three instructions can share the use of the same operator to be defined. So the following modifications were done in the ALU.

```
case ALUControl(2 downto 0) is
			when "000" => ALUResultTmp := a + b;
			when "001" => ALUResultTmp := a - b;
			when "010" => ALUResultTmp := a and b;
			when "011" => ALUResultTmp := a or b;
			when "101" => ALUResultTmp := a * b;				-- Added the multiplication
			when "101" => ALUResultTmp := Short_Zero & S(Width - 1);
			when "110" => ALUResultTmp := a * b;				-- Which is redundant for all instructions
			when "111" => ALUResultTmp := a * b;				-- then only one operator is enouth

			when others => ALUResultTmp := Result_Zero;
		end case;
```

Repeted atempts of implementing the "*" operator were made, none of them was successful. They consisted basically on making functions or procedures inside the riscv_pkg that called the MUL component using port map, which is probably not allowed inside a package. There were a few options in this point, such as redefine the MUL as a function, which simmed too laborious, so the author opted to use the port map inside the ALU for each MUL instruction, as follows. Note the second temporary result variable to hold the 2 * Width - 1 long result vector.

```
architecture synth of alu is
	constant Result_Zero: 			BIT_VECTOR(Width - 1 downto 0) := (others => '0');
	constant Short_Zero: 			BIT_VECTOR(Width - 2 downto 0) := (others => '0');
	signal S, Bout, Carry: 			BIT_VECTOR(Width - 1 downto 0);
	signal ALUResultTmp_long: 		BIT_VECTOR(2 * Width - 1 downto 0) := Result_Zero & Result_Zero;

begin
	Carry <= Short_Zero & ALUControl(2);
	Bout <= (not b) when (ALUControl(2) = '1') else b;
	S <= a + Bout + Carry;
	
	-- Adding the mul component instantiation
   	MULH : mul port map (a => a, b => b, y => ALUResultTmp_long);	
	
	-- alu function
	process(a, b, ALUControl, S)
		variable ALUResultTmp: 			BIT_VECTOR(Width - 1 downto 0) := Result_Zero;
	begin
		case ALUControl(2 downto 0) is
			when "000" => ALUResultTmp := a + b;
			when "001" => ALUResultTmp := a - b;
			when "010" => ALUResultTmp := a and b;
			when "011" => ALUResultTmp := a or b;
			when "100" =>												-- Added the multiplication
					ALUResultTmp := ALUResultTmp_long(2 * Width - 1 downto Width);
			when "101" => ALUResultTmp := Short_Zero & S(Width - 1);
			when "110" =>												-- Which is redundant for all instructions
					ALUResultTmp := ALUResultTmp_long(2 * Width - 1 downto Width);
			when "111" => 												-- then only one operator is enouth
					ALUResultTmp := ALUResultTmp_long(2 * Width - 1 downto Width);
			when others => ALUResultTmp := Result_Zero;
		end case;
```

Here the MUL is instantiated with the inputs a and b and the 2 * Width - 1 temporary result variable as an output. The ALU result is associated with the MUL result's most significant bits whenever the ALUControl equals the ones defined as the multiplication. 

In order to make everything work, the riscv_pkg had to be updated with the new funct7 vector. With all these changes done, the new riscvsingle, controller, aludec and alu error logs and RTL viewers were obtained in Quartus and are available in "./simulacoes_quartus".

<!-- REFERENCES -->
[1]: https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
[2]: https://scholar.google.com.br/scholar?hl=pt-BR&as_sdt=0%2C5&q=Amore%2C+R.%2C+%22VHDL+-+Descrição+e+Síntese+de+Circuitos+Digitais%22%2C+LTC%2C+2012.+&btnG=
