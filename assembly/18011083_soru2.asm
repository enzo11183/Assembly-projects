mystack SEGMENT PARA STACK 'yigin'
        DW 32 DUP(?)
mystack ENDS

datas SEGMENT PARA 'veri'
   
   CR     EQU 13
   LF     EQU 10
   MSG1   DB  CR,LF, 'Ucgen dizisinin eleman sayisini giriniz:' ,0
   MSG2   DB  CR, LF,'Diziyi girin :',0
   MSG3   DB  CR,LF, 'Dizi elemani alindi.',0
   MSG4   DB  CR,LF, 'Dizi alimi basarili. Ucgen diziniz tamam.',0

   EL1    DB CR,LF, '1.kenar:',0
   EL2    DB CR,LF, '2.kenar:',0
   EL3    DB CR,LF, '3.kenar:' ,0

   HATA1  DB CR,LF, 'ELEMAN SAYISI GECERSIZ, 0-100 ARASINDA TAM SAYI GIRINIZ !' ,0
   HATA2  DB CR,LF, 'DIZIYE GECERSIZ SAYI GIRDINIZ, 0-1000 ARASINDA TAM SAYI GIRINIZ !' ,0

   HATA5  DB CR,LF, 'ERROR!' ,0
   
   SONUC1 DB CR,LF, 'Ucgeninizin kenarlari sunlardir:',0
   SONUC2 DB CR,LF, 'Bu verilerle ucgen olusturulamadi.',0
     
   indis  DB 0
    n     DW ?
   dizi   DW 100 DUP(?)
   temp   DW ?
   found  DB 0         

datas ENDS

codesg SEGMENT PARA 'kod'
       ASSUME CS:codesg,DS:datas,SS:mystack
       
       UCGEN PROC FAR
        
         PUSH DS
         XOR AX,AX
         PUSH AX
         MOV AX,datas
         MOV DS,AX
         
         
 diziboyut:
         MOV AX,OFFSET MSG1
         CALL PUT_STR 
         CALL GETN
         
         CMP AL,2
         JLE sorun1
         CMP AL,100
         JA sorun1
         JMP devam1
   
   
   sorun1:
         MOV AX, OFFSET HATA1
         CALL PUT_STR
         JMP diziboyut
   
   
         
   devam1:
         MOV n,AX
         
         LEA SI,dizi
         
         
         MOV CX,n
		 
         
         MOV AX, OFFSET MSG2
         CALL PUT_STR

dizialma:
        CALL GETN
		 
		CMP AX,0
        JL sorun2
        CMP AX,1000
        JA sorun2
		
		JMP devam2
		
sorun2: MOV AX, OFFSET HATA2
        CALL PUT_STR
		
		JMP dizialma

devam2: MOV WORD PTR [SI],AX
        MOV AX, OFFSET MSG3
        CALL PUT_STR
         
         ADD SI,2
         

LOOP dizialma

		 
		 
		 MOV AX,OFFSET MSG4
		 CALL PUT_STR
         MOV CX,n
		 DEC CX
		 MOV SI,0
		

 dongudis:        
         
		 PUSH CX
		 PUSH n
		 
		 SUB n,SI
         
		 MOV CX,n
		 DEC CX
         POP n
		 
		 
		 LEA DI,dizi
         
                  donguic:
		                   MOV BX,DI
						   ADD BX,2
						   MOV AX,WORD PTR[DI]
						   CMP AX,WORD PTR[BX]
						   JLE L1

						 
						   MOV temp,AX
						   
						   MOV AX,WORD PTR[BX]
						   MOV WORD PTR[DI],AX

						   MOV AX,temp
						   MOV WORD PTR[BX],AX

                      L1: 
					      ADD DI,2

                 LOOP donguic

        POP CX
		INC SI
LOOP dongudis   


              LEA SI,dizi
			  
			  XOR CX,CX
			  

	 while: 
	 
	        XOR AX,AX
	        CMP found,1
			JE cikis
			 
			MOV CL,indis
			ADD CX,2
	        CMP n,CX
	        JBE cikis
	
			 

            
			MOV BX,SI
			ADD BX,2
			MOV DI,SI
			ADD DI,4

			ADD AX,WORD PTR[SI]
			ADD AX,WORD PTR[BX]

			CMP AX,WORD PTR[DI]
			JBE false1

		    MOV AX,WORD PTR [SI]
			SUB AX,WORD PTR[BX]
	adim:	CMP AX,0
	        JL negatif
            
			
		
	        CMP AX,WORD PTR[DI]
			JAE false2
			
			MOV found,1
			JMP L2

negatif:	NEG AX
           JMP adim

			
			
     false2:
	      ADD SI,2
         
		  MOV CL,indis
		  INC CL
		  MOV indis,CL
          JMP L2
	  
   
   false1:
          ADD SI,2
         
		  MOV CL,indis
		  INC CL
		  MOV indis,CL
          JMP L2


		  L2: 
		     JMP while

cikis: 

       MOV AL,0
       CMP AL,found
	   JE bulunamadi
	   MOV AL,1
	   CMP AL,found
	   JE bulundu
	   
	   JMP bitir


	   bulundu: 
	   MOV AX,OFFSET SONUC1
	   CALL PUT_STR

	   MOV AX,OFFSET EL1
	   CALL PUT_STR
	   MOV AX,WORD PTR[SI]
	   CALL PUTN


	   MOV AX,OFFSET EL2
	   CALL PUT_STR
	   MOV AX,WORD PTR[BX]
	   CALL PUTN

	   MOV AX,OFFSET EL3
	   CALL PUT_STR
	   MOV AX,WORD PTR[DI]
	   CALL PUTN
  
  
  JMP bitir


  bulunamadi: MOV AX,OFFSET SONUC2
              CALL PUT_STR

bitir:
        

		
		
		
		
		RETF
       UCGEN ENDP




PUT_STR PROC NEAR
    
    PUSH BX
    MOV BX,AX
    MOV AL,BYTE PTR [BX]
 
 PUT_LOOP:
    CMP AL,0
    JE PUT_FIN
    CALL PUTC
    INC BX
    MOV AL,BYTE PTR [BX]
    JMP PUT_LOOP 
 PUT_FIN:
    POP BX
    RET
PUT_STR ENDP 


PUTC PROC NEAR
    
    PUSH AX
    PUSH DX
    MOV DL,AL
    MOV AH,2
    INT 21H
    POP DX
    POP AX
    RET
PUTC ENDP 

GETC PROC NEAR
    MOV AH, 1H
    INT 21H
    RET
GETC ENDP 
 
 GETN PROC NEAR
    
    PUSH BX
    PUSH CX
    
  GETN_START:
    
    XOR BX,BX
    XOR CX,CX
  NEW:
    CALL GETC
    CMP AL,CR
    JE FIN_READ
  CTRL_NUM:
    CMP AX,0
    JL error
    CMP AX,1000
    JA error
    
    SUB AL, '0'
    MOV BL,AL
    MOV AX,10
    
    PUSH DX
    MUL CX
    POP DX
    
    MOV CX,AX
    ADD CX,BX
    JMP NEW
  ERROR:
    MOV AX,OFFSET HATA5
    CALL PUT_STR
    JMP GETN_START
  FIN_READ:
    MOV AX,CX
    
  FIN_GETN:
    
    POP CX
    POP BX 
    RET
GETN ENDP

PUTN PROC NEAR
    PUSH CX
    PUSH DX
    XOR DX,DX
    PUSH DX
    
    MOV CX,10
    CMP AX,0
    JGE CALC_DIGITS
    
    NEG AX
    PUSH AX
    MOV AL, '-'
    CALL PUTC
    POP AX
  CALC_DIGITS:
    DIV CX
    ADD DX,'0'
    PUSH DX
    XOR DX,DX
    CMP AX,0
    JNE CALC_DIGITS
    
  DISP_LOOP:
   
   POP AX
   CMP AX,0
   JE END_DISP_LOOP
   CALL PUTC
   JMP DISP_LOOP
   
 END_DISP_LOOP:
   
   POP DX
   POP CX
   RET
PUTN ENDP 




codesg ENDS
END UCGEN