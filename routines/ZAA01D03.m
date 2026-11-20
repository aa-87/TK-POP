ZAA01D03
	;
	;^PTG(100)="100:1:AHMED:ABDELRAZEK:355 EUCLID AVE:YOUNGSTOWN:OHIO:44506"
	;
	Q
	;
OnBeforeGet(data)
	i $g(data("ACCOUNT"))="" s %ZAUT1STATUS="0`ACCOUNT number is required [ACCOUNT]" q
	i '$d(^PTG(data("ACCOUNT"))) s %ZAUT1STATUS="0`No patient demographics data for "_data("ACCOUNT") q
	q
	;
Map
		 ; FieldName					Global		Delimiter  Piece	Index1		Index2		Index3
	 ; -------------------				------		---------  -----	------		------		------	
	 ; Account							^PTG			:	     1		ACCOUNT
	 ; Patient							^PTG			:	     2		ACCOUNT	
	 ; FirstName						^PTG			:	     3		ACCOUNT	
	 ; LastName							^PTG			:	     4		ACCOUNT	
	 ; Street							^PTG			:	     5		ACCOUNT
	 ; City								^PTG			:	     6		ACCOUNT		
	 ; State							^PTG			:	     7		ACCOUNT	
	 ; Zip								^PTG			:	     8		ACCOUNT	
	;
	Q
OnAfterGet(data)
	;ZK @data@("ReportBatches")
	Q
TestOne
	N A S A="100"
	K DATA
	S DATA("ACCOUNT")=A
	W $$Get^ZAA($na(DATA),"ADSPatientDemographics")
	Q
TestMany
	N A,D,ST,CNTS,CNTF 
	S (CNTS,CNTF)=0
	S A="" F  S A=$O(^PTG(A)) Q:A=""  D
	. K D
	. S D("ACCOUNT")=A
	. S ST=$$Get^ZAA($na(D),"ADSPatientDemographics")
	. I ST S CNTS=CNTS+1
	. E   S CNTF=CNTF+1
	. W "  ACCOUNT:"_(CNTF+CNTS)_"=>"_$J(CNTS,6," ")_"(Success) "_$J(CNTF,6," ")_"(Fail)"_$S('ST:$E(ST,1,30),1:""),!
	Q
