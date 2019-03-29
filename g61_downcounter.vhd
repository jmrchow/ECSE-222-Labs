library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity g61_downcounter is
	Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			count : out natural range 0 to 499999);
end g61_downcounter;

architecture a0 of g61_downcounter is
	signal temp: natural range 0 to 499999;
begin
	Process(clk, reset) begin
		if (reset = '0') then
			temp <= 499999;
		elsif(rising_edge(clk)) then
			if (enable = '1') then
				if (temp = 0) then
					temp <= 499999;
				else
					temp <= temp - 1;
				end if;
			end if;
		end if;
		count <= temp;
	end Process;
end;