---
title: "GIR Context"
nav_order: 40
parent: "Implementations"
grand_parent: "Keyper"
layout: default
---

# GIR Implementation Context

## Keyper Approve integration for the Gebouw Installatie Register

The GIR (Gebouw Installatie Register) requires explicit consent from the building owner before a registrant can submit installation data. The sequence below illustrates the approval process.

```plantuml
@startuml
!theme plain
entryspacing 0.7

frame #f0f8ff GIR

fontawesome5solid f007 "Registrant (installateur)" as REG #512a19
fontawesome5solid f0ae "Formulieren-app" as FormApp #517dbf
fontawesome5solid f084 "Gebouw Installatie Register" as GIR #fbce00
fontawesome5solid f13d "Keyper Approve" as KA #3bba9c
fontawesome5solid f007 "Gebouwbeheerder" as GB #3933ff
fontawesome5solid f2c1 "eHerkenning" as Eherkenning #592874
fontawesome5solid f3ed "GIR Autorisatieregister" as AR #5182d8
fontawesome5solid f1c0 "DSGO participantenregister" as DSGO PR

== Installatie aanmaken en indienen == #f0f8ff
activate REG
REG->FormApp: login met CRT
activate FormApp
REG->FormApp: installatie + componenten aanmaken
FormApp->GIR: installatie indienen
activate GIR
note over GIR: Controle op aanwezigheid toestemming\n(bijv. policy van GB aan REG)
alt Geen toestemming gevonden
GIR->GIR: registratie status = Pending
GIR->FormApp: bevestiging

else Toestemming bestaat al
GIR->GIR: registratie status = Active
GIR->FormApp: bevestiging
deactivate GIR
FormApp->KA: goedkeuringsverzoek aan Keyper Approve
KA->GB: e-mail met goedkeuringslink
activate GB
end
FormApp->REG: bevestiging
deactivate FormApp
deactivate REG

== Gebouweigenaar keurt goed via Keyper Approve == #f0f8ff
GB->KA: controleer transacties
activate KA
note over KA: (eenmalige) registratie \ngebouwbeheerder\nals DSGO-deelnemer\n(niet in scope)
note over KA: toestemmingen controleren voor:\n - machtiging registrant om\ninstallaties te registreren\n - EDSN om subset van installaties\nin te zien

KA->GB: overzicht transacties
GB->Eherkenning: inloggen eHerkenning niveau 3
activate Eherkenning
note over Eherkenning: tijdens testfase\nalternatieve authenticatie\nmet email-link
Eherkenning->KA: identity token
deactivate Eherkenning
KA->DSGO PR: registreer inschrijving
activate DSGO PR
DSGO PR-->KA: bevestiging
deactivate DSGO PR

KA->AR: registreer metadata & toestemmingen
activate AR
AR-->KA: bevestiging

deactivate AR
KA->GB: redirect naar ...?
deactivate GB
deactivate KA

== Installatie geregistreerd == #f0f8ff
note over GIR: installatie beschikbaar voor datadeelprocessen
@enduml
```

### Approval link request

Create an approval link via the Keyper API using the following template. Replace the placeholders with values from your own application.

```json
{
  "addPolicyTransactions": [
    {
      "useCase": "GIR",
      "issuedAt": 1739881378,
      "notBefore": 1739881378,
      "expiration": 1839881378,
      "issuerId": "{{installationOwnerChamberOfCommerceNumber}}",
      "subjectId": "{{registrarChamberOfCommerceNumber}}",
      "serviceProvider": "NL.KVK.27248698",
      "action": "write",
      "resourceId": "{{vboID}}",
      "type": "vboID",
      "attribute": "{{installationID}}",
      "license": "0005"
    },
    {
      "useCase": "GIR",
      "issuedAt": 1739881378,
      "notBefore": 1739881378,
      "expiration": 1839881378,
      "issuerId": "{{installationOwnerChamberOfCommerceNumber}}",
      "subjectId": "NL.KVK.39098825",
      "serviceProvider": "NL.KVK.27248698",
      "action": "read",
      "resourceId": "{{vboID}}",
      "type": "vboID",
      "attribute": "*",
      "license": "0005",
      "rules": "Classificaties(NLSfB-55.21,NLSfB-56.21,NLSfB-61.15,NLSfB-62.32,NLSfB-61.18)"
    }
  ],
  "requester": {
    "email": "{{requesterEmail}}",
    "organization": "{{registrarChamberOfCommerceNumber}}",
    "organizationId": "{{registrarChamberOfCommerceNumber}}"
  },
  "approver": {
    "email": "{{approverEmail}}",
    "organization": "{{installationOwnerChamberOfCommerceNumber}}",
    "organizationId": "{{installationOwnerChamberOfCommerceNumber}}"
  },
  "dataspace": {
    "name": "DSGO",
    "Use case": "GIR"
  },
  "description": "GIR installation registration approval",
  "reference": "<your reference>",
  "expiresInSeconds": 604800,
  "redirectUrl": "https://www.technieknederland.nl"
}
```
