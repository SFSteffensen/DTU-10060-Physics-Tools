# DTU Template Source Architecture

This folder contains the modular source code for the DTU Typst Template. The architecture is designed for maintainability, extensibility, and clear separation of concerns.

## Folder Structure

```
src/
├── assets/              # Static resources (logos, images)
│   └── dtu-logo-cmyk.png
├── components/          # Academic and visual components
│   ├── academic.typ     # Definitions, theorems, examples
│   ├── visual.typ       # Boxes, highlights, visual elements
│   └── mod.typ         # Component module index
├── helpers/            # Layout and utility functions
│   ├── layout.typ      # Grid, column, and layout utilities
│   ├── content.typ     # Figure, list, and content helpers
│   └── mod.typ         # Helper module index
├── layouts/            # Document layout templates
│   ├── assignment.typ  # Assignment layout
│   ├── note.typ       # Note-taking layout
│   └── mod.typ        # Layout module index
├── styles/             # Styling and typography utilities
│   ├── spacing.typ     # Spacing constants and helpers
│   ├── typography.typ  # Text styling utilities
│   └── mod.typ         # Style module index
├── colors.typ          # DTU color palette and utilities
├── enhanced.typ        # Advanced features (tables, quotes, alerts)
├── layouts.typ         # Layout template imports
├── lib.typ            # Main entry point (imports all modules)
├── VERSION.typ         # Version information and metadata
├── components.typ      # Legacy single-file components
└── utils.typ          # Legacy single-file utilities
```

## Module Responsibilities

### Core Modules

- **`lib.typ`**: Main entry point, imports and re-exports all functionality
- **`colors.typ`**: DTU brand colors and color utilities
- **`VERSION.typ`**: Version information and template metadata

### Layout System

- **`layouts/`**: Document layout templates (notes, assignments)
- **`layouts.typ`**: Layout system entry point

### Component System

- **`components/academic.typ`**: Academic components (definitions, theorems, examples)
- **`components/visual.typ`**: Visual elements (boxes, highlights)
- **`enhanced.typ`**: Advanced components (tables, quotes, alerts, code blocks)

### Styling System

- **`styles/spacing.typ`**: Spacing constants and utilities
- **`styles/typography.typ`**: Text styling and emphasis
- **`helpers/layout.typ`**: Grid and layout utilities
- **`helpers/content.typ`**: Content management utilities

### Assets

- **`assets/`**: Static resources like logos and images

## Usage

Import the entire template:

```typst
#import "src/lib.typ": *
```

Import specific modules:

```typst
#import "src/colors.typ": dtu-red, dtu-blue
#import "src/components/academic.typ": definition, theorem
#import "src/styles/spacing.typ": medium-gap, section-gap
```

## Backward Compatibility

The legacy single-file modules (`components.typ`, `utils.typ`) are maintained for backward compatibility but will be deprecated in future versions. New projects should use the modular structure.

## Contributing

When adding new functionality:

1. Choose the appropriate module based on functionality
2. Create new submodules for significant feature sets
3. Update the relevant `mod.typ` index file
4. Test that examples still compile
5. Update this README if adding new folders
