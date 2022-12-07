library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.all;
--- Opcode
--- 1000 = BEQ
--- 1010 = JLR
--- 1011 = JRI
--- 1001 = JAL
--- Anything else = XXX
entity alu_Branch_Jump is 
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 4
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0); 
      opr2: in std_logic_vector(operand_width-1 downto 0);
		dest: out std_logic_vector(operand_width-1 downto 0);
		imm: in std_logic_vector(operand_width-1 downto 0);
		PC_in: in std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0);
		
		opcode: in std_logic_vector(sel_line-1 downto 0);
		enable, reset: in std_logic;
		predicted_address : in std_logic_vector(15 downto 0);
		C, Z: out std_logic;
		actual_branch_addr: out std_logic_vector(15 downto 0);
		inst_valid: out std_logic
	);
end alu_Branch_Jump;

architecture beh of alu_Branch_Jump is
	--- Addition Function
	function add(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0)) 
	return std_logic_vector is
				variable sum: std_logic_vector(operand_width downto 0);
				variable carry: std_logic_vector(operand_width-1 downto 0);
				variable i : integer;
		begin
				sum(0) := A(0) xor B(0);
				carry(0) := A(0) AND B(0);
				summingBitwise: for i in 1 to operand_width-1 loop
					sum(i) := ( A(i) xor B(i) ) xor carry(i-1);
					carry(i) := (A(i) and B(i) ) or ( B(i) and carry(i-1) ) or ( A(i) and carry(i-1) );
				end loop;
				sum(operand_width) := carry(operand_width-1);
			return sum(operand_width-1 downto 0);
	end function add;
	
	
begin
	
	main: process(opr1, opr2, Opcode, enable, reset)
	begin
		if reset = '1' THEN
				 C <= '0';
			    Z <= '0';
		else 
			if enable = '1' then
			-- NAND
				if unsigned(Opcode) = 8 then
					dest <= opr1 xor opr2;
					if((opr1 xor opr2) = x"0000") then
					  actual_branch_addr <= add(PC_in , imm);
					else
					  actual_branch_addr <= add(PC_in, x"0001");
					end if;
				-- BEQ
                -- Storing opr1 xor opr2 to output
				elsif unsigned(Opcode) = 10 then
					dest <= opr2 xor predicted_address;
					actual_branch_addr <= opr2;
				-- JLR
                -- Storing opr1(PC) + 1 to output
				elsif unsigned(Opcode) = 9 then
					dest <= add(opr1, "0000000000000001");
					actual_branch_addr <= add(PC_in, imm);
				-- JAL
                -- Storing opr1(PC) + 1 to output
				elsif unsigned(Opcode) = 11 then
					dest <= add(opr1, opr2) xor predicted_address;
					actual_branch_addr <= add(opr1, opr2);
				--- JRI
                -- Storing opr1(RA) + opr2(Imm) to output
				end if;
			-- OR all bits and write in Z
				-- Z <= or_reduce(dest);
			end if;
		end if;
      inst_valid <= enable;
	end process;

end beh;
