LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;

entity datapath is
	port(clk: in std_logic;
	 reset: in std_logic
	);
end datapath;

architecture arch of datapath is

signal fetch_enable, flush, reg_rename_en_1,reg_rename_en_2, flag_rename_en_1, flag_rename_en_2,
       rs_wr_en_1, rs_wr_en_2, rf_write_en_1, rf_write_en_2, rf_full, rf_clear,
		 flag_write_en_a, flag_write_en_b, flag_rf_en, flag_rf_clear,flag_register_file, flag_rf_full,
		 ram_wr_en_1, ram_wr_en_2, branch_predictor_read_en, branch_predictor_write_en1,
		 branch_predictor_write_en2, branch_actual_result1, branch_actual_result2, pc_buffer_clear,
		 lwsw1_en, lwsw2_en, branch1_en, branch2_en, alu1_en, alu2_en,
		 alu_out_valid1, alu_out_valid2, branch_out_valid2, branch_out_valid1, ls_out_valid2, ls_out_valid1,
	    rob_full, RS_fetch_stall,reset_rob, rs_clear, unspeculate_en, reset_rob_or_reset	 : std_logic;

-----------------------------------------------------------------------------------------------------------
signal instr_word_1, instr_word_2, rf_data_in1, rf_data_in2, ram_addr_read_1, ram_addr_read_2, 
		 ram_addr_write_1, ram_addr_write_2, ram_data_in_1, ram_data_in_2,
	    pc_branch_predictor, ram_data_out_1, ram_data_out_2,
		 actual_brach_addr1,actual_brach_addr2 : std_logic_vector(15 downto 0);
			
-----------------------------------------------------------------------------------------------------------
signal instr_word_out: std_logic_vector(31 downto 0);

-----------------------------------------------------------------------------------------------------------
signal opr1_in_1, opr1_in_2,opr2_in_1, opr2_in_2, dest_in_1, dest_in_2 :std_logic_vector(22 downto 0);

-----------------------------------------------------------------------------------------------------------		 
signal opr1_branch1, opr2_branch1, opr1_branch2, opr2_branch2,
		 opr1_lwsw1, opr2_lwsw1, opr1_lwsw2, opr2_lwsw2,
		 opr1_alu1, opr2_alu1, opr1_alu2, opr2_alu2, 
		 opr1_branch1_out, opr1_branch2_out, opr2_branch1_out, opr2_branch2_out, 
		 opr1_lwsw1_out, opr1_lwsw2_out, opr2_lwsw1_out, opr2_lwsw2_out, 
		 opr1_alu1_out, opr1_alu2_out, opr2_alu1_out, opr2_alu2_out,
		 lwsw1_result, lwsw2_result, branch1_result, branch2_result,
		 alu1_result, alu2_result,
		 dest_val1, dest_val2, dest_val1_out, dest_val2_out, predicted_addr_1, predicted_addr_2,
		 PC1_in, PC2_in,PC3_in, PC4_in, PC5_in, PC6_in,
		 PC1_out, PC2_out,PC3_out,PC4_out,PC5_out,PC6_out,
		 final_target_1, final_target_2 :std_logic_vector(15 downto 0);

-----------------------------------------------------------------------------------------------------------
signal flag_reg_in_1, flag_reg_in_2 :std_logic_vector(7 downto 0);

-----------------------------------------------------------------------------------------------------------
signal PC_1, PC_2, pc_buffer_out, actual_branch_addr_rob1, actual_branch_addr_rob2,
		 PC_cond_jmp1, PC_cond_jmp2, PC_update_rob1, PC_update_rob2, pc_rs_1,
		 pc_rs_2, imm_branch1, imm_branch2, imm_lwsw1, imm_lwsw2, 
		 imm_alu1, imm_alu2, intermediate_branch_addr, PC1_rob_in, PC2_rob_in, PC3_rob_in, PC4_rob_in ,
		 PC5_rob_in, PC6_rob_in, imm_branch1_out, imm_branch2_out: std_logic_vector(15 downto 0);
			
-----------------------------------------------------------------------------------------------------------
signal opr1_addr_out_1, opr1_addr_out_2,opr2_addr_out_1, opr2_addr_out_2, dest_addr_out_1, dest_addr_out_2,
       dest_reg_1, dest_reg_2, free_reg_1, free_reg_2, dest_ARF1,dest_ARF2, dest_RRF1, dest_rRF2: std_logic_vector(4 downto 0);
		 
-----------------------------------------------------------------------------------------------------------
signal decode_out1, decode_out2 : std_logic_vector(131 downto 0);

-----------------------------------------------------------------------------------------------------------
signal write_addr_a, write_addr_b : std_logic_vector(9 downto 0);

-----------------------------------------------------------------------------------------------------------
signal flag_write_addr_a,flag_write_addr_b, flag_reg_addr_out_1, flag_reg_addr_out_2,free_flag_reg_1,
		 free_flag_reg_2 : std_logic_vector(3 downto 0);
			
-----------------------------------------------------------------------------------------------------------
signal flag_data_in1, flag_data_in2, alu_cond1, alu_cond2 : std_logic_vector(1 downto 0);

-----------------------------------------------------------------------------------------------------------
signal update_opcode1, update_opcode2, opcode1, opcode2, opcode3, opcode4, opcode5, 
		 opcode6,
		 opcode1_out,
		 opcode2_out,
		 opcode3_out,
		 opcode4_out
		 : std_logic_vector(3 downto 0);
		 
-----------------------------------------------------------------------------------------------------------
signal opcode5_out,
		 opcode6_out
		 : std_logic_vector(5 downto 0);
--------------------------------------------------------
signal cz_branch1, cz_branch2, cz_lwsw1, cz_lwsw2, cz_alu1, cz_alu2 :std_logic_vector(1 downto 0);

----------------------------------------------------------
signal unspeculate_tag: std_logic_vector(2 downto 0);
-----------------------------------------------------------
signal c_branch1_result, c_branch2_result, z_branch1_result, z_branch2_result,
		 c_lwsw1_result, c_lwsw2_result, z_lwsw1_result, z_lwsw2_result,
		 c_alu1_result, c_alu2_result, z_alu1_result, z_alu2_result,
		 c_alu1_out, c_alu2_out, z_alu1_out, z_alu2_out :std_logic;
------------------------------------------------------------------------------------
signal ROB_new_entry1, ROB_new_entry2 : std_logic_vector(57 downto 0);

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


		
component Main_register_file is
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
end component Main_register_file;

------------------------------------------------------
component Decoder is
generic(input_width: integer := 6;
		output_width: integer := 16;
		reg_file_op_size: integer := 23;
		flag_reg_op_size: integer := 8;
		reg_pointer_size: integer := 5;
		flag_reg_pointer_size: integer := 4;
		opcode_size: integer := 4;
		condition_size: integer := 2;
		output_size: integer := 132;
		pc_size: integer := 16;
		instr_word_size: integer := 32;
		busy_arf: integer:= 6;

--bit structrue of RS buffer
predicted_addr_h: integer:= 131;
predicted_addr_l: integer:= 116;
dest_flag_rr_h: integer:= 115;
dest_flag_rr_l: integer:= 112;
dest_arf_h: integer:= 111;
dest_arf_l: integer:= 107;
dest_valid: integer:= 106;
cz_rename_h: integer:= 105;
cz_rename_l: integer:= 102;
rs_busy: integer:= 101;
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
 --PC_Imm: out std_logic_vector(pc_size - 1 downto 0);--remaining to assign
 
 rs_wr_en_1: out std_logic;
 rs_wr_en_2: out std_logic;
 predicted_addr1: in std_logic_vector(15 downto 0);
 predicted_addr2: in std_logic_vector(15 downto 0)
);
end component Decoder;
----------------------------------------------

component fetch_buffer is
	
	port(
		clk, ena, clr: in std_logic;
		Din1: in std_logic_vector(15 downto 0);
		Din2: in std_logic_vector(15 downto 0);
		
		Dout: out std_logic_vector(31 downto 0));
end component fetch_buffer;

-----------------------------------------------------

component flag_rf_file is
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
end component flag_rf_file;

-----------------------------------------

component Multiple_port_RAM_VHDL is
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
RAM_DATA_OUT_2: out std_logic_vector(15 downto 0); -- Data output 2 of RAM
reset: in std_logic
);
end component Multiple_port_RAM_VHDL;

----------------------------------------------

component branch_predictor IS

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

END component branch_predictor;

----------------------------------------------

component pc_buffer is
	
	port(
		clk, clr: in std_logic;
		Din1: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0));
end component pc_buffer;

---------------------------------------------

component operand_translator is

generic(
      op_width: integer := 16
);
port(
      opcode1: in std_logic_vector(3 downto 0);
		opcode2: in std_logic_vector(3 downto 0);
		opcode3: in std_logic_vector(3 downto 0);
		opcode4: in std_logic_vector(3 downto 0);
		opcode5: in std_logic_vector(3 downto 0);
		opcode6: in std_logic_vector(3 downto 0);
		
		alu_cond1: in std_logic_vector(1 downto 0);
		alu_cond2: in std_logic_vector(1 downto 0);
		
		PC1_in: in std_logic_vector(15 downto 0);
		PC1_out: out std_logic_vector(15 downto 0);
		
		PC2_in: in std_logic_vector(15 downto 0);
		PC2_out: out std_logic_vector(15 downto 0);
		
		PC3_in: in std_logic_vector(15 downto 0);
		PC3_out: out std_logic_vector(15 downto 0);
		
		PC4_in: in std_logic_vector(15 downto 0);
		PC4_out: out std_logic_vector(15 downto 0);
		
		PC5_in: in std_logic_vector(15 downto 0);
		PC5_out: out std_logic_vector(15 downto 0);
		
		PC6_in: in std_logic_vector(15 downto 0);
		PC6_out: out std_logic_vector(15 downto 0);
		
		PC1: in std_logic_vector(15 downto 0);
		PC2: in std_logic_vector(15 downto 0);
		opr1_branch1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		--cz_branch1 : in std_logic_vector(1 downto 0);
		
		opr1_branch2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		--cz_branch2 : in std_logic_vector(1 downto 0);
		
		
		opr1_lwsw1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_lwsw1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_lwsw2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_lwsw2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		--cz_lwsw2 : in std_logic_vector(1 downto 0);
		--cz_lwsw1 : in std_logic_vector(1 downto 0);
		
		
		opr1_alu1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_alu1 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_alu2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_alu2 : in STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		cz_alu1 : in std_logic_vector(1 downto 0);
		cz_alu2 : in std_logic_vector(1 downto 0);
		
		dest_val1: in std_logic_vector(op_width-1 downto 0);
		dest_val2: in std_logic_vector(op_width-1 downto 0);
		
		dest_val1_out: out std_logic_vector(op_width-1 downto 0);
		dest_val2_out: out std_logic_vector(op_width-1 downto 0);
		
		
	   opr1_branch1_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch1_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch1_out: OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		--c_branch1_out : out std_logic;
		--z_branch1_out : out std_logic;
		
		opr1_branch2_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch2_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch2_out: OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		--c_branch2_out : out std_logic;
		--z_branch2_out : out std_logic;
		
		
		opr1_lwsw1_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw1_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_lwsw2_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw2_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		--c_lwsw1_out : out std_logic;
		--z_lwsw1_out : out std_logic;
		--c_lwsw2_out : out std_logic;
		--z_lwsw2_out : out std_logic;
		
		
		opr1_alu1_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu1_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_alu2_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu2_out : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		c_alu1_out : out std_logic;
		z_alu1_out : out std_logic;
		c_alu2_out : out std_logic;
		z_alu2_out : out std_logic;
		
		opcode1_out: out std_logic_vector(3 downto 0);
		opcode2_out: out std_logic_vector(3 downto 0);
		opcode3_out: out std_logic_vector(3 downto 0);
		opcode4_out: out std_logic_vector(3 downto 0);
		-------------------------------------------
		--with condition bits at end
		opcode5_out: out std_logic_vector(5 downto 0);
		opcode6_out: out std_logic_vector(5 downto 0)
		);
end component operand_translator;

-----------------------------------------------

component alu_LS is 
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 4
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0); 
      opr2: in std_logic_vector(operand_width-1 downto 0);
		PC_in: in std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0);
		
		dest: out std_logic_vector(operand_width-1 downto 0);
		opcode: in std_logic_vector(sel_line-1 downto 0);
		enable, reset: in std_logic;
		C, Z: out std_logic;
		inst_valid: out std_logic
	);
end component alu_LS;

-----------------------------------------------------------------

component alu_Branch_Jump is 
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 4
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0); 
        opr2: in std_logic_vector(operand_width-1 downto 0);
		 imm: in std_logic_vector(operand_width-1 downto 0);
		dest: out std_logic_vector(operand_width-1 downto 0);
		opcode: in std_logic_vector(sel_line-1 downto 0);
		PC_in: in std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0);
		
		enable, reset: in std_logic;
		predicted_address : in std_logic_vector(15 downto 0);
		C, Z: out std_logic;
		actual_branch_addr: out std_logic_vector(15 downto 0);
		inst_valid: out std_logic
	);
end component alu_Branch_Jump;

--------------------------------------------------------------------

component alu is 
	generic(
		operand_width : integer:= 16;
		sel_line: integer:= 6
	);
	port (
		opr1: in std_logic_vector(operand_width-1 downto 0);
		opr2: in std_logic_vector(operand_width-1 downto 0);
		dest: in std_logic_vector(operand_width-1 downto 0);
		PC_in: in std_logic_vector(15 downto 0);
		PC_out: out std_logic_vector(15 downto 0);
		
		output: out std_logic_vector(operand_width-1 downto 0);
		opcode: in std_logic_vector(sel_line-1 downto 0);
		cin, zin: in std_logic;
		enable, reset: in std_logic;
		C, Z: out std_logic;
		inst_valid: out std_logic
	);
end component alu;

---------------------------------------------------------------------

component rs_rob_translator is
port (
input_RS: in std_logic_vector(131 downto 0);
output_ROB: out std_logic_vector(57 downto 0)
);
end component rs_rob_translator;
---------------------------------------------------------------------


component ROB is
	generic( word_width : integer:= 76	);
	port(entry_word_1 : in std_logic_vector(word_width-1 downto 2);
		entry_word_2: in std_logic_vector(word_width-1 downto 2);
		clock: in std_logic;
		PC1: in std_logic_vector(15 downto 0);    -- PCs for incoming instruction from execution unit
		PC2: in std_logic_vector(15 downto 0);
		PC3: in std_logic_vector(15 downto 0);
		PC4: in std_logic_vector(15 downto 0);
		PC5: in std_logic_vector(15 downto 0);
		PC6: in std_logic_vector(15 downto 0);
		dest_ready_val1: in std_logic_vector(15 downto 0);  --dest value of incoming instruction according to opcodce
		dest_ready_val2: in std_logic_vector(15 downto 0);
		dest_ready_val3: in std_logic_vector(15 downto 0);
		dest_ready_val4: in std_logic_vector(15 downto 0);
		dest_ready_val5: in std_logic_vector(15 downto 0);
		dest_ready_val6: in std_logic_vector(15 downto 0);
		dest_ready_en1: in std_logic;								--output of execution unit that the value is ready
		dest_ready_en2: in std_logic;
		dest_ready_en3: in std_logic;
		dest_ready_en4: in std_logic;
		dest_ready_en5: in std_logic;
		dest_ready_en6: in std_logic;
		targ_add5: in std_logic_vector(15 downto 0);        --target address of jump instr from execution unit
		targ_add6: in std_logic_vector(15 downto 0);
		cz_en1, cz_en2, cz_en3, cz_en4: in std_logic;		--cz_rf enable
		cz_data1, cz_data2, cz_data3, cz_data4: in std_logic_vector(1 downto 0);
		cz_write_add1: out std_logic_vector(3 downto 0);
		cz_write_add2: out std_logic_vector(3 downto 0);
		cz_write_en1: out std_logic;
		cz_write_en2: out std_logic;
		cz_write_data1: out std_logic_vector(1 downto 0);
		cz_write_data2: out std_logic_vector(1 downto 0);
		reset: in std_logic;
		entry_write_1: in std_logic;
		entry_write_2: in std_logic;
		mem_add1, mem_add2: out std_logic_vector(15 downto 0); --memory address for load and store
		dest_en1, dest_en2: out std_logic;							  --enabel for write back
		dest_ARF1, dest_ARF2: out std_logic_vector(4 downto 0); --ARF and RRF address
		dest_RRF1, dest_RRF2: out std_logic_vector(4 downto 0);
		dest_val1, dest_val2: out std_logic_vector(15 downto 0);
		mispred_flush: out std_logic;									  --misprediction indicator
		target_address: out std_logic_vector(15 downto 0);      -- target PC for branch Predictor
		current_pc: out std_logic_vector(15 downto 0);          -- Current PC for branch Predictor
		branch_pred_en : out std_logic;                         -- Enable to update 
		branch_instr_opcode: out std_logic_vector(3 downto 0);
		mispred_tag: out std_logic_vector(2 downto 0);
		mispred_tag_en : out std_logic;
		rob_full: out std_logic											  -- rob become full
		
	);
end component;
------------------------------------------------------------------------------------------------
component res_station_updated is
	generic(
		inst_size : integer:= 132;
		op_width: integer:= 16;
		cz_tag_width: integer := 4;
		cz_value: integer := 2;
		
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
		cz_high : integer := 40;
		cz_low : integer := 39;
		cz_val : integer := 38;
		imm_high : integer := 37;
		imm_low : integer := 22;
		cz_tag_high : integer := 105;
		cz_tag_low : integer := 102
		
	);
	PORT (
		inst_word1: in std_logic_vector(inst_size-1 downto 0);
		inst_word2: in std_logic_vector(inst_size-1 downto 0);
		RR_tag1, RR_tag2: in std_logic_vector(4 downto 0);
		RR_value1, RR_value2: in std_logic_vector(op_width-1 downto 0);
		cz_tag1, cz_tag2: in std_logic_vector(cz_tag_width-1 downto 0);
		cz_value1, cz_value2: in std_logic_vector(cz_value-1 downto 0);
		clk : in std_logic;
		wr_en1, wr_en2 : in std_logic;
		
		opr1_branch1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		cz_branch1 : out std_logic_vector(1 downto 0);
		
		opr1_branch2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_branch2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_branch2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		cz_branch2 : out std_logic_vector(1 downto 0);
		
		
		opr1_lwsw1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_lwsw1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		cz_lwsw1 : out std_logic_vector(1 downto 0);
		
		opr1_lwsw2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_lwsw2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_lwsw2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		cz_lwsw2 : out std_logic_vector(1 downto 0);
		
		
		
		opr1_alu1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_alu1 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr1_alu2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		opr2_alu2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		imm_alu2 : OUT STD_LOGIC_VECTOR(op_width-1 DOWNTO 0);
		cz_alu1 : out std_logic_vector(1 downto 0);
		cz_alu2 : out std_logic_vector(1 downto 0);
		clear : in std_logic;
		unspeculate_tag: in std_logic_vector(2 downto 0);
		unspeculate_en: in std_logic;
		
		fetch_stall : out std_logic
	  	
	);

END component;


begin

pr: process(clk, reset)
begin
	if(clk'event and clk = '1') then
		report "PC"& ": " & to_string(pc_buffer_out);
		report "Instr_output"& ": " & to_string(instr_word_out);
		report "Branch Pred Output"& ": " & to_string(pc_branch_predictor);
		report "RS Fetch Enable" & ":" & std_logic'image(RS_fetch_stall);
		report "ROB Full " & ":" & std_logic'image(rob_full);
		report "RF Full" & ":" & std_logic'image(rf_full);
		report "Flag RF Full" & ":" & std_logic'image(flag_rf_full);
		report "Decoder OUT 1"& ": " & to_string(decode_out1);
		
	end if;
end process;

fetch: fetch_buffer port map(clk => clk, ena => fetch_enable,clr => flush, Din1 => instr_word_1, 
        Din2 => instr_word_2, Dout => instr_word_out );
decode: decoder port map(Instruction_Word => instr_word_out,
               clock => clk,
				 	free_reg_1 => free_reg_1,
					free_reg_2 => free_reg_2, 
					free_flag_reg_1 => free_flag_reg_1, 
					free_flag_reg_2 =>free_flag_reg_2, 
					opr1_in_1 => opr1_in_1,
               opr1_in_2 => opr1_in_2, 
					opr2_in_1 => opr2_in_1, 
					opr2_in_2 => opr2_in_2, 
			      dest_in_1 => dest_in_1,
			      dest_in_2 => dest_in_1,
			      flag_reg_in_1 => flag_reg_in_1,
			      flag_reg_in_2 => flag_reg_in_2,
					PC_1 => PC_1,--check in branch predictor file
					PC_2 => PC_2, ------
					reg_rename_en_1 => reg_rename_en_1,
					reg_rename_en_2 => reg_rename_en_2,
					flag_rename_en_1 => flag_rename_en_1,
					flag_rename_en_2 => flag_rename_en_2,
					opr1_addr_out_1 => opr1_addr_out_1,
					opr1_addr_out_2 => opr1_addr_out_2,
					opr2_addr_out_1 => opr2_addr_out_1,
					opr2_addr_out_2 => opr2_addr_out_2,
					dest_addr_out_1 => dest_addr_out_1,
					dest_addr_out_2 => dest_addr_out_2,
					flag_reg_addr_out_1 => flag_reg_addr_out_1,
					flag_reg_addr_out_2 => flag_reg_addr_out_2,
					dest_reg_1 => dest_reg_1,
					dest_reg_2 => dest_reg_2, 
					Instr_OUT_1 => decode_out1,
					Instr_OUT_2 => decode_out2,
					rs_wr_en_1 => rs_wr_en_1,
					rs_wr_en_2 => rs_wr_en_2,
					predicted_addr1 => intermediate_branch_addr,
					predicted_addr2 => pc_branch_predictor);
					
register_file: main_register_file port map(
                read_addr_a =>opr1_addr_out_1,
					 read_addr_b => opr1_addr_out_2,
					 read_addr_c => opr2_addr_out_1,
					 read_addr_d => opr2_addr_out_2,
					 read_addr_e => dest_addr_out_1,
					 read_addr_f => dest_addr_out_2,
					 write_addr_a(9 downto 5) => dest_ARF1,
					 write_addr_a(4 downto 0) => dest_RRF1,              --write_addr_a,
					 write_addr_b(9 downto 5) => dest_ARF2,
					 write_addr_b(4 downto 0) => dest_RRF2,              --write_addr_b,
					 data_in_a => rf_data_in1,
					 data_in_b => rf_data_in2,
					 data_out_a => opr1_in_1,
					 data_out_b => opr1_in_2,
					 data_out_c => opr2_in_1,
					 data_out_d => opr2_in_2,
					 data_out_e => dest_in_1,
					 data_out_f => dest_in_2,
					 write_en_a => rf_write_en_1,
					 write_en_b => rf_write_en_2,
					 full => rf_full,
					 clk => clk,
					 clear => rf_clear,
					 reset => reset,
					 fresh_rr_out_1 => free_reg_1, 
					 fresh_rr_out_2 => free_reg_2,
					 rename_reg_addr_in_1 => dest_reg_1,
					 rename_reg_addr_in_2 => dest_reg_2,
					 reg_rename_en_1 => reg_rename_en_1,
					 reg_rename_en_2 => reg_rename_en_2
					 );
					 
flag_register_file_instance: flag_rf_file port map(
                read_addr_a => flag_reg_addr_out_1,
					 read_addr_b => flag_reg_addr_out_2,
					 write_addr_a => flag_write_addr_a,
					 write_addr_b => flag_write_addr_b,
					 data_in_a => flag_data_in1,
					 data_in_b => flag_data_in2,
					 data_out_a => flag_reg_in_1,
					 data_out_b => flag_reg_in_1,
	             write_en_a => flag_write_en_a,
					 write_en_b => flag_write_en_b,
					 full => flag_rf_full,
					 clk => clk,
					 clear => flag_rf_clear,
					 reset => reset,
					 fresh_rr_out_1 => free_flag_reg_1,
					 fresh_rr_out_2 => free_flag_reg_2,
					 reg_rename_en_a => flag_rename_en_1,
					 reg_rename_en_b => flag_rename_en_2				 
	);
	
memory: Multiple_port_RAM_VHDL port map(
					RAM_ADDR_Read_1 => ram_addr_read_1, 
					RAM_ADDR_Read_2 => ram_addr_read_2,
					RAM_ADDR_Write_1 => ram_addr_write_1,
					RAM_ADDR_Write_2 => ram_addr_write_2,
					RAM_DATA_IN_1 => ram_data_in_1,
					RAM_DATA_IN_2 => ram_data_in_2,
					PC_Instr => pc_buffer_out,
					RAM_WR_1 => ram_wr_en_1,
					RAM_WR_2 => ram_wr_en_2,
					RAM_CLOCK => clk,
					instr_out_1 => instr_word_1,--
					instr_out_2 => instr_word_2,--
					RAM_DATA_OUT_1 => ram_data_out_1,
					RAM_DATA_OUT_2 => ram_data_out_2,
					reset => reset
		);
		
branch_predictor_instance: branch_predictor port map(
					PC_given => pc_buffer_out,
					PC_update_rob1 => PC_update_rob1, 
					PC_update_rob2 => PC_update_rob2,
					update_opcode1 => update_opcode1,
					update_opcode2 => update_opcode2,
					inst(31 downto 16) => instr_word_1,
					inst(15 downto 0) => instr_word_2,
					PC_cond_jmp1 => actual_branch_addr_rob1,
					PC_cond_jmp2 => actual_branch_addr_rob2,
					read_en => branch_predictor_read_en,
					write_en1 => branch_predictor_write_en1,
					write_en2 => branch_predictor_write_en2,
					predict1 => branch_actual_result1,
					predict2 => branch_actual_result2,
					clk => clk,
					Branch_addr_out => pc_branch_predictor,
					intermediate_addr_out => intermediate_branch_addr
		);
branch_predictor_write_en2 <= '0';
		
pc_buffer_instance: pc_buffer port map(
					clk => clk,
					clr => pc_buffer_clear,
					Din1 => pc_branch_predictor,
					Dout => pc_buffer_out
					);
					
operand_translator_instance: operand_translator port map(
					opcode1 => opcode1,
					opcode2 => opcode2,
					opcode3 => opcode3,
					opcode4 => opcode4,
					opcode5 => opcode5,
					opcode6 => opcode6,
					
					alu_cond1 => alu_cond1,
					alu_cond2 => alu_cond2,
					
					PC1 => pc_rs_1,
					PC2 => pc_rs_2,
					opr1_branch1 => opr1_branch1, 
					opr2_branch1 => opr2_branch1,
					imm_branch1 => imm_branch1,
--					cz_branch1 => cz_branch1,
					opr1_branch2 => opr1_branch2,
					opr2_branch2 => opr2_branch2,
					imm_branch2 => imm_branch2,
--					cz_branch2 => cz_branch2,
					opr1_lwsw1 => opr1_lwsw1,
					opr2_lwsw1 => opr2_lwsw1,
					imm_lwsw1 => imm_lwsw1,
					opr1_lwsw2 => opr1_lwsw2,
					opr2_lwsw2 => opr2_lwsw2,
					imm_lwsw2 => imm_lwsw2,
--					cz_lwsw2 => cz_lwsw2, 
--					cz_lwsw1 => cz_lwsw1,  
					opr1_alu1 => opr1_alu1,
					opr2_alu1 => opr2_alu1,
					imm_alu1 => imm_alu1,
					opr1_alu2 => opr1_alu2,
					opr2_alu2 => opr2_alu2,
					imm_alu2 => imm_alu2,
					cz_alu1 => cz_alu1, 
					cz_alu2 => cz_alu2,
					dest_val1 => dest_val1,
					dest_val2 => dest_val2,
				------------------------------------------
					dest_val1_out => dest_val1_out,
					dest_val2_out => dest_val2_out,
					opr1_branch1_out => opr1_branch1_out, 
					opr2_branch1_out => opr2_branch1_out,
					imm_branch1_out => imm_branch1_out,
--					c_branch1_out => c_branch1_out,  
--					z_branch1_out => z_branch1_out,  
					opr1_branch2_out => opr1_branch2_out, 
					opr2_branch2_out => opr2_branch2_out,
					imm_branch2_out => imm_branch2_out,
--					c_branch2_out => c_branch2_out,   
--					z_branch2_out => z_branch2_out,  
					opr1_lwsw1_out => opr1_lwsw1_out, 
					opr2_lwsw1_out => opr2_lwsw1_out,
					opr1_lwsw2_out => opr1_lwsw2_out, 
					opr2_lwsw2_out => opr2_lwsw2_out, 
--					c_lwsw1_out => c_lwsw1_out,    
--					z_lwsw1_out => z_lwsw1_out,	  
--					c_lwsw2_out => c_lwsw2_out,     
--					z_lwsw2_out => z_lwsw2_out,    
					opr1_alu1_out => opr1_alu1_out,   
					opr2_alu1_out => opr2_alu1_out, 
					opr1_alu2_out => opr1_alu2_out,  
					opr2_alu2_out => opr2_alu2_out,  
					c_alu1_out => c_alu1_out,		  
					z_alu1_out => z_alu1_out,		  
					c_alu2_out => c_alu2_out,		  
					z_alu2_out => z_alu2_out,
	
					opcode1_out => opcode1_out,
					opcode2_out => opcode2_out,
					opcode3_out => opcode3_out,
					opcode4_out => opcode4_out,
					opcode5_out => opcode5_out,
					opcode6_out => opcode6_out,
					
					PC1_in => PC1_in,
					PC2_in => PC2_in,
					PC3_in => PC3_in,
					PC4_in => PC4_in,
					PC5_in => PC5_in,
					PC6_in => PC6_in,
					
					PC1_out => PC1_out,
					PC2_out => PC2_out,
					PC3_out => PC3_out,
					PC4_out => PC4_out,
					PC5_out => PC5_out,
					PC6_out => PC6_out
					
					);
					
LS_Ex_unit_instance1: alu_LS port map(
					opr1 => opr1_lwsw1_out,
					opr2 => opr2_lwsw1_out,
					dest => lwsw1_result,
					opcode => opcode3_out,
					enable => lwsw1_en,
					reset => reset,
					C => c_lwsw1_result,
					Z => z_lwsw1_result,
					inst_valid => ls_out_valid1,
					PC_in => PC3_out,
				   PC_out => PC3_rob_in	
					
					);
					
LS_Ex_unit_instance2: alu_LS port map(
					opr1 => opr1_lwsw2_out,
					opr2 => opr2_lwsw2_out,
					dest => lwsw2_result,
					opcode => opcode4_out,
					enable => lwsw2_en,
					reset => reset,
					C => c_lwsw2_result,
					Z => z_lwsw2_result,
					inst_valid => ls_out_valid2,
					PC_in => PC4_out,
				   PC_out => PC4_rob_in	
					
					);
					
Branch_Ex_unit_instance1: alu_Branch_Jump port map(
					opr1 => opr1_branch1_out,
					opr2 => opr2_branch1_out,
					dest => branch1_result,
					imm => imm_branch1_out,
					opcode => opcode1_out,
					enable => branch1_en,
					reset => reset,
					predicted_address => predicted_addr_1,
					C => c_branch1_result,
					Z => z_branch1_result,
					actual_branch_addr => actual_brach_addr1,
				   inst_valid => branch_out_valid1,	
					PC_in => PC1_out,
				   PC_out => PC1_rob_in	
					
					);
					
Branch_Ex_unit_instance2: alu_Branch_Jump port map(
					opr1 => opr1_branch2_out,
					opr2 => opr2_branch2_out,
					dest => branch2_result,
					imm => imm_branch2_out,
					opcode => opcode2_out,
					enable => branch2_en,
					reset => reset,
					predicted_address => predicted_addr_2,
			      C => c_branch2_result,
					Z => z_branch2_result,
					actual_branch_addr => actual_brach_addr2,
				   inst_valid => branch_out_valid2,
				   PC_in => PC2_out,
				   PC_out => PC2_rob_in		
					
					);
					

ADD_Ex_Unit_instance1: alu port map(
					opr1 => opr1_alu1_out,	
					opr2 => opr2_alu1_out,
					dest => dest_val1_out,	
					output => alu1_result,
					opcode => opcode5_out,
					cin => c_alu1_out,
					zin => z_alu1_out,
					enable => alu1_en,
					reset => reset,
					C => c_alu1_result,
					Z => z_alu1_result,
					inst_valid => alu_out_valid1,
					PC_in => PC5_out,
				   PC_out => PC5_rob_in	
					
					);
					
ADD_Ex_Unit_instance2: alu port map(
					opr1 => opr1_alu2_out,	
					opr2 => opr2_alu2_out,
					dest => dest_val2_out,	
					output => alu2_result,
					opcode => opcode6_out,
					cin => c_alu2_out,
					zin => z_alu2_out,
					enable => alu2_en,
					reset => reset,
					C => c_alu2_result,
					Z => z_alu2_result,
					inst_valid => alu_out_valid2,
					PC_in => PC6_out,
				   PC_out => PC6_rob_in	
					
					);
					
rs_rob_translator1: rs_rob_translator port map(
               input_RS => decode_out1,
					output_ROB => ROB_new_entry1
);

rs_rob_translator2: rs_rob_translator port map(
               input_RS => decode_out2,
					output_ROB => ROB_new_entry2
					
);
--alu
--ls
--branch
reset_rob_or_reset <= reset_rob or reset;
re_order_buffer: ROB port map(
               entry_word_1(75 downto 60) => "0000000000000000",
					entry_word_1(59 downto 2) => ROB_new_entry1,
					entry_word_2(75 downto 60) => "0000000000000000",
					entry_word_2(59 downto 2) => ROB_new_entry2,
					clock => clk,
					PC1 => PC5_rob_in,
					PC2 => PC6_rob_in,
					PC3 => PC3_rob_in,
					PC4 => PC4_rob_in,
					PC5 => PC1_rob_in,
					PC6 => PC2_rob_in,
					dest_ready_val5 => branch1_result,
					dest_ready_val6 => branch2_result,
					dest_ready_val3 => lwsw1_result,
					dest_ready_val4 => lwsw2_result,
					dest_ready_val1 => alu1_result,
					dest_ready_val2 => alu2_result,
					dest_ready_en5 => branch_out_valid1,
					dest_ready_en6 => branch_out_valid2,
					dest_ready_en3 => ls_out_valid1,
					dest_ready_en4 => ls_out_valid2,
					dest_ready_en1 => alu_out_valid1,
					dest_ready_en2 => alu_out_valid2,
					targ_add5 => actual_brach_addr1,
					targ_add6 => actual_brach_addr2,
					cz_en1  => alu_out_valid1,
					cz_en2  => alu_out_valid2,
					cz_en3  => ls_out_valid1,
				   cz_en4  => ls_out_valid2,
					cz_data1(1) => c_alu1_result,
					cz_data1(0) => z_alu1_result,  
					cz_data2(1) => c_alu2_result,
					cz_data2(0) => z_alu2_result,
					cz_data3(1) => c_lwsw1_result,
					cz_data3(0) => z_lwsw1_result,
					cz_data4(1) => c_lwsw2_result,
					cz_data4(0) => z_lwsw2_result,
					cz_write_add1 => flag_write_addr_a,
					cz_write_add2 => flag_write_addr_b,
					cz_write_en1 => flag_write_en_a,
					cz_write_en2 => flag_write_en_b,
					cz_write_data1 => flag_data_in1,
					cz_write_data2 => flag_data_in2,
					
					reset => reset_rob_or_reset,
				   entry_write_1 => rs_wr_en_1,
					entry_write_2 =>  rs_wr_en_2,
					mem_add1 => ram_addr_write_1,
					mem_add2 => ram_addr_write_2,
					dest_en1 => rf_write_en_1,
					dest_en2 => rf_write_en_2,
					dest_ARF1 => dest_ARF1,
					dest_ARF2 => dest_ARF2,
					dest_RRF1 => dest_RRF1,
					dest_RRF2 => dest_RRF2,
					dest_val1 => rf_data_in1,
					dest_val2 => rf_data_in2,
					mispred_flush => branch_actual_result1,
					target_address => actual_branch_addr_rob1,
					current_pc => PC_update_rob1,
					branch_pred_en => branch_predictor_write_en1,
					branch_instr_opcode => update_opcode1,
					mispred_tag => unspeculate_tag,
					mispred_tag_en => unspeculate_en,
					rob_full => rob_full
					
);


reservation_station: res_station_updated port map(
               inst_word1 => decode_out1,
					inst_word2 => decode_out2,
					RR_tag1 => dest_RRF1,
					RR_tag2 => dest_RRF2,
					RR_value1 => rf_data_in1,
					RR_value2 => rf_data_in2,
					cz_tag1 => flag_write_addr_a,
					cz_tag2 => flag_write_addr_b,
					cz_value1 => flag_data_in1,
					cz_value2 => flag_data_in2,
					clk => clk, 
					wr_en1 => rs_wr_en_1,
					wr_en2 => rs_wr_en_2,
					
					opr1_branch1 => opr1_branch1,
					opr2_branch1 => opr2_branch1,
					imm_branch1 => imm_branch1,
					cz_branch1 => cz_branch1,
					opr1_branch2 => opr1_branch2,
					opr2_branch2 => opr2_branch2,
					imm_branch2 => imm_branch2,
					cz_branch2 => cz_branch2,
					
					opr1_lwsw1 => opr1_lwsw1,
					opr2_lwsw1 => opr2_lwsw1,
					imm_lwsw1 => imm_lwsw1,
					cz_lwsw1 => cz_lwsw1,
					opr1_lwsw2 => opr1_lwsw2,
					opr2_lwsw2 => opr2_lwsw2,
					imm_lwsw2 => imm_lwsw2,
					cz_lwsw2 => cz_lwsw2,
					
					opr1_alu1 => opr1_alu1,
					opr2_alu1 => opr2_alu1,
					imm_alu1 => imm_alu1,
					cz_alu1 => cz_alu1,
					opr1_alu2 => opr1_alu2,
					opr2_alu2 => opr2_alu2,
					imm_alu2 => imm_alu2,
					cz_alu2 => cz_alu2,
					clear => RS_clear,
					
					unspeculate_tag => unspeculate_tag,
					unspeculate_en => unspeculate_en,
					fetch_stall => RS_fetch_stall


); 

fetch_enable <= not(RS_fetch_stall or rob_full or rf_full or flag_rf_full or reset);
rf_clear <= branch_actual_result1 or reset;
flag_rf_clear <= branch_actual_result1 or reset;
flush <= branch_actual_result1 or reset;
pc_buffer_clear <= branch_actual_result1 or reset;
reset_rob <= branch_actual_result1 or reset;
RS_clear <= branch_actual_result1 or reset;
branch_predictor_read_en <= not(reset);


					
end arch;