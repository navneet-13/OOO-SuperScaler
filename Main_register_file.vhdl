library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_file is
port (
read_addr_a : in std_logic_vector(4 downto 0);
read_addr_b : in std_logic_vector(4 downto 0);
read_addr_c : in std_logic_vector(4 downto 0);
read_addr_d : in std_logic_vector(4 downto 0);

write_addr_a: in std_logic_vector(4 downto 0);
write_addr_b: in std_logic_vector(4 downto 0);
write_addr_c: in std_logic_vector(4 downto 0);
write_addr_d: in std_logic_vector(4 downto 0);

data_in_a : in std_logic_vector(9 downto 0);
data_in_b : in std_logic_vector(9 downto 0);

data_out_a : out std_logic_vector(22 downto 0);
data_out_b : out std_logic_vector(22 downto 0);
data_out_c : out std_logic_vector(22 downto 0);
data_out_d : out std_logic_vector(22 downto 0);

write_en_a: in std_logic;
write_en_b: in std_logic;

clk: in std_logic;
clear: in std_logic;
reset: in std_logic


);
end entity register_file;

architecture behavioural of register_file is 
type registerFile is array(0 to 31) of std_logic_vector(22 downto 0);
  signal registers : registerFile;
  begin 
  RF_read: process 
  begin 
  data_out_a <= registers(to_integer(unsigned(read_addr_a)));
  data_out_b <= registers(to_integer(unsigned(read_addr_b)));
  data_out_c <= registers(to_integer(unsigned(read_addr_c)));
  data_out_d <= registers(to_integer(unsigned(read_addr_d)));
  end process;
  
  RF_write: process(clk)
  begin
  if rising_edge(clk) then
     if (write_en_a = '1') then
     if(registers(to_integer(unsigned(write_addr_a(9 downto 5))))(5 downto 1) = write_addr_a(4 downto 0)) then --if the tag is same
	  registers(to_integer(unsigned(write_addr_a(9 downto 5))))(6) <= '0'; -- reset busy of AR
	  end if;
		
		registers(to_integer(unsigned(write_addr_a(4 downto 0))))(22 downto 6) <= data_in_a; --data into the renamed register
	   registers(to_integer(unsigned(write_addr_a(4 downto 0))))(0) <= '1'; -- set valid of RR
		registers(to_integer(unsigned(write_addr_a(4 downto 0))))(6) <= '0'; -- reset busy of RR
		
		registers(to_integer(unsigned(write_addr_a(9 downto 5))))(22 downto 6) <= data_in_a; --data into the architectural register
	  end if;
	 
	if (write_en_b = '1') then
	if(registers(to_integer(unsigned(write_addr_b(9 downto 5))))(5 downto 1) = write_addr_b(4 downto 0)) then --if the tag is same
	  registers(to_integer(unsigned(write_addr_b(9 downto 5))))(6) <= '0'; -- reset busy of AR
	  end if;
		
		registers(to_integer(unsigned(write_addr_b(4 downto 0))))(22 downto 6) <= data_in_b; --data into the renamed register
	   registers(to_integer(unsigned(write_addr_b(4 downto 0))))(0) <= '1'; -- set valid of RR
		registers(to_integer(unsigned(write_addr_b(4 downto 0))))(6) <= '0'; -- reset busy of RR
		
		registers(to_integer(unsigned(write_addr_b(9 downto 5))))(22 downto 6) <= data_in_b; --data into the architectural register
	 
	 end if;
	 end if;
	end process;
	end behavioural;
	

