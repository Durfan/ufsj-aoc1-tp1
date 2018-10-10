#include <stdio.h>

void leArquivo(char string[]) {
    FILE* fp = fopen("entrada.txt", "r");
    fgets(string,50,fp);
    fclose(fp);
}

void manipulaString(char string[]) {
    int i = 0;
    while (string[i] != '\0') {
        if (string[i] < 97) string[i] += 32;
        else string[i] -= 32;
        i++;
    }
}

void salvaArquivo(char string[50]) {
    FILE* fp = fopen("saida.txt", "w");
    fprintf(fp,"%s",string);
    fclose(fp);
}


int main(void) {
    char string[50];

    leArquivo(string);
    manipulaString(string);
    salvaArquivo(string);

    return 0;
}