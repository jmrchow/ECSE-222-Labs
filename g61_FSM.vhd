library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity g61_FSM is
	Port (	enable : in std_logic; -- this one-bit input determines whether the counter is paused or unpaused
		clk : in std_logic; -- this one-bit input indicates when a single clock cycle has occured
		reset : in std_logic; -- this one-bit input determines whether the count will be reset or not
		max : in std_logic_vector(3 downto 0); -- this four-bit input determines the maximum number that the counter will count up to
		direction : in std_logic;
		count : out std_logic_vector(3 downto 0); -- a four-bit binary number whose value is equal to the current count is returned as output
		en_out : out std_logic); -- a single bit is returned as output to indicate whether the count was reset when reset was 1
end g61_FSM;

architecture a0 of g61_FSM is
	-- temporary variables are created because the outputs cannot be modified inside if-statements
	signal temp: std_logic_vector(3 downto 0);
	signal temp_out : std_logic;
begin
	Process(clk, reset, max) begin
		if (reset = '0') then -- if reset is 0
			temp <= "0000"; -- reset the count
			temp_out <= '0'; -- en_out will be 0 since the count was reset when reset was 0
		elsif(rising_edge(clk)) then
			if (enable = '1') then -- if the counter is not paused
				if (direction = '1') then
					if (temp = max) then -- if the count is at its maximum value
						temp <= "0000"; -- reset the count
						temp_out <= '1'; -- en_out will be 1 since the count was reset when reset was 1
					else
						temp <= temp + 1; -- increment the count
						temp_out <= '0'; -- en_out will be 0 since the count was not reset
					end if;
				else
					if ( temp = "0000") then
						temp <= max;
						temp_out <= '1';
					else
						temp <= temp - 1;
						temp_out <= '0';
					end if;
				end if;
			else
				temp_out <='0'; -- en_out will be 0 since the count was not reset
			end if;
		end if;
	end Process;
	-- store the values of the temporary variables to the outputs		
	en_out <= temp_out;
	count <= temp;
end;
				
