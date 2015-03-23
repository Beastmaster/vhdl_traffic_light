--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:17:40 06/09/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/loading_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: loading
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
 
ENTITY loading_test IS
END loading_test;
 
ARCHITECTURE behavior OF loading_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT loading
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         num_in_a : IN  integer range 0 to 99;
         num_in_b : IN  integer range 0 to 99;
         load : IN  std_logic;
         start : IN  std_logic;
			led_r:	out std_logic;
			led_y:	out std_logic;
			led_g:	out std_logic;
         num_out_a : OUT  integer range 0 to 99
  --       num_out_b : OUT  integer range 0 to 99
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal num_in_a : integer:= 90;
   signal num_in_b : integer:= 30;
   signal load : std_logic := '0';
   signal start : std_logic := '0';


 	--Outputs
   signal num_out_a : integer;
 --  signal num_out_b : integer;
signal led_r:	std_logic;
signal led_y:	std_logic;
signal led_g:	std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: loading PORT MAP (
          clk => clk,
          rst => rst,
          num_in_a => num_in_a,
          num_in_b => num_in_b,
          load => load,
          start => start,
			led_r=>led_r,
			led_y=>led_y,
			led_g=>led_g,
          num_out_a => num_out_a
 --         num_out_b => num_out_b
        );

   -- Clock process definitions
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
      -- hold reset state for 100 ns.
      wait for 500 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		
		load<='1';
		wait for 10 ns;
		load<='0';
		
      wait;
   end process;

END;
