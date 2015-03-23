--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:43:17 06/13/2014
-- Design Name:   
-- Module Name:   E:/WORKPLACE/Verilog_Prj/traffic_light_1/traffic_light_1/counter_dec_test.vhd
-- Project Name:  traffic_light_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter_dec
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
 
ENTITY counter_dec_test IS
END counter_dec_test;
 
ARCHITECTURE behavior OF counter_dec_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter_dec
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
			flag : IN  std_logic;
         time_a_0 : IN  std_logic_vector(3 downto 0);
         time_a_1 : IN  std_logic_vector(3 downto 0);
         time_b_0 : IN  std_logic_vector(3 downto 0);
         time_b_1 : IN  std_logic_vector(3 downto 0);
         time_out_0 : out  std_logic_vector(3 downto 0);
         time_out_1 : out  std_logic_vector(3 downto 0);
			led_r,led_y,led_g: out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '1';
	signal flag : std_logic := '0';
   signal time_a_0 : std_logic_vector(3 downto 0) :="0000";
   signal time_a_1 : std_logic_vector(3 downto 0) := "1001";
   signal time_b_0 : std_logic_vector(3 downto 0) := "0000";
   signal time_b_1 : std_logic_vector(3 downto 0) := "0011";
   signal time_out_0 : std_logic_vector(3 downto 0) ;
   signal time_out_1 : std_logic_vector(3 downto 0) ;
	signal led_r,led_y,led_g: std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter_dec PORT MAP (
          clk => clk,
          rst => rst,
          en => en,
          flag => flag,
			 time_a_0 => time_a_0,
          time_a_1 => time_a_1,
          time_b_0 => time_b_0,
          time_b_1 => time_b_1,
          time_out_0 => time_out_0,
          time_out_1 => time_out_1,
			 led_r=>led_r,
			 led_y=>led_y,
			 led_g=>led_g
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
      wait for clk_period*2000;
		
		flag<='1';

      -- insert stimulus here 

      wait;
   end process;

END;
