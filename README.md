# Validação de CPF

Este projeto tem como objetivo deixar de amostra alguns códigos com funções em diferentes linguagens para realizar a **validação de CPFs** (Cadastro de Pessoas Físicas) brasileiros, verificando se o número informado segue as regras matemáticas e estruturais estabelecidas pela Receita Federal.

## Estrutura do CPF

O CPF é composto por 11 dígitos numéricos, sendo:

- **9 primeiros dígitos**: Número base
- **2 últimos dígitos**: Dígitos verificadores

Formato do CPF: `XXX.XXX.XXX-YY`

Onde `X` representa os nove primeiros dígitos e `Y` os dois dígitos verificadores.

## Validação do CPF

A validação do CPF é feita em duas etapas principais:

### 1. Eliminar CPFs inválidos comuns

- CPFs com todos os dígitos iguais são inválidos. Exemplo: `000.000.000-00`, `111.111.111-11`, etc.

### 2. Calcular e verificar os dois dígitos verificadores

- **Primeiro dígito verificador**:
  - Multiplica-se os 9 primeiros dígitos por pesos decrescentes de **10 a 2**.
  - Calcula-se a soma dos produtos.
  - O valor obtido é multiplicado por 10 e o resto da divisão por 11 é calculado.
  - O primeiro dígito verificador é o resultado, considerando que, se o resto for maior que 9, o dígito será 0.
  
- **Segundo dígito verificador**:
  - Agora, utiliza-se os 9 dígitos iniciais + o primeiro dígito verificador.
  - A mesma lógica é aplicada com pesos de **11 a 2**.
  
- Se os dois dígitos verificadores calculados coincidirem com os dois últimos dígitos informados, o CPF é considerado **válido**.

## Exemplo de Validação

Para validar o CPF `168.995.350-09`:

1. **Primeiro dígito**: Calculado com os 9 primeiros dígitos, o resultado será 2, mas o esperado é 0, indicando que o CPF é **inválido**.
  
2. **Segundo dígito**: A mesma lógica seria aplicada para o segundo dígito, mas o CPF já é invalidado no primeiro cálculo.

### Exemplo de CPF Inválido:

- CPF: `109.876.543-21`
- **Resultado**: Inválido

### Exemplo de CPF Válido:

- CPF: `123.456.789-09`
- **Resultado**: Válido
