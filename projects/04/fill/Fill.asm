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

// Put your code here.
(LOOP)
    @8192
    D=A         // cnt = 0x2000
    @0
    M=D         // M[0] = cnt
    @SCREEN
    D=A         // screen_addr = 0x4000
    @1
    M=D         // M[1] = screen_addr
    @KBD        
    D=M         // store key data
    @DRAW_BLACK
    D;JNE       // if D != 0: goto DRAW_BLACK
    @DRAW_WHITE
    0;JMP       // else goto DRAW_WHITE

(DRAW_BLACK)
    @1
    A=M         // A = screen_addr
    M=-1        // M[screen_addr] = -1
    @1
    M=M+1       // screen_addr +=1
    @0
    M=M-1       // M[cnt] -= 1
    D=M         // D = M[cnt]
    @DRAW_BLACK
    D;JGT       // if cnt > 0: goto DRAW_BLACK
    @LOOP
    0;JMP       // inf_loop

(DRAW_WHITE)
    @1
    A=M         // A = screen_addr
    M=0         // M[screen_addr] = 0
    @1
    M=M+1       // screen_addr +=1
    @0
    M=M-1       // M[cnt] -= 1
    D=M         // D = M[cnt]
    @DRAW_WHITE
    D;JGT       // if cnt > 0: goto DRAW_WHITE
    @LOOP
    0;JMP       // inf_loop
