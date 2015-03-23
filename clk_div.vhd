----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:13 06/07/2014 
-- Design Name: 
-- Module Name:    clk_div - Behavioral 
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

entity clk_div is
generic(period: integer:=25000);
port(
clk_in	:	in std_logic;
rst		:	in std_logic;
clk_out1	:	out std_logic
);
end clk_div;

architecture Behavioral of clk_div is

signal	clk_temp: std_logic:='0';
begin

counter1:
process (clk_in,rst)
variable cnt1	:	integer range 0 to period;
		begin
			if (rst='1') then
				cnt1:=0;
				clk_temp<='0';
			elsif rising_edge (clk_in) then
				if (cnt1=period) then
					cnt1:=0;
					clk_temp<=not clk_temp;
				else
					cnt1:=cnt1+1;
				end if;
			else
				cnt1:=cnt1;
			end if;
end process counter1;

clk_out1<=clk_temp;

end Behavioral;

