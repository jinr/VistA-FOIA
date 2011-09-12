GMTSUMX ; SLC/KER - Convert Text to Mix Case   ; 07/18/2000
 ;;2.7;Health Summary;**30,37**;Oct 20, 1995
 Q
EN(X) ; Convert Case
 N Y,GMTSOK,GMTSOC,GMTSWORD,GMTSPC,GMTSLEAD,GMTSTLR,GMTSTR,GMTSCTR,GMTSPRE
 S (GMTSTR,GMTSWORD,GMTSPC)="",X=$$UP(X)
 ; Parse by Spaces
 F GMTSCTR=1:1:$L(X," ") D
 . S GMTSWORD=$P(X," ",GMTSCTR)
 . S (GMTSPC,GMTSLEAD,GMTSTLR)=""
 . I $E(GMTSWORD,1)="(" S GMTSWORD=$E(GMTSWORD,2,$L(GMTSWORD)),GMTSLEAD="("
 . I $E(GMTSWORD,$L(GMTSWORD))=")" S GMTSWORD=$E(GMTSWORD,1,($L(GMTSWORD)-1)),GMTSTLR=")"
 . ; String contains special characters
 . S GMTSOK=1 F GMTSOC="(",")","-","*","+","{","&","}","[","]","/","\","|",",","'" S:GMTSWORD[GMTSOC GMTSOK=0 Q:'GMTSOK
 . I 'GMTSOK D SP
 . I GMTSOK D GMTSWORD
 . S:GMTSLEAD'="" GMTSWORD=GMTSLEAD_GMTSWORD
 . S:GMTSTLR'="" GMTSWORD=GMTSWORD_GMTSTLR
 . S GMTSTR=GMTSTR_" "_GMTSWORD
 S X=$$TRIM(GMTSTR) Q X
EN2(X) ; Convert Case 2
 S X=$$CK($$EN($G(X))) Q X
SP ; Special Characters
 ; Special Cases of Special Characters
 I $$UP(GMTSWORD)="W/&W/O" S GMTSWORD="w/&w/o" Q
 I $$UP(GMTSWORD)="W&W/O" S GMTSWORD="w&w/o" Q
 I $$UP(GMTSWORD)="&/OR" S GMTSWORD="&/or" Q
 I GMTSWORD="W/O" S GMTSWORD="w/o" Q
 N GMTSOK,GMTSWD1,GMTSWD2,GMTSW,GMTSWCTR,GMTSCHR
 S GMTSWD1=GMTSWORD,GMTSWD2="",GMTSW=""
 F GMTSWCTR=1:1:$L(GMTSWD1) D
 . S GMTSCHR=$E(GMTSWD1,GMTSWCTR) I "()-*+{}'&[]/\|,"[GMTSCHR,$L(GMTSW) D  Q
 . . S GMTSPRE=""
 . . S:$E(GMTSW,1,2)="ZZ"&($L(GMTSW)>2) GMTSPRE="ZZ",GMTSW=$E(GMTSW,3,$L(GMTSW))
 . . S GMTSW=GMTSPRE_$$CASE(GMTSW,GMTSCHR)
 . . S GMTSWD2=GMTSWD2_GMTSW_GMTSCHR,GMTSW=""
 . S GMTSW=GMTSW_GMTSCHR
 I $L(GMTSW) D
 . N GMTSPSN F GMTSPSN=1:1:$L(GMTSW) Q:"()-*+{}'&[]/\|,"'[$E(GMTSW,GMTSPSN)
 . N GMTSOW,GMTSLW S GMTSLW=$E(GMTSW,0,(GMTSPSN-1))
 . S GMTSOW=$E(GMTSW,GMTSPSN,$L(GMTSW))
 . S GMTSPRE="" S:$E(GMTSOW,1,2)="ZZ"&($L(GMTSOW)>2) GMTSPRE="ZZ",GMTSOW=$E(GMTSOW,3,$L(GMTSOW))
 . S GMTSOW=GMTSPRE_$$CASE(GMTSOW,$E($G(GMTSWD2),$L($G(GMTSWD2))))
 . S GMTSW=GMTSLW_GMTSOW
 . S GMTSWD2=GMTSWD2_GMTSW
 S GMTSWORD=GMTSWD2 S:GMTSCTR=1 GMTSWORD=$$LD(GMTSWORD)
 K GMTSWD1,GMTSWD2
 Q
GMTSWORD ; Convert word
 S GMTSPRE="" S:$E(GMTSWORD,1,2)="ZZ"&($L(GMTSWORD)>2) GMTSPRE="ZZ",GMTSWORD=$E(GMTSWORD,3,$L(GMTSWORD))
 S GMTSWORD=GMTSPRE_$$CASE(GMTSWORD,"")
 Q
CASE(X,J) ; Set to Mixed/lower/UPPER case
 N GMTSTAG,GMTSRTN,Y S X=$$UP($G(X)),Y="",GMTSTAG=$L(X),GMTSRTN="GMTSUMX2"
 S:+GMTSTAG>4 GMTSRTN="GMTSUMX3" S:+GMTSTAG>9 GMTSTAG="M"
 Q:+GMTSTAG=0&(GMTSTAG'="M") X
 S GMTSRTN=GMTSTAG_"^"_GMTSRTN D @GMTSRTN
 I $L(Y) S X=Y Q X
 S X=$$MX(X)
 Q X
LO(X) Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
LD(X) Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
TRIM(X) S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
CK(X) ;
 S X=$G(X)
 F  Q:X'["(S)"  S X=$P(X,"(S)",1)_"(s)"_$P(X,"(S)",2,299)
 F  Q:X'[" A "  S X=$P(X," A ",1)_" a "_$P(X," A ",2,229)
 I X["Class a" F  Q:X'["Class a"  S X=$P(X,"Class a",1)_"Class A"_$P(X,"Class a",2,229)
 I X["Type a" F  Q:X'["Type a"  S X=$P(X,"Type a",1)_"Type A"_$P(X,"Type a",2,229)
 F  Q:X'["'S"  S X=$P(X,"'S",1)_"'s"_$P(X,"'S",2,229)
 I X["mg Diet" F  Q:X'["mg Diet"  S X=$P(X,"mg Diet",1)_"MG Diet"_$P(X,"mg Diet",2,229)
 I X["LO-Fat" F  Q:X'["LO-Fat"  S X=$P(X,"LO-Fat",1)_"Lo-Fat"_$P(X,"LO-Fat",2,229)
 I $E(X,1)="'" S X="'"_$$LD($E(X,2,$L(X)))
 S X=$TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
 Q X
TYPES ;
 N GMTSIEN S GMTSIEN=0 F  S GMTSIEN=$O(^GMT(142,GMTSIEN)) Q:+GMTSIEN=0  D
 . N GMTSTXT S GMTSTXT=$P($G(^GMT(142,GMTSIEN,0)),"^",1)
 . I $L(GMTSTXT) W !!,GMTSTXT,!,$$EN^GMTSUMX(GMTSTXT)
 Q