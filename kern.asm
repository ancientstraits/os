[bits 32]

VGA_MEMORY equ 0xb8000
VGA_WIDTH  equ 80
VGA_HEIGHT equ 25
VGA_SIZE   equ VGA_WIDTH * VGA_HEIGHT * 2

call clear_screen

clear_screen:
    push eax
    mov eax, VGA_MEMORY

clear_screen_loop:
    mov byte [eax], 0

    cmp eax, VGA_MEMORY + VGA_SIZE
    jge clear_screen_end

    inc eax
    jmp clear_screen_loop

clear_screen_end:
    pop eax
    ret
