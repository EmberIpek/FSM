-------------------------------------------------------------------------------------------------------
-- Course: ECE 232 - Digital System Design Lab
-- Author: Ember Ipek
-- 
-- Create Date:  4/4/23
-- Experiment Name: Finite State Machines in VHDL (Lab #9)
-- Design Name: Lab_9
-- Project Name: Lab_9 - Behavioral
-- Target Devices: xc7a35t-1cpg236c
--
-- Description:	Design a traffic-light controller Finite State Machine and implement it in VHDL.
--				A state diagram for the traffic-light controller is given in the lab manual.
--------------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab_9 is
port(carew, carns : in std_logic;
	 rst, clk : in std_logic;
	 nsg, nsy, nsr, ewg, ewy, ewr : out std_logic);
end lab_9;

architecture behavioral of lab_9 is
	type state_type is(GNS, YNS, GEW, YEW);
	signal Qpresent, Qnext : state_type;
begin
	next_state : process(clk, carew, carns)
	begin
		case Qpresent is
			when GNS =>
				if(carew = '1') then Qnext <= YNS;
				else Qnext <= GNS;
				end if;
			when YNS =>
				if(rising_edge(clk)) then Qnext <= GEW;
				end if;
			when GEW =>
				if(carns = '1') then Qnext <= YEW;
				else Qnext <= GEW;
				end if;
			when YEW =>
				if(rising_edge(clk)) then Qnext <= GNS;
				end if;
			end case;
	end process;
	
	state_reg : process(clk, rst)
	begin
		if(rst = '1') then
			Qpresent <= GNS;
		elsif(rising_edge(clk)) then
			Qpresent <= Qnext;
		end if;
	end process;
	
	nsg <= '1' when (Qpresent = GNS) else '0';
	nsy <= '1' when (Qpresent = YNS) else '0';
	nsr <= '1' when (Qpresent = GEW or Qpresent = YEW) else '0';
	ewg <= '1' when (Qpresent = GEW) else '0';
	ewy <= '1' when (Qpresent = YEW) else '0';
	ewr <= '1' when (Qpresent = GNS or Qpresent = YNS) else '0';
	
end behavioral;
