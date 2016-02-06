#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <unistd.h>
#include <libgen.h>

//Розробити програму, яка переглядає поточний каталог і виводить на екран імена усіх файлів, що зустрілися в ньому, із
//заданим розширенням. Потім здійснюється перехід в батьківський каталог, який потім стає поточним, і вказані вище дії
//повторюються доти, доки поточним каталогом не стане кореневий каталог.
//Task 2. Variant 2.
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("The program expects an argument that you can use to specify an extension that only files that have it will be shown.\n");
        return 0;
    }
    //a variable for the name of the current folder
    char currFolderName[1024];
    while (strcmp(currFolderName, "/") != 0) {
        //reads the path to the current folder to a variable
        getcwd(currFolderName, sizeof(currFolderName));
        //name without the full path
        char *simpleName = basename(currFolderName);
        printf("%s\n", simpleName);
        printFilesWithExtension(argv[1]);
        //goes to the parent directory
        chdir("..");
    }
    return 0;
}

int printFilesWithExtension(char *extension) {
    int extensionLenth = strlen(extension);
    DIR *dir;
    struct dirent *ent;
    if ((dir = opendir("./")) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            //type 4 means a directory. 8 means a plain file.
            if (ent->d_type == 8) {
                int fileNameLength = strlen(ent->d_name);
                //if the extension is longer than the file name, then skip this file.
                if (extensionLenth < fileNameLength) {
                    //the last n characters. n is the length of the extension
                    const char *extension_place = &ent->d_name[fileNameLength - extensionLenth];
                    if (strcmp(extension, extension_place) == 0) {
                        printf("    %s\n", ent->d_name);
                    }
                }
            }
        }
        closedir(dir);
    } else {
        perror("could not open directory");
        return 1;
    }
    return 0;
}