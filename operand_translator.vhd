LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;


entity operand_translator is

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
		
		PC1: in std_logic_vector(15 downto 0);
		PC2: in std_logic_vector(15 downto 0);
		
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
end entity operand_translator;

architecture mapping of operand_translator is 
begin
      
translate: process(
opcode1, opcode2, opcode3, opcode4, opcode5, opcode6,
PC1, PC2,opr1_branch1, opr2_branch1, imm_branch1, opr1_branch2, opr2_branch2, imm_branch2, 
opr1_lwsw1, opr2_lwsw1, imm_lwsw1,opr1_lwsw2, opr2_lwsw2, imm_lwsw2,
opr1_alu1, opr2_alu1, imm_alu1,opr1_alu2, opr2_alu2, imm_alu2, 
dest_val1,dest_val2, cz_alu1, cz_alu2  )---put all inputs in the sensitivity list
begin
     case opcode1 is 
	  
	  when "1000" => --BEQ
	    opr1_branch1_out <= opr1_branch1;
	    opr2_branch1_out <= opr2_branch1;
		 imm_branch1_out <= imm_branch1;
	    
	  when "1010" => --JLR
	    opr1_branch1_out <= PC1;
		 opr2_branch1_out <=  opr1_branch1;
     
	  when "1011" =>  -- JRI
	    opr1_branch1_out <= opr1_branch1;
		 opr2_branch1_out <= imm_branch1;
		 
	  when "1001" => --JAL
	    opr1_branch1_out <= PC1;
		 imm_branch1_out <= imm_branch1;
	  when others =>
	  end case;
	  
	  case opcode2 is 
	  
	  when "1000" => --BEQ
	    opr1_branch2_out <= opr1_branch2;
	    opr2_branch2_out <= opr2_branch2;
		 imm_branch2_out <= imm_branch2;
	    
	  when "1010" => --JLR
	    opr1_branch2_out <= PC1;
		 opr2_branch2_out <=  opr1_branch2;
     
	  when "1011" =>  -- JRI
	    opr1_branch2_out <= opr1_branch2;
		 opr2_branch2_out <= imm_branch2;
		 
	  when "1001" => --JAL
	    opr1_branch2_out <= PC2;
		 imm_branch2_out <= imm_branch2;
		 
	  when others =>
	  end case;
	  
	  
	  case opcode3 is 
	  
	  when "0000" =>
	    opr1_lwsw1_out <= imm_lwsw1;
		 
	  when "0111" =>
	    opr1_lwsw1_out <= opr1_lwsw1;
		 opr2_lwsw1_out <= imm_lwsw1;
		 
	  when "0101" =>
	    opr1_lwsw1_out <= opr1_lwsw1;
		 opr2_lwsw1_out <= opr2_lwsw1;
		 
	 when others =>
	    
	 end case;
	 
	 case opcode4 is 
	  
	  when "0000" =>
	    opr1_lwsw2_out <= imm_lwsw2;
		 
	  when "0111" =>
	    opr1_lwsw2_out <= opr1_lwsw2;
		 opr2_lwsw2_out <= imm_lwsw2;
		 
	  when "0101" =>
	    opr1_lwsw2_out <= opr1_lwsw2;
		 opr2_lwsw2_out <= opr2_lwsw2;
		 
	 when others =>
	    
	 end case;
	 
	 case opcode5 is
	   when "0001" =>
		  opr1_alu1_out <= opr1_alu1;
		  opr2_alu1_out <= opr2_alu1;
		
		when "0011" =>
		  opr1_alu1_out <= opr1_alu1;
		  opr2_alu1_out <= imm_alu1;
		
		when "0010" =>
		  opr1_alu1_out <= opr1_alu1;
		  opr2_alu1_out <= opr2_alu1;
		
		when others =>
		end case;
		
	 case opcode6 is
	   when "0001" =>
		  opr1_alu2_out <= opr1_alu2;
		  opr2_alu2_out <= opr2_alu2;
		
		when "0011" =>
		  opr1_alu2_out <= opr1_alu2;
		  opr2_alu2_out <= imm_alu2;
		
		when "0010" =>
		  opr1_alu2_out <= opr1_alu2;
		  opr2_alu2_out <= opr2_alu2;
		
		when others =>
		end case;
      
--	 c_branch1_out <= cz_branch1(1);
--	 z_branch1_out <= cz_branch1(0);
--	 c_branch2_out <= cz_branch2(1);
--	 z_branch2_out <= cz_branch2(0);
--	 
--	 c_lwsw1_out <= cz_lwsw1(1);
--	 z_lwsw1_out <= cz_lwsw1(0);
--	 c_lwsw2_out <= cz_lwsw2(1);
--	 z_lwsw2_out <= cz_lwsw2(0);
	 
	 c_alu1_out <= cz_alu1(1);
	 z_alu1_out <= cz_alu1(0);
	 c_alu2_out <= cz_alu2(1);
	 z_alu2_out <= cz_alu2(0);
	 
	 opcode1_out <= opcode1;  
	 opcode2_out <= opcode2;
	 opcode3_out <= opcode3; 
	 opcode4_out <= opcode4; 
	 opcode5_out <= opcode5 & alu_cond1;  
	 opcode6_out <= opcode6 & alu_cond2; 
	 
	 dest_val1_out <= dest_val1;
	 dest_val2_out <= dest_val1;
	 
	 PC1_out <= PC1_in;
	 PC2_out <= PC2_in; 
	 PC3_out <= PC3_in;
	 PC4_out <= PC4_in;
	 PC5_out <= PC5_in;
	 PC6_out <= PC6_in;
end process;
end architecture mapping;