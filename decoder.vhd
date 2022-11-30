library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- Decoder & Dispatch
entity Decoder is
generic(input_width: integer := 6;
		output_width: integer := 16;
		reg_file_op_size: integer := 23;
		flag_reg_op_size: integer := 8;
		reg_pointer_size: integer := 5;
		flag_reg_pointer_size: integer := 4;
		opcode_size: integer := 4;
		condition_size: integer := 2;
		output_size: integer := 112;
		pc_size: integer := 16;
		instr_word_size: integer := 32;
		busy_arf: integer:= 6;

		--bit structrue of RS buffer
		dest_arf_h: integer:= 111;
		dest_arf_l: integer:= 107;
		dest_valid: integer:= 106;
		cz_rename_h: integer:= 105;
cz_rename_l: integer:= 102;
spec: integer:= 100;
tag_h: integer:= 99;
tag_l: integer:= 97;
pc_h: integer:= 96;
pc_l: integer:= 81;
opcode_h: integer:= 80;
opcode_l: integer:= 77;
cond_h: integer:= 76;
cond_l: integer:= 75;
opr1_h: integer:= 74;
opr1_l: integer:= 59;
valid1: integer:= 58;
opr2_h: integer:= 57;
opr2_l: integer:= 42;
valid2: integer:= 41;
cz_h: integer:= 40;
cz_l: integer:= 39;
valid_cz: integer:= 38;
imm16_h: integer:= 37;
imm16_l: integer:= 22;
dest_h: integer:= 21;
dest_l: integer:= 17;
dest_val_h: integer:= 16;
dest_val_l: integer:= 1;
ready: integer:= 0

);
		
port(
 Instruction_Word: in std_logic_vector(instr_word_size - 1 downto 0); 
 CLOCK: in std_logic; -- clock input
 
 --read values got from reg files
 free_reg_1: in std_logic_vector(reg_pointer_size - 1 downto 0);--rename reg
 free_reg_2: in std_logic_vector(reg_pointer_size - 1 downto 0);--rename reg
 free_flag_reg_1: in std_logic_vector(flag_reg_pointer_size - 1 downto 0);--flag rename reg
 free_flag_reg_2: in std_logic_vector(flag_reg_pointer_size - 1 downto 0);--flag rename reg
 opr1_in_1: in std_logic_vector(reg_file_op_size - 1 downto 0);
 opr1_in_2: in std_logic_vector(reg_file_op_size - 1 downto 0);
 opr2_in_1: in std_logic_vector(reg_file_op_size - 1 downto 0);
 opr2_in_2: in std_logic_vector(reg_file_op_size - 1 downto 0);
 dest_in_1: in std_logic_vector(reg_file_op_size - 1 downto 0);
 dest_in_2: in std_logic_vector(reg_file_op_size - 1 downto 0);
 flag_reg_in_1: in std_logic_vector(flag_reg_op_size - 1 downto 0);
 flag_reg_in_2: in std_logic_vector(flag_reg_op_size - 1 downto 0);
 ----------------------------------------
 
 PC_1: in std_logic_vector(pc_size - 1 downto 0);
 PC_2: in std_logic_vector(pc_size - 1 downto 0);
 
 reg_rename_en_1: out std_logic;
 reg_rename_en_2: out std_logic;
 flag_rename_en_1: out std_logic;
 flag_rename_en_2: out std_logic;
 
 --things we need to read
 
 opr1_addr_out_1: out std_logic_vector(reg_pointer_size - 1 downto 0);
 opr1_addr_out_2: out std_logic_vector(reg_pointer_size - 1 downto 0);
 opr2_addr_out_1: out std_logic_vector(reg_pointer_size - 1 downto 0);
 opr2_addr_out_2: out std_logic_vector(reg_pointer_size - 1 downto 0);
 
 dest_addr_out_1: out std_logic_vector(reg_pointer_size - 1 downto 0);
 dest_addr_out_2: out std_logic_vector(reg_pointer_size - 1 downto 0);
 flag_reg_addr_out_1: out std_logic_vector(flag_reg_pointer_size - 1 downto 0);
 flag_reg_addr_out_2: out std_logic_vector(flag_reg_pointer_size - 1 downto 0);
 
 --------------------------------
 
 dest_reg_1: out std_logic_vector(reg_pointer_size - 1 downto 0);--arch reg addr which is renamed
 --dest_flag: out std_logic_vector(3 downto 0);--arch flag reg addr which is renamed
 dest_reg_2: out std_logic_vector(reg_pointer_size - 1 downto 0);
 
 Instr_OUT_1: out std_logic_vector(output_size - 1 downto 0);
 Instr_OUT_2: out std_logic_vector(output_size - 1 downto 0);
 PC_Imm: out std_logic_vector(pc_size - 1 downto 0);
 
 rs_wr_en_1: out std_logic;
 rs_wr_en_2: out std_logic
);
end Decoder;

architecture Behavioral of Decoder is

signal Opcode1: std_logic_vector(opcode_size - 1 downto 0) := "0000";
signal Opcode2: std_logic_vector(opcode_size - 1 downto 0) := "0000"; 
signal Condition1: std_logic_vector(condition_size - 1 downto 0) := "00";
signal Condition2: std_logic_vector(condition_size - 1 downto 0) := "00";
signal speculative_indicator: std_logic := '0';

begin

--Instr_OUT_1 <= x"00000000000000000000000000" & "000";
--Instr_OUT_2 <= x"00000000000000000000000000" & "000";
Opcode1 <= Instruction_Word(31 downto 28);
Opcode2 <= Instruction_Word(15 downto 12);
Condition1 <= Instruction_Word(17 downto 16);
Condition2 <= Instruction_Word(1 downto 0);

Decode_process_1: process(CLOCK)
variable tag_counter: integer:= 0;
begin
 if(rising_edge(CLOCK)) then
 
 Instr_OUT_1(spec) <= speculative_indicator;
 Instr_OUT_1(tag_h downto tag_l) <= std_logic_vector(to_unsigned(tag_counter, 3));
 Instr_OUT_1(pc_h downto pc_l) <= PC_1;
 Instr_OUT_1(opcode_h downto opcode_l) <= Opcode1;
 Instr_OUT_1(cond_h downto cond_l) <= Condition1;
 
 rs_wr_en_1 <= '1'; --we will always write first entry in rs
 if(Opcode1 = "1000" or Opcode1 = "1001" or Opcode1 = "1010" or Opcode1 = "1011") then
	rs_wr_en_2 <= '0'; -- throw away second instr
 else
	rs_wr_en_2 <= '1'; --keep second instr
 end if;
 
 dest_reg_1(2 downto 0) <= Instruction_Word(27 downto 25);
 dest_reg_1(4 downto 3) <= "00";
 Instr_OUT_1(dest_arf_l + 2 downto dest_arf_l) <= Instruction_Word(27 downto 25);
 Instr_OUT_1(dest_arf_h downto dest_arf_h - 1) <= "00";
 
 --ready at end
 reg_rename_en_1 <= '0';
 flag_rename_en_1 <= '0';
 --initializing rename enable to 0
 
 case Opcode1 is
 	when "0001"=>--AD instr
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		opr2_addr_out_1(2 downto 0) <= Instruction_Word(21 downto 19);
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		opr1_addr_out_1(4 downto 3) <= "00";
		opr2_addr_out_1(4 downto 3) <= "00";
		dest_addr_out_1(4 downto 3) <= "00";
		flag_reg_addr_out_1 <= "0000";
		
--		wait for 10ns;
		-- delay needed to get the operand value from reg file
			--for opr1
		if(opr1_in_1(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(74 downto 59) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
			--for opr2
			
		if(opr2_in_1(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(41) <= '0';
			Instr_OUT_1(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(46 downto 42) <= opr2_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(41) <= '1';--make valid1 one
			Instr_OUT_1(57 downto 42) <= opr2_in_1(22 downto 7);--wrote operand value	
		end if;
		
			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;
		
			--for dest
		Instr_OUT_1(21 downto 17) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--for cz
			
		if(Condition1 = "10" or Condition1 = "01") then
			
			if(flag_reg_in_1(5) = '1') then--if CZ is busy
				Instr_OUT_1(38) <= '0';
				Instr_OUT_1(105 downto 102) <= flag_reg_in_1(4 downto 1);
			
			else
				Instr_OUT_1(38) <= '1';
				Instr_OUT_1(40 downto 39) <= flag_reg_in_1(7 downto 6);
			end if;
				
		else
			Instr_OUT_1(38) <= '1';
			
		end if;
		
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '1';
-----------------------------------------------------------------
	
	when "0010"=>--ND Instr
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		opr2_addr_out_1(2 downto 0) <= Instruction_Word(21 downto 19);
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		opr1_addr_out_1(4 downto 3) <= "00";
		opr2_addr_out_1(4 downto 3) <= "00";
		dest_addr_out_1(4 downto 3) <= "00";
		
		flag_reg_addr_out_1 <= "0000";
		
		-- delay needed to get the operand value from reg file
			--for opr1
		if(opr1_in_1(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(74 downto 59) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
			--for opr2
			
		if(opr2_in_1(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(41) <= '0';
			Instr_OUT_1(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(46 downto 42) <= opr2_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(41) <= '1';--make valid1 one
			Instr_OUT_1(57 downto 42) <= opr2_in_1(22 downto 7);--wrote operand value	
		end if;
		
			--for dest
		Instr_OUT_1(21 downto 17) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending
		
			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;

		--for cz
		if(Condition1 = "10" or Condition1 = "01") then
			if(flag_reg_in_1(5) = '1') then--if CZ is busy
				Instr_OUT_1(38) <= '0';
				Instr_OUT_1(105 downto 102) <= flag_reg_in_1(4 downto 1);
			
			else
				Instr_OUT_1(38) <= '1';
				Instr_OUT_1(40 downto 39) <= flag_reg_in_1(7 downto 6);
			end if;
			
		else
			Instr_OUT_1(38) <= '1';
			
		end if;
		
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '1';
----------------------------------------------------------------------

	when "0011"=>--ADI inst
		
		Instr_OUT_1(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_1(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		opr1_addr_out_1(4 downto 3) <= "00";
		dest_addr_out_1(4 downto 3) <= "00";
		
		flag_reg_addr_out_1 <= "0000";
		-- delay needed to get the operand value from reg file
		
			--for opr1
			--busy = 6
		if(opr1_in_1(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(opr1_h downto opr1_l) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
		--for dest
		Instr_OUT_1(dest_h downto dest_l) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;

		--for cz

--		if(flag_reg_in(5) = '1') then--if CZ is busy
--			Instr_OUT_1(valid_cz) <= '0';
--			Instr_OUT_1(cz_rename_h downto cz_rename_l) <= flag_reg_in(4 downto 1);
--			
--		else
		Instr_OUT_1(valid_cz) <= '1';
--			Instr_OUT_1(cz_h downto cz_l) <= flag_reg_in(7 downto 6);
			
		--for Imm6
		--sign extend to 16
		Instr_OUT_1(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(21 downto 16);
		
		for i in input_width  to output_width - 1 loop
			Instr_OUT_1(Imm16_l + i) <= Instruction_Word(16 + input_width - 1);
		end loop;
		
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '1';
		
--------------------------------------------------------------------

	when "0111"=>--LW inst
		
		Instr_OUT_1(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_1(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		opr1_addr_out_1(4 downto 3) <= "00";
		dest_addr_out_1(4 downto 3) <= "00";
		
		flag_reg_addr_out_1 <= "0000";
		-- delay needed to get the operand value from reg file
		
			--for opr1
			--busy = 6
		if(opr1_in_1(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(opr1_h downto opr1_l) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
		
		--for dest
		Instr_OUT_1(dest_h downto dest_l) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;


		--for cz

			Instr_OUT_1(valid_cz) <= '1';
			
		--for Imm6
		--sign extend to 16
		Instr_OUT_1(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(21 downto 16);
		 
		for i in input_width  to output_width - 1 loop
			Instr_OUT_1(Imm16_l + i) <= Instruction_Word(16 + input_width - 1);
		end loop;
		
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '1';
		
-----------------------------------------------------------------

	when "0101"=>--SW Instr
		
		--ra and rb both are operands
		--no destination so no rename !!
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		opr2_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		opr1_addr_out_1(4 downto 3) <= "00";
		opr2_addr_out_1(4 downto 3) <= "00";
		
		
		--for opr1(This is in place of Dest in instr word)
		if(opr1_in_1(busy_arf) = '1') then--If ARF of ra is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(opr1_h downto opr1_l) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
		
		--for opr2(This is in place of opr1 in instr word)
		if(opr2_in_1(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid2) <= '0';
			Instr_OUT_1(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(46 downto 42) <= opr2_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid2) <= '1';--make valid2 one
			Instr_OUT_1(opr2_h downto opr2_l) <= opr2_in_1(22 downto 7);--wrote operand value
		end if;
		
			--dest reading
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= "0000000000011111";--wrote destination value	
		
		--for cz

			Instr_OUT_1(valid_cz) <= '1';
		
		--for Imm6
		--sign extend to 16
		Instr_OUT_1(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(21 downto 16);
		
		for i in input_width  to output_width - 1 loop
			Instr_OUT_1(Imm16_l + i) <= Instruction_Word(16 + input_width - 1);
		end loop;
		
		reg_rename_en_1 <= '0';
		flag_rename_en_1 <= '0';
		
-----------------------------------------------------------------
	when "0000"=>--LHI Instr
				
		Instr_OUT_1(valid1) <= '1'; --we don't have opr1 so making its valid 1
		Instr_OUT_1(74 downto 59) <= "0000000000011111"; --writing dummy value to it
		Instr_OUT_1(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_1(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		dest_addr_out_1(4 downto 3) <= "00";
		
		--for dest
		Instr_OUT_1(dest_h downto dest_l) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;


		--for cz

			Instr_OUT_1(valid_cz) <= '1';
			
		--for Imm9
		--Left shifting to 16 bits
		Instr_OUT_1(Imm16_h  downto Imm16_h - 8) <= Instruction_Word(24 downto 16);
		 
		for i in 22 to 28 loop --need to check
			Instr_OUT_1(i) <= '0';
		end loop;
		
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '0';--LHI doesn't modify flag
		
-------------------------------------------------------------------
	when "1000"=>--BEQ Instr
		speculative_indicator <= '1';
		tag_counter := (tag_counter + 1) mod 7;--handle circular adding		
		--ra is opr1
		--rb is opr2
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		opr2_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		opr1_addr_out_1(4 downto 3) <= "00";
		opr2_addr_out_1(4 downto 3) <= "00";
		
		
		--for opr1(This is in place of Dest in instr word)
		if(opr1_in_1(busy_arf) = '1') then--If ARF of ra is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(opr1_h downto opr1_l) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
		
		--for opr2(This is in place of opr1 in instr word)
		if(opr2_in_1(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid2) <= '0';
			Instr_OUT_1(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(46 downto 42) <= opr2_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid2) <= '1';--make valid2 one
			Instr_OUT_1(opr2_h downto opr2_l) <= opr2_in_1(22 downto 7);--wrote operand value
		end if;
		
			--dest reading
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= "0000000000011111";--wrote destination value	

		--for cz

			Instr_OUT_1(valid_cz) <= '1';
	
		--for Imm6
		--sign extend to 16
		Instr_OUT_1(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(21 downto 16);
		 
		for i in input_width  to output_width - 1 loop
			Instr_OUT_1(Imm16_l + i) <= Instruction_Word(16 + input_width - 1);
		end loop;
		
		reg_rename_en_1 <= '0';--BEQ doesn't have a destination
		flag_rename_en_1 <= '0';--BEQ doesn't modify flag
		
--------------------------------------------------------------------

	when "1001"=>--JAL Instr
	--just do renaming and Imm read
	--no operands to read
		
		Instr_OUT_1(valid1) <= '1'; --we don't have opr1 so making its valid 1
		Instr_OUT_1(74 downto 59) <= "0000000000011111"; --writing dummy value to it
		Instr_OUT_1(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_1(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		dest_addr_out_1(4 downto 3) <= "00";
		
		--for dest
		Instr_OUT_1(dest_h downto dest_l) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;
			
		--for cz
		
			Instr_OUT_1(valid_cz) <= '1';
		
		--for Imm6
		--sign extend to 16
		Instr_OUT_1(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(21 downto 16);
		 
		for i in input_width  to output_width - 1 loop
			Instr_OUT_1(Imm16_l + i) <= Instruction_Word(16 + input_width - 1);
		end loop;
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '0';
		
--------------------------------------------------------------------

	when "1011"=>--JRI Instr
		speculative_indicator <= '1';
		
		Instr_OUT_1(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_1(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		tag_counter := (tag_counter + 1) mod 7;
		--we don't have destination so no rename !!!
		
		--ra is opr1
		
		opr1_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		opr1_addr_out_1(4 downto 3) <= "00";
		
		--for opr1(This is in place of Dest in instr word)
		if(opr1_in_1(busy_arf) = '1') then--If ARF of ra is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(opr1_h downto opr1_l) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
		
			--dest reading
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= "0000000000011111";--wrote destination value	
		
		--for cz

			Instr_OUT_1(valid_cz) <= '1';
		
		--for Imm9
		--sign extend to 16
		Instr_OUT_1(Imm16_l + 8  downto Imm16_l) <= Instruction_Word(24 downto 16);
		
		for i in 9 to 15 loop
			Instr_OUT_1(Imm16_l + i) <= Instruction_Word(24);
		end loop;
		
		reg_rename_en_1 <= '0';--<<-###
		flag_rename_en_1 <= '0';
--------------------------------------------------------------------

	when "1010"=>--JLR Instr
		speculative_indicator <= '1';
		--just do renaming
		--no operand read
		tag_counter := (tag_counter + 1) mod 7;
		
		Instr_OUT_1(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_1(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		dest_addr_out_1(2 downto 0) <= Instruction_Word(27 downto 25);
		
		dest_addr_out_1(4 downto 3) <= "00";
		
		--for dest
		Instr_OUT_1(dest_h downto dest_l) <= free_reg_1;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_1(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_1(dest_valid) <= '0';
			Instr_OUT_1(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(dest_val_l + 4 downto dest_val_l) <= dest_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(dest_valid) <= '1';--make dest valid one
			Instr_OUT_1(dest_val_h downto dest_val_l) <= dest_in_1(22 downto 7);--wrote destination value	
		end if;

		opr1_addr_out_1(2 downto 0) <= Instruction_Word(24 downto 22);
		opr1_addr_out_1(4 downto 3) <= "00";
		
		--regB is my operand1
		
		-- delay needed to get the operand value from reg file
			--for opr1
		if(opr1_in_1(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_1(valid1) <= '0';
			Instr_OUT_1(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_1(63 downto 59) <= opr1_in_1(5 downto 1);--wrote tag value
		else
			Instr_OUT_1(valid1) <= '1';--make valid1 one
			Instr_OUT_1(74 downto 59) <= opr1_in_1(22 downto 7);--wrote operand value
		end if;
		
		
		reg_rename_en_1 <= '1';
		flag_rename_en_1 <= '0';
--------------------------------------------------------------------
		
	when others =>
		
	end case;
--end if;
--end process;
 -- Data to be read out


------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------

--Decode_process_2: process(CLOCK)

--begin
-- if(rising_edge(CLOCK)) then
 
 Instr_OUT_2(spec) <= speculative_indicator;
 Instr_OUT_2(tag_h downto tag_l) <= std_logic_vector(to_unsigned(tag_counter,3));
 Instr_OUT_2(pc_h downto pc_l) <= PC_2;
 Instr_OUT_2(opcode_h downto opcode_l) <= Opcode2;
 Instr_OUT_2(cond_h downto cond_l) <= Condition2;
 
 dest_reg_2(2 downto 0) <= Instruction_Word(11 downto 9);
 dest_reg_2(4 downto 3) <= "00";
 Instr_OUT_2(dest_arf_l + 2 downto dest_arf_l) <= Instruction_Word(27 downto 25);
 Instr_OUT_2(dest_arf_h downto dest_arf_h - 1) <= "00";

 --ready at end
 reg_rename_en_2 <= '0';
 flag_rename_en_2 <= '0';
 --initializing rename enable to 1
 case Opcode2 is
	when "0001"=>--AD instr
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(8 downto 6);
		opr2_addr_out_2(2 downto 0) <= Instruction_Word(5 downto 3);
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		opr1_addr_out_2(4 downto 3) <= "00";
		opr2_addr_out_2(4 downto 3) <= "00";
		dest_addr_out_2(4 downto 3) <= "00";
		
		flag_reg_addr_out_2 <= "0000";
		
		-- delay needed to get the operand value from reg file
			--for opr1
		if(opr1_in_2(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(74 downto 59) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
			--for opr2
			
		if(opr2_in_2(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(41) <= '0';
			Instr_OUT_2(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(46 downto 42) <= opr2_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(41) <= '1';--make valid1 one
			Instr_OUT_2(57 downto 42) <= opr2_in_2(22 downto 7);--wrote operand value	
		end if;
			
			--for dest
		Instr_OUT_2(21 downto 17) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;

			--for cz
			
		if(Condition2 = "10" or Condition2 = "01") then
			
			if(flag_reg_in_2(5) = '1') then--if CZ is busy
				Instr_OUT_2(38) <= '0';
				Instr_OUT_2(105 downto 102) <= flag_reg_in_2(4 downto 1);
			
			else
				Instr_OUT_2(38) <= '1';
				Instr_OUT_2(40 downto 39) <= flag_reg_in_2(7 downto 6);
			end if;
				
		else
			Instr_OUT_2(38) <= '1';
			
		end if;
		
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '1';
-----------------------------------------------------------------
	
	when "0010"=>--ND Instr
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(8 downto 6);
		opr2_addr_out_2(2 downto 0) <= Instruction_Word(5 downto 3);
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		opr1_addr_out_2(4 downto 3) <= "00";
		opr2_addr_out_2(4 downto 3) <= "00";
		dest_addr_out_2(4 downto 3) <= "00";
		
		
		flag_reg_addr_out_2 <= "0000";
		
		-- delay needed to get the operand value from reg file
			--for opr1
		if(opr1_in_2(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(74 downto 59) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
			--for opr2
			
		if(opr2_in_2(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(41) <= '0';
			Instr_OUT_2(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(46 downto 42) <= opr2_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(41) <= '1';--make valid1 one
			Instr_OUT_2(57 downto 42) <= opr2_in_2(22 downto 7);--wrote operand value	
		end if;
		
			--for dest
		Instr_OUT_2(21 downto 17) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;

		--for cz
		if(Condition2 = "10" or Condition2 = "01") then
			if(flag_reg_in_2(5) = '1') then--if CZ is busy
				Instr_OUT_2(38) <= '0';
				Instr_OUT_2(105 downto 102) <= flag_reg_in_2(4 downto 1);
			
			else
				Instr_OUT_2(38) <= '1';
				Instr_OUT_2(40 downto 39) <= flag_reg_in_2(7 downto 6);
			end if;
			
		else
			Instr_OUT_2(38) <= '1';
			
		end if;
		
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '1';
----------------------------------------------------------------------

	when "0011"=>--ADI inst
		
		Instr_OUT_2(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_2(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(8 downto 6);
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		opr1_addr_out_2(4 downto 3) <= "00";
		dest_addr_out_2(4 downto 3) <= "00";
		
		flag_reg_addr_out_2 <= "0000";
		-- delay needed to get the operand value from reg file
		
			--for opr1
			--busy = 6
		if(opr1_in_2(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(opr1_h downto opr1_l) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
		--for dest
		Instr_OUT_2(dest_h downto dest_l) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;

		--for cz

--		if(flag_reg_in(5) = '1') then--if CZ is busy
--			Instr_OUT_1(valid_cz) <= '0';
--			Instr_OUT_1(cz_rename_h downto cz_rename_l) <= flag_reg_in(4 downto 1);
--			
--		else
		Instr_OUT_2(valid_cz) <= '1';
--			Instr_OUT_1(cz_h downto cz_l) <= flag_reg_in(7 downto 6);
			
		--for Imm6
		--sign extend to 16
		Instr_OUT_2(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(5 downto 0);
		
		for i in input_width  to output_width - 1 loop
			Instr_OUT_2(Imm16_l + i) <= Instruction_Word(input_width - 1);
		end loop;
		
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '1';
		
--------------------------------------------------------------------

	when "0111"=>--LW inst
		
		Instr_OUT_2(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_2(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(8 downto 6);
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		opr1_addr_out_2(4 downto 3) <= "00";
		dest_addr_out_2(4 downto 3) <= "00";
		
		flag_reg_addr_out_2 <= "0000";
		-- delay needed to get the operand value from reg file
		
			--for opr1
			--busy = 6
		if(opr1_in_2(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(opr1_h downto opr1_l) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
		
		--for dest
		Instr_OUT_2(dest_h downto dest_l) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;


		--for cz

			Instr_OUT_2(valid_cz) <= '1';
			
		--for Imm6
		--sign extend to 16
		Instr_OUT_2(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(5 downto 0);
		 
		for i in input_width  to output_width - 1 loop
			Instr_OUT_2(Imm16_l + i) <= Instruction_Word(input_width - 1);
		end loop;
		
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '1';
		
-----------------------------------------------------------------

	when "0101"=>--SW Instr
		
		--ra and rb both are operands
		--no destination so no rename !!
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		opr2_addr_out_2(2 downto 0) <= Instruction_Word(8 downto 6);
		
		opr1_addr_out_2(4 downto 3) <= "00";
		opr2_addr_out_2(4 downto 3) <= "00";
		
		--for opr1(This is in place of Dest in instr word)
		if(opr1_in_2(busy_arf) = '1') then--If ARF of ra is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(opr1_h downto opr1_l) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
		
		--for opr2(This is in place of opr1 in instr word)
		if(opr2_in_2(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid2) <= '0';
			Instr_OUT_2(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(46 downto 42) <= opr2_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid2) <= '1';--make valid2 one
			Instr_OUT_2(opr2_h downto opr2_l) <= opr2_in_2(22 downto 7);--wrote operand value
		end if;
		
			--dest reading
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= "0000000000011111";--wrote destination value	
		
		--for cz

			Instr_OUT_2(valid_cz) <= '1';
		
		--for Imm6
		--sign extend to 16
		Instr_OUT_2(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(5 downto 0);
		
		for i in input_width  to output_width - 1 loop
			Instr_OUT_2(Imm16_l + i) <= Instruction_Word(input_width - 1);
		end loop;
		
		reg_rename_en_2 <= '0';
		flag_rename_en_2 <= '0';
		
-----------------------------------------------------------------
	when "0000"=>--LHI Instr
				
		Instr_OUT_2(valid1) <= '1'; --we don't have opr1 so making its valid 1
		Instr_OUT_2(74 downto 59) <= "0000000000011111"; --writing dummy value to it
		Instr_OUT_2(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_2(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		dest_addr_out_2(4 downto 3) <= "00";
		
		--for dest
		Instr_OUT_2(dest_h downto dest_l) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;


		--for cz

			Instr_OUT_2(valid_cz) <= '1';
			
		--for Imm9
		--Left shifting to 16 bits
		Instr_OUT_2(Imm16_h  downto Imm16_h - 8) <= Instruction_Word(8 downto 0);
		 
		for i in 22 to 28 loop --need to check
			Instr_OUT_2(i) <= '0';
		end loop;
		
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '0';--LHI doesn't modify flag
		
-------------------------------------------------------------------
	when "1000"=>--BEQ Instr
		speculative_indicator <= '1';
		tag_counter := (tag_counter + 1) mod 7;--handle circular adding		
		--ra is opr1
		--rb is opr2
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		opr2_addr_out_2(2 downto 0) <= Instruction_Word(8 downto 6);
		opr1_addr_out_2(4 downto 3) <= "00";
		opr2_addr_out_2(4 downto 3) <= "00";
		
		
		--for opr1(This is in place of Dest in instr word)
		if(opr1_in_2(busy_arf) = '1') then--If ARF of ra is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(opr1_h downto opr1_l) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
		
		--for opr2(This is in place of opr1 in instr word)
		if(opr2_in_2(busy_arf) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid2) <= '0';
			Instr_OUT_2(57 downto 47) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(46 downto 42) <= opr2_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid2) <= '1';--make valid2 one
			Instr_OUT_2(opr2_h downto opr2_l) <= opr2_in_2(22 downto 7);--wrote operand value
		end if;
		
			--dest reading
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= "0000000000011111";--wrote destination value	
		
		--for cz

			Instr_OUT_2(valid_cz) <= '1';
	
		--for Imm6
		--sign extend to 16
		Instr_OUT_2(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(5 downto 0);
		 
		for i in input_width  to output_width - 1 loop
			Instr_OUT_2(Imm16_l + i) <= Instruction_Word(input_width - 1);
		end loop;
		
		reg_rename_en_2 <= '0';--BEQ doesn't have a destination
		flag_rename_en_2 <= '0';--BEQ doesn't modify flag
		
--------------------------------------------------------------------

	when "1001"=>--JAL Instr
	--just do renaming and Imm read
	--no operands to read
		
		Instr_OUT_2(valid1) <= '1'; --we don't have opr1 so making its valid 1
		Instr_OUT_2(74 downto 59) <= "0000000000011111"; --writing dummy value to it
		Instr_OUT_2(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_2(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		dest_addr_out_2(4 downto 3) <= "00";
		
		--for dest
		Instr_OUT_2(dest_h downto dest_l) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending

			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;
			
		--for cz
		
			Instr_OUT_2(valid_cz) <= '1';
		
		--for Imm6
		--sign extend to 16
		Instr_OUT_2(Imm16_l + 5  downto Imm16_l) <= Instruction_Word(5 downto 0);
		 
		for i in input_width  to output_width - 1 loop
			Instr_OUT_2(Imm16_l + i) <= Instruction_Word(input_width - 1);
		end loop;
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '0';
		
--------------------------------------------------------------------

	when "1011"=>--JRI Instr
		speculative_indicator <= '1';
		
		Instr_OUT_2(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_2(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		tag_counter := (tag_counter + 1) mod 7;
		--we don't have destination so no rename !!!
		
		--ra is opr1
		
		opr1_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		opr1_addr_out_2(4 downto 3) <= "00";
		
		--for opr1(This is in place of Dest in instr word)
		if(opr1_in_2(busy_arf) = '1') then--If ARF of ra is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(opr1_h downto opr1_l) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
		
			--dest reading
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= "0000000000011111";--wrote destination value	
		
		--for cz

			Instr_OUT_2(valid_cz) <= '1';
		
		--for Imm9
		--sign extend to 16
		Instr_OUT_2(Imm16_l + 8  downto Imm16_l) <= Instruction_Word(8 downto 0);
		
		for i in 9 to 15 loop
			Instr_OUT_2(Imm16_l + i) <= Instruction_Word(24);
		end loop;
		
		reg_rename_en_2 <= '0';--<<-###
		flag_rename_en_2 <= '0';
--------------------------------------------------------------------

	when "1010"=>--JLR Instr
		speculative_indicator <= '1';
	--just do renaming
	--no operand read
		tag_counter := (tag_counter + 1) mod 7;
		
		Instr_OUT_2(valid2) <= '1'; --we don't have opr2 so making its valid 1
		Instr_OUT_2(57 downto 42) <= "0000000000011111"; --writing dummy value to it
		
		dest_addr_out_2(2 downto 0) <= Instruction_Word(11 downto 9);
		
		dest_addr_out_2(4 downto 3) <= "00";
		
		
		--regB is my operand1
		
		-- delay needed to get the operand value from reg file
			--for opr1
		if(opr1_in_2(6) = '1') then--If ARF is busy
			--make its valid1 zero
			Instr_OUT_2(valid1) <= '0';
			Instr_OUT_2(74 downto 64) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(63 downto 59) <= opr1_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(valid1) <= '1';--make valid1 one
			Instr_OUT_2(74 downto 59) <= opr1_in_2(22 downto 7);--wrote operand value
		end if;
		
		--for dest
		Instr_OUT_2(dest_h downto dest_l) <= free_reg_2;
--		Instr_OUT_1(16 downto 1) <= dest value pending
		
			--dest reading
		if(dest_in_2(6) = '1') then--If dest is busy
			--make its valid zero
			Instr_OUT_2(dest_valid) <= '0';
			Instr_OUT_2(dest_val_h downto dest_val_l + 5) <= "00000000000";--added 11 zeros in front
			Instr_OUT_2(dest_val_l + 4 downto dest_val_l) <= dest_in_2(5 downto 1);--wrote tag value
		else
			Instr_OUT_2(dest_valid) <= '1';--make dest valid one
			Instr_OUT_2(dest_val_h downto dest_val_l) <= dest_in_2(22 downto 7);--wrote destination value	
		end if;
		
		reg_rename_en_2 <= '1';
		flag_rename_en_2 <= '0';
--------------------------------------------------------------------
		
	when others =>
		
	end case;
end if;
end process;

--------------------------------------------------------------------
--------------------------------------------------------------------

   
end Behavioral;