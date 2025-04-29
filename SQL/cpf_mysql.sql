DELIMITER //

CREATE FUNCTION validar_cpf(cpf_input VARCHAR(20))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE cpf_clean VARCHAR(11);
    DECLARE soma INT DEFAULT 0;
    DECLARE digito1 INT;
    DECLARE digito2 INT;
    DECLARE i INT DEFAULT 1;
    DECLARE peso INT;

    -- Remove caracteres não numéricos
    SET cpf_clean = REPLACE(REPLACE(REPLACE(cpf_input, '.', ''), '-', ''), ' ', '');

    -- Verifica se tem 11 dígitos
    IF LENGTH(cpf_clean) != 11 THEN
        RETURN FALSE;
    END IF;

    -- Verifica se todos os dígitos são iguais
    IF cpf_clean = REPEAT(SUBSTRING(cpf_clean, 1, 1), 11) THEN
        RETURN FALSE;
    END IF;

    -- Calcula primeiro dígito
    SET soma = 0;
    SET peso = 10;
    SET i = 1;
    WHILE i <= 9 DO
        SET soma = soma + CAST(SUBSTRING(cpf_clean, i, 1) AS UNSIGNED) * peso;
        SET peso = peso - 1;
        SET i = i + 1;
    END WHILE;

    SET digito1 = (soma * 10) MOD 11;
    IF digito1 = 10 THEN
        SET digito1 = 0;
    END IF;

    IF digito1 != CAST(SUBSTRING(cpf_clean, 10, 1) AS UNSIGNED) THEN
        RETURN FALSE;
    END IF;

    -- Calcula segundo dígito
    SET soma = 0;
    SET peso = 11;
    SET i = 1;
    WHILE i <= 10 DO
        SET soma = soma + CAST(SUBSTRING(cpf_clean, i, 1) AS UNSIGNED) * peso;
        SET peso = peso - 1;
        SET i = i + 1;
    END WHILE;

    SET digito2 = (soma * 10) MOD 11;
    IF digito2 = 10 THEN
        SET digito2 = 0;
    END IF;

    IF digito2 != CAST(SUBSTRING(cpf_clean, 11, 1) AS UNSIGNED) THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;
END;
//

DELIMITER ;
