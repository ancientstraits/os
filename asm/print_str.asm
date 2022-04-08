print_str:
	push bx

	mov bx, ax
	mov ah, 0x0e

print_str_loop:
	mov al, [bx]

	cmp al, 0
	je  print_str_end

	cmp al, '\'
	je  print_str_newline_a

	int 0x10

	inc bx
	jmp print_str_loop

print_str_newline_a:
	inc bx
	mov al, [bx]
	cmp al, 'n'
	je  print_str_newline_b
	jmp print_str_newline_end

print_str_newline_b:
	mov al, 0x0a ; newline
	int 0x10
	mov al, 0x0d ; carriage return
	int 0x10

print_str_newline_end:
	inc bx
	jmp print_str_loop

print_str_end:
	pop bx
	ret

