function validarCPF_JS(cpf) {
    // Remove tudo que não for número
    cpf = cpf.replace(/\D/g, '');

    if (cpf.length !== 11) {
        return false;
    }

    if (/^(\d)\1{10}$/.test(cpf)) {
        return false;
    }

    let soma = 0;
    for (let i = 0; i < 9; i++) {
        soma += parseInt(cpf.charAt(i)) * (10 - i);
    }
    let digito1 = (soma * 10) % 11;
    digito1 = digito1 === 10 || digito1 === 11 ? 0 : digito1;
    if (digito1 !== parseInt(cpf.charAt(9))) {
        return false;
    }

    soma = 0;
    for (let i = 0; i < 10; i++) {
        soma += parseInt(cpf.charAt(i)) * (11 - i);
    }
    let digito2 = (soma * 10) % 11;
    digito2 = digito2 === 10 || digito2 === 11 ? 0 : digito2;
    if (digito2 !== parseInt(cpf.charAt(10))) {
        return false;
    }

    return true;
}

// Exemplo de uso:
const cpfsParaTestar_JS = [
    "123.456.789-09",  // Válido
    "111.111.111-11",  // Inválido
];

cpfsParaTestar_JS.forEach(cpf => {
    console.log(`CPF ${cpf} é válido? ${validarCPF_JS(cpf)}`);
});
