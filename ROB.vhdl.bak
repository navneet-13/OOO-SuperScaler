library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity ROB is
	generic( word_width : integer:= 60	);
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
		cz_en1, cz_en2, cz_en3, cz_en4: in std_logic;		--cz_rf enable
		cz_data1, cz_data2, cz_data3, cz_data4: in std_logic_vector(1 downto 0);
		cz_write_add1: out std_logic_vector(3 downto 0);
		cz_write_add2: out std_logic_vector(3 downto 0);
		cz_write_en1: out std_logic;
		cz_write_en2: out std_logic;
		cz_write_data1: out std_logic_vector(1 downto 0);
		cz_write_data2: out std_logic_vector(1 downto 0);
		write_en, reset: in std_logic;
		entry_write_1: in std_logic;
		entry_write_2: in std_logic;
		mem_add1, mem_add2: out std_logic_vector(15 downto 0); --memory address for load and store
		dest_en1, dest_en2: out std_logic;							  --enabel for write back
		dest_ARF1, dest_ARF2: out std_logic_vector(4 downto 0); --ARF and RRF address
		dest_RRF1, dest_RRF2: out std_logic_vector(4 downto 0);
		dest_val1, dest_val2: out std_logic_vector(15 downto 0);
		mispred_flush: out std_logic;										--misprediction indicator
		rob_full: out std_logic												--rob become full
	);
end entity;
	
architecture beh of ROB is
TYPE entry IS ARRAY(0 TO 50) OF std_logic_vector(word_width-1 DOWNTO 0);
SIGNAL rob_entry : entry := (others=> (others => '0'));
SIGNAL which_en, which_dest, which_load, which_store: std_logic_vector(1 downto 0);
SIGNAL branch_flush: std_logic;
begin	
		mispred_flush <= branch_flush;
		main: process(reset, clock)
		variable head_pointer: integer := 0;
		variable tail_pointer: integer := 0;
		variable full: std_logic := '1';
		variable no_instr: integer := 0;
		begin
		
		no_instr := 0;
		
		loop_fill: for i in 0 to 50 loop
			full := full and rob_entry(i)(0);
		end loop;
		if reset = '1' then
			rob_entry <= (others=> (others=> '0'));
			head_pointer := 0;
			tail_pointer := 0;
			branch_flush <='0';
			
		elsif (clock'event AND clock = '1') then
			branch_flush <='0';
			which_en <= "00";
			which_dest <= "00";
			which_load  <= "00";
			which_store <= "00";
			if write_en = '1' then
				if tail_pointer = 50 then
					tail_pointer := 0;
					if(full = '1') then
						rob_full<= '1';
					else
						rob_full <= '0';
					end if;
				end if;
				
				if (entry_write_1 = '1') then
					rob_entry(tail_pointer)(word_width - 1 downto 2) <= entry_word_1;
					rob_entry(tail_pointer)(0) <= '1';
					tail_pointer := tail_pointer + 1;
				end if;
				
				if (entry_write_2 = '1') then
					rob_entry(tail_pointer+1)(word_width - 1 downto 2) <= entry_word_2;
					rob_entry(tail_pointer+1)(0) <= '1';
					tail_pointer := tail_pointer + 1;
				end if;
					
--				loop_ready: for i in 0 to 50 loop
--					case 
--					rob_entry(i)(1) <=  r0b_entry(i)(13) and rob_entry(i)(8) and not(rob_entry(i)(43));
				loop1: for i in 0 to 50 loop
					if (i >head_pointer-1 and i<tail_pointer+1) then
						if (rob_entry(i) = PC1) then
							if (rob_entry(i)(9) = '0') then
								rob_entry(i)(word_width - 35 downto word_width - 50) <= dest_ready_val1;
								rob_entry(i)(9) <= dest_ready_en1;
								rob_entry(i)(4 downto 3) <= cz_data1;
								rob_entry(i)(2) <= cz_en1;
							end if;
							
							
						elsif (rob_entry(i) = PC2) then
							if (rob_entry(i)(9) = '0') then
								rob_entry(i)(word_width - 35 downto word_width - 50) <= dest_ready_val2;
								rob_entry(i)(9) <= dest_ready_en2;
								rob_entry(i)(4 downto 3) <= cz_data2;
								rob_entry(i)(2) <= cz_en2;
							end if;
							
						elsif (rob_entry(i) = PC3) then
							if (rob_entry(i)(9) = '0') then
								rob_entry(i)(word_width - 35 downto word_width - 50) <= dest_ready_val3;
								rob_entry(i)(9) <= dest_ready_en3;
								rob_entry(i)(4 downto 3) <= cz_data3;
								rob_entry(i)(2) <= cz_en3;
							end if;

						elsif (rob_entry(i) = PC4) then
							if (rob_entry(i)(9) = '0') then
								rob_entry(i)(word_width - 35 downto word_width - 50) <= dest_ready_val4;
								rob_entry(i)(9) <= dest_ready_en4;
								rob_entry(i)(4 downto 3) <= cz_data4;
								rob_entry(i)(2) <= cz_en4;
							end if;
							
						elsif (rob_entry(i) = PC5) then
							if (rob_entry(i)(9) = '0') then
								rob_entry(i)(word_width - 35 downto word_width - 50) <= dest_ready_val5;
								rob_entry(i)(9) <= dest_ready_en5;
							end if;
							
						elsif (rob_entry(i) = PC6) then
							if (rob_entry(i)(9) = '0') then
								rob_entry(i)(word_width - 35 downto word_width - 50) <= dest_ready_val6;
								rob_entry(i)(9) <= dest_ready_en6;
							end if;
							
						end if;
						
						case rob_entry(i)(word_width - 17 downto word_width - 20) is 
							when "0001" | "0010" => 
								rob_entry(i)(1) <=  rob_entry(i)(9) and rob_entry(i)(2) and not(rob_entry(i)(39));
								no_instr := no_instr + 1;
								if (rob_entry(i)(1) = '1') then
									if (no_instr <3) then
										if (i = head_pointer) then
											head_pointer := head_pointer + 1;
											rob_entry(i)(0) <= '0';
											if (which_dest = "00") then
												dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												dest_val1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en1 <= '1';
												which_dest <= "01";
											elsif (which_dest = "01") then
												dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												dest_val2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en2 <= '1';
												which_dest <= "10";
											end if;
											
											if which_en = "00" then
												cz_write_add1 <= rob_entry(i)(8 downto 5);
												cz_write_data1 <= rob_entry(i)(4 downto 3);
												cz_write_en1<='1';
												which_en <= "01";
											elsif which_en = "01" then
												cz_write_add2 <= rob_entry(i)(8 downto 5);
												cz_write_data2 <= rob_entry(i)(4 downto 3);
												cz_write_en2<='1';
												which_en <= "10";
											end if;
											
										end if;
									end if;
								else
									case which_dest is
										when "00" => 
											dest_en1 <= '0';
											dest_en2 <= '0';
										when "01" => 
											dest_en2 <= '0';
										when others =>
											
									end case;
									
									case which_en is
										when "00" => 
											cz_write_en1 <= '0';
											cz_write_en2 <= '0';
										when "01" => 
											cz_write_en2 <= '0';
										when others =>
									end case;
											
								end if;
								
								
							when "0011" =>
								rob_entry(i)(1) <=  rob_entry(i)(9) and not(rob_entry(i)(39));
								no_instr := no_instr + 1;
								if (rob_entry(i)(1) = '1') then
									if (no_instr <3) then
										if (i = head_pointer) then
											head_pointer := head_pointer + 1;
											rob_entry(i)(0) <= '0';
											if (which_dest = "00") then
												dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												dest_val1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en1 <= '1';
												which_dest <= "01";
											elsif (which_dest = "01") then
												dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												dest_val2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en2 <= '1';
												which_dest <= "10";
											end if;
											
											if which_en = "00" then
												cz_write_add1 <= rob_entry(i)(8 downto 5);
												cz_write_data1 <= rob_entry(i)(4 downto 3);
												cz_write_en1<='1';
												which_en <= "01";
											elsif which_en = "01" then
												cz_write_add2 <= rob_entry(i)(8 downto 5);
												cz_write_data2 <= rob_entry(i)(4 downto 3);
												cz_write_en2<='1';
												which_en <= "10";
											end if;
										end if;
									end if;
									
								else
									case which_dest is
										when "00" => 
											dest_en1 <= '0';
											dest_en2 <= '0';
										when "01" => 
											dest_en2 <= '0';
										when others =>
											
									end case;
									
									case which_en is
										when "00" => 
											cz_write_en1 <= '0';
											cz_write_en2 <= '0';
										when "01" => 
											cz_write_en2 <= '0';
										when others =>
									end case;
								
								end if;
								
							when "0000" =>
								rob_entry(i)(1) <=  rob_entry(i)(9) and not(rob_entry(i)(39));
								no_instr := no_instr + 1;
								if (rob_entry(i)(1) = '1') then
									if (no_instr <3) then
										head_pointer :=  head_pointer + 1;
										rob_entry(i)(0) <= '0';
										if (which_dest = "00") then
											dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
											dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
											dest_val1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
											dest_en1 <= '1';
											which_dest <= "01";
										elsif (which_dest = "01") then
											dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
											dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
											dest_val2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
											dest_en2 <= '1';
											which_dest <= "10";
										end if;
										
										if which_en = "00" then
											cz_write_add1 <= rob_entry(i)(8 downto 5);
											cz_write_data1 <= rob_entry(i)(4 downto 3);
											cz_write_en1<='1';
											which_en <= "01";
										elsif which_en = "01" then
											cz_write_add2 <= rob_entry(i)(8 downto 5);
											cz_write_data2 <= rob_entry(i)(4 downto 3);
											cz_write_en2<='1';
											which_en <= "10";
										end if;
									end if;
									
								else
									case which_dest is
										when "00" => 
											dest_en1 <= '0';
											dest_en2 <= '0';
										when "01" => 
											dest_en2 <= '0';
										when others =>
											
									end case;
									
									case which_en is
										when "00" => 
											cz_write_en1 <= '0';
											cz_write_en2 <= '0';
										when "01" => 
											cz_write_en2 <= '0';
										when others =>
									end case;
									
								end if;
							
							when "0111" => 
								rob_entry(i)(1) <=  rob_entry(i)(9) and rob_entry(i)(2) and not(rob_entry(i)(39));
								no_instr := no_instr + 1;
								if (rob_entry(i)(1) = '1') then
									if(no_instr < 3) then
										if (which_store = "00") then
											head_pointer :=  head_pointer + 1;
											rob_entry(i)(0) <= '0';
											if (which_dest = "00") then
												dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												mem_add1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en1 <= '1';
												which_dest <= "01";
											elsif (which_dest = "01") then
												dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												mem_add2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en2 <= '1';
												which_dest <= "10";
											end if;
											
											if which_en = "00" then
												cz_write_add1 <= rob_entry(i)(8 downto 5);
												cz_write_data1 <= rob_entry(i)(4 downto 3);
												cz_write_en1<='1';
												which_en <= "01";
											elsif which_en = "01" then
												cz_write_add2 <= rob_entry(i)(8 downto 5);
												cz_write_data2 <= rob_entry(i)(4 downto 3);
												cz_write_en2<='1';
												which_en <= "10";
											end if;
											which_load <= "01";
										
										elsif(which_store = "01") then
											if (i>0) then
												if(rob_entry(i)(word_width - 35 downto word_width - 50) = rob_entry(i-1)(word_width - 35 downto word_width - 50)) then
											 	case which_dest is
													when "00" => 
														dest_en1 <= '0';
														dest_en2 <= '0';
													when "01" => 
														dest_en2 <= '0';
													when others =>
														
												end case;
												
												case which_en is
													when "00" => 
														cz_write_en1 <= '0';
														cz_write_en2 <= '0';
													when "01" => 
														cz_write_en2 <= '0';
													when others =>
												end case;
												which_store<= "01";
											else
												head_pointer :=  head_pointer + 1;
												rob_entry(i)(0) <= '0';
												if (which_dest = "00") then
													dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
													dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
													mem_add1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
													dest_en1 <= '1';
													which_dest <= "01";
												elsif (which_dest = "01") then
													dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
													dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
													mem_add2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
													dest_en2 <= '1';
													which_dest <= "10";
												end if;
												
												if which_en = "00" then
													cz_write_add1 <= rob_entry(i)(8 downto 5);
													cz_write_data1 <= rob_entry(i)(4 downto 3);
													cz_write_en1<='1';
													which_en <= "01";
												elsif which_en = "01" then
													cz_write_add2 <= rob_entry(i)(8 downto 5);
													cz_write_data2 <= rob_entry(i)(4 downto 3);
													cz_write_en2<='1';
													which_en <= "10";
												end if;
												
											end if;
											end if;
													
										end if;
									end if;
								else 
									case which_dest is
										when "00" => 
											dest_en1 <= '0';
											dest_en2 <= '0';
										when "01" => 
											dest_en2 <= '0';
										when others =>
											
									end case;
									
									case which_en is
										when "00" => 
											cz_write_en1 <= '0';
											cz_write_en2 <= '0';
										when "01" => 
											cz_write_en2 <= '0';
										when others =>
									end case;
								end if;
							when "0101" =>
								rob_entry(i)(1) <=  rob_entry(i)(9) and not(rob_entry(i)(39));
								no_instr := no_instr + 1;
								if(rob_entry(i)(1) = '1') then
									if (no_instr <3) then
										if (which_store = "00") then
											head_pointer :=  head_pointer + 1;
											rob_entry(i)(0) <= '0';
											if (which_dest = "00") then
												dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												mem_add1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en1 <= '1';
												which_dest <= "01";
											elsif (which_dest = "01") then
												dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												mem_add2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en2 <= '1';
												which_dest <= "10";
											end if;
											
											if which_en = "00" then
												cz_write_add1 <= rob_entry(i)(8 downto 5);
												cz_write_data1 <= rob_entry(i)(4 downto 3);
												cz_write_en1<='1';
												which_en <= "01";
											elsif which_en = "01" then
												cz_write_add2 <= rob_entry(i)(8 downto 5);
												cz_write_data2 <= rob_entry(i)(4 downto 3);
												cz_write_en2<='1';
												which_en <= "10";
											end if;
											which_store  <= "01";
										elsif (which_store = "01") then
											head_pointer :=  head_pointer + 1;
											rob_entry(i)(0) <= '0';
											if (which_dest = "00") then
												dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												mem_add1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en1 <= '1';
												which_dest <= "01";
											elsif (which_dest = "01") then
												dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
												dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
												mem_add2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
												dest_en2 <= '1';
												which_dest <= "10";
											end if;
											
											if which_en = "00" then
												cz_write_add1 <= rob_entry(i)(8 downto 5);
												cz_write_data1 <= rob_entry(i)(4 downto 3);
												cz_write_en1<='1';
												which_en <= "01";
											elsif which_en = "01" then
												cz_write_add2 <= rob_entry(i)(8 downto 5);
												cz_write_data2 <= rob_entry(i)(4 downto 3);
												cz_write_en2<='1';
												which_en <= "10";
											end if;
											which_store  <= "01";
										end if;
									end if;
								end if;
						
							when "1000" =>
								no_instr := no_instr + 1;
								rob_entry(i)(1) <=  rob_entry(i)(9) and not(rob_entry(i)(39));
								if (rob_entry(i)(1) = '1') then	
									if (no_instr = 1 ) then
										if(to_integer(unsigned(rob_entry(i)(25 downto 10))) = 0) then
											loop_spec : for j in i to 50 loop
												if(rob_entry(j)(38 downto 36) = rob_entry(head_pointer)(38 downto 36)) then
													rob_entry(j)(39) <= '0';
												else
													exit;
												end if;
											end loop;
										else
											branch_flush <='1';
										end if;
									end if;
								end if;
								
							when "1001" =>
								rob_entry(i)(1) <=  rob_entry(i)(9) and not(rob_entry(i)(39));
								no_instr := no_instr + 1;
								if (rob_entry(i)(1) = '1') then
									if (no_instr <3) then
										head_pointer :=  head_pointer + 1;
										rob_entry(i)(0) <= '0';
										if (which_dest = "00") then
											dest_ARF1 <= rob_entry(i)(word_width - 25 downto word_width - 29);
											dest_RRF1 <= rob_entry(i)(word_width - 30 downto word_width - 34);
											dest_val1 <= rob_entry(i)(word_width - 35 downto word_width - 50);
											dest_en1 <= '1';
											which_dest <= "01";
										elsif (which_dest = "01") then
											dest_ARF2 <= rob_entry(i)(word_width - 25 downto word_width - 29);
											dest_RRF2 <= rob_entry(i)(word_width - 30 downto word_width - 34);
											dest_val2 <= rob_entry(i)(word_width - 35 downto word_width - 50);
											dest_en2 <= '1';
											which_dest <= "10";
										end if;
										
										if which_en = "00" then
											cz_write_add1 <= rob_entry(i)(8 downto 5);
											cz_write_data1 <= rob_entry(i)(4 downto 3);
											cz_write_en1<='1';
											which_en <= "01";
										elsif which_en = "01" then
											cz_write_add2 <= rob_entry(i)(8 downto 5);
											cz_write_data2 <= rob_entry(i)(4 downto 3);
											cz_write_en2<='1';
											which_en <= "10";
										end if;
									end if;
									
								else
									case which_dest is
										when "00" => 
											dest_en1 <= '0';
											dest_en2 <= '0';
										when "01" => 
											dest_en2 <= '0';
										when others =>
											
									end case;
									
									case which_en is
										when "00" => 
											cz_write_en1 <= '0';
											cz_write_en2 <= '0';
										when "01" => 
											cz_write_en2 <= '0';
										when others =>
									end case;
									
								end if;
							--when "" =>
							when others =>
								
						end case;

					end if;	
					
				
				end loop;
				
				
			end if;
		end if;
	end process;
		
end architecture beh;