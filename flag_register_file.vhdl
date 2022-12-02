library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--latch the rename data first
entity flag_register_file is
port (
read_addr_a : in std_logic_vector(3 downto 0);
read_addr_b : in std_logic_vector(3 downto 0);

write_addr_a: in std_logic_vector(3 downto 0);
write_addr_b: in std_logic_vector(3 downto 0);

data_in_a : in std_logic_vector(1 downto 0);
data_in_b : in std_logic_vector(1 downto 0);

data_out_a : out std_logic_vector(7 downto 0);
data_out_b : out std_logic_vector(7 downto 0);

write_en_a: in std_logic;
write_en_b: in std_logic;

full: out std_logic;

clk: in std_logic;
clear: in std_logic;
reset: in std_logic;

fresh_rr_out_1: out std_logic_vector(3 downto 0);
fresh_rr_out_2: out std_logic_vector(3 downto 0);
reg_rename_en_a: in std_logic;
reg_rename_en_b: in std_logic

);
end entity flag_register_file;

architecture behavioural of flag_register_file is
type flagRegFile is array(0 to 15) of std_logic_vector(7 downto 0);
shared variable cz : flagRegFile ;


signal reg_rename_en_a_lat: std_logic;
signal reg_rename_en_b_lat: std_logic;


begin

read_process: process(read_addr_a, read_addr_b)

begin 

data_out_a <= cz(to_integer(unsigned(read_addr_a)));
data_out_b <= cz(to_integer(unsigned(read_addr_b)));
end process;


write_process: process(clk, clear, reset) 
variable fresh_reg_1: integer:= 1;
variable fresh_reg_2: integer:= 2; -- base case remaining 
variable loop_indx: integer:= 0;


begin
  if(reset = '1') then
	l1: for k in 0 to 15 loop
	  cz(k) := (others => '0');
	end loop l1; 
	 
   elsif (clear = '1') then
	 l2: for k in 0 to 15 loop
	  cz(k)(5 downto 0) := "000000";
	 end loop l2; 
	
   elsif(rising_edge(clk)) then
	  
	  reg_rename_en_a_lat <= reg_rename_en_a;
	  reg_rename_en_a_lat <= reg_rename_en_a; 
	  
		
   	if(write_en_a = '1' and  (write_addr_a /= "000") ) then -- if write enabled and adress is correct start writing process
		   if(cz(0)(4 downto 1) = write_addr_a) then -- if the tag of AR is same as index of RR
			  cz(0)(5) := '0'; --make AR unbusy
			end if;
		cz(0)(7 downto 6) := data_in_a; -- put data into AR
		cz(to_integer(unsigned(write_addr_a)))(7 downto 6) := data_in_a; -- put data into RR
		cz(to_integer(unsigned(write_addr_a)))(5) := '0'; -- set RR as unbusy
		cz(to_integer(unsigned(write_addr_a)))(0) := '1'; -- set RR as valid
		end if;
		
		if(write_en_b = '1' and (write_addr_b /= "000") ) then -- if write enabled and adress is correct start writing process
		   if(cz(0)(4 downto 1) = write_addr_b) then -- if the tag of AR is same as index of RR
			  cz(0)(5) := '0'; --make AR unbusy
			end if;
		cz(0)(7 downto 6) := data_in_b; -- put data into AR
		cz(to_integer(unsigned(write_addr_b)))(7 downto 6) := data_in_b; -- put data into RR
		cz(to_integer(unsigned(write_addr_b)))(5) := '0'; -- set RR as unbusy
		cz(to_integer(unsigned(write_addr_b)))(0) := '1'; -- set RR as valid
		end if;
		
		
		
	--end if;
	
	if((std_logic_vector(to_unsigned(fresh_reg_1, 4)) /= write_addr_a) and (std_logic_vector(to_unsigned(fresh_reg_2, 4)) /= write_addr_a)
   and (std_logic_vector(to_unsigned(fresh_reg_1, 4)) /= write_addr_b) and (std_logic_vector(to_unsigned(fresh_reg_2, 4)) /= write_addr_b)	) then
	if(reg_rename_en_a_lat = '1' and reg_rename_en_b_lat = '0' and ( fresh_reg_1 /= 0)) then
     cz(fresh_reg_1)(0) := '0'; -- make RR invalid
	  cz(fresh_reg_1)(5) := '1'; -- make RR busy
	  cz(0)(4 downto 1) := std_logic_vector(to_unsigned(fresh_reg_1, 4)); --Set tag of AR
	  cz(0)(5) := '1'; --make AR busy
	  
	 elsif((reg_rename_en_a_lat = '0') and (reg_rename_en_b_lat = '1') and (fresh_reg_2 /= 0)) then 
	  cz(fresh_reg_2)(0) := '0'; -- make RR invalid
	  cz(fresh_reg_2)(5) := '1'; -- make RR busy
	  cz(0)(4 downto 1) := std_logic_vector(to_unsigned(fresh_reg_2, 4)); --Set tag of AR
	  cz(0)(5) := '1'; --make AR busy
	  
	 elsif((reg_rename_en_a_lat = '1') and (reg_rename_en_b_lat = '1') and  (fresh_reg_1 /= 0) and  (fresh_reg_2 /= 0) and (fresh_reg_1 /= fresh_reg_2)) then
	  cz(fresh_reg_2)(0) := '0'; -- make RR invalid
	  cz(fresh_reg_1)(0) := '0'; -- make RR invalid
	  
	  cz(fresh_reg_1)(5) := '1'; -- make RR busy
	  cz(fresh_reg_2)(5) := '1'; -- make RR busy
	  
	  cz(0)(4 downto 1) := std_logic_vector(to_unsigned(fresh_reg_2, 4)); --Set tag of AR
	  cz(0)(5) := '1'; --make AR busy
	  
	  end if;
	  
	 
   fresh_reg_1 := 16;
   fresh_reg_2 := 16;	
	loop1: for i in 1 to 15 loop
	if (cz(i)(5) = '0') then
	fresh_reg_1 := i; 
	fresh_rr_out_1 <= std_logic_vector(to_unsigned(i, 4));
	exit loop1;
	end if;
	
	end loop;
	 
	if(fresh_reg_1 = 16) then
	  full <= '1' ;
	
	else  
	loop2: for i in 1 to 15 loop
	if (cz(i)(5) = '0' and not(i = fresh_reg_1)) then
	fresh_reg_2 := i; 
	fresh_rr_out_2 <= std_logic_vector(to_unsigned(i, 4));
	exit loop2;
	end if;
	end loop;
	end if;
	
	if(fresh_reg_2 = 16 ) then
	full <= '1';
	end if;
	
	end if;
	end if;
	  
  
end process;
end architecture;

--2 free registers
--2 enable for renaming
--2 writes from ROB(2 ar and 2 rr)
--2 reads from decode
