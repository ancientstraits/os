hexdigit2char:
	cmp al, 0x9
	jle hexdigit2char_0to9
	jmp hexdigit2char_atof
hexdigit2char_0to9:
	add al, 48
	ret
hexdigit2char_atof:
	add al, 87
	ret

print_hexshort:
	pusha

	mov bx, ax

	mov ah, 0x0e
	mov al, '0'
	int 0x10
	mov al, 'x'
	int 0x10

	mov cl, 12
print_hexshort_loop:
	mov ax, bx
	shr ax, cl
	and ax, 0xf
	call hexdigit2char

	mov ah, 0x0e
	int 0x10

	sub cl, 4
	cmp cl, 0
	jl  print_hexshort_end
	jmp print_hexshort_loop
print_hexshort_end:
	popa
	ret