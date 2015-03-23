----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:49 06/13/2014 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
port(
clk,rst,en : in std_logic;
add_dec  : in std_logic;
init_0,init_1: in std_logic_vector(3 downto 0);
out_0,out_1  : out std_logic_vector(3 downto 0)
);
end counter;

architecture Behavioral of counter is
signal temp_0,temp_1: std_logic_vector(3 downto 0);
signal out_temp_0,out_temp_1: std_logic_vector(3 downto 0);

begin

U2:
process(clk,add_dec,rst)
begin
if(en='0') then
	if (rst='1') then
			temp_0<=init_0;
			temp_1<=init_1;
			out_temp_0<=init_0;
			out_temp_1<=init_1;
	elsif rising_edge(clk) then
		if(add_dec='1')then
			if((out_temp_1="1001") and (out_temp_0="1001")) then
				out_temp_1<="0000";
				out_temp_0<="0000";
			else
				if	(out_temp_0="1001")	then
					out_temp_0<="0000";
					if(out_temp_1="1001") then
						out_temp_1<="0000";
					else
						out_temp_1<=out_temp_1+"0001";
					end if;
				else
					out_temp_0<=out_temp_0+"0001";
				end if;
			end if;
		else
			if((out_temp_1="0000") and (out_temp_0="0000")) then
				out_temp_1<=temp_1;
				out_temp_0<=temp_0;
			else
				if	(out_temp_0="0000")	then
					out_temp_0<="1001";
					if(out_temp_1="0000") then
						out_temp_1<="1001";
					else
						out_temp_1<=out_temp_1-"0001";
					end if;
				else
					out_temp_0<=out_temp_0-"0001";
				end if;
			end if;			
		end if;
	else
		null;
	end if;
else
	null;
end if;
end process U2;

out_0<=out_temp_0;
out_1<=out_temp_1;

end Behavioral;

