--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:28:33 06/14/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/counter_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter
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
 
ENTITY counter_test IS
END counter_test;
 
ARCHITECTURE behavior OF counter_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         add_dec : IN  std_logic;
         init_0 : IN  std_logic_vector(3 downto 0);
         init_1 : IN  std_logic_vector(3 downto 0);
         out_0 : OUT  std_logic_vector(3 downto 0);
         out_1 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal add_dec : std_logic := '0';
   signal init_0 : std_logic_vector(3 downto 0) := "0000";
   signal init_1 : std_logic_vector(3 downto 0) := "1001";

 	--Outputs
   signal out_0 : std_logic_vector(3 downto 0);
   signal out_1 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          clk => clk,
          rst => rst,
          en => en,
          add_dec => add_dec,
          init_0 => init_0,
          init_1 => init_1,
          out_0 => out_0,
          out_1 => out_1
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
		rst<='1';
		wait for 10 ns;
		rst<='0';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
