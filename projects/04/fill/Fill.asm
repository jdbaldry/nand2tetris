// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

  @offset       // Screen offset.
  M=0           // Init at 0.

  @8191
  D=A
  @max_offset   // Maximum screen offset (last word in screen memory map).
  M=D           // Init at 8191.

(LOOP)          // Infinite program loop.
  @offset
  D=M
  @ZERO_OFFSET
  D;JLT         // If offset < 0; reset it to zero.
  @max_offset
  D=D-M
  @MAX_OFFSET   // If offset > max_offset; set it to max_offset.
  D;JGT

  @KBD
  D=M
  @UNPAINT
  D;JEQ         // If no key is pressed, start unpainting the screen.
  @PAINT
  0;JMP         // Else, start painting the screen.

(ZERO_OFFSET)   // Set the offset variable to zero.
  @offset
  M=0
  @LOOP
  0;JMP

(MAX_OFFSET)    // Set the offset variable to max_offset.
  @max_offset
  D=M
  @offset
  M=D
  @LOOP
  0;JMP

(PAINT)         // Paint the screen a word at a time.
  @offset
  D=M
  @SCREEN
  A=D+A
  M=-1

  @offset
  M=M+1         // Increment screen offset.

  @LOOP
  0;JMP

(UNPAINT)       // Unpaint the screen a word at a time.
  @offset
  D=M
  @SCREEN
  A=D+A
  M=0

  @offset
  M=M-1         // -1 == 1111 1111 1111 1111 (twos complement)

  @LOOP
  0;JMP

(END)           // Should never be reached.
  @END
  0;JMP
