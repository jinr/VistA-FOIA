DIARR4 ;SFISC/DCM-ARCHIVING FUNCTION, FIGURE OUT FG(CONT) ;3/15/93  8:54 AM
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CLEANUP K DIAROSF,DIAROSFN,DIAROBF,DIAROBFN,DIAROFLD,DIAROIDF,DIAROSUB,DIAROLUP
 S (DIARTAB,DIAROIDF,DIAROFLD,DIAROLVL)=0
 Q
 ;
LKUP Q:$E(DIAROVAL)'="@"
 S DIAROVAL=$G(DIAROAT(DIAROVAL)) I $E(DIAROVAL)="@" G LKUP
 S DIAROXX=DIAROX,DIAROX=$P(DIAROX,"=")_"="_DIAROVAL,DIAROBCK=1
 Q
 ;
BKPTR S DIAROLNE="FILE SHIFT (Forward Pointer/Backward Pointer): " D SET^DIARR3
 I DIAROX["=@",$G(^TMP("DIAR",$J,DIAROREQ,DIAROM,DIAROZ+1))'["BEGIN:" S DIAROLNE="FILE: "_$P(DIAROX,U)_" (#"_+$P(DIAROX,U,2)_")" D SET^DIARR3 D SFT2
 Q
 ;
SFT2 S DIAROBPT=1,DIAROXX=DIAROX,DIAROX="BEGIN:"_$P(DIAROX,":")_$P(DIAROX,"=",2)
 D BEGIN^DIARR3
 S DIAROBPT=0
 S DIAROX=DIAROXX K DIAROXX
 Q
 ;
POP S DIAROLVL=DIAROLVL-1 S:DIAROLVL=0 DIAROLVL=1
 K DIAROSUB(DIAROBFN)
 Q
 ;
BE S DIAROLVL=+$P($P(DIAROX,"=",2),"@",2)
 I $P(DIAROX,U)=$P(DIAROSTK(DIAROLVL-1),U) S DIAROSTK(DIAROLVL)=DIAROSTK(DIAROLVL-1)
 S DIAROZ=$O(^TMP("DIAR",$J,DIAROREQ,DIAROM,DIAROZ)),DIAROX2=^(DIAROZ)
 S DIAROLNE="FIELD NAME: "_$P(DIAROX,U)_" (#"_+$P(DIAROX,U,2)_") = "_$P(DIAROX2,"=",2) D SET^DIARR3
 S DIAROLNE="SUBFILE: "_$P(DIAROX,U)_" (#"_$P(DIAROSTK(DIAROLVL),U,2)_") ",DIARTAB=$P(DIAROSTK(DIAROLVL),U,3) D SET^DIARR3
 S DIAROLNE="LOOKUP VALUE (#.01): "_$P(DIAROX2,"=",2) D SET^DIARR3
 S DIAROLNE="FIELD NAME: "_$P(DIAROX2,U)_" (#"_+$P(DIAROX2,U,2)_") = "_$P(DIAROX2,"=",2),DIARTAB=$P(DIAROSTK(DIAROLVL),U,3)+2 D SET^DIARR3 S DIARTAB=DIARTAB-4
 Q