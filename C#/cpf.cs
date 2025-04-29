using System;
using System.Text.RegularExpressions;

class Program
{
    static bool ValidarCPF(string cpf)
    {
        // Remove tudo que não for número
        cpf = Regex.Replace(cpf, @"\D", "");

        // Verifica se tem 11 dígitos
        if (cpf.Length != 11)
        {
            return false;
        }

        // Verifica se todos os dígitos são iguais
        if (Regex.IsMatch(cpf, @"^(\d)\1{10}$"))
        {
            return false;
        }

        // Validação do primeiro dígito
        int soma = 0;
        for (int i = 0; i < 9; i++)
        {
            soma += int.Parse(cpf[i].ToString()) * (10 - i);
        }
        int digito1 = (soma * 10) % 11;
        if (digito1 == 10 || digito1 == 11)
        {
            digito1 = 0;
        }
        if (digito1 != int.Parse(cpf[9].ToString()))
        {
            return false;
        }

        // Validação do segundo dígito
        soma = 0;
        for (int i = 0; i < 10; i++)
        {
            soma += int.Parse(cpf[i].ToString()) * (11 - i);
        }
        int digito2 = (soma * 10) % 11;
        if (digito2 == 10 || digito2 == 11)
        {
            digito2 = 0;
        }
        if (digito2 != int.Parse(cpf[10].ToString()))
        {
            return false;
        }

        return true;
    }

    static void Main()
    {
        // Exemplo de uso
        string[] cpfsParaTestar = {
            "123.456.789-09",  // Válido
            "111.111.111-11",  // Inválido
        };

        foreach (var cpf in cpfsParaTestar)
        {
            Console.WriteLine($"CPF {cpf} é válido? {ValidarCPF(cpf) ? "Sim" : "Não"}");
        }
    }
}
