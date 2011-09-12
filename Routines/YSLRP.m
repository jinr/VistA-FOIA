YSLRP ;ALB/ASF-LOOKUP PATIENT 7/13/88 ;12/18/90  18:23 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 ; Called by routines YSCEN5, YSCEN51, YSDX3U, YSHX1, YSMV, YSPHY
 ; YSPPJ, YSPROB, YSPROB4, YSPROBR, YSPTX, YSSR
 S DIC(0)="ACEQMZ"
1 ; Called by routine YSCEN1
 D CNCLN S DIC="^DPT(",YSDFN=-1 D ^DIC S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) S:Y>0 YSDFN=+Y,Z1=Y I $D(Y(0)) S:'$D(YSDFN(0)) YSDFN(0)=Y(0)
 I YSTOUT!YSUOUT!(YSDFN'>0) S YSQT=1 G END
PTVAR ;Patient Variables
 S DFN=YSDFN D DEM^VADPT,PID^VADPT
 S YSNM=VADM(1),YSSEX=$P(VADM(5),U),YSDOB=$P(VADM(3),U,2),YSAGE=VADM(4),YSSSN=VA("PID")
CN ;
 I '$D(^PTX(YSDFN,"CN"))!$D(YSSCN) G MS
 S YSLK=$O(^YSG("CNT","AA",YSDFN,"CN",DUZ,0)) G CNPT:'YSLK
 S YSCM=$O(^YSG("CNT","AD",YSDFN,"SC",0)) G MS:'YSCM,MS:YSLK<YSCM
CNPT ;
 D ENCN^YSPTXR S DIC="^YSG(""CNT"",1,1,",DLAYGO=600,DIC(0)="L",X="""NOW""" D ^DIC S ^YSG("CNT",1,1,+Y,0)=$P(Y,U,2)_U_YSDFN_U_"CN"_U_DUZ,^YSG("CNT","AA",YSDFN,"CN",DUZ,9999999-$P(Y,U,2),+Y)=""
MS ;
 G:'$D(^PTX(YSDFN,"MS"))!$D(YSSCN) END S YSLK=$O(^YSG("CNT","AA",YSDFN,"MS",DUZ,0)) I YSLK>0 S YSCM=$O(^YSG("CNT","AD",YSDFN,"SM",0)) G:YSCM<1!(YSLK'>YSCM) END
 W !!!?10,"Message(s) are on file for ",$P(^DPT(YSDFN,0),U),!?10,"Last message was entered on " S YSCM=$O(^PTX(YSDFN,"MS",0)),Y=9999999-YSCM D DD^%DT W $C(7,7),Y,!
 D WAIT^YSUTL
 S DIC="^YSG(""CNT"",1,1,",DLAYGO=600,DIC(0)="L",X="""NOW""" D ^DIC S ^YSG("CNT",1,1,+Y,0)=$P(Y,U,2)_U_YSDFN_U_"MS"_U_DUZ,^YSG("CNT","AA",YSDFN,"MS",DUZ,9999999-$P(Y,U,2),+Y)=""
END ;
 K YSLK,YSCM,DIC,DIE,DA,DR Q
CNCLN ;
 Q:DT=$G(^YSG("CNT",1,0))
 L +^YSG("CNT") K ^YSG("CNT",1),^YSG("CNT","B"),^("AA"),^("AD") S ^YSG("CNT",0)="CRISIS NOTE DISPLAY^600.7D^1^1",^YSG("CNT",1,0)=DT,^YSG("CNT",1,1,0)="^600.71DA^0^0",^YSG("CNT","B",DT,1)="" L -^YSG("CNT")