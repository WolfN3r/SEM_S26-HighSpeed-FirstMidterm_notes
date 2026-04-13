# HSDSD Midterm -- Study Notes Generator

## Source material
Lecture slides: `LectureSlides/chap1_HSDSD.pdf` through `chap5_HSDSD.pdf`.

## Output rules
- Output reads like class notes taken by a diligent student. Never mention AI, agents, or automation.
- Target audience: university student with EM fields + intro radio-wave background. Still, give a brief intro before each new topic -- don't assume HSDSD-specific knowledge.
- Slides are the single source of truth. Don't invent or infer beyond them. Flag ambiguity with `<!-- VERIFY -->`.
- Every equation needs a source citation: *(chapX.pdf, p.Y)*.

## Figures
Use the document-loader MCP server (`extract_slides_as_images`) to render PDF pages as PNGs, then crop relevant graphs/diagrams with `convert` (ImageMagick). Include a figure when:
- It shows a concept hard to explain in words (graphs, field plots, circuit topologies)
- It would take a long paragraph to describe textually what the image shows instantly

Save extracted figures to `figures/` and reference them in markdown as `![description](figures/filename.png)`.

## Tasks (in order)

### 1. Knowledge extraction
Read each PDF -> `knowledge/chap{1-5}.md`. Preserve all equations (LaTeX `$...$` / `$$...$$`) with citations. Describe diagrams. Include slide/page refs for every concept.

### 2. Equation verification
Re-read each PDF page-by-page. Compare every extracted equation to the original. Fix errors, flag unclear ones with `<!-- VERIFY -->`. Log corrections in `knowledge/equation-corrections.md`.

### 3. Study notes
Create `notes/study-notes.md` -- concise, clear explanations per concept. Brief intro per topic. Include important figures. Every equation cited.

### 4. Exam prep examples
Create `notes/exam-examples.md`:
- Example problems from slides suitable for closed-book test
- Key formulas with citations
- Hand-solvable computational examples

### 5. Practice questions
Create `notes/practice-questions.md` organized by chapter. Mix of: conceptual, short calculation, true/false with explanation, multiple choice. Answers in separate section at bottom. Each question references chapter/page.

### 6. Export to PDF
Use the LaTeX template at `templates/notes-template.tex` with pandoc. **Engine: always lualatex** (handles Unicode — Ω, ε, →, em-dashes — natively; pdflatex cannot).

```bash
mkdir -p pdf figures
pandoc FILE.md -o pdf/OUTPUT.pdf \
  --pdf-engine=lualatex \
  --template=templates/notes-template.tex \
  -V title="DOCUMENT TITLE"
```

Convert all `knowledge/` and `notes/` files to `pdf/`. If LaTeX errors occur, fix markdown syntax and retry.

#### Template design (templates/notes-template.tex)

The template already exists — do **not** recreate it. Key decisions baked in:

- **Page:** A4, margins `tmargin=0.75in lmargin=0.80in rmargin=1.2in bmargin=1in` (wider right margin for reader annotations).
- **Packages:** `amsmath`, `amssymb`, `booktabs`, `longtable`+`array`+`calc` (required for pandoc markdown tables), `graphicx`, `hyperref`, `enumitem`, `fancyhdr`.
- **Section headings:** `titlesec` with `nobottomtitles*` — prevents a heading from sitting alone at the bottom of a page.
- **Math line-breaking:** `\relpenalty=9999` and `\binoppenalty=9999` — keeps inline math expressions on one line.
- **Widow/orphan lines:** `\widowpenalty=10000` and `\clubpenalty=10000`.
- **Header/footer:** left = document title (`$title$`), right = `HSDSD -- NTUST`, centre = page number.
- **Title block:** centred `\LARGE\bfseries` title with double rule underneath; no date or author.
- **Images:** default width `0.85\linewidth`, aspect ratio preserved.

#### Degree signs and Unicode in markdown
- Inside math: use `^\circ` — e.g. `$90^\circ$`.
- Outside math: use `$^\circ$` — e.g. `a 90$^\circ$ bend`.
- Never use the literal `°` character — lualatex's default Latin Modern font drops it silently.
- Do **not** use `$^\circ$` inside an already-open math span — that nests dollar signs and breaks LaTeX.

## Equation format
```
$$E = \frac{V}{d}$$
*(chap1.pdf, p.12)*
```
Inline: $\varepsilon = \varepsilon_0 \varepsilon_r$ *(chap2.pdf, p.3)*
