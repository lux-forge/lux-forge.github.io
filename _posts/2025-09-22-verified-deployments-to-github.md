---
title: "Verified Deployments to GitHub"
date: 2025-09-22T17:20:00+01:00
tags: [luxforge-ui, git-signing, verified-badge]
layout: post
---

LuxForge now deploys with a verified signature. This post outlines how to ensure future deploys inherit the same signature.

---

## Outline

- ✅ Git identity corrected from placeholder to the user identinty (our case, `lux-forge`)
- ✅ Commits now show the **Verified** badge on GitHub
---

## 🛠️ How to: Verified GitHub Commits

To get the **Verified** badge on commits:

1. **Generate a GPG key**:  
   ```bash
   gpg --full-generate-key
   ```

2. **List your key**:  
   ```bash
   gpg --list-secret-keys --keyid-format LONG
   ```

   Look for the long string after `rsa4096/`—that’s your key ID.

3. **Export your public key**:  
   ```bash
   gpg --armor --export YOUR_KEY_ID
   ```
   Copy the entire key

4. **Add it to GitHub**:  
   Go to [GitHub → User Icon → Settings → SSH and GPG keys](https://github.com/settings/keys) → **New GPG key**
    Paste the key
5. **Configure Git to sign commits**:  
   ```bash
   git config --global user.signingkey YOUR_KEY_ID
   git config --global commit.gpgsign true
   ```

6. **Test it**:  
   ```bash
   git commit -S -m "Signed LuxForge deploy"
   ```

Your commits will now show the **Verified** badge on GitHub.

---

##  Summary

We all like big green signs and the Verified one is no different. Not only that but it also ensures future deployments are secure. Lovely.

---