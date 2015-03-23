----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:05:06 06/13/2014 
-- Design Name: 
-- Module Name:    counter_dec - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_dec is
port(
clk,rst,en,flag:in std_logic;
time_a_0,time_a_1:in std_logic_vector(3 downto 0);
time_b_0,time_b_1:in std_logic_vector(3 downto 0);

time_out_0,time_out_1:out std_logic_vector(3 downto 0);

led_r,led_y,led_g: out std_logic
);
end counter_dec;

architecture Behavioral of counter_dec is

signal out_a_temp_0	:std_logic_vector(3 downto 0);
signal out_a_temp_1	:std_logic_vector(3 downto 0);

signal out_b_temp_0	:std_logic_vector(3 downto 0);
signal out_b_temp_1	:std_logic_vector(3 downto 0);

signal x_0: std_logic;
signal y_0: std_logic;

signal x_1: std_logic;
signal y_1: std_logic;

signal led_r_0 : std_logic;
signal led_y_0 : std_logic;
signal led_g_0 : std_logic;

signal led_r_1 : std_logic;
signal led_y_1 : std_logic;
signal led_g_1 : std_logic;


begin

-----------------
x_0<='1' when  (out_a_temp_1&out_a_temp_0="00000000") and (out_b_temp_1&out_b_temp_0>="00000101") else '0';

y_0<= not clk when (out_a_temp_1&out_a_temp_0="00000000") and (out_b_temp_1&out_b_temp_0<"00000101") else '0';

led_r_0<= x_0 or y_0;
			
led_y_0<='1' when (out_a_temp_1&out_a_temp_0<"00000101") and (out_a_temp_1&out_a_temp_0>"00000000") and (clk='1') else
			'0';

led_g_0<='1' when (out_a_temp_1&out_a_temp_0>"00000100") and (out_a_temp_1&out_a_temp_0<time_a_1&time_a_0) else
			'0';

------------------
x_1<='1' when (out_a_temp_1&out_a_temp_0>="00000101") else '0';

y_1<= not clk when (out_b_temp_1&out_b_temp_0=time_b_1&time_b_0)and(out_a_temp_1&out_a_temp_0<"00000101") else '0';

led_r_1<= x_1 or y_1;
			
led_y_1<='1' when (out_b_temp_1&out_b_temp_0<"00000101") and (out_b_temp_1&out_b_temp_0>"00000000") and (clk='1') else '0';

led_g_1<='1' when (out_b_temp_1&out_b_temp_0>"00000100") and (out_b_temp_1&out_b_temp_0<time_b_1&time_b_0) else	'0';

------------
led_r<=led_r_0 when (flag ='1') else led_r_1;
led_y<=led_y_0 when (flag ='1') else led_y_1;
led_g<=led_g_0 when (flag ='1') else led_g_1;


U1:
process(rst,clk,en)
begin

if (rst='1') then
		out_a_temp_0<=time_a_0;
		out_a_temp_1<=time_a_1;
		
		out_b_temp_0<=time_b_0;
		out_b_temp_1<=time_b_1;	

		time_out_0<=time_a_0;
		time_out_1<=time_a_1;
elsif (en ='1') then	
	if rising_edge(clk) then
		if(out_a_temp_0&out_a_temp_1="00000000") then
			time_out_0<=out_b_temp_0;
			time_out_1<=out_b_temp_1;
			if(out_b_temp_0&out_b_temp_1="00000000") then
				out_a_temp_0<=time_a_0;
				out_a_temp_1<=time_a_1;
				out_b_temp_0<=time_b_0;
				out_b_temp_1<=time_b_1;	
			elsif(out_b_temp_0="0000") then
				out_b_temp_0<="1001";
				out_b_temp_1<=out_b_temp_1-"0001";
			else
				out_b_temp_0<=out_b_temp_0-"0001";
			end if;
		elsif(out_a_temp_0="0000") then
			out_a_temp_0<="1001";
			out_a_temp_1<=out_a_temp_1-"0001";
			time_out_0<=out_a_temp_0;
			time_out_1<=out_a_temp_1;
		else
			out_a_temp_0<=out_a_temp_0-"0001";
			time_out_0<=out_a_temp_0;
			time_out_1<=out_a_temp_1;
		end if;
	else
		null;
	end if;
else
	null;
end if;
end process U1;

end Behavioral;

