library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g61_stopwatch is
	Port (	start	:	in std_logic;
				stop	: in std_logic;
				reset	: in std_logic; -- start, stop, and reset are one-bit inputs that are each assigned to a button. When a button is pressed, the corresponding input is set to 0 (set to 1 otherwise) 
				clk	: in std_logic; -- clk is a one-bit input that is assigned to a 50MHz clock. It is used in g61_FSM and g61_clock_divider to keep track of when one centisecond has elapsed (once every 500000 clock cycles)
				direction : in std_logic;
				HEX0	: out std_logic_vector (6 downto 0);
				HEX1	: out std_logic_vector (6 downto 0)); -- HEX0, HEX1 are seven-bit outputs obtained from g61_7_segment_decoder. They each describe which segments to turn off in an LED in order to display the count
end g61_stopwatch;

architecture a0 of g61_stopwatch is
	
	component g61_FSM is -- declare a component of g61_FSM
		Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			max : in std_logic_vector(3 downto 0);
			direction : in std_logic;
			count : out std_logic_vector(3 downto 0);
			en_out : out std_logic);
	end component g61_FSM;
	
	component g61_clock_divider is -- declare a component of g61_clock_divider
		Port (enable	: in std_logic;
			reset	: in std_logic;
			clk	: in std_logic;
			en_out	: out std_logic);
	end component g61_clock_divider;
	
	component g61_7_segment_decoder is -- declare a component of g61_7_segment_decoder
	Port (	code     : in std_logic_vector(3 downto 0);
		segments : out std_logic_vector(6 downto 0)
			);
	end component g61_7_segment_decoder;
	
	signal state : std_logic := '0'; -- this is a memory variable to remember when the stopwatch is paused or unpaused
	signal divided_clk : std_logic; -- this will store the output of g61_clock_divider
	
	signal en_out0: std_logic;
	signal en_out1: std_logic;
	signal en_out2: std_logic;
	signal en_out3: std_logic; -- There are four en_out variables, one for each instance of g61_FSM (to store the output)
	
	signal count0 : std_logic_vector(3 downto 0);
	signal count1 : std_logic_vector(3 downto 0);
	signal count2 : std_logic_vector(3 downto 0);
	signal count3 : std_logic_vector(3 downto 0); -- There are four count variables, one for each instance of g61_FSM (to store the output). Each count variable stores the value of a digit in the six-digit count that is displayed on the screen.
		
	signal displayNumber0 : std_logic_vector(3 downto 0);
	signal displayNumber1  : std_logic_vector(3 downto 0);
		
begin
	process(state, start, stop) begin
		if (start = '1' and stop = '1') then -- if the start and stop buttons are not pressed
			if (state = '1') then -- if the stopwatch is unpaused
				state <= '1'; -- unpause the stopwatch
			else
				state <= '0'; -- pause the stopwatch
			end if;
		elsif (start = '0' and stop = '1') then -- if the start button is pressed and the stop button is not pressed
			state <= '1'; -- unpause the stopwatch
		elsif (start = '1' and stop = '0') then -- if the stop button is pressed and the start button is not pressed
			state <= '0'; -- pause the stopwatch
		end if;
		
		if (reset = '0') then -- if the reset button is pressed
			state <= '0'; -- pause the stopwatch
		end if;
	end process;
	
	clockdivider : g61_clock_divider port map (state, reset, clk, divided_clk); -- Return a value for divided_clk. If divided_clk is 1, then one centisecond has elapsed
	
	-- The instances of g61_FSM increment the count displayed on the screen by one every time a centisecond elapsed (every time divided_clock is 1)
	FSM0 : g61_FSM port map (state, divided_clk, reset, "1001", direction, count0, en_out0); -- if count(i) has a value of 9 when it is being incremented, it is reset to 0 and en_out(i) is set to 1 so that the next g61_FSM instance increments the count by 1
	FSM1 : g61_FSM port map (en_out0, divided_clk, reset, "1001", direction, count1, en_out1);
	FSM2 : g61_FSM port map (en_out1, divided_clk, reset, "1110", direction, count2, en_out2);
--	FSM3 : g61_FSM port map (en_out2, divided_clk, reset, "0001", direction, count3, en_out3);-- if count3 has a value of 9 when it is being incremented, it is reset to 0 and nothing is incremented, so the count displayed is effectively reset to 0
	
	
	-- The instances of g61_7_segment_decoder decode each count variable to be displayed on the screen
	with count2 select displayNumber0 <= -- MUX
		"0001" when "0000", -- 1
		"0010" when "0001", -- 2
		"0100" when "0010", -- 4
		"1000" when "0011", -- 8
		"0011" when "0100", -- 3
		"0110" when "0101", -- 6
		"0010" when "0110", -- 1(2)
		"0001" when "0111", -- 1(1)
		"0101" when "1000", -- 5
		"0000" when "1001", -- 1(0)
		"0111" when "1010", -- 7
		"0100" when "1011", -- 1(4)
		"0101" when "1100", -- 1(5)
		"0011" when "1101", -- 1(3)
		"1001" when "1110", -- 9
		"0000" when others; -- others
		
	with count2 select displayNumber1 <= -- MUX
		"0001" when "1001", -- (1)0
		"0001" when "0111", -- (1)1
		"0001" when "0110", -- (1)2
		"0001" when "1101", -- (1)3
		"0001" when "1011", -- (1)4
		"0001" when "1100", -- (1)5
		"0000" when others; -- others
	
	decoder0 : g61_7_segment_decoder port map (displayNumber0, HEX0);
	decoder1 : g61_7_segment_decoder port map (displayNumber1, HEX1);

	

	
end;