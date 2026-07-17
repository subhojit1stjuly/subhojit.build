---
name: Lumina System
colors:
  surface: '#fbf9f4'
  surface-dim: '#dbdad5'
  surface-bright: '#fbf9f4'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f5f3ee'
  surface-container: '#f0eee9'
  surface-container-high: '#eae8e3'
  surface-container-highest: '#e4e2dd'
  on-surface: '#1b1c19'
  on-surface-variant: '#484553'
  inverse-surface: '#30312e'
  inverse-on-surface: '#f2f1ec'
  outline: '#787585'
  outline-variant: '#c9c4d5'
  surface-tint: '#5d4ac4'
  primary: '#523fb9'
  on-primary: '#ffffff'
  primary-container: '#6b59d3'
  on-primary-container: '#f1ecff'
  inverse-primary: '#c8bfff'
  secondary: '#4e616b'
  on-secondary: '#ffffff'
  secondary-container: '#d1e6f2'
  on-secondary-container: '#546771'
  tertiary: '#7a4800'
  on-tertiary: '#ffffff'
  tertiary-container: '#9c5d00'
  on-tertiary-container: '#ffebda'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e5deff'
  primary-fixed-dim: '#c8bfff'
  on-primary-fixed: '#190064'
  on-primary-fixed-variant: '#452fab'
  secondary-fixed: '#d1e6f2'
  secondary-fixed-dim: '#b5cad5'
  on-secondary-fixed: '#0a1e26'
  on-secondary-fixed-variant: '#374953'
  tertiary-fixed: '#ffdcbc'
  tertiary-fixed-dim: '#ffb86c'
  on-tertiary-fixed: '#2c1600'
  on-tertiary-fixed-variant: '#683c00'
  background: '#fbf9f4'
  on-background: '#1b1c19'
  surface-variant: '#e4e2dd'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 57px
    fontWeight: '600'
    lineHeight: 64px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: 0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
    letterSpacing: 0.01em
  title-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
    letterSpacing: '0'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.01em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 64px
---

## Brand & Style

The design system is built on a foundation of **Sophisticated Minimalism** and **Human-Centric Utility**. It synthesizes the academic, high-trust warmth of research-led AI interfaces with the rigorous, systematic component architecture of modern productivity frameworks.

The visual direction avoids the clinical coldness of typical tech products by utilizing a warm-skewed neutral palette, creating an environment that feels more like a well-lit physical workspace than a digital screen. The personality is intelligent and composed—prioritizing clarity of thought and ease of reading over decorative flair. It utilizes "elevated surface containers" to group complex technical information into digestible, high-trust units.

## Colors

This color system prioritizes visual comfort and semantic clarity through a "Soft High-Contrast" approach.

- **Primary**: A muted, scholarly purple (#6B59D3) used for meaningful actions and brand presence. It is saturated enough to be accessible but softened to avoid eye strain.
- **Surface & Background**: The foundation is a warm bone-white (#FBF9F4). This reduces the harsh blue-light glare of pure white while maintaining a clean, professional feel.
- **Surface Containers**: Secondary elevation is achieved using #F3F0E9, providing a subtle tonal shift for grouping content without relying on heavy borders or shadows.
- **Typography**: All primary text uses a deep charcoal (#1A1C1E) rather than pure black, ensuring high legibility while appearing more natural against the warm background.

## Typography

The typography system leverages **Inter** for its systematic clarity and excellent readability at small sizes. 

- **Headings**: Use generous letter-spacing (tracking) for a refined, editorial feel. Larger headers should use a slight negative tracking for a tighter, more modern look.
- **Rhythm**: Ensure a strict 4px vertical baseline grid is maintained. 
- **Readability**: Body text is set with a slightly increased line-height (1.5x) to support the human-centric focus on long-form content and technical reading.

## Layout & Spacing

The layout philosophy follows a **Modular Grid** approach with generous whitespace to prevent cognitive overload.

- **Desktop**: A 12-column fluid grid with 24px gutters. Use wide outside margins (64px+) to center the focus and evoke a "document" feel.
- **Mobile**: A 4-column grid with 16px gutters and 16px margins.
- **Spacing Logic**: All spacing tokens are multiples of 8px (or 4px for tight internal component spacing). Elements should be grouped into distinct "Surface Containers" to separate technical tools from conversational or content-heavy areas.

## Elevation & Depth

This design system uses **Tonal Layering** over heavy shadows to create depth.

- **Level 0 (Background)**: The base warm neutral (#FBF9F4).
- **Level 1 (Flat Containers)**: Uses a slightly darker tint (#F3F0E9) with no shadow. This is the primary method for grouping content (Material Design 3 "Tonal" style).
- **Level 2 (Floating/Interactive)**: Used for cards or menus that require focus. These use a very soft, diffused shadow: `0px 4px 20px rgba(26, 28, 30, 0.04)`.
- **Dividers**: Use low-contrast 1px strokes in a tint slightly darker than the surface they sit on.

## Shapes

The shape language follows a **Medium-Rounded** philosophy to balance professional structure with approachable softness.

- **Buttons & Small Components**: 8px (Standard Rounded).
- **Cards & Large Containers**: 12px or 16px (Rounded-LG / XL) to create a distinct frame for content.
- **Input Fields**: 8px, maintaining a consistent rhythm with action buttons.
- **Icons**: Utilize a 2px stroke weight with slightly rounded terminals to match the font's geometry.

## Components

- **Buttons**: Primary buttons are solid (Primary Purple) with white text. Secondary buttons use the Tonal Surface Container color with Primary-colored text. All buttons have 8px corners and 12px horizontal padding.
- **Cards**: Cards should be defined by their background color (#F3F0E9) rather than borders whenever possible. Use 12px corner radii.
- **Input Fields**: Ghost-style or Tonal-filled. Use a 1px border that darkens on focus. Labels should always be visible (never placeholder-only) using the `label-md` style.
- **Chips**: Use the "Filter" style from Material 3: rounded-pill shapes with 8px height and tonal backgrounds for low-emphasis meta-data.
- **Lists**: Clean, borderless rows with 16px vertical padding. Use the secondary surface color for hover states.
- **Technical Containers**: For code blocks or data tables, use a slightly cooler neutral or a darker "deep charcoal" background to provide a clear mental shift from the human-centric prose.