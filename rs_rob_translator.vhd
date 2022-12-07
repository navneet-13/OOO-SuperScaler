LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rs_rob_translator is
port (
input_RS: in std_logic_vector(131 downto 0);
output_ROB: out std_logic_vector(57 downto 0)
);
end entity rs_rob_translator;

architecture mapping of rs_rob_translator is 
begin 
output_ROB(57 downto 42) <= input_RS(96 downto 81);
output_ROB(41 downto 38) <= input_RS(80 downto 77);
output_ROB(37) <= input_RS(100);
output_ROB(36 downto 34) <= input_RS(99 downto 97);
output_ROB(33 downto 29) <= input_RS(111 downto 107);
output_ROB(28 downto 24) <= input_RS(21 downto 17);
output_ROB(23 downto 8) <= input_RS(16 downto 1);
output_ROB(7) <= '0';
output_ROB(6 downto 3) <= input_RS(105 downto 102);
output_ROB(2 downto 1) <= "00";
output_ROB(0) <= '0';
end architecture;

