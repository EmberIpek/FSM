--------------------------------------------------------------------------------------------
-- Course: ECE 232 - Digital System Design Lab
-- Author: Craig Lorie
-- 
-- Create Date:  
-- Experiment Name: Finite State Machines in VHDL (Lab #9)
-- Project Name: Lab_9 - Behavioral
--
-- Description:	Test bench for the traffic-light controller FSM (Lab_9).
--				Use one PROCESS statement to generate a periodic clock signal.
--				Use a second PROCESS statement to set/clear the reset signal, and the 
--				two controller inputs (carew and carns).
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity lab_9_tb is
end lab_9_tb;

architecture behavior of lab_9_tb is

-- component declaration for unit under test
component lab_9 is
port(carew, carns : in std_logic;
	 rst, clk : in std_logic;
	 nsg, nsy, nsr, ewg, ewy, ewr : out std_logic);
end component;

-- signals declared for use in the testbench 
signal clk_tb, rst_tb, carew_tb, carns_tb,
	   nsg_tb, nsy_tb, nsr_tb, ewg_tb, ewy_tb, ewr_tb : std_logic;

begin
	-- instantiate the unit under test (uut)
	uut : lab_9 port map (
		clk => clk_tb,
		rst => rst_tb,
		carew => carew_tb,
		carns => carns_tb,
		nsg => nsg_tb,
		nsy => nsy_tb,
		nsr => nsr_tb,
		ewg => ewg_tb,
		ewy => ewy_tb,
		ewr => ewr_tb
		);

	-- generate clock signal		
	clock_signal : process
	begin
		clk_tb <= '0';
		wait for 10ns;
		clk_tb <= '1';
		wait for 10ns;
	end process clock_signal;
	
	inputs : process 
	begin
		-- Specify the values for the reset signal to reset the controller.
		-- Then specify the values for the controller inputs to simulate its behavior.
		rst_tb <= '1';
		rst_tb <= '0';
		wait for 10ns;
		carew_tb <= '1';
		wait for 10ns;
		carew_tb <= '0';
		wait for 10ns;
		carns_tb <= '1';
		wait for 10ns;
		carns_tb <= '0';
		wait for 10ns;
	end process inputs;
end behavior;
