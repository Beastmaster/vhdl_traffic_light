----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:31 06/08/2014 
-- Design Name: 
-- Module Name:    load - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity loading is
port(
clk	:	in std_logic;					--1Hz
rst	:	in std_logic;
num_in_a	:	in integer range 0 to 99;
num_in_b	:	in integer range 0 to 99;
load	:	in std_logic;					--en
--start	:	in std_logic;
led_r:	out std_logic;
led_y:	out std_logic;
led_g:	out std_logic;

num_out_a	:out	integer range 0 to 99
num_out_b	:out	integer range 0 to 99
);
end loading;

architecture Behavioral of loading is

signal num_out_a_temp	:integer range 0 to 99;
signal num_out_b_temp	:integer range 0 to 99;

begin

U1:
process(rst,load,clk)
begin
	if rising_edge(rst) then
		num_out_a_temp<=90;
		num_out_b_temp<=30;
	if (load='1') then
		num_out_a_temp<=num_in_a;
		num_out_b_temp<=num_in_b;
	elsif (clk='1') then
		if (num_out_a_temp=0) then
			if(num_out_b_temp=0) then
				num_out_a_temp<=num_in_a;
				num_out_b_temp<=num_in_b;
				num_out_a<=num_out_a_temp;
			else
				led_g<='0';
				led_y<='0';
				num_out_b_temp<=num_out_b_temp-1;
				num_out_a<=num_out_b_temp;
				if(num_out_b_temp<6) then
					led_r<=clk;
				else
					led_r<='1';
				end if;
			end if;
		else
			num_out_a_temp<=num_out_a_temp-1;
			num_out_a<=num_out_a_temp;
			if(num_out_a_temp>5) then
				led_g<='1';
				led_r<='0';
				led_y<='0';
			else
				led_g<='0';
				led_r<='0';
				led_y<=clk;
			end if;
		end if;
	else
		null;
	end if;
end process U1;

num_out_a<=num_out_a_temp;
num_out_b<=num_out_b_temp;

end Behavioral;

