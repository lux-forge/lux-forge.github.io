---
title: "The Syntax That Broke the Skin: SCSS and the Silent Fail"
date: 2025-09-20 21:06 BST
tags: [incident, scss, theme, luxforge, dark-mode]
version: 1.0.2
commit: <latest hash>
layout: post
---

Irony at its finest. While trying to come up with a new way of adding a blog in an "easy fashion" I of course made things 10 times harder by trying to learn a new software in github pages. Figuring it can't be that hard, I forged ahead and looked into making it look sleek. I found a brilliant post that was ~ 5 years old in a blog called the (Slowbro blog)[https://blog.slowb.ro/dark-theme-for-minima-jekyll/]. Knowing I primarily use a windows machine for my own use, I don't natrually have a Linux machine to work with. So, natrually, I had to come up to speed with the usability of WSL too.

Some 5 hours later, I was almost there. Jekyll was installed on my new Ubuntu 22.04 WSL kernel attached to a VSCode instance to make modifying the files just that bit easier. As a programmer, I am natrually lazy so I wanted to find a way of automating the version control and changelog. Well, here we are with another post. Will it last? Who knows. But I learnt something new and, lets be honest, thats what a homelab is all about.

Logged in `.forge-history`, stamped in v1.0.2, and burned into LuxForge’s memory.

---

**Tags:**  
{% for tag in page.tags %}
[{{ tag }}](/tags/{{ tag | slugify }})  
{% endfor %}

**Related:**

- [LuxForge Changelog](https://github.com/30-something-programmer/luxforge.github.io/blob/main/CHANGELOG.md)  
- [Commit <latest hash>](https://github.com/30-something-programmer/luxforge.github.io/commit/<latest hash>)