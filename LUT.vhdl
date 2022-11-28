LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE ieee.std_logic_1164.ALL;
ENTITY LUT IS

	PORT (
		IF_M1_OUT, PC_EXE, PC_PRED, PC_RR: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk, reset, RR_EX_valid : IN STD_LOGIC;
		match, fush : OUT STD_LOGIC;
		Branch_addr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);

END ENTITY;
ARCHITECTURE arch OF LUT IS
	TYPE mult IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	TYPE mul IS ARRAY (0 TO 7) OF STD_LOGIC;
	SIGNAL CA, BA : mult := (OTHERS => (OTHERS => '0'));
	SIGNAL v : mul := (others => '0');
	SIGNAL u : STD_LOGIC := '0';
BEGIN

	PROCESS (clk, IF_M1_OUT, PC_EXE, PC_PRED, PC_RR, reset,RR_EX_valid)
	BEGIN
		IF PC_PRED = PC_RR THEN
			match <= '0';
			Branch_addr <= (OTHERS => '0');
			fush <= '0';
			FOR i IN 0 TO 7 LOOP
				IF v(i) = '1' THEN
					IF CA(i) = IF_M1_OUT THEN
						Branch_addr <= BA(i);
						match <= '0';--------------------------------1 changed to 0---------------------------
						fush <= '0';
					END IF;
				END IF;
			END LOOP;
		elsif RR_EX_valid = '1' then
			match <= '0';
			fush <= '0'; -----------------------------------1 changed to 0---------------------------
			Branch_addr <= (OTHERS => '0');
			FOR i IN 0 TO 7 LOOP
				IF v(i) = '1' THEN
					IF CA(i) = PC_EXE THEN
						BA(i) <= PC_PRED;
					END IF;
				END IF;
			END LOOP;
			FOR i IN 0 TO 7 LOOP
				IF v(i) = '0' THEN
					CA(i) <= PC_EXE;
					BA(i) <= PC_PRED;
					v(i) <= '1';
					EXIT;
				END IF;
			END LOOP;
			Else 
			fush<='0';
			match<='0';
			Branch_addr<=(others=>'0');
			     
		END IF;
		IF reset = '1' then 
			v <= (others =>  '0');
		END IF;
	END PROCESS;

END ARCHITECTURE;