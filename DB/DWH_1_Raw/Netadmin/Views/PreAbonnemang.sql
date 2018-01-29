

CREATE VIEW [Netadmin].[PreAbonnemang]
AS
SELECT  SysValidFromDateTime       = CAST(GETUTCDATE() AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , PreAbonnemang_bkey       = CONVERT(INT, preaboid)
        , Preinkopldat             = CONVERT(DATE, CONVERT(VARCHAR(8), CONVERT(INT, NULLIF(Preinkopldat, 10101))))
        , Preurkopldat             = CONVERT(DATE, CONVERT(VARCHAR(8), CONVERT(INT, Preurkopldat)))
        , Preadrid                 = CONVERT(INT, Preadrid)
        , Pretmpid                 = CONVERT(INT, Pretmpid)
        , Preartnr                 = CONVERT(NVARCHAR(50), Preartnr)
        , Prestartartnr            = CONVERT(NVARCHAR(50), Prestartartnr)
        , aboisp                   = TRY_CAST(CAST(aboisp AS NVARCHAR(250)) AS INT)
        , abostartdat              = TRY_CAST(CAST(abostartdat AS NVARCHAR(8)) AS DATE)
        , aboansvarig              = CAST(aboansvarig AS NVARCHAR(50))
FROM    OPENQUERY (NETADMIN
                   , '
SELECT 
     preaboid
     , preinkopldat
	 , preurkopldat
     , preadrid
     , pretmpid
     , preartnr
     , prestartartnr
    , SUBSTRING_INDEX(SUBSTRING_INDEX(predata_v4,''</aboisp>'',1),''<aboisp>'',-1) as aboisp
    , SUBSTRING_INDEX(SUBSTRING_INDEX(predata_v4,''</abostartdat>'',1),''<abostartdat>'',-1) as abostartdat 
    , SUBSTRING_INDEX(SUBSTRING_INDEX(predata_v4,''</aboansvarig>'',1),''<aboansvarig>'',-1) as aboansvarig
FROM netadmin.prevabo
WHERE pretmpid <> 2585 
'   ) oq;