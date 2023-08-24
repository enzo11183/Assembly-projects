#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <iostream>
#include "image_processing.cpp"

using namespace std;

void SteganografiBul(int n, int resimadres_org, int resimadres_ste, int steganografi_adres);

int main(void) {
	int M, N, Q, i, j;
	bool type;
	int efile;
	char org_resim[100], ste_resim[100], steganografi[100];
	do {
		printf("Orijinal resmin yolunu (path) giriniz:\n-> ");
		scanf("%s", &org_resim);
		system("CLS");
		efile = readImageHeader(org_resim, N, M, Q, type);
	} while (efile > 1);
	int** resim_org = resimOku(org_resim);

	do {
		printf("Steganografik resmin yolunu (path) giriniz:\n-> ");
		scanf("%s", &ste_resim);
		system("CLS");
		efile = readImageHeader(ste_resim, N, M, Q, type);
	} while (efile > 1);
	int** resim_ste = resimOku(ste_resim);

	printf("Orjinal Resim Yolu: \t\t\t%s\n", org_resim);
	printf("SteganografiK Resim Yolu: \t\t%s\n", ste_resim);

	short *resimdizi_org, *resimdizi_ste;
	resimdizi_org = (short*) malloc(N*M * sizeof(short));
	resimdizi_ste = (short*) malloc(N*M * sizeof(short));

	for (i = 0; i < N; i++) 
		for (j = 0; j < M; j++) {
			resimdizi_org[i*N + j] = (short) resim_org[i][j];
			resimdizi_ste[i*N + j] = (short) resim_ste[i][j];
		}

	int resimadres_org = (int) resimdizi_org;
	int resimadres_ste = (int) resimdizi_ste;
	int steganografi_adres = (int) steganografi;

	SteganografiBul(N*M, resimadres_org, resimadres_ste, steganografi_adres);




	printf("\nResim icerisinde gizlenmis kod: \t%s\n", steganografi);
	system("PAUSE");
	return 0;
}

void SteganografiBul(int n, int resim_org, int resim_ste, int steganografi_adres) {

	
	__asm {

		MOV ECX, n

		MOV EDI, resim_org  
		MOV EDX,resim_ste

		MOV EBX, steganografi_adres                   



	L1:	
		MOV AX, WORD PTR[EDI]

	CMP AX, WORD PTR[EDX]
	JZ donguson

	CMP AX, WORD PTR[EDX]
	JL sifremodsuz

	MOV ESI, 0
	SUB SI, WORD PTR[EDI]
	ADD ESI, 256
	ADD SI, WORD PTR[EDX]



	MOV AX, SI
			MOV BYTE PTR[EBX], AL
	       
		     INC EBX
		
		     JMP donguson

sifremodsuz: MOV ESI,0
	             ADD SI, WORD PTR [EDX]
				 SUB SI,WORD PTR [EDI]
				 
				 
				MOV AX,SI
	
				 MOV BYTE PTR [EBX],AL
				 
				 INC EBX
				 JMP donguson

     
		donguson: ADD EDI,2
			      ADD EDX,2
	             LOOP L1
			
			MOV BYTE PTR[EBX], 32
			INC EBX
		    MOV BYTE PTR [EBX],45
			INC EBX
			MOV BYTE PTR[EBX], 32
			INC EBX
			MOV BYTE PTR[EBX], 49
			INC EBX
			MOV BYTE PTR[EBX], 56
			INC EBX
			MOV BYTE PTR[EBX], 48
			INC EBX
			MOV BYTE PTR[EBX], 49
			INC EBX
			MOV BYTE PTR[EBX], 49
			INC EBX
			MOV BYTE PTR[EBX], 48
			INC EBX
			MOV BYTE PTR[EBX], 56
			INC EBX
			MOV BYTE PTR[EBX], 51
			INC EBX
			MOV BYTE PTR [EBX],0
		


	}
}
