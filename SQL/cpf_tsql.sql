CREATE FUNCTION validar_cpf (@cpf_input NVARCHAR(20))
RETURNS BIT
AS
BEGIN
    DECLARE @cpf_clean NVARCHAR(11)
    DECLARE @soma INT = 0
    DECLARE @digito1 INT
    DECLARE @digito2 INT
    DECLARE @i INT = 1
    DECLARE @peso INT

    -- Remove caracteres não numéricos
    SET @cpf_clean = REPLACE(REPLACE(REPLACE(@cpf_input, '.', ''), '-', ''), ' ', '');

    -- Verifica se tem 11 dígitos
    IF LEN(@cpf_clean) != 11
        RETURN 0;

    -- Verifica se todos os dígitos são iguais
    IF @cpf_clean = REPLICATE(SUBSTRING(@cpf_clean, 1, 1), 11)
        RETURN 0;

    -- Primeiro dígito
    SET @soma = 0;
    SET @peso = 10;
    SET @i = 1;
    WHILE @i <= 9
    BEGIN
        SET @soma = @soma + CAST(SUBSTRING(@cpf_clean, @i, 1) AS INT) * @peso;
        SET @peso = @peso - 1;
        SET @i = @i + 1;
    END

    SET @digito1 = (@soma * 10) % 11;
    IF @digito1 = 10
        SET @digito1 = 0;

    IF @digito1 != CAST(SUBSTRING(@cpf_clean, 10, 1) AS INT)
        RETURN 0;

    -- Segundo dígito
    SET @soma = 0;
    SET @peso = 11;
    SET @i = 1;
    WHILE @i <= 10
    BEGIN
        SET @soma = @soma + CAST(SUBSTRING(@cpf_clean, @i, 1) AS INT) * @peso;
        SET @peso = @peso - 1;
        SET @i = @i + 1;
    END

    SET @digito2 = (@soma * 10) % 11;
    IF @digito2 = 10
        SET @digito2 = 0;

    IF @digito2 != CAST(SUBSTRING(@cpf_clean, 11, 1) AS INT)
        RETURN 0;

    RETURN 1;
END;
