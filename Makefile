ASM_FILES := $(wildcard asm/*.asm)
BOOT_SECT_ASM = asm/boot_sector.asm

SRC_FILES := $(wildcard src/*.c)
OBJ_FILES := $(patsubst src/%.c, obj/%.o, $(SRC_FILES))

all: os.img

os.img: obj/boot_sector.bin obj/kernel.bin
	cat $^ > $@

obj/boot_sector.bin: $(BOOT_SECT_ASM) $(filter-out $(BOOT_SECT_ASM), $(ASM_FILES))
	@mkdir -p $(@D)
	nasm $< -o $@ -Iasm -f bin

obj/kernel.bin: obj/kernel_entry.o $(OBJ_FILES)
	# objcopy -R .note.gnu.property -R .note.GNU-stack -R .eh_frame $(OBJ_FILES)
	# ld -T ld/link.ld -melf_i386 -s $^ -o $@ --oformat binary
	ld -T ld/elf_i386.x -Ttext=0x1000 -melf_i386 -s $^ -o $@ --oformat binary

obj/kernel_entry.o: asm/kernel_entry.asm
	nasm $< -o $@ -f elf 

obj/%.o: src/%.c
	gcc $< -o $@ -c -m32 -fno-pie -ffreestanding
