#include <stdio.h>

void printSpaces(int count) {
    for (int i = 0; i < count; i++) {
        printf(" ");
    }
}

void printDiamond(int n) {
    int halfLines = (n + 1) / 2;

    // Upper part of the diamond
    for (int i = 0; i < halfLines; i++) {
        printSpaces(halfLines - i - 1);
        printf("*");

        if (i > 0) {
            printSpaces(2 * i - 1);
            printf("*");
        }
        printf("\n");
    }

    // Lower part of the diamond
    for (int i = halfLines - 2; i >= 0; i--) {
        printSpaces(halfLines - i - 1);
        printf("*");

        if (i > 0) {
            printSpaces(2 * i - 1);
            printf("*");
        }
        printf("\n");
    }
}

int main() {
    int input;
    
    while (1) {
        printf("Please enter a positive odd number: ");
        scanf("%d", &input);

        // Check if input is positive and odd
        if (input > 0 && input % 2 == 1) {
            printDiamond(input);
            break;
        } else {
            printf("Invalid Input. Try again!\n");
        }
    }

    return 0;
}
