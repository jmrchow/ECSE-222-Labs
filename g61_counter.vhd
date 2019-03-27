library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity g61_counter is
	Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			max : in std_logic_vector(3 downto 0);
			count : out std_logic_vector(3 downto 0));
end g61_counter;

architecture a0 of g61_counter is
	signal temp: std_logic_vector(3 downto 0);
begin
	Process(clk, reset, max) begin
		if (reset = '0') then
			temp <= "0000";
		elsif(rising_edge(clk)) then
			if (enable = '1') then
				if (temp = max) then
					temp <= "0000";
				else
					temp <= temp + 1;
				end if;
			end if;
		end if;

	end Process;
	count <= temp;
end;
				
