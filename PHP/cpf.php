<?php

function validarCPF($cpf)
{
    // Remove tudo que não for número
    $cpf = preg_replace('/\D/', '', $cpf);

    // Verifica se tem 11 dígitos
    if (strlen($cpf) != 11) {
        return false;
    }

    // Verifica se todos os dígitos são iguais
    if (preg_match('/(\d)\1{10}/', $cpf)) {
        return false;
    }

    // Validação do primeiro dígito
    $soma = 0;
    for ($i = 0; $i < 9; $i++) {
        $soma += $cpf[$i] * (10 - $i);
    }
    $digito1 = $soma % 11;
    if ($digito1 == 10 || $digito1 == 11) {
        $digito1 = 0;
    }
    if ($digito1 != $cpf[9]) {
        return false;
    }

    // Validação do segundo dígito
    $soma = 0;
    for ($i = 0; $i < 10; $i++) {
        $soma += $cpf[$i] * (11 - $i);
    }
    $digito2 = $soma % 11;
    if ($digito2 == 10 || $digito2 == 11) {
        $digito2 = 0;
    }
    if ($digito2 != $cpf[10]) {
        return false;
    }

    return true;
}

// Exemplo de uso
$cpfsParaTestar = [
    "123.456.789-09",  // Válido
    "111.111.111-11",  // Inválido
];

foreach ($cpfsParaTestar as $cpf) {
    echo "CPF $cpf é válido? " . (validarCPF($cpf) ? "Sim" : "Não") . "\n";
}

?>
