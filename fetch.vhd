library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch_buffer is
	
	port(
		clk, ena, clr: in std_logic;
		Din1: in std_logic_vector(15 downto 0);
		Din2: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(31 downto 0));
end entity;

architecture struct of fetch_buffer is


begin
	process(clk, clr)	
	begin
		if(clr = '1') then
			Dout <= (others => '0');
			
		elsif(clk'event and clk='1') then
			if (ena='1') then
				Dout(31 downto 16) <= Din1; 
				Dout(15 downto 0) <= Din2;
			end if;
		end if;
		
	end process;
	
end architecture;