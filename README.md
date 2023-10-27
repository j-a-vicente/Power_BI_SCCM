# Utilizando o Power BI para criar painéis para o System Center Configuration Manager "SCCM".

Para criar o painel vamos utilizar alg

Vamos definir o objetivo a ser alcançados com os nossos painéis:
 * Quantitativos:
   * Total de servidores.
   * Total de estações de trabalho.
   * Total de estações de trabalho Ativos e desativado.
   * Proporção por sistema operacional.
   * Quantitativo de servidores e estações de trabalho por localize ou escritório.
   * Total de sistemas operacionais.
   * Total de aplicativos instalados nos servidores e estação de trabalho.
   * Quantitativo por tipo de máquina "Física" ou "Virtual".
   * Total de servidores e estações de trabalho com atualização do "SO" em dia.
   * Total de servidores e estações de trabalho com atualização do "SO" pendente.
   * Volume dos discos "hd".
   * Total de CPU's.
   * Total de Mémoria RAM.

* Qualitativo:
   * Lista de servidores e estações de trabalho por "SO"
   * Lista de servidores e estações de trabalho por localidade ou escritório.
   * Lista de aplicativos instalado.
   * BackList de aplicativos.
   * Lista de servidores e estações de trabalho com aplicativos da backlist instalado.
   * Lista de servidores e estações de trabalho com atualização do "SO" em dia.
   * Lista de servidores e estações de trabalho com atualização do "SO" pendente.
   * Lista de servidores e estações de trabalho com antivirus instalado e sem.
   * Lista de IP's.
* Gráficos:
   * ......
   * ......
   * ......

Antes de começar a desenvolver os painéis é preciso entender a estrutura de dados do SCCM. Para facilitar a extração dos dados por padrão existe diversas visões "VIEW" configuradas na base de dados do SCCM.

<p>Cada visão começa com uma siglas, para sua classificação:</p>

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
