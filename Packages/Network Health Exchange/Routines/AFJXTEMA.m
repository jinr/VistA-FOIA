AFJXTEMA ;FO-OAKLAND/GMB-ONE-TIME ADD PTS TO DB ;1/17/96  13:11
 ;;5.1;Network Health Exchange;**31**;Jan 23, 1996
 ; Totally rewritten 11/2001.  (Previously FJ/CWS.)
ENTER ; Send data from patient file 0 node
 N ZTSAVE,ZTIO,ZTRTN,ZTDESC
 S ZTIO="",ZTRTN="PROCESS^AFJXTEMA",ZTDESC="ONE-TIME ADD PTS TO NETWORK FILE"
 D ^%ZTLOAD
 Q
PROCESS ;
 D PROCESS^AFJXPNHA("ONE-TIME ADD PTS TO NETWORK FILE",2940420)
 Q