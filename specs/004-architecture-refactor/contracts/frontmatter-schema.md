# Markdown Frontmatter Contracts

This document defines the schema for the YAML frontmatter required in the `content/` markdown files.

## Blog Post (`content/blog/*.md`)
```yaml
title: "String (Required)"
date: "YYYY-MM-DD (Required)"
excerpt: "String (Required)"
tags: 
  - "String"
  - "String"
```

## Career / Job Experience (`content/career/*.md`)
```yaml
company: "String (Required)"
role: "String (Required)"
duration: "String (Required)"
responsibilities:
  - "String"
  - "String"
```

## Project (`content/projects/*.md`)
```yaml
name: "String (Required)"
description: "String (Required)"
technologies:
  - "String"
  - "String"
externalLink: "String (Optional URL)"
```
