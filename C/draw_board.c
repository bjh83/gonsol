#include <stdio.h>
#include <ncurses.h>

void draw_board(char* board, int width, int height) {
    printf("draw_board was called in C\n");
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            move(y, x);
            addch(board[y * width + x]);
        }
        printf("\n");
    }
    move(height, 0);
    refresh();
}
