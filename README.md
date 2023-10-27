# Utilizando o Power BI para criar painéis para o System Center Configuration Manager "SCCM".

Neste projeto vamos acessar a base de dados do SCCM que está no SQL Server e vou mostras quais consultas vamos utilizar para montar o nosso painel.

## Vamos definir as informações que serão fornecidas pelo painel.

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
+ Lista de servidores e estações de trabalho por localidade ou escritório.
+ Lista de aplicativos instalado.

### Base de dados do SCCM.
Antes de começar a desenvolver o painel será preciso entender a estrutura de dados do SCCM. Para facilitar a extração dos dados por padrão existe diversas visões "VIEW" configuradas na base de dados do SCCM.

#### Cada visão começa com uma sigla, para sua classificação:
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

#### Querys
Serão utilizadas três consultas “querys” para o desenvolvimento do projeto.
+ 00-ServerHost.sql
+ 01-SoftwareInstall.sql
+ 02-HardDisk.sql






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
