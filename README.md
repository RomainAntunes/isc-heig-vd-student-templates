# ISC HEIG-VD Student Templates

A [Typst](https://typst.app/) template package tailored to the **ISC** (Informatique et Systèmes de Communication) program at **HEIG-VD**, School of Engineering, Yverdon-les-Bains, Switzerland.

## Features

- **Report template** with customizable title page, headers, and footers
- **Internationalization** support (English, French, German)
- **Pre-built boxes**: info, warning, important, idea, TODO, and question boxes
- **Table of contents** with mini-TOC per chapter
- **Code listings** with styled code blocks
- **HEIG-VD / HES-SO logos** included
- **Multi-author** support with email links
- **Configurable** document metadata (school, course, professor, etc.)

## Usage

```typst
#import "@preview/isc-heig-vd-student-templates:0.3.0": report

#show: report.with(
  option: (
    lang: "en",
    type: "draft",
  ),
  doc: (
    title: "My Report",
    abbr: "MR",
    subtitle: "A short description",
    logos: (
      tp_topleft: image("img/heig-vd.svg", height: 1.5cm),
      tp_topright: image("img/hes-so.svg", height: 1cm),
      tp_main: none,
      header: image("img/heig-vd.svg", height: 1cm),
    ),
    authors: (
      (
        name: "Jane Doe",
        abbr: "JD",
        email: "jane.doe@heig-vd.ch",
        url: none,
      ),
    ),
    school: (
      name: "HEIG-VD",
      major: "Informatique et Systèmes de Communication",
      orientation: none,
      url: "https://heig-vd.ch",
    ),
    course: (
      name: "Course Name",
      url: none,
      prof: "Prof. Name",
      class: "ISC",
      semester: "Spring 2026",
    ),
  ),
  tableof: (
    toc: true,
    tof: true,
    tot: false,
    tol: false,
    toe: false,
    maxdepth: 3,
  ),
)

= Introduction

Your content here...
```

## Configuration Options

### `option`

| Key    | Type   | Description                                                   |
| ------ | ------ | ------------------------------------------------------------- |
| `lang` | string | Document language (`"en"`, `"fr"`, `"de"`)                    |
| `type` | string | Document type shown on title page (e.g. `"draft"`, `"final"`) |

### `doc`

| Key        | Type   | Description                      |
| ---------- | ------ | -------------------------------- |
| `title`    | string | Main document title              |
| `abbr`     | string | Abbreviation for header          |
| `subtitle` | string | Subtitle displayed on title page |
| `url`      | string | Project URL                      |
| `logos`    | dict   | Logo images (see below)          |
| `authors`  | array  | List of author dicts             |
| `school`   | dict   | School information               |
| `course`   | dict   | Course information               |
| `keywords` | array  | Document metadata keywords       |
| `version`  | string | Document version string          |

### `doc.logos`

| Key              | Type  | Description                       |
| ---------------- | ----- | --------------------------------- |
| `tp_topleft`     | image | Top-left logo on title page       |
| `tp_topright`    | image | Top-right logo on title page      |
| `tp_bottomleft`  | image | Bottom-left logo on title page    |
| `tp_bottomright` | image | Bottom-right logo on title page   |
| `tp_main`        | image | Large centered logo on title page |
| `header`         | image | Logo in page header               |

### `doc.authors`

Each author dict supports:

| Key     | Type   | Description        |
| ------- | ------ | ------------------ |
| `name`  | string | Full name          |
| `abbr`  | string | Short abbreviation |
| `email` | string | Email address      |
| `url`   | string | Personal URL       |

### `tableof`

| Key        | Type    | Description                  |
| ---------- | ------- | ---------------------------- |
| `toc`      | bool    | Show table of contents       |
| `tof`      | bool    | Show table of figures        |
| `tot`      | bool    | Show table of tables         |
| `tol`      | bool    | Show table of listings       |
| `toe`      | bool    | Show table of equations      |
| `maxdepth` | integer | Maximum heading depth in TOC |

## Provided Functions

### Boxes

```typst
#import "@preview/isc-heig-vd-student-templates:0.3.0": colorbox, infobox, warningbox, importantbox, ideabox, todobox, question

// Generic colored box
#colorbox(title: "Note", color: blue)[Content here]

// Pre-built boxes
#infobox[This is an info box]
#warningbox[This is a warning]
#importantbox[This is important]
#ideabox[This is an idea]
#todobox[Something to do]
#question[What is the answer?]
```

### Logos

```typst
#import "@preview/isc-heig-vd-student-templates:0.3.0": heig-vd-logo, hes-so-logo, heig-vd-baseline-logo

// Default sizes
#heig-vd-logo
#hes-so-logo
#heig-vd-baseline-logo

// Custom sizes
#heig-vd-logo(height: 3cm)
#hes-so-logo-sm
```

### Text Utilities

```typst
#import "@preview/isc-heig-vd-student-templates:0.3.0": blockquote, kbd

#blockquote[A quoted passage]
Press #kbd("Ctrl+C") to copy.
```

### Chapter Management

```typst
#import "@preview/isc-heig-vd-student-templates:0.3.0": add-chapter, minitoc

// Include a chapter file with optional mini-TOC
#add-chapter(
  file: "chapters/intro.typ",
  after: <sec:intro>,
  before: <sec:body>,
  pb: true,
)

// Or inline chapter with body
#add-chapter[
  = Chapter Title
  Content...
]
```

## File Structure

```
isc-heig-vd-student-templates/
├── lib/
│   ├── template-report.typ   # Main report function
│   ├── pages-report.typ      # Title page layout
│   ├── helpers.typ           # Utility functions
│   ├── boxes.typ             # Box components
│   ├── images.typ            # Logo definitions
│   ├── constants.typ         # Colors and font sizes
│   └── i18n.json             # Translations (en/fr/de)
├── img/
│   ├── heig-vd.svg
│   ├── heig-vd-baseline.svg
│   └── hes-so.svg
├── template/
│   └── report.typ            # Starter template
├── typst.toml
└── README.md
```

## Installation

This package is available on [Typst Universe](https://typst.app/universe/package/isc-heig-vd-student-templates).

## License

MIT
