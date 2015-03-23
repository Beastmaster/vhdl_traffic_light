--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:03:12 06/10/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/display_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: display
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
 
ENTITY display_test IS
END display_test;
 
ARCHITECTURE behavior OF display_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT display
    PORT(
         clk : IN  std_logic;
			
			data_a_0	:	in std_logic_vector(3 downto 0);
			data_a_1	:	in std_logic_vector(3 downto 0);
			data_b_0	:	in std_logic_vector(3 downto 0);
			data_b_1	:	in std_logic_vector(3 downto 0);

         segment : OUT  std_logic_vector(7 downto 0);
         bit_d : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	
   signal data_a_0 : std_logic_vector:="0100";
   signal data_a_1 : std_logic_vector:="0000";
   signal data_b_0 : std_logic_vector:="0000";
   signal data_b_1 : std_logic_vector:="0000";

 	--Outputs
   signal segment : std_logic_vector(7 downto 0);
   signal bit_d : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: display PORT MAP (
          clk => clk,
          data_a_0 => data_a_0,
          data_a_1 => data_a_1,
          data_b_0 => data_b_0,
          data_b_1 => data_b_1,
          segment => segment,
          bit_d => bit_d
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
