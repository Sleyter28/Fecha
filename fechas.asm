%include "/home/sleyter/Documents/Tarea_Fechas/io.mac"
section .data				;se inicializan las variables
	buffer_fecha: dw "Digite la fecha que desea introducir. Debe introducirla de la siguiente manera: dd/mm/yyyy",10
	largo: equ $-buffer_fecha
	
	;buffer que contienen todas las letras de los dias
	buffer_A: 
			db "AAAAAA",10
		        db "A    A",10
		        db "AAAAAA",10
		        db "A    A",10
		        db "A    A",10
	len_A: equ $-buffer_A
	
	buffer_B: 
			db "BBBBB  ",10
		        db "B    B",10
		        db "BBBBBB",10
		        db "B    B",10
		        db "BBBBBB",10
	len_B: equ $-buffer_B
	
	buffer_C: 
			db "CCCCCC",10
		        db "C          ",10
		        db "C          ",10
		        db "C          ",10
		        db "CCCCCC",10
	len_C: equ $-buffer_C
	
	buffer_D: 
			db "DDDDD",10
		        db "D    D",10
		        db "D    D",10
		        db "D    D",10
		        db "DDDDD",10
	len_D: equ $-buffer_D
	
	buffer_E: 
			db "EEEEEE",10
		        db "E          ",10
		        db "EEEEEE",10
		        db "E          ",10
		        db "EEEEEE",10
	len_E: equ $-buffer_E
	
	buffer_G: 
			db "GGGGGG",10
		        db "G          ",10
		        db "GGGGGG",10
		        db "G    G",10
		        db "GGGGGG",10
	len_G: equ $-buffer_G
	buffer_I: 
			db "IIIIII",10
		        db "  I      ",10
		        db "  I      ",10
		        db "  I      ",10
		        db "IIIIII",10
	len_I: equ $-buffer_I
	buffer_J: 
			db "JJJJJJ",10
		        db "   J      ",10
		        db "   J      ",10
		        db "J  J      ",10
		        db "JJJJ      ",10
	len_J: equ $-buffer_J
	buffer_L: 
			db "L",10
		        db "L",10
		        db "L",10
		        db "L",10
		        db "LLLLLLL",10
	len_L: equ $-buffer_L
	buffer_M: 
			db "M     M",10
		        db "M M M M",10
		        db "M  M  M",10
		        db "M     M",10
		        db "M     M",10
	len_M: equ $-buffer_M
	
	buffer_N: 
			db "N     N",10
		        db "N N   N",10
		        db "N   N N",10
		        db "N    NN",10
		        db "N     N",10
	len_N: equ $-buffer_N
	buffer_O: 
			db "OOOOOO",10
		        db "O    O",10
		        db "O    O",10
		        db "O    O",10
		        db "OOOOOO",10
	len_O: equ $-buffer_O
	buffer_R: 
			db "RRRRRR",10
		        db "R     R",10
		        db "RRRRRR",10
		        db "RR         ",10
		        db "R  R      ",10
			db "R     R   ",10
	len_R: equ $-buffer_R
	buffer_S:
			db "SSSSSS",10
			db "S            ",10
			db "SSSSSS",10
			db "     S",10
			db "SSSSSS",10
	len_S: equ $-buffer_S
	
	buffer_T:
			db"TTTTTTT",10
			db"   T",10
			db"   T",10
			db"   T",10
			db"   T",10
	len_T: equ $-buffer_T
	buffer_U: 
			db "U    U",10
		        db "U    U",10
		        db "U    U",10
		        db "U    U",10
		        db "UUUUUU",10
	len_U: equ $-buffer_U
	buffer_V: 
			db "V     V",10
		        db "V     V",10
		        db " V   V  ",10
		        db "  V V    ",10
		        db "   V      ",10  	
	len_V: equ $-buffer_V
	
	;Mensajes del anno bisiesto
	buffer_si_bisiesto: db "El anno introducido si es bisiesto.",10,0
	len_bisiesto: equ $-buffer_si_bisiesto
	
	buffer_no_bisiesto: db "El anno introducido no es bisiesto.",10,0
	len_nobisiesto: equ $-buffer_no_bisiesto
	
	;guardo los valores para luego cambiarlos
	dia: db "  ",0
	len_dia: equ $-dia 
	
	mes: db "  ",0
	len_mes: equ $-mes 

	anno: db "    ",0
	len_anno: equ $-anno
	
section .bss						;es la seccion donde se inicializan variables que aun no tiene ningun valor
	fecha_usuario: resb 1000			;es la fecha que el usuario introducira
	salida_dia resb 100
	salida_mes resb 100
	salida_anno resb 100
	cont_dia resb 1
	
	
section .text						;seccion donde se programa
	global _start

_start:							;funcion principal, llama a las otras funciones
	call imprimir_msjBienvenida
	GetStr fecha_usuario
	call sacar_Dia
	call sacar_Mes
	call sacar_Anno
	call atoi_Dia
	call atoi_Mes
	call atoi_Anno
	call determinar_Mes
	call es_Bisiesto
	call salir


imprimir_msjBienvenida:				;imprime el msj donde le solicita al usuario que introduzca la fecha
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_fecha
	mov edx, largo
	int 80h
	ret
	
sacar_Dia:						;obtiene el dia de la fecha que introdujo el usuario
	mov bl,byte[fecha_usuario + 0] ; 
	mov byte[dia + 0],bl
	mov cl,byte[fecha_usuario + 1]
	mov byte[dia + 1],cl 
	ret
	
atoi_Dia:							;convierte el dia de ASCII a INTEGER
	XOR eax,eax
        mov AL,byte[dia + 0]
        mov CL,byte[dia + 1]
        sub AL,30h
        sub CL,30h
        mov BL,10
        mul bx
        add AX,CX
        mov [salida_dia],AX
        ret

sacar_Mes:						;obtiene el mes de la fecha introducida por el usuario
	mov bl,byte[fecha_usuario + 2] ; 
	mov byte[mes + 0],bl
	mov cl,byte[fecha_usuario + 3]
	mov byte[mes + 1],cl 
	ret

atoi_Mes: 							;convierte el mes de ASCII a INTEGER
	xor eax, eax
        mov AL,byte[mes + 0]
        mov CL,byte[mes + 1]
        sub AL,30h
        sub CL,30h
        mov BL,10
        mul bx
        add AX,CX
        mov [salida_mes],AX
        ret

sacar_Anno:						;obtiene el anno de la fecha introducida por el usuario
	mov bl,byte[fecha_usuario + 4]
	mov byte[anno + 0], bl
	mov cl,byte[fecha_usuario + 5]
	mov byte[anno + 1],cl
	mov bl, byte[fecha_usuario + 6]
	mov byte[anno + 2],bl
	mov cl, byte[fecha_usuario + 7]
	mov byte[anno + 3], cl
	ret
atoi_Anno:						;convierte el anno de ASCII a INTERGER
	xor eax,eax
        mov AL,byte[anno + 0]
        sub AL,30h
        mov BX,1000
        mul BX
        mov [salida_anno],AX
        mov AL,byte[anno + 1]
        sub AL,30h
        mov BX,100
        mul BX
        add [salida_anno],AX
        mov AL,byte[anno + 2]
        sub AL,30h
        mov BX,10
        mul BX
        add [salida_anno],AX
        mov AL,byte[anno + 3]
        sub AL,30h
        add [salida_anno],AX
        ret

determinar_Mes:					;determina el mes en el que estoy
     xor AX,AX
     mov AX,[salida_mes]
     cmp AX,1
     je mes_Enero
     cmp AX,2
     je mes_Febrero
     jne obtener_Dia
     ret

mes_Enero:
     mov AX,13
     mov [mes],AX
     mov BX,[anno]
     sub BX,1
     mov [anno],BX
     call obtener_Dia
     ret

mes_Febrero:
     mov AX,14
     mov [mes],AX
     mov BX,[anno]
     sub BX,1
     mov [anno],BX
     call obtener_Dia
     ret
     
obtener_Dia:				;obtengo el dia a traves de la formula N = D + M + A + E [A/4] + S 
     xor EAX,EAX       
     xor EBX,EBX      
     xor ECX,ECX    
     mov BX,[salida_mes]      
     mov AX,2          
     mul BX           
     mov CX,[salida_dia]      	
     add AX,CX         
     mov CX,AX       
     mov BX,[salida_mes]     
     add BX,1         
     mov AX,3          
     mul BX            
     xor EBX,EBX       
     mov EDX,0        
     mov BX,5          
     div BX            
     add CX,AX        
     mov AX,[salida_anno]     
     add CX,AX         
     mov BX,4          
     mov EDX,0         
     div BX            
     add CX,AX         
     mov EDX,0        
     mov AX,[salida_anno]     
     mov BX,100        
     div BX            
     sub CX,AX          
     mov EDX,0          
     mov AX,[salida_anno]     
     mov BX,400       
     div BX            
     add CX,AX        
     add CX,2          
     mov EDX,0         
     mov AX,CX        
     mov BX,7          
     div BX            
     mov [cont_dia],DX
       
imprimir_Dia:					;sabe que dia voy a imprimir
	cmp byte[cont_dia],2
	je imprimir_Domingo
	cmp byte[cont_dia],3
	je imprimir_Lunes
	cmp byte[cont_dia],4
	je imprimir_Martes
	cmp byte[cont_dia],5
	je imprimir_Miercoles
	cmp byte[cont_dia],6
	je imprimir_Jueves
	cmp byte[cont_dia],0
	je imprimir_Viernes
	cmp byte[cont_dia],1
	je imprimir_Sabado
	
; de aqui se empiezan a imprimir los dias
imprimir_Domingo:
	call imprimir_letraD
	call imprimir_letraO
	call imprimir_letraM
	call imprimir_letraI
	call imprimir_letraN
	call imprimir_letraG
	call imprimir_letraO
	int 80h
	ret
	
imprimir_Lunes:
	call imprimir_letraL
	call imprimir_letraU
	call imprimir_letraN
	call imprimir_letraE
	call imprimir_letraS
	int 80h
	ret
	
imprimir_Martes:
	call imprimir_letraM
	call imprimir_letraA
	call imprimir_letraR
	call imprimir_letraT
	call imprimir_letraE
	call imprimir_letraS
	int 80h
	ret

imprimir_Miercoles:
	call imprimir_letraM
	call imprimir_letraI
	call imprimir_letraE
	call imprimir_letraR
	call imprimir_letraC
	call imprimir_letraO
	call imprimir_letraL
	call imprimir_letraE
	call imprimir_letraS
	int 80h
	ret

imprimir_Jueves:
	call imprimir_letraJ
	call imprimir_letraU
	call imprimir_letraE
	call imprimir_letraV
	call imprimir_letraE
	call imprimir_letraS
	int 80h
	ret

imprimir_Viernes:
	call imprimir_letraV
	call imprimir_letraI
	call imprimir_letraE
	call imprimir_letraR
	call imprimir_letraN
	call imprimir_letraE
	call imprimir_letraS
	int 80h
	ret

imprimir_Sabado:
	call imprimir_letraS
	call imprimir_letraA
	call imprimir_letraB
	call imprimir_letraA
	call imprimir_letraD
	call imprimir_letraO
	int 80h
	ret
	
es_Bisiesto:				;con esta funcion obtengo los annos bisiestos
       mov AX,[salida_anno]
       mov BX,400
       mov EDX,0
       div BX
       cmp DX,0
       je imprimir_bisiesto
       mov AX,[salida_anno]
       mov BX,4
       mov EDX,0
       div BX
       cmp DX,0
       jne imprimir_nobisiesto
       mov AX,[salida_anno]
       mov BX,100
       mov EDX,0
       div BX
       cmp DX,0
       jne imprimir_bisiesto
       je imprimir_nobisiesto
       int 80h
       ret
       
imprimir_bisiesto:					;imprimo mensaje bisiesto
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_si_bisiesto
	mov edx, len_bisiesto
	int 80h
	ret
	
imprimir_nobisiesto:					;imprimo mensaje no es bisiesto
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_no_bisiesto
	mov edx, len_nobisiesto
	int 80h
	ret
	
imprimir_letraA:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_A
	mov edx, len_A
	int 80h
	ret
	
imprimir_letraB:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_B
	mov edx, len_B
	int 80h
	ret
	
imprimir_letraC:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_C
	mov edx, len_C
	int 80h
	ret
	
imprimir_letraD:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_D
	mov edx, len_D
	int 80h
	ret
	
imprimir_letraE:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_E
	mov edx, len_E
	int 80h
	ret
	
imprimir_letraG:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_G
	mov edx, len_G
	int 80h
	ret
	
imprimir_letraI:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_I
	mov edx, len_I
	int 80h
	ret
	
imprimir_letraJ:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_J
	mov edx, len_J
	int 80h
	ret
	
imprimir_letraL:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_L
	mov edx, len_L
	int 80h
	ret
	
imprimir_letraM:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_M
	mov edx, len_M
	int 80h
	ret
	
imprimir_letraN:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_N
	mov edx, len_N
	int 80h
	ret
	
imprimir_letraO:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_O
	mov edx, len_O
	int 80h
	ret
	
imprimir_letraR:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_R
	mov edx, len_R
	int 80h
	ret
	
imprimir_letraS:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_S
	mov edx, len_S
	int 80h
	ret
	
imprimir_letraT:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_T
	mov edx, len_T
	int 80h
	ret	
imprimir_letraU:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_U
	mov edx, len_U
	int 80h
	ret
	
imprimir_letraV:
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer_V
	mov edx, len_V
	int 80h
	ret
salir:				;salir
	mov eax,1
	mov ebx,0
	int 80h

	