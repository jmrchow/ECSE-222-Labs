library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g61_clock_divider is
	Port (	enable	: in std_logic;
		reset	: in std_logic;
		clk	: in std_logic; -- enable, reset, and clk are one-bit inputs that are used in the g61_downcounter instance
		en_out	: out std_logic); -- returns a one-bit output that indicates when one centisecond has elapse
end g61_clock_divider;

architecture a0 of g61_clock_divider is

	component g61_downcounter is -- create an instance of g61_downcounter
		Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			count : out natural range 0 to 499998);
	end component g61_downcounter;
	
	signal count : natural range 0 to 499998; -- stores the output of the g61_downcounter instance
	
begin 
	downcounter0 : g61_downcounter port map (enable, clk, reset, count);
	en_out <= '1' when count = 0 else '0'; -- When the count is 0,  500000 clock cycles have occured. So, en_out is set to 1 (which means a centisecon has elapsed).
end a0;
