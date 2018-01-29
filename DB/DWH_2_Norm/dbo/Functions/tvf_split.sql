CREATE FUNCTION dbo.tvf_split
(
    @Text VARCHAR(MAX),
    @Separator CHAR(1)
)
RETURNS @Values TABLE (SplitValue NVARCHAR(100))
AS
BEGIN

    DECLARE @X XML

    SELECT @X = CONVERT(XML, ' <root> <s>' + REPLACE(@Text, @Separator, '</s> <s>') + '</s>   </root> ')

    INSERT @Values
    (
        SplitValue
    )
    SELECT Value = T.c.value('.', 'varchar(100)')
    FROM @X.nodes('/root/s')T(c)


    RETURN
END