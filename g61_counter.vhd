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
			count : out std_logic_vector(3 downto 0);
			en_out : out std_logic);
end g61_counter;

architecture a0 of g61_counter is
	signal temp: std_logic_vector(3 downto 0);
	signal temp_out : std_logic;
begin
	Process(clk, reset, max) begin
		--temp_out <= '0';
		if (reset = '0') then
			temp <= "0000";
			temp_out <= '0';
		elsif(rising_edge(clk)) then
			if (enable = '1') then
				if (temp = max) then
					temp <= "0000";
					temp_out <= '1';
				else
					temp <= temp + 1;
					temp_out <= '0';
				end if;
			else
				temp_out <='0';
			end if;
		--elsif(not rising_edge(clk)) then
			--temp_out <= '0';
		end if;

	end Process;
	en_out <= temp_out;
	count <= temp;
end;
				
