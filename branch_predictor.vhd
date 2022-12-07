LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY branch_predictor IS

	PORT (
		PC_given, PC_update_rob1 ,PC_update_rob2,  PC_cond_jmp1, PC_cond_jmp2: in std_logic_vector(15 downto 0);
		inst: in std_logic_vector(31 downto 0);
		update_opcode1, update_opcode2 : in std_logic_vector(3 downto 0);
		--IF_M1_OUT, PC_EXE, PC_PRED, PC_RR: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		--clk, reset, RR_EX_valid : IN STD_LOGIC;
		read_en, write_en1, write_en2, predict1, predict2 : in std_logic; -- T,NT -predict=1,0
		clk: in std_logic;
		--match, fush : OUT STD_LOGIC;
		Branch_addr_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		intermediate_addr_out : out std_logic_vector(15 downto 0)
	);

END ENTITY;

ARCHITECTURE arch OF  branch_predictor IS
	--TYPE mult IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	--TYPE mul IS ARRAY (0 TO 7) OF STD_LOGIC;
	--SIGNAL CA, BA : mult := (OTHERS => (OTHERS => '0'));
	--SIGNAL v : mul := (others => '0');
	--SIGNAL u : STD_LOGIC := '0';
	-- 32 entries of LUT
	
	signal branch_addr: std_logic_vector(15 downto 0);
	signal inst1, inst2: std_logic_vector(15 downto 0);
	
	BEGIN
	
	PROCESS (clk)
	variable sign_ext_imm : std_logic_vector(15 downto 0);
	TYPE LUT_type is array (0 to 32) of std_logic_vector(34 downto 0);
	variable LUT: LUT_type := (OTHERS => (OTHERS => '0'));
	variable present: integer := 0; -- present in look up table --not initialized
	variable head : integer := 0; -- present in look up table --not initialized
	
	

	BEGIN
	inst1 <= inst(31 downto 16);
	inst2 <= inst(15 downto 0);
	
	 if(rising_edge(clk)) then
	 branch_addr <= PC_given +1;
		if (read_en = '1') then
		L1 : for i in 0 to 32 loop
			if(LUT(i)(34 downto 19) = PC_given) then
				if(inst1(15 downto 12) = "1000") then --- beq inst
				
					if(LUT(i)(18 downto 17) = "10" or LUT(i)(18 downto 17) = "11") then
						--Branch_addr = pc + immediate ( 6 bit )
						sign_ext_imm(5 downto 0) := inst1(5 downto 0);
						for j in 6 to 15 loop
							sign_ext_imm(j) := inst1(5);
						end loop;
						Branch_addr <= PC_given + sign_ext_imm;
						
					elsif(LUT(i)(18 downto 17) = "00" or LUT(i)(18 downto 17) = "01") then
						Branch_addr <= PC_given + 1;
					end if; 
					
				elsif(inst1(15 downto 12) = "1001") then --- jal inst , immed(9 bit)
					sign_ext_imm(8 downto 0) := inst1(8 downto 0);
						for j in 9 to 15 loop
							sign_ext_imm(j) := inst1(8);
						end loop;
						Branch_addr <= PC_given + sign_ext_imm;
					---Branch_addr <= PC_given + immediate;
					
				elsif(inst1(15 downto 12) = "1010" or inst1(15 downto 12) = "1011") then
					-- conditional jump instruction, predict address, 
					Branch_addr <= LUT(i)(15 downto 0);
				end if;
				present := 1;
				exit;
			end if;
		end loop;
		
			if(inst1(15 downto 12) = "1000" or inst1(15 downto 12) = "1001"                     --making new entry for a instruction
				or inst1(15 downto 12) = "1010" or inst1(15 downto 12) = "1011") then
				if(present = 0) then
					present := 1;
					LUT(head)(34 downto 19) := PC_given;
					LUT(head)(18 downto 17) := "10";
					Branch_addr <= PC_given+1;
					if(head = 31) then
						head := 0;
					else
						head := head + 1;
					end if;
				end if;
			else
				Branch_addr <= PC_given + 1;
			end if;
		end if;	
		if(write_en1 = '1') then                     -- updating smith tag of the resolved branch
			for i in 0 to 32 loop
				if(LUT(i)(34 downto 19) = PC_update_rob1) then

						case LUT(i)(18 downto 17) is
							when "11" => 
								if (predict1 = '0') then
									LUT(i)(18 downto 17) := "10";
								end if;
							when "10" =>
								if(predict1 = '1') then
									LUT(i)(18 downto 17) := "11";
								else
									LUT(i)(18 downto 17) := "00";
								end if;
							when "01" =>
								if(predict1 = '1') then
									LUT(i)(18 downto 17) := "11";
								else
									LUT(i)(18 downto 17) := "00";
								end if;
							when "00" =>
								if (predict1 = '1') then
									LUT(i)(18 downto 17) := "01";
								end if;
							when others =>
							
						end case;
				
				-- write address in for jri and jlr instructions
				if(update_opcode1 = "1010" or update_opcode1 = "1011") then
					LUT(i)(15 downto 0) := PC_cond_jmp1;
				end if;
				end if;
			end loop;
			
			
			if (write_en2 = '1') then                   -- updating smith tag of the resolved branch
			for i in 0 to 32 loop
				if(LUT(i)(34 downto 19) = PC_update_rob2) then

						case LUT(i)(18 downto 17) is
							when "11" => 
								if (predict2 = '0') then
									LUT(i)(18 downto 17) := "10";
								end if;
							when "10" =>
								if(predict2 = '1') then
									LUT(i)(18 downto 17) := "11";
								else
									LUT(i)(18 downto 17) := "00";
								end if;
							when "01" =>
								if(predict2 = '1') then
									LUT(i)(18 downto 17) := "11";
								else
									LUT(i)(18 downto 17) := "00";
								end if;
							when "00" =>
								if (predict2 = '1') then
									LUT(i)(18 downto 17) := "01";
								end if;
							when others =>
							
						end case;
				
				-- write address in for jri and jlr instructions
				if(update_opcode2 = "1010" or update_opcode2 = "1011") then
					LUT(i)(15 downto 0) := PC_cond_jmp2;
				end if;
				end if;
			end loop;
			end if;
		end if;
		
		present :=0;
		intermediate_addr_out <= branch_addr; 
		if(branch_addr = PC_given +1) then 
		  if (read_en = '1') then
		L2 : for i in 0 to 32 loop
			if(LUT(i)(34 downto 19) = PC_given +1) then
				if(inst2(15 downto 12) = "1000") then --- beq inst
				
					if(LUT(i)(18 downto 17) = "10" or LUT(i)(18 downto 17) = "11") then
						--Branch_addr = pc + immediate ( 6 bit )
						sign_ext_imm(5 downto 0) := inst2(5 downto 0);
						for j in 6 to 15 loop
							sign_ext_imm(j) := inst2(5);
						end loop;
						Branch_addr <= PC_given + sign_ext_imm +1;
						
					elsif(LUT(i)(18 downto 17) = "00" or LUT(i)(18 downto 17) = "01") then
						Branch_addr <= PC_given + 1 +1;
					end if; 
					
				elsif(inst2(15 downto 12) = "1001") then --- jal inst , immed(9 bit)
					sign_ext_imm(8 downto 0) := inst2(8 downto 0);
						for j in 9 to 15 loop
							sign_ext_imm(j) := inst2(8);
						end loop;
						Branch_addr <= PC_given + sign_ext_imm+1;
					---Branch_addr <= PC_given + immediate;
					
				elsif(inst2(15 downto 12) = "1010" or inst2(15 downto 12) = "1011") then
					-- conditional jump instruction, predict address, 
					Branch_addr <= LUT(i)(15 downto 0);
				end if;
				present := 1;
				exit;
			end if;
		end loop;
		
			if(inst2(15 downto 12) = "1000" or inst2(15 downto 12) = "1001"                     --making new entry for a instruction
				or inst2(15 downto 12) = "1010" or inst2(15 downto 12) = "1011") then
				if(present = 0) then
					present := 1;
					LUT(head)(34 downto 19) := PC_given+1;
					LUT(head)(18 downto 17) := "10";
					Branch_addr <= PC_given+1 +1;
					if(head = 31) then
						head := 0;
					else
						head := head + 1;
					end if;
				end if;
			else
				Branch_addr <= PC_given + 1 +1;
			end if;
		end if;
		  
		  
		  
		end if;
		branch_addr_out <= branch_addr;
		end if;
		
	END PROCESS;

END ARCHITECTURE;