<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="MS583730BA01-50">
<packages>
<package name="TE_MS583730BA01-50">
<wire x1="-1.65" y1="1.65" x2="-1.65" y2="-1.65" width="0.127" layer="51"/>
<wire x1="-1.65" y1="-1.65" x2="1.65" y2="-1.65" width="0.127" layer="51"/>
<wire x1="1.65" y1="-1.65" x2="1.65" y2="1.65" width="0.127" layer="51"/>
<wire x1="1.65" y1="1.65" x2="-1.65" y2="1.65" width="0.127" layer="51"/>
<wire x1="-1.65" y1="0.2" x2="-1.65" y2="-0.2" width="0.127" layer="21"/>
<wire x1="-0.2" y1="1.65" x2="0.2" y2="1.65" width="0.127" layer="21"/>
<wire x1="1.65" y1="0.2" x2="1.65" y2="-0.2" width="0.127" layer="21"/>
<wire x1="-0.2" y1="-1.65" x2="0.2" y2="-1.65" width="0.127" layer="21"/>
<circle x="-2.25" y="1" radius="0.1" width="0.2" layer="21"/>
<wire x1="-1.9" y1="1.9" x2="1.9" y2="1.9" width="0.05" layer="39"/>
<wire x1="1.9" y1="1.9" x2="1.9" y2="-1.9" width="0.05" layer="39"/>
<wire x1="1.9" y1="-1.9" x2="-1.9" y2="-1.9" width="0.05" layer="39"/>
<wire x1="-1.9" y1="-1.9" x2="-1.9" y2="1.9" width="0.05" layer="39"/>
<text x="-1.906640625" y="2.160859375" size="0.610125" layer="25">&gt;NAME</text>
<text x="-1.90796875" y="-2.671159375" size="0.61055" layer="27">&gt;VALUE</text>
<circle x="-1" y="1" radius="0.1" width="0.2" layer="51"/>
<smd name="1" x="-1" y="1" dx="1.3" dy="1.3" layer="1"/>
<smd name="2" x="-1" y="-1" dx="1.3" dy="1.3" layer="1"/>
<smd name="3" x="1" y="-1" dx="1.3" dy="1.3" layer="1"/>
<smd name="4" x="1" y="1" dx="1.3" dy="1.3" layer="1"/>
</package>
</packages>
<symbols>
<symbol name="MS583730BA01-50">
<wire x1="7.62" y1="5.08" x2="7.62" y2="-5.08" width="0.254" layer="94"/>
<wire x1="7.62" y1="-5.08" x2="-7.62" y2="-5.08" width="0.254" layer="94"/>
<wire x1="-7.62" y1="-5.08" x2="-7.62" y2="5.08" width="0.254" layer="94"/>
<wire x1="-7.62" y1="5.08" x2="7.62" y2="5.08" width="0.254" layer="94"/>
<text x="-7.63008125" y="5.84973125" size="1.78035" layer="95">&gt;NAME</text>
<text x="-7.632459375" y="-7.632459375" size="1.780909375" layer="96">&gt;VALUE</text>
<pin name="VDD" x="12.7" y="2.54" length="middle" direction="pwr" rot="R180"/>
<pin name="GND" x="12.7" y="-2.54" length="middle" direction="pwr" rot="R180"/>
<pin name="SCL" x="-12.7" y="2.54" length="middle" direction="in" function="clk"/>
<pin name="SDA" x="-12.7" y="-2.54" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="MS583730BA01-50" prefix="U">
<description>SENSOR PRESSURE UNDERWATER</description>
<gates>
<gate name="G$1" symbol="MS583730BA01-50" x="0" y="0"/>
</gates>
<devices>
<device name="" package="TE_MS583730BA01-50">
<connects>
<connect gate="G$1" pin="GND" pad="1"/>
<connect gate="G$1" pin="SCL" pad="3"/>
<connect gate="G$1" pin="SDA" pad="4"/>
<connect gate="G$1" pin="VDD" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="COMMENT" value="MS583730BA01-50"/>
<attribute name="DESCRIPTION" value=" Waterproof Digital Pressure Ms583730ba01-50 "/>
<attribute name="DIGI-KEY_PART_NUMBER" value="223-1704-1-ND"/>
<attribute name="DIGIKEY-PURCHASE-URL" value="https://snapeda.com/shop?store=DigiKey&amp;id=566080"/>
<attribute name="MF" value="TE Connectivity"/>
<attribute name="MOUSER-PURCHASE-URL" value="https://snapeda.com/shop?store=Mouser&amp;id=566080"/>
<attribute name="MP" value="MS583730BA01-50"/>
<attribute name="PACKAGE" value="SMD-4 TE Connectivity ALCOSWITCH Switches"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="wirepad" urn="urn:adsk.eagle:library:412">
<description>&lt;b&gt;Single Pads&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="1,6/0,8" urn="urn:adsk.eagle:footprint:30809/1" library_version="2">
<description>&lt;b&gt;THROUGH-HOLE PAD&lt;/b&gt;</description>
<wire x1="-0.762" y1="0.762" x2="-0.508" y2="0.762" width="0.1524" layer="21"/>
<wire x1="-0.762" y1="0.762" x2="-0.762" y2="0.508" width="0.1524" layer="21"/>
<wire x1="0.762" y1="0.762" x2="0.762" y2="0.508" width="0.1524" layer="21"/>
<wire x1="0.762" y1="0.762" x2="0.508" y2="0.762" width="0.1524" layer="21"/>
<wire x1="0.762" y1="-0.508" x2="0.762" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="0.762" y1="-0.762" x2="0.508" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="-0.508" y1="-0.762" x2="-0.762" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="-0.762" y1="-0.762" x2="-0.762" y2="-0.508" width="0.1524" layer="21"/>
<circle x="0" y="0" radius="0.635" width="0.1524" layer="51"/>
<pad name="1" x="0" y="0" drill="0.8128" diameter="1.6002" shape="octagon"/>
<text x="-0.762" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0.6" size="0.0254" layer="27">&gt;VALUE</text>
</package>
</packages>
<packages3d>
<package3d name="1,6/0,8" urn="urn:adsk.eagle:package:30830/1" type="box" library_version="2">
<description>THROUGH-HOLE PAD</description>
<packageinstances>
<packageinstance name="1,6/0,8"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="PAD" urn="urn:adsk.eagle:symbol:30808/1" library_version="2">
<wire x1="-1.016" y1="1.016" x2="1.016" y2="-1.016" width="0.254" layer="94"/>
<wire x1="-1.016" y1="-1.016" x2="1.016" y2="1.016" width="0.254" layer="94"/>
<text x="-1.143" y="1.8542" size="1.778" layer="95">&gt;NAME</text>
<text x="-1.143" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="P" x="2.54" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="1,6/0,8" urn="urn:adsk.eagle:component:30848/2" prefix="PAD" uservalue="yes" library_version="2">
<description>&lt;b&gt;THROUGH-HOLE PAD&lt;/b&gt;</description>
<gates>
<gate name="P" symbol="PAD" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1,6/0,8">
<connects>
<connect gate="P" pin="P" pad="1"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:30830/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="15" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="U1" library="MS583730BA01-50" deviceset="MS583730BA01-50" device=""/>
<part name="PAD1" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="1,6/0,8" device="" package3d_urn="urn:adsk.eagle:package:30830/1"/>
<part name="PAD2" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="1,6/0,8" device="" package3d_urn="urn:adsk.eagle:package:30830/1"/>
<part name="PAD3" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="1,6/0,8" device="" package3d_urn="urn:adsk.eagle:package:30830/1"/>
<part name="PAD4" library="wirepad" library_urn="urn:adsk.eagle:library:412" deviceset="1,6/0,8" device="" package3d_urn="urn:adsk.eagle:package:30830/1"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U1" gate="G$1" x="35.56" y="48.26" smashed="yes">
<attribute name="NAME" x="27.92991875" y="54.10973125" size="1.78035" layer="95"/>
<attribute name="VALUE" x="27.927540625" y="40.627540625" size="1.780909375" layer="96"/>
</instance>
<instance part="PAD1" gate="P" x="55.88" y="45.72" smashed="yes" rot="R180">
<attribute name="NAME" x="57.023" y="43.8658" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="57.023" y="49.022" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD2" gate="P" x="55.88" y="50.8" smashed="yes" rot="R180">
<attribute name="NAME" x="57.023" y="48.9458" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="57.023" y="54.102" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="PAD3" gate="P" x="17.78" y="50.8" smashed="yes">
<attribute name="NAME" x="16.637" y="52.6542" size="1.778" layer="95"/>
<attribute name="VALUE" x="16.637" y="47.498" size="1.778" layer="96"/>
</instance>
<instance part="PAD4" gate="P" x="17.78" y="45.72" smashed="yes">
<attribute name="NAME" x="16.637" y="47.5742" size="1.778" layer="95"/>
<attribute name="VALUE" x="16.637" y="42.418" size="1.778" layer="96"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="PAD3" gate="P" pin="P"/>
<pinref part="U1" gate="G$1" pin="SCL"/>
<wire x1="20.32" y1="50.8" x2="22.86" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="PAD4" gate="P" pin="P"/>
<pinref part="U1" gate="G$1" pin="SDA"/>
<wire x1="20.32" y1="45.72" x2="22.86" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U1" gate="G$1" pin="VDD"/>
<pinref part="PAD2" gate="P" pin="P"/>
<wire x1="48.26" y1="50.8" x2="53.34" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="PAD1" gate="P" pin="P"/>
<pinref part="U1" gate="G$1" pin="GND"/>
<wire x1="53.34" y1="45.72" x2="48.26" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
