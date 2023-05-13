--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : rec_fifo_schemat.vhf
-- /___/   /\     Timestamp : 05/31/2019 16:37:22
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl C:/Users/lab/Desktop/RS232-235568-235714/rec_fifo_schemat.vhf -w C:/Users/lab/Desktop/RS232-235568-235714/rec_fifo_schemat.sch
--Design Name: rec_fifo_schemat
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity rec_fifo_schemat is
   port ( Reset     : in    std_logic; 
          ROT_A     : in    std_logic; 
          ROT_B     : in    std_logic; 
          RS232_RXD : in    std_logic; 
          Zegar     : in    std_logic; 
          FEMPTY    : out   std_logic; 
          FFULL     : out   std_logic; 
          led       : out   std_logic_vector (7 downto 0); 
          RS232_TXD : out   std_logic; 
          XLXN_11   : out   std_logic);
end rec_fifo_schemat;

architecture BEHAVIORAL of rec_fifo_schemat is
   attribute BOX_TYPE   : string ;
   signal XLXN_21   : std_logic;
   signal XLXN_24   : std_logic;
   signal XLXN_25   : std_logic;
   signal led_DUMMY : std_logic_vector (7 downto 0);
   component RotaryEnc
      port ( ROT_A : in    std_logic; 
             ROT_B : in    std_logic; 
             RotL  : out   std_logic; 
             RotR  : out   std_logic; 
             Clk   : in    std_logic);
   end component;
   
   component rec_fifo
      port ( DI         : in    std_logic; 
             Zegar      : in    std_logic; 
             FIFO_POP   : in    std_logic; 
             Reset      : in    std_logic; 
             FIFO_EMPTY : out   std_logic; 
             FIFO_FULL  : out   std_logic; 
             FIFO_DO    : out   std_logic_vector (7 downto 0));
   end component;
   
   component RS232_TX
      port ( clock : in    std_logic; 
             start : in    std_logic; 
             reset : in    std_logic; 
             DI    : in    std_logic_vector (7 downto 0); 
             Busy  : out   std_logic; 
             Data  : out   std_logic);
   end component;
   
   component OR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR2 : component is "BLACK_BOX";
   
begin
   led(7 downto 0) <= led_DUMMY(7 downto 0);
   XLXI_1 : RotaryEnc
      port map (Clk=>Zegar,
                ROT_A=>ROT_A,
                ROT_B=>ROT_B,
                RotL=>XLXN_25,
                RotR=>XLXN_24);
   
   XLXI_2 : rec_fifo
      port map (DI=>RS232_RXD,
                FIFO_POP=>XLXN_24,
                Reset=>Reset,
                Zegar=>Zegar,
                FIFO_DO(7 downto 0)=>led_DUMMY(7 downto 0),
                FIFO_EMPTY=>FEMPTY,
                FIFO_FULL=>FFULL);
   
   XLXI_3 : RS232_TX
      port map (clock=>Zegar,
                DI(7 downto 0)=>led_DUMMY(7 downto 0),
                reset=>Reset,
                start=>XLXN_21,
                Busy=>XLXN_11,
                Data=>RS232_TXD);
   
   XLXI_4 : OR2
      port map (I0=>XLXN_25,
                I1=>XLXN_24,
                O=>XLXN_21);
   
end BEHAVIORAL;


