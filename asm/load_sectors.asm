; load `dh` sectors to `es:bx` from drive `dl`
; use BIOS subroutine `int 0x13, ah 0x02`
load_sectors:
    ; backup value of `dx` which was set
    push dx

    mov ah, 0x02

    ; read `dh` sectors
    mov al, dh
    ; select cylinder 0
    mov ch, 0x00
    ; select head 0
    mov dh, 0x00
    ; read from second sector (boot sector is 1st)
    mov cl, 0x02

    ; interrupt to read from disk
    int 0x13

    ; handle error if carry is 1
    jc load_sectors_error

    ; get original value of `dx`
    pop dx
    ; `al` is number of sectors actually read
    ; `dh` is the passed argument for the number of sectors that should be read
    ; handle error if al != dh
    cmp dh, al
    jne load_sectors_error

    ret

load_sectors_error:
    mov ax, load_sectors_error_msg
    call print_str
    jmp $

load_sectors_error_msg db "Failed to read disk",0
