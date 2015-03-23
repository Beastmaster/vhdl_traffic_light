----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:00:22 06/08/2014 
-- Design Name: 
-- Module Name:    set_time - Behavioral 
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

entity set_time is
port(
rst	:	in std_logic;
--clk	:	in std_logic;
en		:	in std_logic;			--en=1时，开始设置时间
add_a	:	in std_logic;
add_b	:	in std_logic;
time_out_a_0	: out	std_logic_vector(3 downto 0);
time_out_a_1	: out	std_logic_vector(3 downto 0);

time_out_b_0	: out	std_logic_vector(3 downto 0);
time_out_b_1	: out	std_logic_vector(3 downto 0)
);
end set_time;

architecture Behavioral of set_time is
signal time_cnt_a:integer:=90;
signal time_cnt_b:integer:=90;
begin

P1:
process(rst,en,add_a)
variable cnt:integer range 0 to 100;
begin
	if rising_edge (rst) then
		cnt:=90;
	elsif (en='1') then
		if rising_edge(add_a) then
			if(cnt=99) then
				cnt:=0;
			else
				cnt:=cnt+1;
			end if;
		else
			null;
		end if;
	else
		null;
	end if;
	
	time_cnt_a<=cnt;
	
end process P1;


P2:
process(rst,en,add_b)
variable cnt:integer range 0 to 100;
begin
	if (rst='1') then
		cnt:=90;
	elsif (en='1') then
		if rising_edge(add_b) then
			if(cnt=99) then
				cnt:=0;
			else
				cnt:=cnt+1;
			end if;
		else
			null;
		end if;
	else
		null;
	end if;
	
	time_cnt_b<=cnt;
	
end process P2;



time_out_a<=time_cnt_a;
time_out_b<=time_cnt_b;

end Behavioral;

