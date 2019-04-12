-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "03/27/2019 16:09:52"
                                                            
-- Vhdl Test Bench template for design  :  g61_counter
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g61_FSM_test IS
END g61_FSM_test;

ARCHITECTURE a0 OF g61_FSM_test IS
	
-- Input variables for the circuit  
SIGNAL enable : STD_LOGIC := '1';
SIGNAL clk : STD_LOGIC := '0';
SIGNAL reset : STD_LOGIC := '0';
SIGNAL max : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
SIGNAL direction : STD_LOGIC := '1';

-- Output variables for the circuit
SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL en_out : STD_LOGIC;

-- Clock period definition
constant clk_period : time := 20 ns;

COMPONENT g61_FSM -- create a component for the circuit that will be tested
	PORT (
	enable : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	max : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	direction : IN STD_LOGIC;
	count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	en_out : OUT STD_LOGIC
	);
END COMPONENT;

BEGIN
-- Instantiate the circuit
circuit : g61_FSM PORT MAP (enable, clk, reset, max, direction, count, en_out);

-- Clock process
clk_process : process -- simulates a clock cycle by changing clk once in the middle of every clock period
begin
	clk <= '1';
	wait for clk_period/2;
	clk <= '0';
	wait for clk_period/2;
end process;

reset_process : process -- changes reset
begin
	reset <= '1'; -- reset is active low (when reset is '0', the count is reset)
	wait for 500 ns;
	reset <= '0';
	wait for 500 ns;
end process;

direction_process : process -- changes direction
begin
	direction <= '0';
	wait for 150 ns;
	direction <= '1';
	wait for 150 ns;
end process;

-- Stimulus process
stim_proc : process
begin
	enable <= '1';
	max <= "1110";
	wait;
end process;                                    
END a0;
