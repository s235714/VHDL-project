library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity rec_fifo is
    Port ( 
			  DI 			 : in  STD_LOGIC;
           Zegar      : in  STD_LOGIC;
			  FIFO_EMPTY : out STD_LOGIC;
           FIFO_FULL  : out STD_LOGIC;
			  FIFO_POP   : in  STD_LOGIC;
			  FIFO_DO    : out STD_LOGIC_VECTOR(7 downto 0);
			  Reset      : in  STD_LOGIC);
end rec_fifo;

architecture Behavioral of rec_fifo is

	type state_type is (A, B, C, D);
	
	subtype t_counter is integer range 0 to 433;
	subtype t_index   is integer range 0 to 7;
	subtype t_data    is std_logic_vector(7 downto 0);
	type t_fifo is array(natural range<>) of t_data;

   constant FIFO_LEN : positive := 10;
	constant ticks : t_counter := 433; --434 - 1
	
	signal fifo : t_fifo(0 to FIFO_LEN - 1);
	signal fifo_in  : natural range 0 to FIFO_LEN - 1;
	signal fifo_out : natural range 0 to FIFO_LEN - 1;
	signal fifo_cnt : natural range 0 to FIFO_LEN;
	signal state   : state_type;
	signal index   : t_index;
	signal licznik : t_counter;
	signal prev    : std_logic := '1';
   signal tmp     : std_logic := '0'; 
   signal bufor   : t_data;
   signal r       : std_logic := '0';
	signal DI_l  	: std_logic := '1';

begin

	
	proces : process(Reset, Zegar)
	
	
	--------------------------------------------------------------------------------
procedure fifo_clear is
  begin
		fifo_in <= 0;
		fifo_out <= 0;
		fifo_cnt <= 0;
		for i in 0 to FIFO_LEN - 1 loop
			fifo(i) <= (others => '0');
		end loop;
  end procedure fifo_clear;
  
--------------------------------------------------------------------------------
procedure fifo_push_data (data : in t_data) is
  begin
    if fifo_cnt < FIFO_LEN then
      fifo(fifo_in) <= data;
      fifo_cnt <= fifo_cnt + 1;
      if fifo_in = FIFO_LEN - 1 then
        fifo_in <= 0;
      else
        fifo_in <= fifo_in + 1;
      end if;
    end if;
  end procedure fifo_push_data;
  
--------------------------------------------------------------------------------
procedure fifo_pop_data (data : out t_data) is
  begin
    if fifo_cnt > 0 then
       data := fifo(fifo_out);
      fifo_cnt <= fifo_cnt - 1;
      if fifo_out = FIFO_LEN - 1 then
        fifo_out <= 0;
      else
        fifo_out <= fifo_out + 1;
      end if;
--    else
--      fifo_in <= 0;
--      fifo_out <= 0;
--      fifo(fifo_out) <= (others => '0');
    end if;
  end procedure fifo_pop_data;
----------------------------------------------------------------------------
variable temp : t_data;
	begin
		if Reset = '1' then
			DI_l <= '1';
			index <= 0;
			state <= A;
			
			fifo_clear;

  		elsif rising_edge(Zegar) then

         DI_l <= DI;
			prev <= DI_l;
         
			if FIFO_POP = '1' then
					fifo_pop_data (temp);
			end if;
         
			case state is
				
				when A =>	--wykrywamy zmiane
					licznik <= 0;
					index <= 0;
               --Rdy <= '0';
					
--					if FIFO_POP = '1' then
--							fifo_pop_data (temp);
--					end if;
					
					if DI_l = '0' and prev = '1' then
						state <= B;
					end if;
					
				when B => --bit startu
					
					if licznik >= ticks / 2 then
						if DI_l = '1' then
						  state <= A;
                  else
                    licznik <= 0;
						  state <= C;
                  end if;
					else
						licznik <= licznik + 1;
					end if;
					
				when C => -- dane
            
					if licznik >= ticks then
					   bufor(index) <= DI;

                  if index >= 7 then
                    licznik <= 0;
						  state <= D;
					   else
						  index <= index + 1;
                    licznik <= 0;
                  end if;
					else
						licznik <= licznik + 1;
					end if;
               
					
				when D => -- bit stopu
					
					if licznik >= ticks then
					  state <= A;
					  					  
					  fifo_push_data (bufor);
					  
                else 
						licznik <= licznik + 1;
					end if;
					
			end case;
		end if;		
	end process proces;
	
	FIFO_EMPTY <= '1' when fifo_cnt = 0 else '0';
	FIFO_FULL <= '1' when fifo_cnt = FIFO_LEN else '0';
	FIFO_DO <= fifo(fifo_out);
   
end Behavioral;
