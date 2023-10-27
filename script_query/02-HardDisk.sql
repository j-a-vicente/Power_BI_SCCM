SELECT ResourceID
     , GroupID
	 , RevisionID
	 , Name0 as 'Unidade'
	 , Caption0
	 , Compressed0
	 , Description0
	 , FileSystem0
	 , Size0
	 , FreeSpace0
	 , SystemName0
	 , VolumeName0
	 , VolumeSerialNumber0
	 , TimeStamp
FROM  CM_IFR.[dbo].v_GS_LOGICAL_DISK 