#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CODELIMIT 256

//This program encrypt a specified file with a specified shift, using a Caesar cipher.
//The parameters are set in command line.
int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("The first argument is a path to a file to encrypt. The second argument is a key for the Caesar cipher. The second argument must be a number.\n");
        return 1;
    }
    int shift;
    {
        //This variable will contain the next character in argv[2] after the numerical value
        char *firstNoNum;
        shift = strtol(argv[2], &firstNoNum, 10);
        int lengthNoNum = strlen(firstNoNum);
        if (lengthNoNum != 0) {
            printf("The second argument must be a number which will be used as a shift for the Caesar cipher.\n");
            return 1;
        }
    }
    //read the file
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Unable to open the specified file.\n");
        return 1;
    }
    int c;
    while ((c = fgetc(file)) != EOF) {
        int newCode;
        //if the character's code is bigger than the limit, then do nothing with this character - leave it as it is.
        if (c > CODELIMIT) {
            newCode = c;
        } else {
            //shifting the character
            int shiftedRaw = c + shift;
            int RANGE = CODELIMIT + 1;
            if (CODELIMIT < shiftedRaw) {
                newCode = shiftedRaw - RANGE;
            } else if (0 > shiftedRaw) {
                newCode = shiftedRaw + RANGE;
            } else {
                //if the new code is not out of the range, then there is no needs to transform it.
                newCode = shiftedRaw;
            }
        }
        char newChar = (char) newCode;
        printf("%c", newChar);
    }
    //close the file after using
    fclose(file);
}