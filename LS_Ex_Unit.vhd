library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.all;
--- Opcode
--- 0000 = LHI
--- 0111 = LW
--- 0101 = SW
--- Anything else = XXX
entity alu_LS is 
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 4
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0); 
      opr2: in std_logic_vector(operand_width-1 downto 0);
		dest: out std_logic_vector(operand_width-1 downto 0);
		PC_in: in std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0);
		opcode: in std_logic_vector(sel_line-1 downto 0);
		enable, reset: in std_logic;
		C, Z: out std_logic;
		inst_valid: out std_logic
	);
end alu_LS;

architecture beh of alu_LS is
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
	signal dest_temp : std_logic_vector(operand_width-1 downto 0) := (others => '0');
	
begin
	PC_out <= PC_in;
	main: process(opr1, opr2, Opcode, enable, reset)
	begin
		if reset = '1' THEN
			C <= '0';
			Z <= '0';
		else 
			if enable = '1' then
			-- NAND
				if unsigned(Opcode) = 0 then
					dest <= opr1;
				-- LHI
                -- Storing opr1 to output
				elsif unsigned(Opcode) = 7 then
					dest_temp <= add(opr1, opr2);
					dest <= dest_temp;
               Z <= or_reduce(dest_temp);
				-- LW
                -- Storing opr1 + opr2 to output
				elsif unsigned(Opcode) = 5 then
					dest <= add(opr1, opr2);
				--- SW
                -- Storing opr1 + opr2 to output
				end if;
			-- OR all bits and write in Z
				
			end if;
		end if;
      inst_valid <= enable;
	end process;

end beh;
