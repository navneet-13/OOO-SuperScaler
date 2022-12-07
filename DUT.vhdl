library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

library work;
use work.elem.all;

entity DUT is
   port(input_vector: in std_logic_vector(1 downto 0)
       	);
end entity;

architecture DutWrap of DUT is
	component datapath IS
	PORT (
		reset, clock : IN STD_LOGIC
	);
END component;
signal dummy4, dummy5, dummy6: std_logic_vector(15 downto 0);

begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: datapath
			port map (
					reset => input_vector(1),
					clock => input_vector(0)
					);

end DutWrap;

