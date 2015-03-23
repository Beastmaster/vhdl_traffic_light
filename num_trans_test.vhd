--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:39:33 06/10/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/num_trans_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: num_trans
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
 
ENTITY num_trans_test IS
END num_trans_test;
 
ARCHITECTURE behavior OF num_trans_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT num_trans
    PORT(
         num_in : IN  integer range 0 to 99;
         num_out_0 : OUT  std_logic_vector(3 downto 0);
			num_out_1 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal num_in : integer:=20;--std_logic_vector(0 to 6) := (others => '0');

 	--Outputs
   signal num_out_0 : std_logic_vector(3 downto 0);
	signal num_out_1 : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: num_trans PORT MAP (
          num_in => num_in,
          num_out_0 => num_out_0,
			 num_out_1 => num_out_1
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for period*10;

      -- insert stimulus here 
		num_in<=num_in+1;

   end process;

END;
