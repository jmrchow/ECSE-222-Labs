library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity g61_downcounter is
	Port (	enable : in std_logic; -- this one-bit input determines whether the downcounter is paused or unpaused
		clk : in std_logic; -- this one-bit input indicates when a single clock cycle has occured
		reset : in std_logic; -- this one-bit input determines whether the count will be reset or not
		count : out natural range 0 to 499999); -- a natural number equal to the current count is returned as output
end g61_downcounter;

architecture a0 of g61_downcounter is
	signal temp: natural range 0 to 499999; -- a temporary variable is created because the count variable cannot be modified inside inside an if-statement
begin
	Process(clk, reset) begin
		if (reset = '0') then -- if reset is 0
			temp <= 499999; -- reset the count
		elsif(rising_edge(clk)) then -- if clk has changed from 1 to 0 or from 0 to 1
			if (enable = '1') then -- if enable is 1 (downcounter is unpaused)
				if (temp = 0) then -- if temp is 0
					temp <= 499999; -- reset the count
				else
					temp <= temp - 1; -- decrement temp
				end if;
			end if;
		end if;
		count <= temp; -- store the value of temp as the output
	end Process;
end;
