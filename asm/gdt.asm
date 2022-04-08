; The Global Descriptor Table.
gdt_start:

; A null descriptor is required in the GDT.
; It is 32 bits long.
gdt_null_desc:
	dd 0x0
	dd 0x0

; Our GDT will have two segments: `code` and `data`.

; code_descriptor = {
; 	base = 0x0,
; 	limit = 0xfffff,
; 	first_flags  = { present = 1, privilege = 00, descriptor_type = 1 } (0b1001),
; 	type_flags   = { code = 1, conforming = 0, readable = 1, accessed = 0 } (0b1010),
; 	second_flags = { granularity = 1, default32bit = 1, segment64bit = 0, AVL = 0 } (0b1100),
; }
gdt_code:
	; Limit
	dw 0xffff
	; Base
	dw 0x0
	db 0x0

	; First flags + type flags
	db 0b10011010

	; Second flag + final bits of limit
	db 0b11001111

	; final bits of base
	db 0x0

; data_descriptor = code_descriptor + {
;	type_flags = { code = 0, expanddown = 0, writable = 0, accessed = 0 } (0010b),
; }
gdt_data:
	; Limit
	dw 0xffff
	; Base
	dw 0x0
	db 0x0

	; First flags + type flags
	db 0b10010010

	; Second flag + final bits of limit
	db 0b11001111

	; final bits of base
	db 0x0

; Label used for determining length of GDT
gdt_end:


gdt_descriptor:
	; size of GDT
	dw gdt_end - gdt_start - 1

	; start of GDT
	dd gdt_start

; segment descriptor offsets
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

