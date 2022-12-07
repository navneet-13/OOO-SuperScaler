library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;


entity DUT is
   port(input_vector: in std_logic_vector(1 downto 0);
	output_vector: out std_logic_vector(1 downto 0)
       	);
end entity;

architecture DutWrap of DUT is
component datapath IS
	PORT (
		reset, clk : IN STD_LOGIC)
		;
END component;
signal dumm: std_logic_vector(1 downto 0);
begin
	dumm <= "11";
	output_vector <= dumm;

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: datapath
			port map (
					reset => input_vector(0),
					clk => input_vector(1)
					);

end DutWrap;

