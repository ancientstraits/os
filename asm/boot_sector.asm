[org 0x7c00]
KERNEL_OFFSET equ 0x1000

	mov [BOOT_DRIVE], dl

	mov bp, 0x9000
	mov sp, bp

	mov ax, MSG_REAL_MODE
	call print_str

	call load_kernel
	call switch_to_pm

	jmp $



%include "print_str.asm"
%include "print_str_pm.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "load_sectors.asm"

[bits 16]
load_kernel:
	mov ax, MSG_LOAD_KERNEL
	call print_str

	mov bx, KERNEL_OFFSET
	mov dh, 20
	mov dl, [BOOT_DRIVE]
	call load_sectors

	ret

[bits 32]
begin_pm:
	mov eax, MSG_PROT_MODE
	call print_str_pm

	call KERNEL_OFFSET

	jmp $


BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode",0
MSG_PROT_MODE db "Now in 32-bit protected mode",0
MSG_LOAD_KERNEL db "Loading kernel into memory",0

times 510 - ($ - $$) db 0
dw 0xaa55

