[bits 32]

; the location of the VGA video memory
VIDEO_MEMORY equ 0xb8000
; the option for printing
WHITE_ON_BLACK equ 0x0f

; print string at `eax`
print_str_pm:
	pusha

	; edx is our iterator through the memory
	mov edx, VIDEO_MEMORY
	mov ebx, eax

print_str_pm_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK

	cmp al, 0
	je  print_str_pm_end

	mov [edx], ax

	; increment string
	inc ebx
	; go to next position in memory
	; add 2 because of text & opts
	add edx, 2
	jmp print_str_pm_loop

print_str_pm_end:
	popa
	ret

