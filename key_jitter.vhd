----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:05:04 06/08/2014 
-- Design Name: 
-- Module Name:    key_jitter - Behavioral 
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

entity key_jitter is
port(
clk	:	in std_logic;		--1kHz
rst	:	in std_logic;
key_in	:	in std_logic;
key_out	:	out std_logic
);
end key_jitter;

architecture Behavioral of key_jitter is

signal	key_temp	:std_logic:='0';
constant	border	:integer:=100;
signal cnt:integer range 0 to border;
begin

key: 
process(rst,clk,rst,key_in)

begin
	if (rst='1') then
		cnt<=0;
	elsif (key_in='1') then
		if (clk='1' and clk'event) then
			if(cnt=border) then
				cnt<=0;
			else
				cnt<=cnt+1;
			end if;
		else
			null;
		end if;
	else
		NULL;
	end if;
	
	if (cnt=border) then 
		key_temp<='1';
	else
		key_temp<='0';
	end if;
	
end process key;

key_out<=key_temp;

end Behavioral;

