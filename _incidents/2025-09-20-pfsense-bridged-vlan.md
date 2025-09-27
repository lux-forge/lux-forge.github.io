---
title: "pfSense Bridged VLAN Firewall Edge Case"
date: 2025-09-20
tags: [pfsense, vlan, firewall, incident]
layout: post
---

**Summary:** A rare bridged VLAN issue on pfSense that defied default rule logic. Solved through empirical testing and rule inversion.

**Timeline:**
- `09:12` — Initial packet drop observed
- `09:47` — Rule audit begins
- `10:15` — Bridged interface behavior isolated
- `11:03` — Fix applied, confirmed via packet capture

**Reflection:** This one taught me that pfSense’s bridge logic can override expected rule flow. Documenting it here for future LuxForge readers.
