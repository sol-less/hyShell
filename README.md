<div align="center">
  <h1>[ Yamd3s ]</h1>
</div>

> or [ Yet Another Material Design 3 Shell ]

<img width="1366" height="768" alt="2026-08-03_18-58-38" src="https://github.com/user-attachments/assets/eea9d1ee-2332-4b68-9ae0-1db0694f6d8c" />

---

<div align="center">
  <h2>[ About ]</h2>
</div>

**yamd3s** is a Quickshell configuration inspired by Google's **Material Design 3**, built to feel visually fluid while staying lightweight enough for aging hardware (developed and daily-driven on an Intel HD 4000 / ThinkPad X230). Every shape you see — the concave corners flowing out of the bar, the workspace indicators, the loading spinner, the album art mask — is either hand-built with `QtQuick.Shapes` or driven by real Material 3 polygon morphing via [m3shapes](https://github.com/soramanew/m3shapes).

* **Target OS:** Arch Linux *(recommended)*
* **Compositor:** Hyprland

---

<div align="center">
  <h2>[ Features ]</h2>
</div>

- **Dynamic theming** — colors extracted live from your wallpaper via `matugen`, full Material 3 tonal palette (primary/secondary/tertiary + containers)
- **Persisted theme roles** — assign which M3 color role (primary/secondary/tertiary) each module uses, saved to `config/user_config.json`
- **Real shape morphing** — workspace focus indicators, the loading spinner, and album art masks all use genuine Material 3 polygon interpolation, not approximated paths
- **Concave corner system** — the dashboard visually "flows" out of the bar with a hand-built concave notch (square-minus-circle via `oddEven` fill), synced to the open/close animation
- **Full dashboard** — App Launcher, Wallpaper picker (with a hidden Konami-code easter egg 👀), System Info (CPU/disk/battery/uptime/package counts), and a Music panel with live MPRIS playback controls
- **Spring-based motion** throughout — corner radii, pill widths, and shape transitions all use tuned spring physics rather than flat easing curves
- **Toggleable dashboard tabs** — enable/disable Wallpaper, System, and Music panels individually (Apps is always available)

---

<div align="center">
  <h2>[ Required Depedencies ]</h2>
</div>

* `quickshell-git` *(AUR)*
* `matugen`
* `qt6-m3shapes-git` *(AUR — Material 3 shape library)*
* `ttf-material-symbols-variable`
* `ttf-roboto`
* `git`
* `yay` *(or your preferred AUR helper — required for the AUR packages above)*
* `hyprlock`

---

<div align="center">
  <h2>[ Installation ]</h2>
</div>

Clone the repository directly into your Quickshell configuration directory:

```bash
mkdir -p ~/.config/quickshell
git clone https://github.com/sol-less/yamd3s/ ~/.config/quickshell
```

Install dependencies:

```bash
yay -S quickshell-git matugen qt6-m3shapes-git ttf-material-symbols-variable ttf-roboto hyprlock
```

Start the shell:

```bash
qs -c yamd3s
```

> **Note:** on first launch, the color palette will show a fallback theme until `matugen` generates real colors from your wallpaper. Set a wallpaper via the Dashboard's Wallpaper tab to trigger generation.

---

<div align="center">
  <h2>[ Usage ]</h2>
</div>

- [ "quickshell ipc call dashboard toggle" ] — Toggles the Dashboard

---

<div align="center">
  <h2>[ Credits ]</h2>
</div>

- [Quickshell](https://quickshell.org) by outfoxxed
- [matugen](https://github.com/InioX/matugen)
- [m3shapes](https://github.com/soramanew/m3shapes) by soramanew
- Material Design 3 by Google
> and also Claude for helping a little bit, lol
