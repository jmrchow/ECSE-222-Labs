library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity g61_downcounter is
	Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			count : out std_logic_vector(18 downto 0));
end g61_downcounter;

architecture a0 of g61_downcounter is
	signal temp: std_logic_vector(18 downto 0);
begin
	Process(clk, reset) begin
		if (reset = '0') then
			count <= "1111111111111111111";
		elsif(rising_edge(clk)) then
			if (enable = '1') then
				if (temp = "0000000000000000000") then
					temp <= "1111010000100011111";
				else
					temp <= temp - 1;
				end if;
			end if;
		end if;
	end Process;
end;