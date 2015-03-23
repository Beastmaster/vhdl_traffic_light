--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:37:23 06/08/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/set_time_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: set_time
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY set_time_test IS
END set_time_test;
 
ARCHITECTURE behavior OF set_time_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT set_time
    PORT(
         rst : IN  std_logic;
         en : IN  std_logic;
         add : IN  std_logic;
         time_out : out  integer range 0 to 100
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal add : std_logic := '0';
   signal time_out : integer range 0 to 100;--std_logic_vector(0 to 6) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: set_time PORT MAP (
          rst => rst,
          en => en,
          add => add,
          time_out => time_out
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      -- insert stimulus here 
		
		rst<='1';
		wait for 10 ns;
		rst<='0';
		wait for 10 ns;
		wait for 10 ns;

		
      wait;
   end process;
	

 stim_proc1: process
   begin		
		wait for 10 ns;
		en<='1';
		wait for 20 ns;
		add<='1';
		wait for 10 ns;
		add<='0';
		wait for 10 ns;
		add<='1';
		wait for 10 ns;
		add<='0';
		wait for 10 ns;
		add<='1';

   end process;

END;
