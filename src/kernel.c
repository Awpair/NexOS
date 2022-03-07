#include <stdint.h>

void write_string( int colour, const char *string )
{
    volatile char *video = (volatile char*)0xB8000;
    while( *string != 0 )
    {
        *video++ = *string++;
        *video++ = colour;
    }
}

extern void main()
{
    write_string(0x0d,"Hello, world!");
    return;
}