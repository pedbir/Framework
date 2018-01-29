Imports Varigence.Biml.Extensions
Imports Varigence.Languages.Biml
Imports Varigence.Languages.Biml.FileFormat
Imports Varigence.Languages.Biml.Table
Imports System.IO
Imports System.Xml
Imports System.Data
Imports System.Runtime.CompilerServices



Module FlatFileExtension


    Public Datapath As String
    Public FormatPath As String = "C:\Users\pedram.birounvand\Source\Repos\KPI\SSIS\Format\iLevel\"
    Public FolderName As String = Directory.GetParent(FormatPath).Name



    Public Locale As Varigence.Languages.Biml.Cube.Language = Varigence.Languages.Biml.Cube.Language.Lcid1033

    <Extension()>
    Public Function ToAstTableNode(FlatFile As AstFlatFileFormatNode, Schema As AstSchemaNode) As AstTableNode
        Dim BimlTable As New AstTableNode(Nothing)
        BimlTable.Name = "rt_" + FlatFile.name
        Schema.Name = FolderName + "_RawTyped"
        BimlTable.Schema = Schema

        AddSysColumns(BimlTable, "SysFileName", DbType.String, "1000", "False")
        AddSysColumns(BimlTable, "SysExecutionLog_key", DbType.Int32, Nothing, "False")
        AddSysColumns(BimlTable, "SysDatetimeInsertedUTC", DbType.Datetime, Nothing, "False")
        AddSysColumns(BimlTable, "SysDatetimeUpdatedUTC", DbType.Datetime, Nothing, "True")
        AddSysColumns(BimlTable, "SysDatetimeDeletedUTC", DbType.Datetime, Nothing, "True")
        AddSysColumns(BimlTable, "SysModifiedUTC", DbType.Datetime, Nothing, "False")


        For Each flatFileColumn As astflatfilecolumnnode In FlatFile.Columns
            Dim tableColumn As New AstTableColumnNode(Nothing)
            tableColumn.Name = flatFileColumn.Name
            tableColumn.DataType = flatFileColumn.DataType
            tableColumn.Length = flatFileColumn.Length
            tableColumn.Precision = flatFileColumn.Precision
            tableColumn.Scale = flatFileColumn.Scale
            tableColumn.CodePage = flatFileColumn.CodePage
            tableColumn.IsNullable = "True"
            BimlTable.Columns.Add(tableColumn)
        Next

        'Dim SysTableColumn As New AstTableColumnNode(Nothing)
        'SysTableColumn.Name = "FileName"
        'SysTableColumn.DataType = DbType.String
        'SysTableColumn.Length = "1000"
        'BimlTable.Columns.Add(SysTableColumn)


        Dim annotation As New AstAnnotationNode(Nothing)
        annotation.Tag = "ConnName"
        annotation.Text = FlatFile.Name
        BimlTable.Annotations.Add(annotation)
        Return BimlTable

    End Function

    Public Function AddSysColumns(BimlTable As AstTableNode, ColumnName As String, DataType As String, Length As String, IsNullable As String)
        Dim SysTableColumn As New AstTableColumnNode(Nothing)
        SysTableColumn.Name = ColumnName
        SysTableColumn.DataType = DataType
        SysTableColumn.Length = Length
        SysTableColumn.IsNullable = IsNullable
        BimlTable.Columns.Add(SysTableColumn)
    End Function

    <Extension()>
    Public Function ToFlatfileConnection(FlatFileFormat As AstFlatFileFormatNode) As Connection.AstFlatFileConnectionNode
        Dim Connection As New Connection.AstFlatFileConnectionNode(Nothing)
        Connection.Name = FlatFileFormat.Name
        Connection.FileFormat = FlatFileFormat
        Connection.FilePath = Datapath & "\" & FlatFileFormat.name & ".csv"


        Return Connection
    End Function

    <Extension()>
    Public Function GetFlatFileFormatfromXML(XmlFile As String) As AstFlatFileFormatNode

        Dim FlatFileFormat As New AstFlatFileFormatNode(Nothing)
        Dim xmldoc As New XmlDocument
        xmldoc.Load(XmlFile)
        Dim records As XmlNodeList = xmldoc.GetElementsByTagName("RECORD").item(0).childnodes
        Dim rows As XmlNodeList = xmldoc.GetElementsByTagName("ROW").item(0).childnodes
        Dim row As xmlnode
        FlatFileFormat.Locale = Locale
        FlatFileFormat.Name = Path.GetFileNameWithoutExtension(XmlFile)
        FlatFileFormat.RowDelimiter = ConvertDelimiter(records.item(records.count - 1).attributes("TERMINATOR").value)
        FlatFileFormat.ColumnNamesInFirstDataRow = True
        FlatFileFormat.isunicode = False
        FlatFileFormat.CodePage = 65001


        FlatFileFormat.TextQualifier = "_x0022_"
        For Each record As xmlnode In records
            row = rows.item(record.attributes("ID").value - 1)
            Dim DataType As String = row.attributes("xsi:type").value
            Dim DatatypeID As Integer = ConvertDatatype(DataType)
            Dim Column As New AstFlatFileColumnNode(Nothing)
            Column.name = row.attributes("NAME").value
            Column.Delimiter = ConvertDelimiter(record.attributes("TERMINATOR").value)
            If DatatypeID = Nothing Then
                ' By default, we will make this a string!
                Column.DataType = DbType.String
            Else
                Column.DataType = DatatypeID
            End If
            If DatatypeID = Nothing Then
                ' By default, we want out strings to be 1000 Characters
                ' Column.Length = 1000
                Column.Length = record.attributes("MAX_LENGTH").value
            ElseIf DatatypeID = dbtype.AnsiString Or DatatypeID = DbType.String Then
                Column.Length = record.attributes("MAX_LENGTH").value
            End If
            If ConvertDatatype(DataType) = dbtype.Decimal Then
                If (record.attributes("PRECISION") IsNot Nothing AndAlso record.attributes("SCALE") IsNot Nothing) Then
                    Column.Precision = CInt(record.attributes("PRECISION").value)
                    Column.Scale = CInt(record.attributes("SCALE").value)
                Else
                    Column.Precision = 18
                    Column.Scale = 4
                End If
            End If
                If DatatypeID = Nothing Then
                Dim columnannotation As New AstAnnotationNode(Nothing)
                columnannotation.Tag = "Original Datatype"
                columnannotation.Text = DataType
                Column.Annotations.Add(columnannotation)
            End If
            FlatFileFormat.Columns.Add(Column)
        Next
        Return FlatFileFormat
    End Function

    Public Function ConvertDatatype(CSVType As String) As String
        Select Case CSVType
            Case "SQLINT"
                Return dbtype.Int32
            Case "SQLSMALLINT"
                Return dbtype.int16
            Case "SQLVARCHAR"
                Return dbtype.AnsiString
            Case "SQLDATETIME"
                Return dbtype.DateTime
            Case "SQLDATETIME2"
                Return dbtype.DateTime2
            Case "SQLMONEY"
                Return dbtype.Currency
            Case "SQLNUMERIC"
                Return dbtype.Decimal
            Case "SQLDECIMAL"
                Return dbtype.Decimal
            Case "SQLNVARCHAR"
                Return DbType.String
            Case "SQLUNIQUEID"
                ' GUIDs should be interpreted as strings
                Return DbType.String
            Case Else
                Return Nothing
        End Select
    End Function

    Public Function ConvertDelimiter(CSVDelimiter As String) As String
        Select Case CSVDelimiter
            Case "\r\n"
                Return "CRLF"
            Case Else
                Return CSVDelimiter
        End Select
    End Function
End Module