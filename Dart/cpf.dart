bool validarCPF(String cpf) {
    // Remove tudo que não for número
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    // Verifica se tem 11 dígitos
    if (cpf.length != 11) {
        return false;
    }

    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(.)\1{10}$').hasMatch(cpf)) {
        return false;
    }

    // Validação do primeiro dígito
    int soma = 0;
    for (int i = 0; i < 9; i++) {
        soma += int.parse(cpf[i]) * (10 - i);
    }
    int digito1 = (soma * 10) % 11;
    if (digito1 == 10 || digito1 == 11) {
        digito1 = 0;
    }
    if (digito1 != int.parse(cpf[9])) {
        return false;
    }

    // Validação do segundo dígito
    soma = 0;
    for (int i = 0; i < 10; i++) {
        soma += int.parse(cpf[i]) * (11 - i);
    }
    int digito2 = (soma * 10) % 11;
    if (digito2 == 10 || digito2 == 11) {
        digito2 = 0;
    }
    if (digito2 != int.parse(cpf[10])) {
        return false;
    }

    return true;
}

void main() {
    // Exemplo de uso
    List<String> cpfsParaTestar = [
        "123.456.789-09",  // Válido
        "111.111.111-11",  // Inválido
    ];

    for (var cpf in cpfsParaTestar) {
        print('CPF $cpf é válido? ${validarCPF(cpf) ? 'Sim' : 'Não'}');
    }
}
