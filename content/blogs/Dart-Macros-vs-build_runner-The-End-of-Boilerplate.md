---
title: "Dart Macros vs build_runner: The End of Boilerplate"
date: "2026-08-25"
description: "How native Dart Macros are replacing code generation tools like Freezed and JSON Serializable."
category: "Dart"
tags: ["Dart", "Macros", "Tooling", "Performance"]
readMin: "7 min read"
featured: true
layout: "blog"
imageColor: "#fff3e0"
imageUrl: "https://dart.dev/assets/dash/dash-mascot.png"
---

# Dart Macros vs build_runner: The End of Boilerplate

Generating code for data classes and JSON serialization has long been a pain point in Dart. With the stabilization of Dart Macros, the paradigm is shifting from external file generation to native compile-time augmentation.

## build_runner: The Legacy Standard
Tools like `freezed` and `json_serializable` use `build_runner` to read annotations and write `.g.dart` files to the disk.

* **Pros:** Incredibly battle-tested, supports complex custom logic, vast ecosystem of plugins.
* **Cons:** Appalling build times on large projects, clutters the repository with generated files, requires constant terminal monitoring.

## Dart Macros: Native Meta-Programming
Macros execute directly within the Dart compiler, modifying classes in memory without writing visible files to your directory.

* **Pros:** Instant feedback in the IDE, zero file clutter, massively reduces CI/CD build times, no external watcher scripts required.
* **Cons:** Harder to debug generated code since files aren't on disk; custom macro authoring has a steep learning curve requiring AST (Abstract Syntax Tree) knowledge.

## Recommendation Matrix
* Continue using **build_runner** for legacy projects heavily dependent on complex `freezed` unions until automated migration tools mature.
* Migrate to **Dart Macros** for all new projects to instantly reclaim development velocity and eliminate build script overhead.