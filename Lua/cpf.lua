function validarCPF(cpf)
    -- Remove tudo que não for número
    cpf = cpf:gsub("[^0-9]", "")

    if #cpf ~= 11 then
        return false
    end

    -- Verifica se todos os dígitos são iguais
    if cpf:match("^(%d)%1*") then
        return false
    end

    -- Validação do primeiro dígito
    local soma = 0
    for i = 1, 9 do
        soma = soma + tonumber(cpf:sub(i, i)) * (10 - i)
    end
    local digito1 = (soma * 10) % 11
    if digito1 == 10 or digito1 == 11 then
        digito1 = 0
    end
    if tonumber(cpf:sub(10, 10)) ~= digito1 then
        return false
    end

    -- Validação do segundo dígito
    soma = 0
    for i = 1, 10 do
        soma = soma + tonumber(cpf:sub(i, i)) * (11 - i)
    end
    local digito2 = (soma * 10) % 11
    if digito2 == 10 or digito2 == 11 then
        digito2 = 0
    end
    if tonumber(cpf:sub(11, 11)) ~= digito2 then
        return false
    end

    return true
end

-- Exemplo de uso:
local cpfsParaTestar = {
    "123.456.789-09",  -- Válido
    "111.111.111-11",  -- Inválido
}

for _, cpf in ipairs(cpfsParaTestar) do
    print(string.format("CPF %s é válido? %s", cpf, validarCPF(cpf) and "Sim" or "Não"))
end
