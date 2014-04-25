SHELL= /bin/sh
PACKAGE= gonsol

.PHONY: all

all: gonsol

draw_board.o: C/draw_board.c
	gcc -std=c99 -c C/draw_board.c

screen_ops.o: C/screen_ops.c
	gcc -std=c99 -c C/screen_ops.c

gonsol: draw_board.o screen_ops.o
	ghc --make -main-is Main -o gonsol Main.hs draw_board.o screen_ops.o -lncurses
