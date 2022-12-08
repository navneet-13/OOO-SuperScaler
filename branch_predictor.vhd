LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY branch_predictor IS
	generic(operand_width:integer := 16);
	

	PORT (
		PC_given, PC_update_rob1 ,PC_update_rob2,  PC_cond_jmp1, PC_cond_jmp2: in std_logic_vector(15 downto 0);
		inst: in std_logic_vector(31 downto 0);
		update_opcode1, update_opcode2 : in std_logic_vector(3 downto 0);
		--IF_M1_OUT, PC_EXE, PC_PRED, PC_RR: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		--clk, reset, RR_EX_valid : IN STD_LOGIC;
		read_en, write_en1, write_en2, predict1, predict2 : in std_logic; -- T,NT -predict=1,0
		clk, reset: in std_logic;
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
	function add(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0)) 
	return std_logic_vector is
				variable sum: std_logic_vector(operand_width downto 0);
				variable carry: std_logic_vector(operand_width-1 downto 0);
				variable i : integer;
		begin
				sum(0) := A(0) xor B(0);
				carry(0) := A(0) AND B(0);
				summingBitwise: for i in 1 to operand_width-1 loop
					sum(i) := ( A(i) xor B(i) ) xor carry(i-1);
					carry(i) := (A(i) and B(i) ) or ( B(i) and carry(i-1) ) or ( A(i) and carry(i-1) );
				end loop;
				sum(operand_width) := carry(operand_width-1);
			return sum(15 downto 0);
	end function add;
	
	signal inst1, inst2: std_logic_vector(15 downto 0);
	signal final_branch_add: std_logic_vector( 15 downto 0) := (others => '0');
	
	BEGIN
	
	PROCESS (clk)
	variable sign_ext_imm : std_logic_vector(15 downto 0);
	TYPE LUT_type is array (0 to 32) of std_logic_vector(34 downto 0);
	variable LUT: LUT_type := (OTHERS => (OTHERS => '1'));
	variable present: integer := 0; -- present in look up table --not initialized
	variable head : integer := 0; -- present in look up table --not initialized
	variable branch_addr: std_logic_vector(15 downto 0);
	
	

	BEGIN
	inst1 <= inst(31 downto 16);
	inst2 <= inst(15 downto 0);
	if (reset ='1') then
	LUT := (OTHERS => (OTHERS => '1'));
	final_branch_add <= (others => '0');
	Branch_addr_out <= (others => '0');
	intermediate_addr_out <= (others => '0');
	
	
	elsif(rising_edge(clk)) then
	 present := 0;
	 branch_addr := add(PC_given, x"0001");
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
						Branch_addr := add(PC_given, sign_ext_imm);
						
					elsif(LUT(i)(18 downto 17) = "00" or LUT(i)(18 downto 17) = "01") then
						Branch_addr := add(PC_given, x"0001");
					end if; 
					
				elsif(inst1(15 downto 12) = "1001") then --- jal inst , immed(9 bit)
					sign_ext_imm(8 downto 0) := inst1(8 downto 0);
						for j in 9 to 15 loop
							sign_ext_imm(j) := inst1(8);
						end loop;
						Branch_addr := add(PC_given,sign_ext_imm);
					---Branch_addr <= PC_given + immediate;
					
				elsif(inst1(15 downto 12) = "1010" or inst1(15 downto 12) = "1011") then
					-- conditional jump instruction, predict address, 
					Branch_addr := LUT(i)(15 downto 0);
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
					Branch_addr := add(PC_given, x"0001");
					if(head = 31) then
						head := 0;
					else
						head := head + 1;
					end if;
				end if;
			else
				Branch_addr := add(PC_given, x"0001");
				report "ABCD1";
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
		if(Branch_addr = add(PC_given, x"0001")) then 
		  if (read_en = '1') then
		L2 : for i in 0 to 32 loop
			if(LUT(i)(34 downto 19) = add(PC_given, x"0001")) then
				if(inst2(15 downto 12) = "1000") then --- beq inst
				
					if(LUT(i)(18 downto 17) = "10" or LUT(i)(18 downto 17) = "11") then
						--Branch_addr = pc + immediate ( 6 bit )
						sign_ext_imm(5 downto 0) := inst2(5 downto 0);
						for j in 6 to 15 loop
							sign_ext_imm(j) := inst2(5);
						end loop;
						final_branch_add <= add(add(PC_given, sign_ext_imm),x"0001");
						
					elsif(LUT(i)(18 downto 17) = "00" or LUT(i)(18 downto 17) = "01") then
						final_branch_add <= add(PC_given, x"0002");
					end if; 
					
				elsif(inst2(15 downto 12) = "1001") then --- jal inst , immed(9 bit)
					sign_ext_imm(8 downto 0) := inst2(8 downto 0);
						for j in 9 to 15 loop
							sign_ext_imm(j) := inst2(8);
						end loop;
						final_branch_add <= add(add(PC_given, sign_ext_imm), x"0001");
					---Branch_addr <= PC_given + immediate;
					
				elsif(inst2(15 downto 12) = "1010" or inst2(15 downto 12) = "1011") then
					-- conditional jump instruction, predict address, 
					final_branch_add <= LUT(i)(15 downto 0);
				end if;
				present := 1;
				exit;
			end if;
		end loop;
		
			if(inst2(15 downto 12) = "1000" or inst2(15 downto 12) = "1001"                     --making new entry for a instruction
				or inst2(15 downto 12) = "1010" or inst2(15 downto 12) = "1011") then
				if(present = 0) then
					present := 1;
					LUT(head)(34 downto 19) := add(PC_given, x"0001");
					LUT(head)(18 downto 17) := "10";
					final_branch_add <= add(PC_given, x"0002");
					if(head = 31) then
						head := 0;
					else
						head := head + 1;
					end if;
				end if;
			else
				final_branch_add <= add(PC_given, x"0002");
				report "ABCD2";
			end if;
		end if;
		  
		  
		  
		end if;
		branch_addr_out <= final_branch_add;
		end if;
		
	END PROCESS;

END ARCHITECTURE;