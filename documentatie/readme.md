# Opdracht Windows server
## Opdracht:

U bent IT-Consultant en krijgt de vraag om een voorstel te maken en te demonstreren van een Windowsomgeving.

Deze omgeving moet bestaan uit het volgende .

De cliënt wenst een redundante oplossing voor zijn servers. Dit vooral op de domeincontrollers. Je gaat er voor zergen dat de client een oplossing heeft voor Mail (Exchange), Automatische deplyement van toestellen (SCCM – MDT). Je zal ook SharePoint als oplossing installeren.

U krijgt dus volgende situatie  dewelke u zoveel mogelijk zal automatiseren via PowerShell scripting

1. **2 Domeincontrollers die bestaan uit Windows 2019 met volgende specifiacties**
  1. OS: Windows 2019
  2. NAAM domain controller 1 WIN-DC1
  3. IP instellingen WIN-DC1
    1. 1 NIC op NAT
    2. 1 NIC op intern netwerk met volgende IP configuratie
      1. IP: 192.168.100.10
      2. SN: 255.255.255.0
  4. NAAM domain controller 2 WIN-DC2
  5. IP instellingen WIN-DC2
    1. 1 NIC op Intern netwerk
      1. IP: 192.168.100.20
      2. SN: 255.255.255.0
      3. DG: 192.168.100.10
2. **SQL server**
  1. OS: Windows 2019
  2. Naam SQL Server WIN-SQL-SCCM
  3. Versie SQL versie 2017
  4. IP instellingen SQL server
    1. 1 NIC op intern netwerk
      1. IP: 192.168.100.30
      2. SN: 255.255.255.0
      3. DG: 192.168.100.10
3. **Exchange server**
  1. OS: Windows 2019
  2. Naam SQL Server WIN-EXC-SHP
  3. Versie Exchange: 2016
  4. IP instellingen Exchange
    1. 1 NIC op intern netwerk
      1. IP: 192.168.100.40
      2. SN: 255.255.255.0
      3. DG: 192.168.100.40

1. **Deployment server**
  1. OS: Windows 2019
  2. Naam WIN-SQL-SCCM
  3. Versie SCCM: 2016
  4. IP instellingen Deployment
    1. 1 NIC op intern netwerk
      1. IP: 192.168.100.30
      2. SN: 255.255.255.0
      3. DG: 192.168.100.30
2. **SharePoint server**
  1. OS Windows 2019
  2. Naam SQL Server WIN-EXC-SHP
  3. Versie SharePoint: 2016
  4. IP instellingen Exchange
    1. 1 NIC op intern netwerk
      1. IP: 192.168.100.40
      2. SN: 255.255.255.0
      3. DG: 192.168.100.40
3. **Windows Cliënt**
  1. OS: Windows 10
  2. Na&amp;am client WIN-CLT1
  3. IP: via DHCP van de DC1 of DC2
  4. Office software om te mailen

1. **Bijkomende specificaties**
  1. Domeinnaam voor deze opstelling uw naam.periode1
    1. Voorbeeld **thijs.periode1**
  2. Configureer op uw DC 1 de routerfaciliteiten zodat uw intern netwerk via de DC1 op het internet kan.
  3. Zorg ook dat DNS op alle servers wordt ingesteld op 192.168.100.10
2. **Opdracht specifiek servers**
  1. Deployment server:
    1. Moet mogelijk zijn om een Windows Cliënt te installeren via een image
    2. Moet mogelijk zijn om Adobe reader te deployen op een Windows toestel via een package (msi of iets dergelijks)
    3. Beheers uw updates via de SCCM deployment omgeving
  2. SharePoint server
    1. Installatie en configuratie voor een intranet site. Niet toegankelijk van buitenuit
    2. Zorg dat de active directory security groepen deze kunnen gebruiken.
3. **Evaluatie**
  1. Als documentatie zorgt u voor een volledige installatiehandleiding van alle verschillende servers en clients. U voegt ook uw scripts bij het portfolio.
  2. Voorafgaand aan de mondelinge verdediging in de examen periode zal u uw portfolio inleveren via chamilo op 27 december ten laatste.
