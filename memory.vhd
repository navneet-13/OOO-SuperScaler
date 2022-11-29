library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.ALL;

-- A 64x8 Multiple-port RAM in VHDL
entity Multiple_port_RAM_VHDL is
port(
 RAM_ADDR_Read_1: in std_logic_vector(15 downto 0); -- Address_1 to read RAM
 RAM_ADDR_Read_2: in std_logic_vector(15 downto 0); -- Address_2 to read RAM
 RAM_ADDR_Write_1: in std_logic_vector(15 downto 0); -- Address_1 to write RAM
 RAM_ADDR_Write_2: in std_logic_vector(15 downto 0); -- Address_2 to write RAM
 RAM_DATA_IN_1: in std_logic_vector(15 downto 0); -- 16 bit Data_1 to write into RAM
 RAM_DATA_IN_2: in std_logic_vector(15 downto 0); -- 16 bit Data_2 to write into RAM
 PC_Instr: in std_logic_vector(15 downto 0);--PC address

 RAM_WR_1: in std_logic; -- Write enable 1
 RAM_WR_2: in std_logic; -- Write enable 2
 RAM_CLOCK: in std_logic; -- clock input for RAM

 instr_out_1: out std_logic_vector(15 downto 0);
 instr_out_2: out std_logic_vector(15 downto 0);
 RAM_DATA_OUT_1: out std_logic_vector(15 downto 0); -- Data output 1 of RAM
 RAM_DATA_OUT_2: out std_logic_vector(15 downto 0) -- Data output 2 of RAM
);
end Multiple_port_RAM_VHDL;

architecture Behavioral of Multiple_port_RAM_VHDL is
-- define the new type for the 63x16 RAM 
type RAM_ARRAY is array (0 to  63) of std_logic_vector (15 downto 0);
-- initial values in the RAM
signal RAM: RAM_ARRAY :=(
   x"0000",x"0000",x"0000",x"0000",-- 0x00: 
   x"0000",x"0000",x"0000",x"0000",-- 0x04: 
   x"0000",x"0000",x"0000",x"0000",-- 0x08: 
   x"0000",x"0000",x"0000",x"0000",-- 0x0C: 
   x"0000",x"0000",x"0000",x"0000",-- 0x10: 
   x"0000",x"0000",x"0000",x"0000",-- 0x14: 
   x"0000",x"0000",x"0000",x"0000",-- 0x18: 
   x"0000",x"0000",x"0000",x"0000",-- 0x1C: 
   x"0000",x"0000",x"0000",x"0000",-- 0x20: 
   x"0000",x"0000",x"0000",x"0000",-- 0x24: 
   x"0000",x"0000",x"0000",x"0000",-- 0x28: 
   x"0000",x"0000",x"0000",x"0000",-- 0x2C: 
   x"0000",x"0000",x"0000",x"0000",-- 0x30: 
   x"0000",x"0000",x"0000",x"0000",-- 0x34: 
   x"0000",x"0000",x"0000",x"0000",-- 0x38: 
   x"0000",x"0000",x"0000",x"0000",-- 0x3C: 
   x"0000",x"0000",x"0000",x"0000",-- 0x40: 
   x"0000",x"0000",x"0000",x"0000",-- 0x44: 
   x"0000",x"0000",x"0000",x"0000",-- 0x48: 
   x"0000",x"0000",x"0000",x"0000",-- 0x4C: 
   x"0000",x"0000",x"0000",x"0000",-- 0x50: 
   x"0000",x"0000",x"0000",x"0000",-- 0x54: 
   x"0000",x"0000",x"0000",x"0000",-- 0x58: 
   x"0000",x"0000",x"0000",x"0000",-- 0x5C: 
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000",
   x"0000",x"0000",x"0000",x"0000"

   ); 
begin
process(RAM_CLOCK)
begin
 if(rising_edge(RAM_CLOCK)) then
 if(RAM_WR_1='1') then -- when write enable = 1, 
 -- write input data into RAM at the provided address
 RAM(to_integer(unsigned(RAM_ADDR_Write_1))) <= RAM_DATA_IN_1;
 -- The index of the RAM array type needs to be integer so
 -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
 end if;
 end if;

 if(rising_edge(RAM_CLOCK)) then
    if(RAM_WR_2='1') then -- when write enable = 1, 
    -- write input data into RAM at the provided address
    RAM(to_integer(unsigned(RAM_ADDR_Write_2))) <= RAM_DATA_IN_2;
    -- The index of the RAM array type needs to be integer so
    -- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
    end if;
    end if;

end process;
 -- Data to be read out 
 RAM_DATA_OUT_1 <= RAM(to_integer(unsigned(RAM_ADDR_Read_1)));
 RAM_DATA_OUT_2 <= RAM(to_integer(unsigned(RAM_ADDR_Read_2)));

 instr_out_1 <= RAM(to_integer(unsigned(PC_Instr)));
 instr_out_2 <= RAM(to_integer(unsigned(PC_Instr + 1)));
end Behavioral;