----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:31 06/08/2014 
-- Design Name: 
-- Module Name:    display - Behavioral 
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

entity display is
port(
clk	:	in std_logic;	--1kHz

data_a_0	:	in std_logic_vector(3 downto 0);
data_a_1	:	in std_logic_vector(3 downto 0);
data_b_0	:	in std_logic_vector(3 downto 0);
data_b_1	:	in std_logic_vector(3 downto 0);

segment	:	out std_logic_vector(7 downto 0);
bit_d		:	out std_logic_vector(3 downto 0)
);
end display;

architecture Behavioral of display is

component translate
port(
data		:	in std_logic_vector(3 downto 0);
segment	:	out std_logic_vector(7 downto 0)
);
end component translate;

signal state: integer range 0 to 3;
signal data_temp:	std_logic_vector(3 downto 0);
signal bit_d_temp: std_logic_vector(3 downto 0):="0000";


begin

P1:
process(clk)
begin
	if rising_edge(clk) then
		if (state=3) then
			state<=0;
		else
			state<=state+1;
		end if;
	else
		null;
	end if;
end process P1;

-------------------------------------
data_temp<=	data_a_0 when state=0 else
				data_a_1 when state=1 else
				data_b_0 when state=2 else
				data_b_1 when state=3 else
				"0000";

-------------------------------------
MUX:
process(state)
begin
CASE state IS
		when 0 =>	
			bit_d_temp<="1110"; 
		when 1 =>	
			bit_d_temp<="0111";
		when 2 =>	
			bit_d_temp<="1011";
		when 3 =>	
			bit_d_temp<="1101";
		when others	=>	
			bit_d_temp <="1111";
END CASE;
end process MUX;

translate1:translate port map(data_temp,segment);

bit_d<=bit_d_temp;

end Behavioral;




