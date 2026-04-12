# EMC First Midterm -- Study Assistant

## Role
You are helping a student prepare for the first midterm exam in an
High-Speed PC Board System Design (HSDSD) course at NTUST (National Taiwan
University of Science and Technology).

## Materials
Lecture slides are in `LectureSlides/`:
- chap1_HSDSD.pdf through chap5_HSDSD.pdf

## Tasks
Complete these tasks in order:

### Task 1: Knowledge Extraction
Read each PDF and convert into detailed knowledge markdown files
(e.g., `knowledge/chap1.md` through `knowledge/chap4.md`).
- Preserve information about diagrams and figures (describe what they show)
- Preserve all equations using LaTeX notation (`$...$` for inline,
  `$$...$$` for display)
- **Behind every equation, add a citation** in the format:
  *(chap2.pdf, p.15)* so the student can find the original immediately
- Include slide/page references for every concept

### Task 2: Equation Verification
After finishing Task 1, re-read each PDF page-by-page and verify every
extracted equation against the original slide:
- Compare each LaTeX equation to the original visually
- Fix any transcription errors (wrong symbols, missing terms, sign errors)
- If an equation is ambiguous or partially visible on the slide, flag it
  with a note like: `<!-- VERIFY: equation unclear on slide -->`
- Log all corrections made in `knowledge/equation-corrections.md`

### Task 3: Concise Study Notes
Create `notes/study-notes.md` with brief, clear explanations of each
concept from the lectures. Target audience: a university student who
has already studied electromagnetic fields and introduction to radio
waves. Keep it simple and to the point.
- Every equation mentioned must include its citation: *(chapX.pdf, p.Y)*

### Task 4: Exam Preparation Examples
Create `notes/exam-examples.md` identifying:
- Example problems from the slides that could appear on a closed-book test
- Key formulas and concepts likely to be tested (with citations)
- Simple computational examples a student should be able to solve by hand
- This is a closed-book midterm at NTUST, so difficulty should be reasonable

### Task 5: Practice Test Questions
Create `notes/practice-questions.md` with practice questions organized
by chapter. Include a mix of:
- Conceptual questions (explain X, compare Y and Z)
- Short calculations
- True/false with explanation
- Multiple choice
Include answers in a separate section at the bottom.
Each question should reference which chapter/page it relates to.

### Task 6: Export to PDF
After all markdown files are complete, convert them to PDF using pandoc:
```bash
pandoc knowledge/chap1.md -o pdf/chap1-knowledge.pdf --pdf-engine=pdflatex
pandoc notes/study-notes.md -o pdf/study-notes.pdf --pdf-engine=pdflatex
pandoc notes/exam-examples.md -o pdf/exam-examples.pdf --pdf-engine=pdflatex
pandoc notes/practice-questions.md -o pdf/practice-questions.pdf --pdf-engine=pdflatex
```
Create the `pdf/` directory first. Pandoc and LaTeX are pre-installed in
this container. If a conversion fails due to a LaTeX error, fix the
equation syntax and retry.

## Equation Format

Every equation in every output file MUST follow this pattern:

```markdown
The electric field intensity is given by:

$$E = \frac{V}{d}$$
*(chap1.pdf, p.12)*
```

Or inline: The permittivity $\varepsilon = \varepsilon_0 \varepsilon_r$
*(chap2.pdf, p.3)* relates...

**Never write an equation without its source citation.**

## Guidelines
- **Always cite** which chapter and page/slide a concept comes from
  so the student can easily find it in the original material
- **Lecture slides are the single source of truth.** Do NOT invent,
  add, or infer information beyond what is in the slides. If something
  is ambiguous, note the ambiguity rather than guessing.
- Work only with the provided slides -- no external sources
- Use Python (available in container) for any numerical verification
  if needed -- install libraries via pip as needed
- Pandoc + texlive are pre-installed for PDF export
