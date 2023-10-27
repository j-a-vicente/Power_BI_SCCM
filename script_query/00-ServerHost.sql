SELECT RS.[ResourceID]         
     , CS.[Manufacturer0]                AS 'Fabricante'
     , CS.[Model0]                       AS 'Modelo'
     , CS.[Name0]                        AS 'HostName'
     , CS.[Domain0]                      AS 'Dominio'
     , CS.[UserName0]                    AS 'UserName'
     , CASE
         WHEN (RS.Is_Virtual_Machine0 = '1') THEN 'Virtual'
         WHEN (RS.Is_Virtual_Machine0 = '0') THEN 'Physical'
        ELSE '_NI'
       END                               AS 'MachineType'

     , CASE
         WHEN SY.ChassisTypes0 IN ('3','4','6','15','16') THEN 'Desktop'
         WHEN SY.ChassisTypes0 IN ('7','17','23') THEN 'Physical Server'
         WHEN SY.ChassisTypes0 IN ('8','9','10') THEN 'Notebook'
         WHEN (SY.ChassisTypes0 = '1') AND (RS.Is_Virtual_Machine0 = '1')THEN 'Virtual Machine'
        ELSE 'Others'
       END                               AS 'Chassi' 
     , BI.SerialNumber0              AS 'BioSerialNumber'
     , RS.Operating_System_Name_and0     AS 'OS'
     , OS.[CSDVersion0]                  AS 'OSPKVersao'
     , OS.[Version0]                     AS 'OSVersao'
     , OS.[SerialNumber0]                AS 'NSerie'
     , ME.[TotalPhysicalMemory0] / 1024  AS 'TotalPhysicalMemory'
     , CP.Manufacturer0                  AS 'CPUFabricante'
     , CP.NameCPU                        AS 'CPUModelo'
     , CP.Sockets                        AS 'CPUSockets'
     , CP.CoresPerSocket
     , CASE
         WHEN RS.Active0 = 1 THEN 'Active'
         WHEN RS.Active0 = 0 THEN 'Inactive'                     
       END                                AS 'Status'
     , CASE
         WHEN Client0 = 1 THEN 'Client Installed'
        ELSE 'No Client'
       END                                AS 'ClientSCCM'
  FROM CM_IFR.[dbo].[v_R_System] AS RS
  LEFT JOIN CM_IFR.[dbo].[v_GS_COMPUTER_SYSTEM]  AS CS ON RS.[ResourceID] = CS.[ResourceID]
  LEFT JOIN CM_IFR.[dbo].[v_GS_PC_BIOS]          AS BI ON RS.[ResourceID] = BI.[ResourceID]
  LEFT JOIN CM_IFR.[dbo].[v_GS_OPERATING_SYSTEM] AS OS ON OS.[ResourceID] = CS.[ResourceID]
  LEFT JOIN CM_IFR.[dbo].[v_GS_X86_PC_MEMORY]    AS ME ON RS.[ResourceID] = ME.[ResourceID]
  LEFT JOIN CM_IFR.[dbo].[v_GS_SYSTEM_ENCLOSURE] AS SY ON RS.[ResourceID] = SY.[ResourceID]
  LEFT JOIN (SELECT DISTINCT 
				    CPU.[ResourceID]
				  , (CPU.SystemName0) AS [Hostname]
				  , CPU.Manufacturer0
				  , CPU.Name0 AS NameCPU
				  , COUNT(distinct CPU.SocketDesignation0) AS [Sockets]
				  , SUM(CPU.NumberOfCores0) AS [CoresPerSocket]
				FROM 
				CM_IFR.[dbo].[v_GS_PROCESSOR] CPU
				INNER JOIN  CM_IFR.[dbo].v_GS_COMPUTER_SYSTEM CSYS on CPU.ResourceID = CSYS.ResourceID
				GROUP BY
					CPU.[ResourceID]
					,CPU.SystemName0
					,CPU.Manufacturer0
					,CPU.Name0
					,CPU.NumberOfCores0)   AS CP ON RS.[ResourceID] = CP.[ResourceID]
WHERE RS.Client0 IS NOT NULL 
  AND CS.[Name0] IS NOT NULL 