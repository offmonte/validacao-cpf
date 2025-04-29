import re

def validar_cpf(cpf: str) -> bool:
    # Remove caracteres não numéricos
    cpf = re.sub(r'[^0-9]', '', cpf)
    
    # Verifica se o CPF tem 11 dígitos
    if len(cpf) != 11:
        return False
    
    # Verifica se todos os dígitos são iguais (ex: 111.111.111-11 é inválido)
    if cpf == cpf[0] * 11:
        return False

    # Valida o primeiro dígito
    soma = sum(int(cpf[i]) * (10 - i) for i in range(9))
    digito1 = (soma * 10 % 11) % 10
    if digito1 != int(cpf[9]):
        return False

    # Valida o segundo dígito
    soma = sum(int(cpf[i]) * (11 - i) for i in range(10))
    digito2 = (soma * 10 % 11) % 10
    if digito2 != int(cpf[10]):
        return False

    return True

# Exemplo de uso:
# Exemplo de uso
cpfs_para_testar = [
    "123.456.789-09",  # Válido
    "111.111.111-11",     # Inválido
]

for cpf in cpfs_para_testar:
    print(f"CPF {cpf} é válido? {validar_cpf(cpf)}")