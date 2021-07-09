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

  @i
  M=0

  @8191
  D=A
  @n
  M=D

(LOOP)
  @i
  D=M
  @RESET
  D;JLT
  @n
  D=D-M
  @STOP
  D;JGT

  @KBD
  D=M
  @UNPAINT
  D;JEQ
  @PAINT
  0;JMP

(RESET)
  @i
  M=0
  @LOOP
  0;JMP

(STOP)
  @n
  D=M
  @i
  M=D
  @LOOP
  0;JMP

(PAINT)
  @i
  D=M
  @SCREEN
  A=D+A
  M=-1

  @i
  M=M+1

  @LOOP
  0;JMP

(UNPAINT)
  @i
  D=M
  @SCREEN
  A=D+A
  M=0

  @i
  M=M-1

  @LOOP
  0;JMP

(END)
  @END
  0;JMP
