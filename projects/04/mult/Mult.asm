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
  @R1
  D=D-M    // R0 - R1
  @LOOP_R0
  D;JLE    // if (R0 <= R1)
  @LOOP_R1
  0;JMP    // else

(LOOP_R0)
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

  @LOOP_R0
  0;JMP    // Loop

(LOOP_R1)
  @i
  D=M      // Load i

  @R1
  D=M-D    // R1 - i
  @END
  D;JEQ    // if (R1 - i) == 0

  @R0
  D=M      // Load R0

  @R2
  M=M+D    // R2 += R0

  @i
  M=M+1    // i++

  @LOOP_R1
  0;JMP    // Loop

(END)
  @END
  0;JMP
