library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g61_stopwatch is
	Port (	start	:	in std_logic;
				stop	: in std_logic;
				reset	: in std_logic;
				clk	: in std_logic;
				HEX0	: out std_logic_vector (6 downto 0);
				HEX1	: out std_logic_vector (6 downto 0);
				HEX2	: out std_logic_vector (6 downto 0);
				HEX3	: out std_logic_vector (6 downto 0);
				HEX4	: out std_logic_vector (6 downto 0);
				HEX5	: out std_logic_vector (6 downto 0));
end g61_stopwatch;

architecture a0 of g61_stopwatch is
	
	component g61_counter is
		Port (enable : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			max : in std_logic_vector(3 downto 0);
			count : out std_logic_vector(3 downto 0));
	end component g61_counter;
	
	component g61_clock_divider is
		Port (enable	: in std_logic;
			reset		: in std_logic;
			clk		: in std_logic;
			en_out	: out std_logic);
	end component g61_clock_divider;
	
	component g61_7_segment_decoder is
	Port (	code			:	in		std_logic_vector(3 downto 0);
				segments		:	out	std_logic_vector(6 downto 0)
			);
	end component g61_7_segment_decoder;
	
	signal state : std_logic := '0'; -- paused or unpaused
	signal divided_clk : std_logic;
	
	signal count0 : std_logic_vector(3 downto 0);
	signal count1 : std_logic_vector(3 downto 0);
	signal count2 : std_logic_vector(3 downto 0);
	signal count3 : std_logic_vector(3 downto 0);
	signal count4 : std_logic_vector(3 downto 0);
	signal count5 : std_logic_vector(3 downto 0);
	
	
begin
	process(state, start, stop) begin
		if (start = '1' and stop = '1') then
			state <= '0';
		elsif (start = '1' and stop = '0') then
			state <= '1';
		elsif (start = '0' and stop = '1') then
			state <= '0';
		end if;
	end process;
	
	clockdivider : g61_clock_divider port map (state, reset, clk, divided_clk);
	
	counter0 : g61_counter port map (start, divided_clk, reset, "1001", count0);
	counter1 : g61_counter port map (start, divided_clk, reset, "1001", count1);
	counter2 : g61_counter port map (start, divided_clk, reset, "1001", count2);
	counter3 : g61_counter port map (start, divided_clk, reset, "0101", count3);
	counter4 : g61_counter port map (start, divided_clk, reset, "1001", count4);
	counter5 : g61_counter port map (start, divided_clk, reset, "0101", count5);
	
	decoder0 : g61_7_segment_decoder port map (count0, HEX0);
	decoder1 : g61_7_segment_decoder port map (count1, HEX1);
	decoder2 : g61_7_segment_decoder port map (count2, HEX2);
	decoder3 : g61_7_segment_decoder port map (count3, HEX3);
	decoder4 : g61_7_segment_decoder port map (count4, HEX4);
	decoder5 : g61_7_segment_decoder port map (count5, HEX5);
	

	
end;
