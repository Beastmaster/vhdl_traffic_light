----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:53:55 06/10/2014 
-- Design Name: 
-- Module Name:    num_trans - Behavioral 
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

entity num_trans is
port(
num_in: 	in integer range 0 to 99 ;
num_out_0: out integer range 0 to 9;--out std_logic_vector(3 downto 0):="0000";
num_out_1: out integer range 0 to 9 --out std_logic_vector(3 downto 0):="0000"
--num_out_1: out std_logic_vector(3 downto 0)
);
end num_trans;

architecture Behavioral of num_trans is

--signal num_temp_0: std_logic_vector(3 downto 0):="0000";
--signal num_temp_1: std_logic_vector(3 downto 0):="0000";

begin
process(num_in)
VARIABLE NUM: INTEGER RANGE 0 TO 99;
VARIABLE HUNDRED,TEN,ONE: integer range 0 to 9;
VARIABLE T,O: STD_LOGIC_VECTOR(3 DOWNTO 0);
	BEGIN
	NUM:=num_in;
	TEN:=NUM MOD 10;
	ONE:=NUM MOD 10;
	T:=CONV_STD_LOGIC_VECTOR(TEN,4);
	O:=CONV_STD_LOGIC_VECTOR(ONE,4);
	--num_out_0<=O(3 downto 0);
	--num_out_1<=T(7 downto 3);
	num_out_0<=TEN;
	num_out_0<=ONE;
	
END PROCESS;


end Behavioral;

