;THIS CODE IS FOR 32 bit SYSTEM(can also work on 64 bit)
;it uses proper stack 
;commands to run on ubuntu

;nasm -f elf file.asm
;gcc -m32 file.o
;./a.out arg1 arg2 arg3..

;if it is not working try install these and then again try previos command
;sudo apt-get update
;sudo apt-get install libc6-dev-i386

;QUES:take i and n as command line argument,Do (i to n product of i*i)


extern printf
extern atoi
SECTION .data
	integerr: db '%d',10,0        ;10 for line feed(\n) and 0 for '\0'
	
SECTION .bss
	i RESB 32
	n RESB 32
	Sum RESB 32
SECTION .text
	global main
main:
	push ebp
	mov ebp,esp
	mov ebx,dword[esp+12]	;it point to argv;here offset is 4
	mov ecx,[ebx+4]			;for first argument argv[1]
	push ecx
	call atoi
	mov [i],eax
	mov edx,[ebx+8]			;for second argument argv[2]
	push edx
	call atoi
	mov [n],eax
	
	mov eax,1
	mov [Sum],eax			;store initial result 1

loop: 
	mov eax,[n]
	inc eax
	cmp eax,[i]
	jz end
	mov eax,[i]
	mov edx,[i]
	mul edx
	mov edx,[Sum]
	mul edx
	mov [Sum],eax
	mov eax,[i]
	inc eax
	mov [i],eax

	jmp loop
end:
	;mov edx,[Sum]
	;call atoi
	mov eax,[Sum]	;no need of atoi as Sum is already integer
	push eax
	push integerr		
	call printf				; call to printf
	mov esp,ebp
	pop ebp
	ret
	;mov eax,1				; stop the program
	;mov ebx,0
	int 80h