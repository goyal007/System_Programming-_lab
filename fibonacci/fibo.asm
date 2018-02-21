;In a 64 bit system the arguments are not in the stack but in the general purpose registers.
;argc is in %rdi and argv in %rsi. 

;THIS CODE IS FOR 64 bit SYSTEM

;commands to run on ubuntu
;nasm -felf64 file.asm
;gcc file.o
;./a.out arg1 arg2 .....
;
;QUES:take  n as command line argument,print fibonacci series upto n

extern printf
extern atoi
SECTION .data
	integerr: db '%d',10,0        ;10 for line feed(\n) and 0 for '\0'
	
SECTION .bss
	i RESB 64
	j RESB 64
	n RESB 64
	Sum RESB 64
SECTION .text
	global main
main:
	mov rcx,rdi			;argc
	mov r8,8			;offset
	mov rdx, qword[rsi+r8]	;point to argv initial address(argv[0])
	
;for variable n
	
	push rcx				;save registers that printf wastes
	push rdx				
	push rsi
	push r8
	mov rdi,rdx
	call atoi				;atoi takes input as whatever pointed by rdi
	mov [n],rax				;after call atoi result store in eax and it is integer value;i.e move into i
	pop r8					;;;;;restore registers
	pop rsi
	pop rdx
	pop rcx

	mov rax,0
	mov [i],rax			;as first number of fibo is 0
	mov rax,1
	mov [j],rax			;as second number of fibo is 1

	;print i
	push rcx
	push rdx
	push rsi
	push r8
	mov rdi,integerr		; first parameter for printf
	mov rsi, [i]			; second parameter for printf
	mov rax,0				; no floating point register used
	call printf				; call to printf
	pop r8
	pop rsi
	pop rdx
	pop rcx
	
	;print j
	push rcx
	push rdx
	push rsi
	push r8
	mov rdi,integerr		; first parameter for printf
	mov rsi, [j]			; second parameter for printf
	mov rax,0				; no floating point register used
	call printf				; call to printf
	pop r8
	pop rsi
	pop rdx
	pop rcx
	
	;now print remaining numbers
	mov eax,[n]
	mov ebx,2
	sub eax,ebx
	mov [n],eax
loop:
	mov eax,[n]
	cmp eax,0
	jz end
	mov eax,[i]
	mov ebx,[j]
	add eax,ebx
	mov [Sum],eax
	mov edx,[j]
	mov [i],edx
	mov [j],eax


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
	
	mov eax,[n]
	dec eax
	mov [n],eax
	jmp loop
end:
	mov eax,1				; stop the program
	mov rbx,0
	int 80h
