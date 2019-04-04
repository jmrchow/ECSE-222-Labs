LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY g61_clock_divider_test IS
END g61_clock_divider_test;

ARCHITECTURE a0 OF g61_clock_divider_test IS

COMPONENT g61_clock_divider -- create a component for the circuit that will be tested
	PORT(	enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			en_out : out std_logic);
END COMPONENT;

-- Input variables for the circuit
signal enable : std_logic := '1';
signal clk : std_logic := '0';
signal reset : std_logic := '0';

-- Output variables for the circuit
signal en_out : std_logic;

-- Clock period definition
constant clk_period : time := 20 ns;

BEGIN

-- Instantiate the circuit
circuit : g61_clock_divider PORT MAP (
	enable => enable,
	clk => clk,
	reset => reset,
	en_out => en_out
);

-- Clock process definition
clk_process :process
begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;

-- Stimulus process
stim_proc: process
begin
	enable <= '1';
	reset <= '0';
	wait for clk_period;
	reset <= '1';
	wait for 18 ns;
	reset <= '0';
	wait;
end process;

END;
