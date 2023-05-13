----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:52 04/16/2019 
-- Design Name: 
-- Module Name:    RS232_TX - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


 
entity RS232_TX is
  port (
    clock       : in  std_logic;
    start       : in  std_logic;
	 reset       : in  std_logic;
    DI          : in  std_logic_vector(7 downto 0);
    Busy        : out std_logic;
    Data          : out std_logic
    );
end RS232_TX;
 
 
architecture Behavioral of RS232_TX is
 
  type state_type is (A, B, C, D);

  subtype t_counter is integer range 0 to 433;
  subtype t_index   is integer range 0 to 7;
  subtype t_byte    is std_logic_vector(7 downto 0);

  constant ticks : t_counter := 433; --434 - 1

  signal index   : t_index;
  signal licznik : t_counter;
  signal state   : state_type;

  signal DI_buff : t_byte;
   
begin
	
  proces_2 : process(reset, clock)
  begin
  
  if reset = '1' then
    Busy <= '0';
    Data <= '1';
    index <= 0;
    state <= A;
  elsif rising_edge(clock) then
	
    case state is
        when A =>		--idle
          if start = '1' then
            licznik <= 0;
            index <= 0;
 
            Busy <= '1';
            Data <= '0';
            DI_buff <= DI;

				state <= B;
          end if;
         
        when B =>		--start 
			if licznik >= ticks then
				licznik <= 0;
            state <= C;
         else
				licznik <= licznik + 1;
         end if;
 
        when C =>	--dane
          Data <= DI_buff(index);
			 
			 if licznik >= ticks then
            licznik <= 0;
             
            if index < 7 then
              index <= index + 1;
            else
              index <= 0;
  			     Data <= '1';
              state <= D;
            end if;
          else
            licznik <= licznik + 1;
          end if;
 
        when D => --stop
			 if licznik >= ticks then
            licznik <= 0;
				state <= A;
          else
            licznik <= licznik + 1;
          end if;
 
      end case;
	end if;		
  end process proces_2;
  
end Behavioral;
