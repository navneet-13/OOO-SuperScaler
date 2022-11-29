library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity alu is
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 6
	);
	port(opr1: in std_logic_vector(operand_width-1 downto 0);
		opr2: in std_logic_vector(operand_width-1 downto 0);
		dest: out std_logic_vector(operand_width-1 downto 0)
		);
end entity;

architecture Behavioral of alu is
begin

    dest <= opr1 + opr2;

end Behavioral;