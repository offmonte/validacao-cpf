fn validar_cpf(cpf_input: &str) -> bool {
    let cpf_digits: Vec<u8> = cpf_input
        .chars()
        .filter(|c| c.is_ascii_digit())
        .map(|c| c.to_digit(10).unwrap() as u8)
        .collect();

    if cpf_digits.len() != 11 {
        return false;
    }

    if cpf_digits.iter().all(|&d| d == cpf_digits[0]) {
        return false;
    }

    let soma1: u32 = cpf_digits
        .iter()
        .take(9)
        .enumerate()
        .map(|(i, &d)| (10 - i as u32) * d as u32)
        .sum();

    let digito1 = (soma1 * 10) % 11 % 10;
    if digito1 != cpf_digits[9] {
        return false;
    }

    let soma2: u32 = cpf_digits
        .iter()
        .take(10)
        .enumerate()
        .map(|(i, &d)| (11 - i as u32) * d as u32)
        .sum();

    let digito2 = (soma2 * 10) % 11 % 10;
    if digito2 != cpf_digits[10] {
        return false;
    }

    true
}

fn main() {
    let cpfs = [
        "123.456.789-09", // Válido
        "111.111.111-11", // Inválido
    ];

    for cpf in &cpfs {
        if validar_cpf(cpf) {
            println!("CPF {} é válido.", cpf);
        } else {
            println!("CPF {} é inválido.", cpf);
        }
    }
}