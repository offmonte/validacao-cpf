#include <stdio.h>
#include <string.h>
#include <ctype.h>

int validarCPF(const char *cpf_input) {
    char cpf[12];  // 11 dígitos + '\0'
    int i, j = 0, soma = 0, digito1, digito2;

    // Remover caracteres não numéricos
    for (i = 0; cpf_input[i] != '\0' && j < 11; i++) {
        if (isdigit(cpf_input[i])) {
            cpf[j++] = cpf_input[i];
        }
    }
    cpf[j] = '\0';

    // Verificar se tem 11 dígitos
    if (strlen(cpf) != 11)
        return 0;

    // Verificar se todos os dígitos são iguais
    int todos_iguais = 1;
    for (i = 1; i < 11; i++) {
        if (cpf[i] != cpf[0]) {
            todos_iguais = 0;
            break;
        }
    }
    if (todos_iguais)
        return 0;

    // Calcular primeiro dígito
    soma = 0;
    for (i = 0; i < 9; i++)
        soma += (cpf[i] - '0') * (10 - i);
    digito1 = (soma * 10) % 11;
    if (digito1 == 10)
        digito1 = 0;
    if (digito1 != (cpf[9] - '0'))
        return 0;

    // Calcular segundo dígito
    soma = 0;
    for (i = 0; i < 10; i++)
        soma += (cpf[i] - '0') * (11 - i);
    digito2 = (soma * 10) % 11;
    if (digito2 == 10)
        digito2 = 0;
    if (digito2 != (cpf[10] - '0'))
        return 0;

    return 1;  // CPF válido
}

int main() {
    const char *cpf1 = "529.982.247-25";
    const char *cpf2 = "123.456.789-09";

    if (validarCPF(cpf1))
        printf("CPF %s é válido.\n", cpf1);
    else
        printf("CPF %s é inválido.\n", cpf1);

    if (validarCPF(cpf2))
        printf("CPF %s é válido.\n", cpf2);
    else
        printf("CPF %s é inválido.\n", cpf2);

    return 0;
}
