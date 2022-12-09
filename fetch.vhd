library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch_buffer is
	
	port(
		clk, ena, clr: in std_logic;
		Din1: in std_logic_vector(31 downto 0);
		Din2: in std_logic_vector(31 downto 0);
		Dout: out std_logic_vector(31 downto 0);
		PC : out std_logic_vector(31 downto 0);
		dec_instr1: out std_logic;
		dec_instr2: out std_logic
		);
end entity;

architecture struct of fetch_buffer is


begin
	process(clk, clr)	
	variable temp_bool1: std_logic:= '1';
	variable temp_bool2: std_logic:= '1';
	begin
		if(clr = '1') then
			Dout <= (others => '0');
			dec_instr1 <= '0';
			dec_instr2 <= '0';
			
		elsif(clk'event and clk='1') then
			dec_instr1 <= '0';
			dec_instr2 <= '0';
			if (ena='1') then
				Dout(31 downto 16) <= Din1(15 downto 0); 
				Dout(15 downto 0) <= Din2(15 downto 0);
				PC (31 downto 16) <= Din2(31 downto 16);
				PC (15 downto 0) <= Din1(31 downto 16);
			end if;
			loop_check: for i in 0 to 31 loop
				if Din1(i) /= '0' and Din1(i) /= '1' then
					temp_bool1 := '0' and temp_bool1;
					exit;
				else
					temp_bool1 := '1' and temp_bool1;
				end if;
				
				if Din2(i) /= '0' and Din2(i) /= '1' then
					temp_bool2 := '0' and temp_bool2;
					exit;
				else
					temp_bool2 := '1' and temp_bool2;
				end if;
			end loop;
			dec_instr1 <= '1';
			dec_instr2 <= temp_bool2;
		end if;
		
	end process;
	
end architecture;