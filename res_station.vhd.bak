LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY res_station IS
	generic(
		inst_size : integer:= 106;
		op_width: integer:= 16;
		CZ_tag_width: integer := 4;
		CZ_value: integer := 2;
		
		RS_size: integer := 50;
		ready: integer := 0;
		busy : integer := 101;
		opr1_high : integer := 74;
		opr1_low : integer := 59;
		opr1_val : integer := 58;
		opr2_high : integer := 57;
		opr2_low : integer := 42;
		opr2_val : integer := 41;
		dest_high : integer := 16;
		dest_low : integer := 1;
		dest_val : integer := 106;
		dest_tag_high : integer := 21;
		dest_tag_low : integer := 17;
		spec_tag_high : integer := 99;
		spec_tag_low : integer := 97;
		spec_val : integer := 100;
		opcode_high : integer := 80;
		opcode_low : integer := 77;
		condn_high : integer := 76;
		condn_low : integer := 75;
		PC_high : integer := 96;
		PC_low : integer := 81;
		CZ_high : integer := 40;
		CZ_low : integer := 39;
		CZ_val : integer := 38;
		imm_high : integer := 37;
		imm_low : integer := 22;
		CZ_tag_high : integer := 105;
		CZ_tag_low : integer := 102
		
	);
	PORT (
		inst_word1: in std_logic_vector(inst_size-1 downto 0);
		inst_word2: in std_logic_vector(inst_size-1 downto 0);
		RR_tag1, RR_tag2: in std_logic_vector(op_width-1 downto 0);
		RR_value1, RR_value2: in std_logic_vector(op_width-1 downto 0);
		CZ_tag1, CZ_tag2: in std_logic_vector(CZ_tag_width-1 downto 0);
		CZ_value1, CZ_value2: in std_logic_vector(CZ_value-1 downto 0);
		
		opr1_branch1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_branch2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		
		opr1_lwsw1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_lwsw1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_lwsw2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_lwsw2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		
		opr1_alu1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_alu1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_alu2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_alu2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		
		fetch_stall : out std_logic	
	);

END ENTITY

ARCHITECTURE arch OF LUT IS
	TYPE RS_type is array (0 to RS_size-1) of std_logic_vector(inst_size-1 downto 0);
	variable RS: LUT_type := (OTHERS => (OTHERS => '0'));
	variable RS_full : integer := 0; -- 
	variable sent_branch, sent_lwsw, sent_alu : integer := 0 -- max inst that we can send in branch pipelines
	
BEGIN
	
	PROCESS (fetch_stall)
	BEGIN
		if(RS_full = 1) then
			L1: for i in 0 to RS_size-2 loop
				if(RS(i)(busy) = '0') then
					RS(i)(busy) := '1';
					RS(i) := inst_word1;
					RS_full := 0;
					exit L1;
				end if;
				RS_full := 1;
			end loop;
		end if;
		
		if(RS_full = 1) then
			fetch_stall <= '1';
			RS(RS_size-1) := inst_word2; 
		end if;
		
		if(RS_full = 1) then
			L2: for i in 0 to RS_size-1 loop
				if(RS(i)(busy) = '0') then
					RS(i)(busy) := '1';
					RS(i) := inst_word2;
					RS_full := 0;
					exit L2;
				end if;
				RS_full := 1;
			end loop;
		end if;
		if(RS_full = 1) then
			fetch_stall <= '1';
		end if;
	END PROCESS;
	
	PROCESS(opr1_branch1, opr2_branch1, imm_branch1, CZ_branch1, opr1_branch2,
	opr2_branch2, imm_branch2, CZ_branch2,
	opr1_lwsw1, opr2_lwsw1, imm_lwsw1, CZ_lwsw1, opr1_lwsw2, opr2_lwsw2, 
	imm_lwsw2, CZ_lwsw2,
	opr1_alu1, opr2_alu1, imm_alu1, CZ_alu1, opr1_alu2, opr2_alu2, imm_alu2, CZ_alu2)
	BEGIN
		L3: for i in 0 to RS_size-1 loop
			if(RS(i)(ready) = '1') then
				RS(i)(busy) := '0';
				RS(i)(ready) := '0';
				if(RS(i)(opcode_high to opcode_low) = "1000" or
				RS(i)(opcode_high to opcode_low) = "1001" or 
				RS(i)(opcode_high to opcode_low) = "1010" or 
				RS(i)(opcode_high to opcode_low) = "1011") then
					if(sent_branch = 0) then
							opr1_branch1 <= RS(i)(opr1_high to opr1_low);
							opr2_branch1 <= RS(i)(opr2_high to opr2_low);
							imm_branch1 <= RS(i)(imm_high to imm_low);
							CZ_branch1 <= RS(i)(CZ_high to CZ_low);
					end if;
					if(sent_branch = 1) then
							opr1_branch2 <= RS(i)(opr1_high to opr1_low);
							opr2_branch2 <= RS(i)(opr2_high to opr2_low);
							imm_branch2 <= RS(i)(imm_high to imm_low);
							CZ_branch2 <= RS(i)(CZ_high to CZ_low);
					end if;
					sent_branch := sent_branch+1;
					
				elsif(RS(i)(opcode_high to opcode_low) = "0111" or
				RS(i)(opcode_high to opcode_low) = "0000" or 
				RS(i)(opcode_high to opcode_low) = "0101") then
					if(sent_lwsw = 0) then
							opr1_lwsw1 <= RS(i)(opr1_high to opr1_low);
							opr2_lwsw1 <= RS(i)(opr2_high to opr2_low);
							imm_lwsw1 <= RS(i)(imm_high to imm_low);
							CZ_lwsw1 <= RS(i)(CZ_high to CZ_low);
					end if;
					if(sent_lwsw = 1) then
							opr1_lwsw2 <= RS(i)(opr1_high to opr1_low);
							opr2_lwsw2 <= RS(i)(opr2_high to opr2_low);
							imm_lwsw2 <= RS(i)(imm_high to imm_low);
							CZ_branch2 <= RS(i)(CZ_high to CZ_low);
					end if;
					sent_lwsw := sent_lwsw+1;
				end if;
				
				else
					if(sent_alu = 0) then
							opr1_alu1 <= RS(i)(opr1_high to opr1_low);
							opr2_alu1 <= RS(i)(opr2_high to opr2_low);
							imm_alu1 <= RS(i)(imm_high to imm_low);
							CZ_alu1 <= RS(i)(CZ_high to CZ_low);
					end if;
					if(sent_alu = 1) then
							opr1_alu2 <= RS(i)(opr1_high to opr1_low);
							opr2_alu2 <= RS(i)(opr2_high to opr2_low);
							imm_alu2 <= RS(i)(imm_high to imm_low);
							CZ_alu2 <= RS(i)(CZ_high to CZ_low);
					end if;
					sent_alu := sent_alu+1;
				end if;
				
			end if;
			if(sent_branch = 2 and sent_lwsw = 2 and sent_alu) then
				exit L3;
			end if;
		end loop;
		sent_branch := 0;
		sent_lwsw := 0;
		sent_alu := 0;		
	END PROCESS;
	
	PROCESS()
	BEGIN
	--if opr1 is tag "11 0s + tag" = 16 bit
		L4: for i in 0 to RS_size-1 then
			if(RS(i)(busy) = '1') then
				if(RS(i)(opr1_high-11 downto opr1_low) = RR_tag1 and RS(i)(opr1_val = '0') then
					RS(opr1_high downto opr1_low) := RR_value1;
					RS(i)(opr1_val) = '1';
				end if;
				if(RS(i)(opr2_high-11 downto opr2_low) = RR_tag1 and RS(i)(opr2_val = '0') then
					RS(opr2_high downto opr2_low) := RR_value1;
					RS(i)(opr2_val) = '1';
				end if;
				if(RS(i)(dest_high-11 downto dest_low) = RR_tag1 and RS(i)(dest_val = '0') then
					RS(dest_high downto dest_low) := RR_value1;
					RS(i)(dest_val) = '1';
				end if;
				if(RS(i)(CZ_tag_high downto CZ_tag_low) = CZ_tag1 and RS(i)(dest_val = '0') then
					RS(CZ_high downto CZ_low) := CZ_value1;
					RS(i)(CZ_val) = '1';
				end if;
				
				if(RS(i)(opr1_high-11 downto opr1_low) = RR_tag2 and RS(i)(opr1_val = '0') then
					RS(opr1_high downto opr1_low) := RR_value2;
					RS(i)(opr1_val) = '1';
				end if;
				if(RS(i)(opr2_high-11 downto opr2_low) = RR_tag2 and RS(i)(opr2_val = '0') then
					RS(opr2_high downto opr2_low) := RR_value2;
					RS(i)(opr2_val) = '1';
				end if;
				if(RS(i)(dest_high-11 downto dest_low) = RR_tag2 and RS(i)(dest_val = '0') then
					RS(dest_high downto dest_low) := RR_value2;
					RS(i)(dest_val) = '1';
				end if;
				if(RS(i)(CZ_tag_high downto CZ_tag_low) = CZ_tag2 and RS(i)(dest_val = '0') then
					RS(CZ_high downto CZ_low) := CZ_value2;
					RS(i)(CZ_val) = '1';
				end if;
				
				if((RS(i)(condn_high downto condn_low) = "10" or 
				RS(i)(condn_high downto condn_low) = "01") and 
				(RS(i)(opcode_high downto opcode_low) = "0001" or
				RS(i)(opcode_high downto opcode_low) = "0010")) then
				--- for addc, addz, ndc, ndz 
					if(RS(i)(CZ_val) = 1) then
					--- carry flag = 0, dont wait for opr1 and opr2 to become valid
						if((RS(i)(condn_high) and RS(i)(CZ_high)) or 
						(RS(i)(condn_low) and RS(i)(CZ_low)) = '0') then
							RS(i)(ready) := RS(i)(dest_val);
						else
							RS(i)(ready) := RS(i)(opr1_val) and RS(i)(opr2_val);
						end if;
					end if;
				else
					RS(i)(ready) := RS(i)(opr1_val) and RS(i)(opr2_val);
				end if;
			end if;
		end loop;
	END PROCESS;
	
END ARCHITECTURE;