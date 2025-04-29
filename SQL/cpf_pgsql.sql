CREATE OR REPLACE FUNCTION validar_cpf(cpf_input TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    cpf_clean TEXT;
    soma INT;
    digito1 INT;
    digito2 INT;
    i INT;
BEGIN
    -- Remove caracteres não numéricos
    cpf_clean := regexp_replace(cpf_input, '[^0-9]', '', 'g');

    -- Verifica se tem 11 dígitos
    IF length(cpf_clean) != 11 THEN
        RETURN FALSE;
    END IF;

    -- Verifica se todos os dígitos são iguais
    IF cpf_clean ~ '^(.)\1*$' THEN
        RETURN FALSE;
    END IF;

    -- Calcula primeiro dígito
    soma := 0;
    FOR i IN 1..9 LOOP
        soma := soma + (CAST(substr(cpf_clean, i, 1) AS INT) * (10 - i));
    END LOOP;
    digito1 := (soma * 10) % 11;
    IF digito1 = 10 THEN
        digito1 := 0;
    END IF;

    IF digito1 != CAST(substr(cpf_clean, 10, 1) AS INT) THEN
        RETURN FALSE;
    END IF;

    -- Calcula segundo dígito
    soma := 0;
    FOR i IN 1..10 LOOP
        soma := soma + (CAST(substr(cpf_clean, i, 1) AS INT) * (11 - i));
    END LOOP;
    digito2 := (soma * 10) % 11;
    IF digito2 = 10 THEN
        digito2 := 0;
    END IF;

    IF digito2 != CAST(substr(cpf_clean, 11, 1) AS INT) THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
