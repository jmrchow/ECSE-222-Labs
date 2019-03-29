library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g61_clock_divider is
	Port (enable	: in std_logic;
			reset		: in std_logic;
			clk		: in std_logic;
			en_out	: out std_logic);
end g61_clock_divider;

architecture a0 of g61_clock_divider is

	component g61_downcounter is
		Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			count : out natural range 0 to 499999);
	end component g61_downcounter;
	
	signal count : natural range 0 to 499999;
	
begin 
	downcounter0 : g61_downcounter port map (enable, clk, reset, count);
	en_out <= '1' when count = 0 else '0';
end a0;