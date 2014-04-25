SHELL= /bin/sh
PACKAGE= gonsol

.PHONY: all

all: gonsol

draw_board.o: C/draw_board.c
	gcc -std=c99 -c C/draw_board.c

gonsol: draw_board.o
	ghc --make -main-is Main -o gonsol Main.hs
