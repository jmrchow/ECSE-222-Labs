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
			count : out std_logic_vector(18 downto 0));
	end component g61_downcounter;
	
	signal count : std_logic_vector(18 downto 0);
	
begin 
	en_out <= '0';
	downcounter0 : g61_downcounter port map (enable, clk, reset, count);

	process(count) begin
		if (count = "0000000000000000000") then
			en_out <= '1';
		end if;
	end process;
end;
	


			