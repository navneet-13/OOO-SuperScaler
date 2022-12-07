library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
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
		sel_line: integer:= 6
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0);
		opr2: in std_logic_vector(operand_width-1 downto 0);
		dest: in std_logic_vector(operand_width-1 downto 0);
		output: out std_logic_vector(operand_width-1 downto 0);
		opcode: in std_logic_vector(sel_line-1 downto 0);
		PC_in: in std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0);
		
		cin, zin: in std_logic;
		enable, reset: in std_logic;
		C, Z: out std_logic;
		inst_valid: out std_logic
	);
end alu;

architecture beh of alu is
		function to_string ( a: std_logic_vector) return string is
		variable b : string (1 to a'length) := (others => NUL);
		variable stri : integer := 1; 
		begin
			 for i in a'range loop
				  b(stri) := std_logic'image(a((i)))(2);
			 stri := stri+1;
			 end loop;
		return b;
		end function;
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
	signal output_temp : std_logic_vector(operand_width-1 downto 0) := (others => '0'); --(Aayush) directly using or reduce is giving some error for zero flag 
                                                                 -- added a signal for that
begin
	add_temp <= add(opr1, opr2);
	adl_temp <= adl(opr1, opr2);
	PC_out <= PC_in;
	main: process(opr1, opr2, dest, cin, zin, opcode, enable, reset)
	begin
		if reset = '1' THEN
			C <= '0';
			Z <= '0';
		else 
			if enable = '1' then
			   -- ADD
				if opcode(sel_line-1 downto 2) = "0001" then
					if opcode(1 downto 0) = "00" then
						output <= add_temp(operand_width-1 downto 0);   --std_logic_vector(unsigned(opr1)+ unsigned(opr2));
						output_temp <= add_temp(operand_width-1 downto 0);
					-- ADC
					elsif opcode(1 downto 0) = "10" then
						if cin = '1' then
							output <= add_temp(operand_width-1 downto 0);   --std_logic_vector(unsigned(opr1)+ unsigned(opr2));
							output_temp <= add_temp(operand_width-1 downto 0);
							C <= add_temp(operand_width);
							Z <= or_reduce(output_temp);
						else 
							output <= dest;
							output_temp <= dest;
							C <= cin;
							Z <= zin;
						end if;
				-- ADZ
					elsif opcode(1 downto 0) = "01" then
						if zin = '1' then 
							output <= add_temp(operand_width-1 downto 0);   --std_logic_vector(unsigned(opr1)+ unsigned(opr2));
							output_temp <= add_temp(operand_width-1 downto 0);
							C <= add_temp(operand_width);
							Z <= or_reduce(output_temp);
						else 
							output <= dest;
							output_temp <= dest;
						end if;
				--- ADL
					elsif opcode(1 downto 0) = "11" then
						output <= adl_temp(operand_width-1 downto 0);
						output_temp <= adl_temp(operand_width-1 downto 0);
						C <= adl_temp(operand_width);
						Z <= or_reduce(output_temp);
					end if;
			 -- NDU
				elsif opcode(sel_line-1 downto 2) = "0010" then
					if opcode(1 downto 0) = "00" then
						output <= opr1 nand opr2;
						output_temp <= opr1 nand opr2;
						Z <= or_reduce(output_temp);
						C <= cin;
					-- NDC
					elsif opcode(1 downto 0) = "10" then
						if cin = '1' then
							output <= opr1 nand opr2;
							output_temp <= opr1 nand opr2;
							Z <= or_reduce(output_temp);
							C <= cin;
						else 
							output <= dest;
							output_temp <= dest;
							Z <= zin;
							C <= cin;
						end if;
					---NDZ
					elsif opcode(1 downto 0) = "01" then
						if zin = '1' then
							output <= opr1 nand opr2;
							output_temp <= opr1 nand opr2;
							Z <= or_reduce(output_temp);
							C <= cin;
						else 
							output <= dest;
							output_temp <= dest;
							Z <= zin;
							C <= cin;
						end if; 
					end if;
				end if;	
			end if;
		end if;
      inst_valid <= enable;
	end process;

end beh;
