---
title: "Pixel Arcade: Flame 2D Engine"
category: "Game Dev"
readMin: "4 min read"
excerpt: "A retro arcade game built with the Flame engine on Flutter, featuring optimized custom sprite-sheet rendering, particle effects, and frame-rate independent physics loops."
tags: ["Flame", "Flutter", "Pixel Art", "Mobile", "Canvas"]
repoUrl: "https://github.com/subhojitpramanik"
liveUrl: "#"
imageColor: "secondaryContainer"
featured: true
---

## Overview
**Pixel Arcade** is a mobile-first 2D arcade title engineered completely within Flutter using the Flame game engine. Designed with authentic retro pixel-art aesthetics, it pushes the boundaries of Flutter's rendering pipeline for smooth 60/120Hz canvas manipulation.

## Core Features
* **Custom Sprite Batching:** Minimized draw calls using advanced sprite sheet packing.
* **Physics System:** Custom frame-rate independent delta-time calculation to prevent stuttering on variable-refresh-rate mobile displays.
* **Audio Integration:** Low-latency spatial sound effects management.

## Technical Stack
Built with Dart, Flame Engine, and custom Canvas paint shaders. Optimized specifically for cross-platform deployment on iOS, Android, and Web.