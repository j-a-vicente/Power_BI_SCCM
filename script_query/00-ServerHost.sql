SELECT DISTINCT
       SYS.ResourceID,
       SYS.Name0 as 'Hostname',
       'Regiao'=CASE
                     WHEN (IP.IP_Subnets0 like '10.1.%') or (IP.IP_Subnets0 like '10.9.%') THEN 'DF'
                     WHEN (IP.IP_Subnets0 like '10.2.%') THEN 'DF'
                     WHEN (IP.IP_Subnets0 like '10.3.%') or (IP.IP_Subnets0 like '10.143.%') THEN 'GM'
                     WHEN (IP.IP_Subnets0 like '10.4.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.5.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.6.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.7.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.8.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.9.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.10.%') THEN 'CE'
           ELSE '_NI'
       END,
       'Chassi' = CASE
                     WHEN SYSENC.ChassisTypes0 IN ('3','4','6','15','16') THEN 'Desktop'
                     WHEN SYSENC.ChassisTypes0 IN ('7','17','23') THEN 'Physical Server'
                     WHEN SYSENC.ChassisTypes0 IN ('8','9','10') THEN 'Notebook'
                     WHEN (SYSENC.ChassisTypes0 = '1') AND (SYS.Is_Virtual_Machine0 = '1')THEN 'Virtual Machine'
          ELSE 'Others'
       END,
       'MachineType' = CASE
                     WHEN (SYS.Is_Virtual_Machine0 = '1') THEN 'Virtual'
                     WHEN (SYS.Is_Virtual_Machine0 = '0') THEN 'Physical'
          ELSE '_NI'
       END,
       SYS.Operating_System_Name_and0 as 'OS',
       OPSYS.Caption0 as 'OS Caption',
       CSYS.Manufacturer0 as 'CManufacturer',
       CSYS.Model0 as 'Model',
       MEM.TotalPhysicalMemory0 as 'TotalPhysicalMemory',
       Processor.Manufacturer0 as 'ProcessorManufacturer',
       CP.NameCPU AS 'CPUModelo',
       Processor.MaxClockSpeed0 as 'ProcessorClock',
       CP.Sockets AS 'CPUSockets',
       CP.CoresPerSocket,
       HWSCAN.LastHWScan,
       SWSCAN.LastScanDate as 'LastSWScan',
       'Client Status' = CASE
                     WHEN SYS.Active0 = 1 THEN 'Active'
          ELSE 'Inactive'
       END,
       'Client SCCM' = CASE
                     WHEN Client0 = 1 THEN 'Client Installed'
          ELSE 'No Client'
       END
FROM
CM_IFR.[dbo].v_R_System SYS
LEFT JOIN CM_IFR.[dbo].v_GS_X86_PC_MEMORY MEM on SYS.ResourceID = MEM.ResourceID
LEFT JOIN CM_IFR.[dbo].v_GS_COMPUTER_SYSTEM CSYS on SYS.ResourceID = CSYS.ResourceID
LEFT JOIN CM_IFR.[dbo].v_GS_PROCESSOR Processor  on Processor.ResourceID = SYS.ResourceID
LEFT JOIN CM_IFR.[dbo].v_GS_OPERATING_SYSTEM OPSYS on SYS.ResourceID = OPSYS.ResourceID
LEFT JOIN CM_IFR.[dbo].v_GS_LastSoftwareScan SWSCAN on SYS.ResourceID = SWSCAN.ResourceID
LEFT JOIN CM_IFR.[dbo].v_GS_WORKSTATION_STATUS HWSCAN on SYS.ResourceID = HWSCAN.ResourceID
LEFT JOIN CM_IFR.[dbo].v_GS_SYSTEM_ENCLOSURE SYSENC on SYS.ResourceId = SYSENC.ResourceId
LEFT JOIN CM_IFR.[dbo].v_RA_System_IPSubnets IP ON SYS.ResourceID = IP.ResourceID
LEFT JOIN CM_IFR.[dbo].v_R_User USR ON SYS.User_Name0 = USR.User_Name0
LEFT JOIN (SELECT DISTINCT CPU.[ResourceID], (CPU.SystemName0) AS [Hostname], CPU.Manufacturer0, CPU.Name0 AS NameCPU
, COUNT(distinct CPU.SocketDesignation0) AS [Sockets], SUM(CPU.NumberOfCores0) AS [CoresPerSocket]
FROM CM_IFR.[dbo].[v_GS_PROCESSOR] CPU
INNER JOIN  CM_IFR.[dbo].v_GS_COMPUTER_SYSTEM CSYS on CPU.ResourceID = CSYS.ResourceID
GROUP BY CPU.[ResourceID],CPU.SystemName0,CPU.Manufacturer0,CPU.Name0,CPU.NumberOfCores0
) AS CP ON SYS.[ResourceID] = CP.[ResourceID]
