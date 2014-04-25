#include <ncurses.h>

void draw_board(char** board, int width, int height) {
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            move(y, x);
            addch(board[y][x]);
        }
    }
    move(height, 0);
}
