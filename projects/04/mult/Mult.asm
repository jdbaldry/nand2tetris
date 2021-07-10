// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// if R0 <= R1:
//   for i in range(R0):
//     R2 += R1
// else:
//   for i in range(R1):
//     R2 += R0

  @R2
  M=0      // R2 = 0

  @i
  M=0      // i = 0

  @R0
  D=M      // Load R0
  @END
  D;JEQ    // if (R0 == 0) => R2 == 0
  @R1
  D=D-M    // R0 - R1
  @SWAP
  D;JGE    // if (R0 >= R1)
  D=M
  @END
  D;JEQ    // If (R1 == 0) => R2 == 0
  @LOOP
  0;JMP    // else

(SWAP)     // swap R0 and R1
  @R0
  D=M
  @tmp
  M=D
  @R1
  D=M
  @R0
  M=D
  @tmp
  D=M
  @R1
  M=D

  @LOOP
  0;JMP


(LOOP)
  @i
  D=M      // Load i

  @R0
  D=M-D    // R0 - i
  @END
  D;JEQ    // if (R0 - i) == 0

  @R1
  D=M      // Load R1

  @R2
  M=M+D    // R2 += R1

  @i
  M=M+1    // i++

  @LOOP
  0;JMP    // Loop

(END)
  @END
  0;JMP
