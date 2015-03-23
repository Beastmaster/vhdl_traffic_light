----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:35:57 06/08/2014 
-- Design Name: 
-- Module Name:    top - Behavioral 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port(
clk	:	in std_logic;		--时钟信号
rst	:	in std_logic;		--复位

-----------红黄绿三色信号灯----------------
led_r_a	:	out std_logic;
led_r_b	:	out std_logic;

led_y_a	:	out std_logic;
led_y_b	:	out std_logic;

led_g_a	:	out std_logic;
led_g_b	:	out std_logic;

--------------载入设置好的时间--------------
load		:	in  std_logic;
switch	:	in  std_logic;
add_dec	:	IN  STD_LOGIC;

------------------时间设置-----------------
add_a		:	in std_logic;
add_b		:	in std_logic;
start_in :	in std_logic;

---------------数码管信号-------------------
segment :	out std_logic_vector(7 downto 0);
bit_d	  :	out std_logic_vector(3 downto 0);

----------------LCD信号--------------------
SF_D : out std_logic_vector(3 downto 0); 
LCD_E, LCD_RS, LCD_RW, SF_CE0 : out std_logic 
);

end top;

architecture Behavioral of top is

component clk_div
generic(period: integer:=50000);
port(
clk_in	:	in std_logic;
rst		:	in std_logic;
clk_out1	:	out std_logic
);
end component clk_div;

component display
port(
clk	:	in std_logic;	--1kHz

data_a_0	:	in std_logic_vector(3 downto 0);
data_a_1	:	in std_logic_vector(3 downto 0);
data_b_0	:	in std_logic_vector(3 downto 0);
data_b_1	:	in std_logic_vector(3 downto 0);

segment	:	out std_logic_vector(7 downto 0);
bit_d		:	out std_logic_vector(3 downto 0)
);
end component display;

component key_jitter
port(
clk	:	in std_logic;		--1kHz
rst	:	in std_logic;
key_in	:	in std_logic;
key_out	:	out std_logic
);
end component key_jitter;



component LCD_display is
port(
 clk, reset : in std_logic; 
 SF_D : out std_logic_vector(3 downto 0); 
 num  : in std_logic_vector (3 downto 0);
 num1:in std_logic_vector (3 downto 0);
 num2:in std_logic_vector (3 downto 0);
 num21:in std_logic_vector (3 downto 0);
 num3:in std_logic_vector (3 downto 0);
 num31:in std_logic_vector (3 downto 0);
 LCD_E, LCD_RS, LCD_RW, SF_CE0 : out std_logic 
);
end component LCD_display;

component counter is
port(
clk,rst,en : in std_logic;
add_dec  : in std_logic;
init_0,init_1: in std_logic_vector(3 downto 0);
out_0,out_1  : out std_logic_vector(3 downto 0)
);
end component counter;

component counter_dec is
port(
clk,rst,en,flag:in std_logic;
time_a_0,time_a_1:in std_logic_vector(3 downto 0);
time_b_0,time_b_1:in std_logic_vector(3 downto 0);
time_out_0,time_out_1:out std_logic_vector(3 downto 0);
led_r,led_y,led_g: out std_logic
);
end component counter_dec;

----------------中间信号--------------
signal clk_1kHz,clk_1Hz: std_logic;
signal add_a_temp:std_logic;--按键
signal add_b_temp:std_logic;--按键

------------------初始时间设置，90s，30s---------------
constant init_time_a_0: std_logic_vector(3 downto 0):="0000";
constant init_time_a_1: std_logic_vector(3 downto 0):="1001";

constant init_time_b_0: std_logic_vector(3 downto 0):="0000";
constant init_time_b_1: std_logic_vector(3 downto 0):="0011";

---------------------时间寄存器------------------------
signal time_temp_a_0: std_logic_vector(3 downto 0);
signal time_temp_a_1: std_logic_vector(3 downto 0);

signal time_temp_b_0: std_logic_vector(3 downto 0);
signal time_temp_b_1: std_logic_vector(3 downto 0);

-----------------------计数输出时间----------------------
signal disp_a_0: std_logic_vector(3 downto 0);
signal disp_a_1: std_logic_vector(3 downto 0);
signal disp_b_0: std_logic_vector(3 downto 0);
signal disp_b_1: std_logic_vector(3 downto 0);

----------------------显示寄存器---------------------------
signal disp_a_0_temp: std_logic_vector(3 downto 0);
signal disp_a_1_temp: std_logic_vector(3 downto 0);
signal disp_b_0_temp: std_logic_vector(3 downto 0);
signal disp_b_1_temp: std_logic_vector(3 downto 0);

----------------------LED寄存器---------------
signal led_r_a_temp	:	std_logic;
signal led_r_b_temp	:	std_logic;
signal led_y_a_temp	:	std_logic;
signal led_y_b_temp	:	std_logic;
signal led_g_a_temp	:	std_logic;
signal led_g_b_temp	:	std_logic;

signal start_out		:	std_logic;

begin
---------------------------------------

---------各模块调用-----------
clock_div_1kHz:	clk_div 	generic map(25000)
					port map(clk_in=>clk,	  rst=>rst,clk_out1=>clk_1kHz);
clock_div_1Hz:		clk_div 	generic map(500)
					port map(clk_in=>clk_1kHz,rst=>rst,clk_out1=>clk_1Hz);


key_add_a:	key_jitter port map(clk=>clk_1kHz,rst=>rst,key_in=>add_a,key_out=>add_a_temp); 
key_add_b:	key_jitter port map(clk=>clk_1kHz,rst=>rst,key_in=>add_b,key_out=>add_b_temp); 
key_start:	key_jitter port map(clk=>clk_1kHz,rst=>rst,key_in=>start_in,key_out=>start_out); 

------------allowing time setting-------------
----load=0 开始可以计数
setting_a_add: counter 
port map(
clk=>add_a_temp,
rst=>rst,
en=>load,
add_dec=>add_dec,
init_0=>init_time_a_0,
init_1=>init_time_a_1,
out_0=>time_temp_a_0,
out_1=>time_temp_a_1
);

---------------banning time setting------------
setting_b_add: counter 
port map(
clk=>add_b_temp,
rst=>rst,
en=>load,
add_dec=>add_dec,
init_0=>init_time_b_0,
init_1=>init_time_b_1,
out_0=>time_temp_b_0,
out_1=>time_temp_b_1
);


------------allowing time counting-------------
counting_a: counter_dec 
port map(
clk=>clk_1Hz,
rst=>start_out,
en=>load,
flag=>'1',
time_a_0=>time_temp_a_0,
time_a_1=>time_temp_a_1,
time_b_0=>time_temp_b_0,
time_b_1=>time_temp_b_1,
time_out_0=>disp_a_0,
time_out_1=>disp_a_1,
led_r=>led_r_a_temp,
led_y=>led_y_a_temp,
led_g=>led_g_a_temp
);

---------------banning time counting------------
counting_b: counter_dec 
port map(
clk=>clk_1Hz,
rst=>start_out,
en=>load,
flag=>'0',
time_a_0=>time_temp_a_0,
time_a_1=>time_temp_a_1,
time_b_0=>time_temp_b_0,
time_b_1=>time_temp_b_1,
time_out_0=>disp_b_0,
time_out_1=>disp_b_1,
led_r=>led_r_b_temp,
led_y=>led_y_b_temp,
led_g=>led_g_b_temp
);

-----switch=1,a=>a-------------
led_r_a	<=(switch and led_r_a_temp) or((not switch) and led_r_b_temp);
led_r_b	<=(switch and led_r_b_temp) or((not switch) and led_r_a_temp);

led_y_a	<=(switch and led_y_a_temp) or((not switch) and led_y_b_temp);
led_y_b	<=(switch and led_y_b_temp) or((not switch) and led_y_a_temp);

led_g_a	<=(switch and led_g_a_temp) or((not switch) and led_g_b_temp);
led_g_b	<=(switch and led_g_b_temp) or((not switch) and led_g_a_temp);


----------load=0,设置时间-------------------
disp_a_0_temp<= time_temp_a_0  when load='0' else
					disp_a_0;

disp_a_1_temp<=time_temp_a_1   when load='0' else
					disp_a_1;

disp_b_0_temp<=time_temp_b_0   when load='0' else
					disp_b_0;

disp_b_1_temp<=time_temp_b_1   when load='0' else
				disp_b_1;


seg_disp: display
port map(
clk=>clk_1kHz,
data_a_0=>disp_a_0_temp,
data_a_1=>disp_a_1_temp,
data_b_0=>disp_b_0_temp,
data_b_1=>disp_b_1_temp,
segment=>segment,
bit_d	=>bit_d
);

--displayx:				
--LCD_display port map(
-- clk=>clk,
-- reset=>rst, --: in std_logic; 
-- SF_D=>SF_D,  --: out std_logic_vector(3 downto 0); 
-- num=> time_a_0x, --: in std_logic_vector (3 downto 0);
-- num1=>time_a_1x,--:in std_logic_vector (3 downto 0);
-- num2=>time_b_0x,--:in std_logic_vector (3 downto 0);
-- num21=>time_b_1x,--:in std_logic_vector (3 downto 0);
-- num3=>time_a_0x,--:in std_logic_vector (3 downto 0);
-- num31=>time_a_0x,--:in std_logic_vector (3 downto 0);
-- LCD_E=>LCD_E,
-- LCD_RS=>LCD_RS,
-- LCD_RW=>LCD_RW,
-- SF_CE0=>SF_CE0
-- );


-------------------------

end Behavioral;

