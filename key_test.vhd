--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:27:35 06/08/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/key_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: key_jitter
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
 
ENTITY key_test IS
END key_test;
 
ARCHITECTURE behavior OF key_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT key_jitter
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         key_in : IN  std_logic;
         key_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal key_in : std_logic := '0';

 	--Outputs
   signal key_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: key_jitter PORT MAP (
          clk => clk,
          rst => rst,
          key_in => key_in,
          key_out => key_out
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
   wait for 50 ns;	

      wait for clk_period;

      -- insert stimulus here 
		rst<='1';
		wait for 10 ns;
		rst<='0';
		
		wait for 30 ns;
		key_in<='1';
		wait for 10 ns;
		key_in <='0';
		wait for 15 ns;
		key_in <='1';
		wait for 1000 ns;
		key_in <='0';
		
      wait;
   end process;

END;
