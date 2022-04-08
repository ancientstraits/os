#define VGA_MEMORY (char*)0xb8000
#define VGA_WIDTH  80
#define VGA_HEIGHT 25
#define VGA_SIZE   VGA_WIDTH * VGA_HEIGHT * 2
#define WHITE_ON_BLACK 0x0f

void clear_screen() {
	for (char* ptr = VGA_MEMORY; ptr < (VGA_MEMORY + VGA_SIZE); ptr++) {
		*ptr = 0;
	}
}

void write_char(char c, char forecolor, char backcolor, int x, int y) {
	char* ptr = VGA_MEMORY + 2 * (y * 80 + x);
	ptr[0] = c;
	ptr[1] = (backcolor << 4) | forecolor;
}

void print(char* str, char forecolor, char backcolor) {
	static int x, y;

	char* ptr = VGA_MEMORY;
	for (int i = 0; str[i]; i++) {
		if (str[i] == '\n') {
			x = 0;
			y++;
			continue;
		}
		write_char(str[i], forecolor, backcolor, x, y);
		x++;
	}
}

void entry() {
	clear_screen();
	print("Hello World!\n", 0xf, 0x0);
	print("Hello World!\n", 0xf, 0x0);
	print("Hello World!\n", 0xf, 0x0);
}