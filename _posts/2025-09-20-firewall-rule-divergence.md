---
title: "The Rule That Slipped Through: pfSense and the Floating Ghost"
date: 2025-09-20 20:48 BST
tags: [incident, pfsense, firewall, homelab, luxforge]
version: 1.0.1
commit: b664c4b
layout: post
---

It started with a shrug. VLAN 30 was supposed to be locked down—tight, clean, no cross-talk. But something slipped through. I caught it during a routine packet capture, just a flicker of traffic that shouldn’t have been there. At first, I thought it was a misfire in the rule set. Maybe I’d forgotten to apply the block to the right interface. But everything looked clean.

pfSense said the rule matched. The logs agreed. And yet, the traffic flowed.

I dug deeper. Interface bindings, rule order, floating rules. That’s when I found it—the ghost. A floating rule, long forgotten, silently overriding the interface-specific block. It wasn’t malicious. Just... legacy. A leftover from an earlier experiment, now quietly sabotaging the present.

I stripped it out. Rebuilt the rule set. Captured again. Silence. The block held.

This wasn’t just a fix. It was a reminder: pfSense’s rule evaluation isn’t always intuitive. Floating rules can override without warning. And in a multi-VLAN setup, ghosts linger.

This incident is logged in `.forge-history`, stamped in v1.0.1, and burned into LuxForge’s memory.

---

**Tags:**  
{% for tag in page.tags %}
  <a href="/tags/{{ tag | slugify }}/">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}
{% endfor %}

**Related:**

- [LuxForge Changelog](https://github.com/30-something-programmer/luxforge.github.io/blob/main/CHANGELOG.md)  
- [Commit b664c4b](https://github.com/30-something-programmer/luxforge.github.io/commit/b664c4b)