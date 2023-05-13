<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="ROT_A" />
        <signal name="ROT_B" />
        <signal name="Zegar" />
        <signal name="XLXN_4" />
        <signal name="RS232_RXD" />
        <signal name="FEMPTY" />
        <signal name="FFULL" />
        <signal name="led(7:0)" />
        <signal name="Reset" />
        <signal name="XLXN_8(7:0)" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11" />
        <signal name="RS232_TXD" />
        <signal name="XLXN_14" />
        <signal name="XLXN_15" />
        <signal name="XLXN_16" />
        <signal name="XLXN_19" />
        <signal name="XLXN_21" />
        <signal name="XLXN_23" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <port polarity="Input" name="ROT_A" />
        <port polarity="Input" name="ROT_B" />
        <port polarity="Input" name="Zegar" />
        <port polarity="Input" name="RS232_RXD" />
        <port polarity="Output" name="FEMPTY" />
        <port polarity="Output" name="FFULL" />
        <port polarity="Output" name="led(7:0)" />
        <port polarity="Input" name="Reset" />
        <port polarity="Output" name="XLXN_11" />
        <port polarity="Output" name="RS232_TXD" />
        <blockdef name="RotaryEnc">
            <timestamp>2019-5-20T22:49:18</timestamp>
            <rect width="256" x="64" y="-256" height="192" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="rec_fifo">
            <timestamp>2019-5-31T13:59:19</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-128" y2="-128" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="RS232_TX">
            <timestamp>2019-5-31T13:48:11</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <block symbolname="RotaryEnc" name="XLXI_1">
            <blockpin signalname="ROT_A" name="ROT_A" />
            <blockpin signalname="ROT_B" name="ROT_B" />
            <blockpin signalname="XLXN_25" name="RotL" />
            <blockpin signalname="XLXN_24" name="RotR" />
            <blockpin signalname="Zegar" name="Clk" />
        </block>
        <block symbolname="rec_fifo" name="XLXI_2">
            <blockpin signalname="RS232_RXD" name="DI" />
            <blockpin signalname="Zegar" name="Zegar" />
            <blockpin signalname="XLXN_24" name="FIFO_POP" />
            <blockpin signalname="Reset" name="Reset" />
            <blockpin signalname="FEMPTY" name="FIFO_EMPTY" />
            <blockpin signalname="FFULL" name="FIFO_FULL" />
            <blockpin signalname="led(7:0)" name="FIFO_DO(7:0)" />
        </block>
        <block symbolname="RS232_TX" name="XLXI_3">
            <blockpin signalname="Zegar" name="clock" />
            <blockpin signalname="XLXN_21" name="start" />
            <blockpin signalname="Reset" name="reset" />
            <blockpin signalname="led(7:0)" name="DI(7:0)" />
            <blockpin signalname="XLXN_11" name="Busy" />
            <blockpin signalname="RS232_TXD" name="Data" />
        </block>
        <block symbolname="or2" name="XLXI_4">
            <blockpin signalname="XLXN_25" name="I0" />
            <blockpin signalname="XLXN_24" name="I1" />
            <blockpin signalname="XLXN_21" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="864" y="832" name="XLXI_1" orien="R0">
        </instance>
        <branch name="ROT_A">
            <wire x2="864" y1="608" y2="608" x1="560" />
        </branch>
        <branch name="ROT_B">
            <wire x2="864" y1="672" y2="672" x1="560" />
        </branch>
        <branch name="RS232_RXD">
            <wire x2="1328" y1="432" y2="432" x1="560" />
            <wire x2="1328" y1="432" y2="576" x1="1328" />
            <wire x2="2080" y1="576" y2="576" x1="1328" />
        </branch>
        <branch name="FEMPTY">
            <wire x2="2800" y1="576" y2="576" x1="2464" />
        </branch>
        <branch name="FFULL">
            <wire x2="2800" y1="672" y2="672" x1="2464" />
        </branch>
        <iomarker fontsize="28" x="2800" y="576" name="FEMPTY" orien="R0" />
        <branch name="Reset">
            <wire x2="704" y1="864" y2="864" x1="544" />
            <wire x2="2032" y1="864" y2="864" x1="704" />
            <wire x2="704" y1="864" y2="1184" x1="704" />
            <wire x2="2720" y1="1184" y2="1184" x1="704" />
            <wire x2="2080" y1="768" y2="768" x1="2032" />
            <wire x2="2032" y1="768" y2="864" x1="2032" />
        </branch>
        <iomarker fontsize="28" x="544" y="736" name="Zegar" orien="R180" />
        <iomarker fontsize="28" x="560" y="672" name="ROT_B" orien="R180" />
        <iomarker fontsize="28" x="560" y="608" name="ROT_A" orien="R180" />
        <iomarker fontsize="28" x="544" y="864" name="Reset" orien="R180" />
        <iomarker fontsize="28" x="2800" y="672" name="FFULL" orien="R0" />
        <iomarker fontsize="28" x="2800" y="768" name="led(7:0)" orien="R0" />
        <iomarker fontsize="28" x="560" y="432" name="RS232_RXD" orien="R180" />
        <instance x="2720" y="1280" name="XLXI_3" orien="R0">
        </instance>
        <instance x="2080" y="800" name="XLXI_2" orien="R0">
        </instance>
        <branch name="led(7:0)">
            <wire x2="2592" y1="768" y2="768" x1="2464" />
            <wire x2="2800" y1="768" y2="768" x1="2592" />
            <wire x2="2592" y1="768" y2="1248" x1="2592" />
            <wire x2="2720" y1="1248" y2="1248" x1="2592" />
        </branch>
        <branch name="XLXN_11">
            <wire x2="3184" y1="1056" y2="1056" x1="3104" />
        </branch>
        <branch name="RS232_TXD">
            <wire x2="3184" y1="1248" y2="1248" x1="3104" />
        </branch>
        <iomarker fontsize="28" x="3184" y="1056" name="XLXN_11" orien="R0" />
        <iomarker fontsize="28" x="3184" y="1248" name="RS232_TXD" orien="R0" />
        <branch name="Zegar">
            <wire x2="816" y1="736" y2="736" x1="544" />
            <wire x2="864" y1="736" y2="736" x1="816" />
            <wire x2="816" y1="736" y2="832" x1="816" />
            <wire x2="816" y1="832" y2="1056" x1="816" />
            <wire x2="2720" y1="1056" y2="1056" x1="816" />
            <wire x2="1968" y1="832" y2="832" x1="816" />
            <wire x2="2080" y1="640" y2="640" x1="1968" />
            <wire x2="1968" y1="640" y2="832" x1="1968" />
        </branch>
        <instance x="2144" y="1056" name="XLXI_4" orien="R0" />
        <branch name="XLXN_21">
            <wire x2="2560" y1="960" y2="960" x1="2400" />
            <wire x2="2560" y1="960" y2="1120" x1="2560" />
            <wire x2="2720" y1="1120" y2="1120" x1="2560" />
        </branch>
        <branch name="XLXN_24">
            <wire x2="1296" y1="672" y2="672" x1="1248" />
            <wire x2="1296" y1="672" y2="704" x1="1296" />
            <wire x2="1840" y1="704" y2="704" x1="1296" />
            <wire x2="2080" y1="704" y2="704" x1="1840" />
            <wire x2="1840" y1="704" y2="928" x1="1840" />
            <wire x2="2144" y1="928" y2="928" x1="1840" />
        </branch>
        <branch name="XLXN_25">
            <wire x2="1696" y1="608" y2="608" x1="1248" />
            <wire x2="1696" y1="608" y2="992" x1="1696" />
            <wire x2="2144" y1="992" y2="992" x1="1696" />
        </branch>
    </sheet>
</drawing>