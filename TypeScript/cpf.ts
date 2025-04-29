function validarCPF_TS(cpf: string): boolean {
    // Remove caracteres que não sejam dígitos
    cpf = cpf.replace(/\D/g, '');

    // Verifica se tem 11 dígitos
    if (cpf.length !== 11) {
        return false;
    }

    // Verifica se todos os dígitos são iguais
    if (/^(\d)\1{10}$/.test(cpf)) {
        return false;
    }

    // Validação do primeiro dígito
    let soma = 0;
    for (let i = 0; i < 9; i++) {
        soma += parseInt(cpf.charAt(i)) * (10 - i);
    }
    let digito1 = (soma * 10) % 11;
    if (digito1 === 10 || digito1 === 11) {
        digito1 = 0;
    }
    if (digito1 !== parseInt(cpf.charAt(9))) {
        return false;
    }

    // Validação do segundo dígito
    soma = 0;
    for (let i = 0; i < 10; i++) {
        soma += parseInt(cpf.charAt(i)) * (11 - i);
    }
    let digito2 = (soma * 10) % 11;
    if (digito2 === 10 || digito2 === 11) {
        digito2 = 0;
    }
    if (digito2 !== parseInt(cpf.charAt(10))) {
        return false;
    }

    return true;
}

// Exemplo de uso:
const cpfsParaTestar_TS = [
    "123.456.789-09",  // Válido
    "111.111.111-11",  // Inválido
];

cpfsParaTestar_TS.forEach(cpf => {
    console.log(`CPF ${cpf} é válido? ${validarCPF_TS(cpf)}`);
});
