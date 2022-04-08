[bits 16]
switch_to_pm:
	; clear interrupts
	cli

	; load GDT
	lgdt [gdt_descriptor]

	; set first bit of `cr0` to 1 to switch to protected mode
	mov eax, cr0
	or  eax, 0b1
	mov cr0, eax

	; use far jump to finish CPU instructions (clear all 16 bit real mode instructions)
	jmp CODE_SEG:init_pm

[bits 32]
init_pm:
	; initialize all registers with protected mode offsets
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; set stack to top of free space
	mov ebp, 0x90000
	mov esp, ebp

	call begin_pm

