# Utilizando o Power BI para criar painéis com os dados do System Center Configuration Manager "SCCM".

Neste projeto vamos entender parte da estrutura de dados do SCCM e desenvolver algumas query's para extrair as informações da base de dados do SCCM.

## O que será extraído.

### Dados quantitativos:
+ Total de servidores.
+ Total de estações de trabalho.
+ Total de estações de trabalho 
  + Ativos
  + Desativado.
+ Proporção sistemas operacionais.
+ Quantitativo de servidores e estações de trabalho por localize ou escritório.
+ Total de sistemas operacionais.
+ Total de aplicativos instalados nos servidores e estação de trabalho.
+ Quantitativo por tipo de máquina "Física" ou "Virtual".
+ Volume dos discos "hd".
  + Total 
  + Livre
+ Total de CPU's.
+ Total de Mémoria RAM.

### Dados qualitativo:
+ Lista de servidores e estações de trabalho por "SO"
+ Lista de servidores e estações de trabalho e sua localidade.
+ Lista de aplicativos instalado.

## Power BI
|||
|----|------|
|![image](https://github.com/j-a-vicente/Power_BI_SCCM/blob/main/imagens/quantitativo.PNG?raw=true)|![image](https://github.com/j-a-vicente/Power_BI_SCCM/blob/main/imagens/servidores.PNG?raw=true)|
|![image](https://github.com/j-a-vicente/Power_BI_SCCM/blob/main/imagens/esta%C3%A7%C3%B5es.PNG?raw=true)|![image](https://github.com/j-a-vicente/Power_BI_SCCM/blob/main/imagens/softwareInstalados.PNG?raw=true)|

### Base de dados do SCCM.
Antes de começar a desenvolver as query's, vamos entender a estrutura de dados do SCCM. 

Para facilitar a extração dos dados por padrão existe diversas visões "VIEW" configuradas na base de dados do SCCM.

#### Cada visão começa com uma sigla de classificação:
-------------------------------
| Sigla         | Descrição    |
|---------------|--------------|
| v_R_ ou v_RA  | Visualizações de classe de descoberta|
| v_GS          | Visualizações de classe de inventário de hardware|
| v_HS          | Visualizações de classe de inventário de hardware histórico|
| v_CH          | Saúde do cliente|
|_RES_COL_      | Informações específicas dos membros da coleção|
| v_            | Todos os outros |
-----------------------------------

#### Tabelas ou views que serão utilizadas no projeto.
-------------------------------
| Tabelas ou Views         | Descrição    |
|---------------|--------------|
|v_R_System|	Lista todos os recursos do sistema descobertos por ID de recurso
|v_GS_COMPUTER_SYSTEM|	Lista informações sobre os clientes do Gerenciador de Configurações
|v_GS_PC_BIOS|	Lista informações sobre o BIOS encontrado em clientes do Configuration Manager
|v_GS_OPERATING_SYSTEM|	Lista informações sobre o sistema operacional encontrado em Configuration Manager clientes
|v_GS_X86_PC_MEMORY|	Lista informações sobre a memória encontrada em Configuration Manager clientes
|v_GS_SYSTEM_ENCLOSURE|	Lista informações sobre o gabinete do sistema encontrado em clientes do Gerenciador de Configurações
|v_GS_PROCESSOR|	Lista informações sobre os processadores encontrados em Configuration Manager clientes
|v_GS_SoftwareProduct| Lista os produtos encontrados em cada cliente do Gerenciador de Configurações
|v_GS_SoftwareFile|	Lista os arquivos e IDs de produto associados em cada cliente do Gerenciador de Configurações
|v_GS_LOGICAL_DISK|	Lista informações sobre os discos lógicos encontrados em Configuration Manager clientes
|v_GS_LastSoftwareScan|Lista a última vez que cada cliente do Gerenciador de Configurações foi verificado em busca de inventário de software. 
|v_GS_WORKSTATION_STATUS|Lista informações de status da estação de trabalho para clientes do Gerenciador de Configurações, incluindo a última verificação de hardware, ID de localidade padrão, deslocamento de fuso horário e assim por diante.
|v_RA_System_IPSubnets|Lista as sub-redes IP para recursos do sistema descobertos. 
|v_R_User|Lista todos os recursos de usuário descobertos por ID de recurso, tipo de recurso, nome de usuário, domínio e assim por diante. 


#### Querys
Serão utilizadas três consultas “querys” para o desenvolvimento do projeto.
+ 00-ServerHost.sql
+ 01-SoftwareInstall.sql
+ 02-HardDisk.sql

### Power BI.
Dentro do Power BI as tabelas vão se relacionar pela coluna "ResourceID".
![image](https://github.com/j-a-vicente/Power_BI_SCCM/blob/main/imagens/diagrama.PNG?raw=true)

##### 00-ServerHost.sql
Retorna todas as máquinas cadastradas no SCCM.
````

SELECT DISTINCT
       SYS.ResourceID,
       SYS.Name0 as 'Hostname',
       'Regiao'=CASE
                     WHEN (IP.IP_Subnets0 like '10.0.%') or (IP.IP_Subnets0 like '10.9.%') THEN 'DF'
                     WHEN (IP.IP_Subnets0 like '10.8.%') THEN 'DF'
                     WHEN (IP.IP_Subnets0 like '10.1.%') or (IP.IP_Subnets0 like '10.143.%') THEN 'GM'
                     WHEN (IP.IP_Subnets0 like '10.30.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.31.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.32.128.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.32.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.33.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.36.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.30.128.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.34.128.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.34.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.35.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.37.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.38.%') THEN 'RJ'
                     WHEN (IP.IP_Subnets0 like '10.39.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.49.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.82.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.83.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.2.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.6.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.40.128.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.40.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.41.%') THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.42.%') or (IP.IP_Subnets0 like '10.11.44.%')  THEN 'SP'
                     WHEN (IP.IP_Subnets0 like '10.43.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.44.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.45.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.46.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.47.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.48.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.80.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.81.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.84.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.85.%') THEN 'MG'
                     WHEN (IP.IP_Subnets0 like '10.86.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.87.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.3.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.50.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.51.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.52.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.53.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.54.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.55.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.56.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.57.%') THEN 'SC'
                     WHEN (IP.IP_Subnets0 like '10.58.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.7.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.90.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.91.128.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.91.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.92.128.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.92.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.93.128.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.93.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.94.128.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.94.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.95.128.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.95.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.96.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.97.%') THEN 'ES'
                     WHEN (IP.IP_Subnets0 like '10.99.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.4.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.60.128.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.60.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.61.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.62.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.63.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.64.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.65.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.66.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.67.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.68.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.69.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.5.%') THEN 'MT'
                     WHEN (IP.IP_Subnets0 like '10.70.128.0') or (IP.IP_Subnets0 like '10.70.147.0') or (IP.IP_Subnets0 like '10.70.156.0') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.70.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.71.128.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.71.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.73.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.75.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.76.128.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.76.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.78.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.72.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.74.128.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.74.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.77.%') THEN 'CE'
                     WHEN (IP.IP_Subnets0 like '10.79.%') THEN 'CE'
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

````
##### 01-SoftwareInstall.sql
Retorna todos os softwares instalados nos servidores e estações de trabalho cadastradas no SCCM.
````
SELECT DISTINCT 
       A.ResourceID
     , A.Name0 AS [Computer Name]
     , S.CompanyName
     , S.ProductName
     , F.FileName
     , F.FileVersion
     , F.FilePath
FROM CM_IFR.dbo.V_R_System AS A
INNER JOIN CM_IFR.dbo.v_GS_SoftwareProduct AS S ON S.ResourceID = A.ResourceID
INNER JOIN CM_IFR.dbo.v_GS_SoftwareFile AS F ON F.ResourceID = S.ResourceID AND F.ProductId = S.ProductID
````
##### 02-HardDisk.sql
Retorna todos os hd's configurados nos servidores e estações de trabalho cadastradas no SCCM.
````
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
```` 

## Referências 
* [Compreendendo os dados do Configuration Manager](https://www.informit.com/articles/article.aspx?p=2514918)
* [SCCM Report for Windows 11 Version Count Dashboard](https://www.anoopcnair.com/sccm-report-for-windows-11-version-count-dashbd/)
* [Exemplo de consultas para inventário de hardware no Configuration Manager](https://docs.microsoft.com/pt-br/mem/configmgr/develop/core/understand/sqlviews/sample-queries-hardware-inventory-configuration-manager)
* [Exemplo de consultas para inventário de software no Configuration Manager](https://docs.microsoft.com/pt-br/mem/configmgr/develop/core/understand/sqlviews/sample-queries-software-inventory-configuration-manager)
* [Exemplo de consultas para inteligência de ativos no Configuration Manager](https://docs.microsoft.com/pt-br/mem/configmgr/develop/core/understand/sqlviews/sample-queries-asset-intelligence-configuration-manager)
* [HOW TO QUERY THE SQL SCCM DATABASE](https://systemcenterdudes.com/how-to-query-the-sql-sccm-database/)
* [Below are some SCCM sql queries for your SSRS reports, all queries work with SCCM 2012 or greater.](https://mynexttech.com/sccm-custom-reports/sccm-sql-queries/)
* [Visualizações de gerenciamento de aplicativos no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/application-management-views-configuration-manager)
* [Visualizações de implantação de cliente no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/client-deployment-views-configuration-manager)
* [Visualizações de status do cliente no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/client-status-views-configuration-manager)
* [Visualizações de coleção no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/collection-views-configuration-manager)
* [Exibições de configurações de conformidade no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/compliance-settings-views-configuration-manager)
* [Visualizações de gerenciamento de conteúdo no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/content-management-views-configuration-manager)
* [Visualizações de descoberta no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/discovery-views-configuration-manager)
* [Visualizações de proteção de endpoint no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/endpoint-protection-views-configuration-manager)
* [Visualizações de inventário de hardware no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/hardware-inventory-views-configuration-manager)
* [Visualizações de inventário de software no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/software-inventory-views-configuration-manager)
* [Visualizações de inteligência de ativos no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/asset-intelligence-views-configuration-manager)
* [Visualizações de migração no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/migration-views-configuration-manager)
* [Visualizações de gerenciamento de dispositivos móveis no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/mobile-device-management-views-configuration-manager)
* [Visualizações de implantação do sistema operacional no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/operating-system-deployment-views-configuration-manager)
* [Visualizações de gerenciamento de energia no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/power-management-views-configuration-manager)
* [Visualizações de esquema no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/schema-views-configuration-manager)
* [Visualizações de segurança no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/security-views-configuration-manager)
* [Visualizações de administração do site no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/site-admin-views-configuration-manager)
* [Visualizações de medição de software no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/software-metering-views-configuration-manager)
* [Exibições de atualizações de software no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/software-updates-views-configuration-manager)
* [Visualizações de status e alerta no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/status-alert-views-configuration-manager)
* [Visualizações de descoberta no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/discovery-views-configuration-manager)
* [Exibições Wake On LAN no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/wake-lan-views-configuration-manager)
* [Outro](https://docs.microsoft.com/pt-br/mem/configmgr/develop/core/understand/sqlviews/sample-queries-application-management-configuration-manager)
