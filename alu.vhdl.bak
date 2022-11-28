library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library work;
use work.all;
--- Operations
--- 00 = NAND
--- 01 = XOR
--- 10 = ADD
--- 11 = ADL
entity alu is 
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 2
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0);
		opr2: in std_logic_vector(operand_width-1 downto 0);
		dest: out std_logic_vector(operand_width-1 downto 0);
		sel: in std_logic_vector(sel_line-1 downto 0);
		enable, reset: in std_logic;
		C, Z: out std_logic
	);
end alu;

architecture beh of alu is
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
			return sum;
	end function add;
	function adl(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0)) 
	return std_logic_vector is
				variable sumL: std_logic_vector(operand_width downto 0);
				variable carryL: std_logic_vector(operand_width-1 downto 0);
				variable i : integer;
		begin --- After leftshift, addition will be A(0) + 0, A(1) + B(0), ...
				sumL(0) := A(0);
				carryL(0) := '0';
				summingBitwise: for i in 1 to operand_width-1 loop
					sumL(i) := ( A(i) xor B(i-1) ) xor carryL(i-1);
					carryL(i) := (A(i) and B(i-1) ) or (B(i-1) and carryL(i-1) ) or ( A(i) and carryL(i-1) );
				end loop;
				sumL(operand_width) := B(operand_width-1) xor carryL(operand_width-1);
			return sumL;
	end function adl;
	


	signal add_temp : std_logic_vector(operand_width downto 0) := (others => '0');
	signal adl_temp : std_logic_vector(operand_width downto 0) := (others => '0');
	signal dest_temp : std_logic_vector(operand_width-1 downto 0) := (others => '0'); --(Aayush) directly using or reduce is giving some error for zero flag 
                                                                 -- added a signal for that
begin
	add_temp <= add(opr1, opr2);
	adl_temp <= adl(opr1, opr2);

	main: process(opr1, opr2, sel, enable, reset)
	begin
		if reset = '1' THEN
			C <= '0';
			Z <= '0';
		else 
			if enable = '1' then
			-- NAND
				if unsigned(sel) = 0 then
					dest <= opr1 nand opr2;
					dest_temp <= opr1 nand opr2;
				-- XOR
				elsif unsigned(sel) = 1 then
					dest <= opr1 xor opr2;
					dest_temp <= opr1 xor opr2;
				-- ADD
				elsif unsigned(sel) = 2 then
					dest <= add_temp(operand_width-1 downto 0);--std_logic_vector(unsigned(opr1)+ unsigned(opr2));
					dest_temp <= add_temp(operand_width-1 downto 0);
					C <= add_temp(operand_width);
				--- ADL
				elsif unsigned(sel) = 3 then
					dest <= adl_temp(operand_width-1 downto 0);
					dest_temp <= adl_temp(operand_width-1 downto 0);
					C <= adl_temp(operand_width);
				end if;
			 -- OR all bits and write in Z
				Z <= or_reduce(dest_temp);
			end if;
		end if;

	end process;


	
end beh;
