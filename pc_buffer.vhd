library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_buffer is
	
	port(
		clk, clr: in std_logic;
		Din1: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0));
end entity;

architecture struct of pc_buffer is

begin
	process(clk, clr)	
	begin
		if(clr = '1') then
				Dout <= (others => '0');
			
		elsif(clk'event and clk='0') then
				Dout <= Din1;
		end if;
		
	end process;
	
end architecture;