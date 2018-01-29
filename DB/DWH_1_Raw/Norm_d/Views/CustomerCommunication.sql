

CREATE VIEW [Norm_d].[CustomerCommunication]
AS
SELECT  SysValidFromDateTime					= SysValidFromDateTime
        , SysSrcGenerationDateTime				= SysSrcGenerationDateTime
        , SysDatetimeDeletedUTC					= CAST(CASE WHEN Deleted = 1 THEN SysValidFromDateTime ELSE NULL END AS DATETIME2(0))
        , SysModifiedUTC						= SysModifiedUTC
		, CustomerCommunication_bkey			= Omrade_bkey
        , Area_bkey								= Omrade_bkey
		, CommunicationPhase					= Phase
		, CustomerCommunicationCount			= KkKundkommunikationCountC
FROM 
	(SELECT	SysValidFromDateTime
			, SysSrcGenerationDateTime
			, Deleted, SysModifiedUTC
			, Omrade_bkey
			, KkKundkommunikationCountC
			, KrFas1C AS Phase1
			, KrFas2C AS Phase2
			, KrFas3C AS Phase3
			, KrFas4C AS Phase4
			, KrFas5C AS Phase5
			, KrFas6C AS Phase6
	FROM	Sugar_RawTyped.r_Omrade) p
UNPIVOT
	(Status FOR Phase IN 
      (Phase1, Phase2, Phase3, Phase4, Phase5, Phase6)
	) AS unpvt
WHERE	Omrade_bkey <> '-1'
AND		Status = 'Pagaende'