import java.util.regex.*;

public class ValidadorCPF {

    public static boolean validarCPF(String cpf) {
        // Remove tudo que não for número
        cpf = cpf.replaceAll("[^0-9]", "");

        // Verifica se tem 11 dígitos
        if (cpf.length() != 11) {
            return false;
        }

        // Verifica se todos os dígitos são iguais
        if (cpf.matches("(\\d)\\1{10}")) {
            return false;
        }

        // Validação do primeiro dígito
        int soma = 0;
        for (int i = 0; i < 9; i++) {
            soma += Character.getNumericValue(cpf.charAt(i)) * (10 - i);
        }
        int digito1 = (soma * 10) % 11;
        if (digito1 == 10 || digito1 == 11) {
            digito1 = 0;
        }
        if (digito1 != Character.getNumericValue(cpf.charAt(9))) {
            return false;
        }

        // Validação do segundo dígito
        soma = 0;
        for (int i = 0; i < 10; i++) {
            soma += Character.getNumericValue(cpf.charAt(i)) * (11 - i);
        }
        int digito2 = (soma * 10) % 11;
        if (digito2 == 10 || digito2 == 11) {
            digito2 = 0;
        }
        if (digito2 != Character.getNumericValue(cpf.charAt(10))) {
            return false;
        }

        return true;
    }

    public static void main(String[] args) {
        // Exemplo de uso
        String[] cpfsParaTestar = {
            "123.456.789-09",  // Válido
            "111.111.111-11",  // Inválido
        };

        for (String cpf : cpfsParaTestar) {
            System.out.println("CPF " + cpf + " é válido? " + (validarCPF(cpf) ? "Sim" : "Não"));
        }
    }
}
