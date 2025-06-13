

# DVU Implementation Context

## Quick Links
- [🏠 Add single building](context.md)
- [🏘️ Add multiple buildings](gebouwen-in-bulk.md)

> **Status:** Work in progress

## Sequence diagram toegang aanvragen tot gebouwen in bulk

De onderstaande sequence toont het DVU goedkeuringsproces voor meerdere gebouwen tegelijk.

```mermaid
sequenceDiagram
    participant GE as Gebouwbeheerder<br/>en energiecontractant
    participant DG as dataservice-gebruiker
    participant KA as Keyper Approve
    participant MetadataApp as DVU Metadata-app
    participant DVUSat as DVU Satelliet
    participant AR as Autorisatieregister
    participant Eherkenning as eHerkenning
    participant DA as dataservice-aanbieder
    participant RNB as RNB

    Note over GE, DG: Gebouwen toevoegen via DG
    GE->>DG: start sessie
    GE->>DG: invoeren gebouwen (adres/vboId)
    DG->>DG: verzamelen gebouwdata
    DG->>KA: aanmaken transactielink
    KA->>KA: valideren input
    KA->>DG: status: Active + redirect URL
    DG->>GE: redirect naar Keyper Approve

    Note over GE, MetadataApp: Bulk-gebouwgegevens aanvullen<br/>(tijdelijk totdat CAR aansluiting in gebruik is)
    GE->>KA: openen redirect URL
    KA->>GE: redirect naar MetadataApp (gebouw toevoegen in bulk)
    GE->>MetadataApp: invullen aanvullende gegevens
    GE->>MetadataApp: doorlopen flow
    MetadataApp->>GE: terug naar Keyper Approve

    Note over GE, KA: Transacties bevestigen
    GE->>KA: controleer transacties
    
    Note over KA: (optioneel) registratie<br/>overheidsorganisatie<br/>als DVU-deelnemer
    Note over KA: toestemming ophalen<br/>energiedata voor DG:<br/>per gebouw geregistreerd<br/>(later: bulktoestemming)

    KA->>GE: overzicht transacties
    GE->>Eherkenning: inloggen eHerkenning niveau 3
    Eherkenning->>KA: identity token
    KA->>DVUSat: registreer inschrijving
    DVUSat-->>KA: bevestiging
    KA->>AR: registreer metadata & toestemmingen
    AR-->>KA: bevestiging
    KA-->>RNB: afgeven/hergebruiken toestemmingen onder GUE
    KA->>GE: redirect naar DG
    KA->>DG: notificatie: autorisaties verwerkt

    Note over DG, DA: Data ophalen via DVU koppelingen
    DG->>AR: ophalen vboIds + EANs (digikoppeling)
    AR-->>DG: identifiers
    DG->>DA: ophalen energiedata
```
