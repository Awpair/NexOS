#include <stdint.h>

static const int VGA_WIDTH = 80;
static const int VGA_HEIGHT = 25;
static uint16_t* const VGA_MEMORY = (uint16_t*) 0xB8000;

struct cursor 
{
    uint8_t x;
    uint8_t y;
} cursor;

void move_cursor( uint8_t x, uint8_t y )
{
    cursor.x+=x;
    cursor.y+=y;
};

void set_cursor( uint8_t x, uint8_t y)
{
    cursor.x = x;
    cursor.y = y;
};

void print( const char *string)
{
    volatile uint8_t *video = (volatile uint8_t*) 0xB8000 + (2*cursor.y * VGA_WIDTH + 2*cursor.x);

    while( *string != 0 )
    {
        *video++ = *string++;
        *video++ = 0x0f;
        cursor.x++;
    }
}

void println(const char *string)
{
    print(string);
    cursor.x = 0;
    cursor.y++;
};

static inline void outb(uint16_t port, uint8_t val)
{
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
    /* There's an outb %al, $imm8  encoding, for compile-time constant port numbers that fit in 8b.  (N constraint).
     * Wider immediate constants would be truncated at assemble-time (e.g. "i" constraint).
     * The  outb  %al, %dx  encoding is the only option for all other cases.
     * %1 expands to %dx because  port  is a uint16_t.  %w1 could be used if we had the port number a wider C type */
}

void update_cursor()
{
    uint16_t pos = cursor.y * VGA_WIDTH + cursor.x;
	outb(0x3D5, (uint8_t) (pos & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (uint8_t) ((pos >> 8) & 0xFF));
}

#define newline() move_cursor(0,1) // Macro to move cursor down one line

extern void main()
{
    println("Hello, world!");
    print("Hello, all!");
    update_cursor();
    return;
}