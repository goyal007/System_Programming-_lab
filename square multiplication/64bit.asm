;In a 64 bit system the arguments are not in the stack but in the general purpose registers.
;argc is in %rdi and argv in %rsi. 

;THIS CODE IS FOR 64 bit SYSTEM

;commands to run on ubuntu
;nasm -felf64 file.asm
;gcc file.o
;./a.out arg1 arg2 .....
;
;QUES:take i and n as command line argument,Do (i to n product of i*i)
 
extern printf
extern atoi
SECTION .data
	integerr: db '%d',10,0        ;10 for line feed(\n) and 0 for '\0'
	
SECTION .bss
	i RESB 64
	n RESB 64
	Sum RESB 64			;variable for storing final product result
SECTION .text
	global main
main:
	mov rcx,rdi			;argc
	mov r8,8			;offset
	mov rdx, qword[rsi+r8]	;point to argv initial address(argv[0])
	
;for variable i
	
	push rcx				;save registers that printf wastes
	push rdx				
	push rsi
	push r8
	mov rdi,rdx
	call atoi				;atoi takes input as whatever pointed by rdi
	mov [i],rax				;after call atoi result store in eax and it is integer value;i.e move into i
	pop r8					;;;;;restore registers
	pop rsi
	pop rdx
	pop rcx
	
;for variable n

	add r8,8		;in 64 bit offset is of 8 bit
								
	push rcx
	push rdx
	push rsi
	push r8
	mov rdx, qword[rsi+r8]		;for second argument argv[2]
	mov rdi,rdx
	call atoi
	mov [n], rax
	pop r8
	pop rsi
	pop rdx
	pop rcx


	mov rax,1
	mov [Sum],rax			;store initial result 1

loop:
	mov eax,[n]
	inc eax
	cmp eax,[i]
	jz end
	mov eax,[i]
	mov ebx,[i]
	mul ebx
	mov ebx,[Sum]
	mul ebx
	mov [Sum],eax
	mov eax,[i]
	inc eax
	mov [i],eax

	jmp loop
end:
	push rcx
	push rdx
	push rsi
	push r8
	mov rdi,integerr		; first parameter for printf
	mov rsi, [Sum]			; second parameter for printf
	mov rax,0				; no floating point register used
	call printf				; call to printf
	pop r8
	pop rsi
	pop rdx
	pop rcx

	mov eax,1				; stop the program
	mov rbx,0
	int 80h
