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

ENTITY g61_counter_vhd_tst IS
END g61_counter_vhd_tst;
ARCHITECTURE g61_counter_arch OF g61_counter_vhd_tst IS

COMPONENT g61_counter -- create a component for the circuit that will be tested
	PORT (
	enable : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC
	max : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	en_out : OUT STD_LOGIC
	);
END COMPONENT;
	
-- Input variables     
SIGNAL enable : STD_LOGIC;
SIGNAL clk : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL max : STD_LOGIC_VECTOR(3 DOWNTO 0);

-- Output variable
SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL en_out : STD_LOGIC;

BEGIN
circuit : g61_counter PORT MAP (enable, clk, reset, max, count, en_out);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END g61_counter_arch;
