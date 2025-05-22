---
title: "Data Sources"
parent: "HeyWim"
nav_order: 15
layout: default
---


# HeyWim — Data Sources

A living catalogue of every external feed wired into HeyWim, including what each brings to the platform.

---

## 1 · Ocean-carrier APIs

| Carrier         | Location(s) | Data supplied                        | Refresh (minimum) |
| --------------- | ----------- | ------------------------------------ | ----------------- |
| **Maersk**      | Global      | DCSA-style events                    | 24 h              |
| **MSC**         | Global      | DCSA-style events                    | 24 h              |
| **CMA CGM**     | Global      | DCSA-style events                    | 24 h              |
| **Hapag-Lloyd** | Global      | DCSA-style events                    | 24 h              |
| **ONE**         | Global      | Container history + vessel calls     | 24 h              |
| **Arkas**       | Global      |                                     | 24 h              |
| **COSCO**       | Global      |                                     | 24 h              |
| **Evergreen**   | Global      |                                     | 24 h              |
| **HMM**         | Global      |                                     | 24 h              |
| **OOCL**        | Global      |                                     | 24 h              |
| **Yang Ming**   | Global      |                                     | 24 h              |
| **ZIM**         | Global      |                                     | 24 h              |

## 2 · Deep-sea terminal systems

| Terminal          | Location(s) | Data supplied (work in progress)           | Refresh (minimum) |
| ----------------- | ----------- | ------------------------------------------ | ----------------- |
| **APM Terminals** | Global      | Gate in/out, discharge, load               | 8 h               |
| **ECT**           | Rotterdam   | Gate in/out, discharge, load               | 8 h               |
| **RWG**           | Rotterdam   | Gate moves                                 | 8 h               |
| **Delta 2**       | Rotterdam   | Gate moves                                 | 8 h               |
| **NextPort**      | Antwerp     | Vessel ETA feed & container gate moves     | 8 h               |

---

## 3 · Inland terminals & hinterland feeds

| Source   | Scope               | Data supplied                                 | Refresh |
| -------- | ------------------- | --------------------------------------------- | ------- |
| **BCTN** | NL/BE barge network | Gate in/out, barge ATA/ATD                    | 4 h     |
| **EGS**  | North-West Europe      | Full event stream (truck / barge / rail) | 2 h     |

---

## 4 · DCSA-compliant events

Any publisher that already emits DCSA 2+ JSON (e.g., Hapag-Lloyd, EGS) is ingested directly.

## · 5 Publisher-specific Assumptions

Assumptions to standardize non-DCSA event data may vary by publisher. Below is an overview of known differences in field interpretation.

| Publisher | Field(s) | Source description | Interpretation HeyWim |
|-----------|-----------|-----------|-----------|
| `EGS`       | `Pickup.EtaDate`, `Pickup.Etatime`, `Pickup.DeepseaTerminalEtdDate`, `Pickup.DeepseaTerminalEtdTime`, `Delivery.EtdDate`, `Delivery.EtdTime`, `Delivery.DeepseaTerminalEtaDate`, `Delivery.DeepseaTerminalEtaTime`  | ETA values only; not updated to ATA. | As a result, only `EST` events and no `ACT` events are available. Use a separate event to determine actual arrival, if available.|
|           | `Pickup.GateInDate`, `Pickup.GateInTime`   | Represents gate-in across all modalities. | For modality `Barge` and `Train`, this is mapped to a `DISC` event. For other modalities, including `Truck`, this is mapped to `GTIN` |
|*work in progress* | | |

## Adding Custom Data Sources

Enterprise customers can integrate custom data sources with HeyWim through our extensible connector framework. This allows for incorporation of proprietary systems such as:

For more information on custom integrations, please contact your Poort8 account representative.

*Last updated: 22 May 2025*
