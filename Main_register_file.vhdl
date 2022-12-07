library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;


entity Main_register_file is
port (
read_addr_a : in std_logic_vector(4 downto 0);
read_addr_b : in std_logic_vector(4 downto 0);
read_addr_c : in std_logic_vector(4 downto 0);
read_addr_d : in std_logic_vector(4 downto 0);
read_addr_e : in std_logic_vector(4 downto 0);
read_addr_f : in std_logic_vector(4 downto 0);


write_addr_a: in std_logic_vector(9 downto 0);
write_addr_b: in std_logic_vector(9 downto 0);
--write_addr_c: in std_logic_vector(4 downto 0);
--write_addr_d: in std_logic_vector(4 downto 0);

data_in_a : in std_logic_vector(15 downto 0);
data_in_b : in std_logic_vector(15 downto 0);

data_out_a : out std_logic_vector(22 downto 0);
data_out_b : out std_logic_vector(22 downto 0);
data_out_c : out std_logic_vector(22 downto 0);
data_out_d : out std_logic_vector(22 downto 0);
data_out_e : out std_logic_vector(22 downto 0);
data_out_f : out std_logic_vector(22 downto 0);

write_en_a: in std_logic;
write_en_b: in std_logic;

full: out std_logic;

clk: in std_logic;
clear: in std_logic;
reset: in std_logic;

fresh_rr_out_1: out std_logic_vector(4 downto 0);
fresh_rr_out_2: out std_logic_vector(4 downto 0);
rename_reg_addr_in_1: in std_logic_vector(4 downto 0);
rename_reg_addr_in_2: in std_logic_vector(4 downto 0);
reg_rename_en_1: in std_logic;
reg_rename_en_2: in std_logic
);
end entity Main_register_file;

architecture behavioural of Main_register_file is 

type registerFile is array(0 to 31) of std_logic_vector(22 downto 0);
  shared variable registers : registerFile;
  
  signal rename_reg_addr_in_1_lat: std_logic_vector(4 downto 0);
  signal rename_reg_addr_in_2_lat: std_logic_vector(4 downto 0);
  signal reg_rename_en_1_lat: std_logic;
  signal reg_rename_en_2_lat: std_logic;
  
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

  
  begin 
  RF_read: process(read_addr_a, read_addr_b,read_addr_c, read_addr_d ) 
  begin 
  data_out_a <= registers(to_integer(unsigned(read_addr_a)));
  data_out_b <= registers(to_integer(unsigned(read_addr_b)));
  data_out_c <= registers(to_integer(unsigned(read_addr_c)));
  data_out_d <= registers(to_integer(unsigned(read_addr_d)));
  data_out_e <= registers(to_integer(unsigned(read_addr_e)));
  data_out_f <= registers(to_integer(unsigned(read_addr_f)));
  end process;
  
  RF_write: process(clk, clear, reset )
  begin
  if(reset = '1') then
	l1: for k in 0 to 31 loop
	  registers(k) := (others => '0');
	 end loop l1; 
	 
   elsif (clear = '1') then
	 l2: for k in 0 to 31 loop
	registers(k)(6 downto 0) := "0000000";
	 end loop l2; 
	 
  
  
  elsif rising_edge(clk) then -- writeback from ROB
   
	 
    if ((not write_addr_a = write_addr_b) and (not write_addr_a(9 downto 5) = write_addr_a(4 downto 0)) ) then
     if (write_en_a = '1') then
     if(registers(to_integer(unsigned(write_addr_a(9 downto 5))))(5 downto 1) = write_addr_a(4 downto 0)) then --if the tag is same
	  registers(to_integer(unsigned(write_addr_a(9 downto 5))))(6) := '0'; -- reset busy of AR
	  end if;
		
		registers(to_integer(unsigned(write_addr_a(4 downto 0))))(22 downto 7) := data_in_a; --data into the renamed register
	   registers(to_integer(unsigned(write_addr_a(4 downto 0))))(0) := '1'; -- set valid of RR
		registers(to_integer(unsigned(write_addr_a(4 downto 0))))(6) := '0'; -- reset busy of RR
		
		registers(to_integer(unsigned(write_addr_a(9 downto 5))))(22 downto 7) := data_in_a; --data into the architectural register
	  end if;
	 
	 end if;
	 
   if ((not write_addr_a = write_addr_b) and (not write_addr_b(9 downto 5) = write_addr_b(4 downto 0)) ) then
	if (write_en_b = '1') then
	if(registers(to_integer(unsigned(write_addr_b(9 downto 5))))(5 downto 1) = write_addr_b(4 downto 0)) then --if the tag is same
	  registers(to_integer(unsigned(write_addr_b(9 downto 5))))(6) := '0'; -- reset busy of AR
	  end if;
		
		registers(to_integer(unsigned(write_addr_b(4 downto 0))))(22 downto 7) := data_in_b; --data into the renamed register
	   registers(to_integer(unsigned(write_addr_b(4 downto 0))))(0) := '1'; -- set valid of RR
		registers(to_integer(unsigned(write_addr_b(4 downto 0))))(6) := '0'; -- reset busy of RR
		
		registers(to_integer(unsigned(write_addr_b(9 downto 5))))(22 downto 7) := data_in_b; --data into the architectural register
	 
	 end if;
	 end if;
	 end if;

	end process;
	
	
	

	rename: process (clk)
	variable fresh_reg_1: integer:= 8;
	variable fresh_reg_2: integer:= 9; -- base case remaining 
	variable loop_indx: integer:= 0;
	
	begin
	if rising_edge(clk) then 
	rename_reg_addr_in_1_lat <= rename_reg_addr_in_1;
	rename_reg_addr_in_2_lat <= rename_reg_addr_in_2;
	reg_rename_en_1_lat <= reg_rename_en_1;
	reg_rename_en_2_lat <= reg_rename_en_2; 
	
	
	if((not std_logic_vector(to_unsigned(fresh_reg_1, 5))= write_addr_a(9 downto 5)) and (not std_logic_vector(to_unsigned(fresh_reg_1, 5)) = write_addr_a(9 downto 0)) 
	and (not std_logic_vector(to_unsigned(fresh_reg_2, 5)) = write_addr_a(9 downto 5)) and (not std_logic_vector(to_unsigned(fresh_reg_2, 5)) = write_addr_a(9 downto 0)) ) then
	
	
	if(reg_rename_en_1_lat = '1' and reg_rename_en_2_lat = '0') then
	registers(fresh_reg_1)(6) := '1'; -- make the RR busy
	registers(fresh_reg_1)(0) := '0'; -- make the RR invalid
	registers(to_integer(unsigned(rename_reg_addr_in_1_lat)))(5 downto 1) := std_logic_vector(to_unsigned(fresh_reg_1, 5)); -- giving the tag to AR
	registers(to_integer(unsigned(rename_reg_addr_in_1_lat)))(6) := '1'; -- making AR busy
	
	elsif (reg_rename_en_1_lat = '0' and reg_rename_en_2_lat = '1') then
	registers(fresh_reg_2)(6) := '1'; --make the RR busy
	registers(fresh_reg_2)(0) := '1'; --make the RR invalid
	registers(to_integer(unsigned(rename_reg_addr_in_2_lat)))(5 downto 1) := std_logic_vector(to_unsigned(fresh_reg_2, 5)); -- giving the tag to AR
	registers(to_integer(unsigned(rename_reg_addr_in_2_lat)))(6) := '1';-- making AR busy
	
	elsif (reg_rename_en_1_lat = '1' and reg_rename_en_2_lat = '1') then
	if(rename_reg_addr_in_1_lat = rename_reg_addr_in_2_lat) then
	registers(fresh_reg_1)(6) := '1';
	registers(fresh_reg_1)(0) := '0';
	registers(fresh_reg_2)(6) := '1';
	registers(fresh_reg_2)(0) := '1';
	
	registers(to_integer(unsigned(rename_reg_addr_in_2_lat)))(5 downto 1) := std_logic_vector(to_unsigned(fresh_reg_2, 5));
	registers(to_integer(unsigned(rename_reg_addr_in_2_lat)))(6) := '1';
	
	else
	registers(fresh_reg_1)(6) := '1'; -- make the RR1 busy
	registers(fresh_reg_1)(0) := '0'; -- make the RR2 invalid
	registers(to_integer(unsigned(rename_reg_addr_in_1_lat)))(5 downto 1) := std_logic_vector(to_unsigned(fresh_reg_1, 5)); -- giving the tag to AR1
	registers(to_integer(unsigned(rename_reg_addr_in_1_lat)))(6) := '1'; -- making AR1 busy
	
	registers(fresh_reg_2)(6) := '1'; --make the RR1 busy
	registers(fresh_reg_2)(0) := '1'; --make the RR2 invalid
	registers(to_integer(unsigned(rename_reg_addr_in_2_lat)))(5 downto 1) := std_logic_vector(to_unsigned(fresh_reg_2, 5)); -- giving the tag to AR2
	registers(to_integer(unsigned(rename_reg_addr_in_2_lat)))(6) := '1';-- making AR2 busy
	
	 
	end if;
	end if;
	end if;
	
	--finding fresh registers
	fresh_reg_1 := 32;
   fresh_reg_2 := 32;	
	
	loop1: for i in 8 to 31 loop
	if (registers(i)(6) = '0') then
	fresh_reg_1 := i; 
	fresh_rr_out_1 <= std_logic_vector(to_unsigned(i, 5));
	exit loop1;
	end if;
	 
	end loop;
	 
	if(fresh_reg_1 = 32) then
	   full <= '1' ;
	else
	loop2: for i in 8 to 31 loop
	if (registers(i)(6) = '0' and not(i = fresh_reg_1)) then
	fresh_reg_2 := i; 
	fresh_rr_out_2 <= std_logic_vector(to_unsigned(i, 5));
	exit loop2;
	end if;
	end loop;
	
	end if;
	
	if(fresh_reg_2 = 32) then  
	full <= '1';
	end if;
	 
	 for i in 0 to 31 loop
	 report "R"& integer'image(i)& ": " & to_string(registers(i));
	
	 end loop;
	 end if;
	end process;
	end behavioural;