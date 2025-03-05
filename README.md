# JSON Resume Generator
Simple JSON to PDF resume using Chrome's headless rendering

`JSON → Python → HTML/CSS → Chrome headless → PDF`

## Requirements

- Python 3.x
- Make
- Chrome

## Getting Started

1. Clone this repository

2. Make the Python script executable:
   ```bash
   chmod +x scripts/generate_resume.py
   ```

3. Edit `data.json` with resume information

4. Generate resume:
   ```bash
   make
   ```

5. Resume PDF can be found in the `build` directory:
   - `build/resume.html` - HTML version
   - `build/resume.pdf` - PDF version


## Project Structure

```
resume/
├── data.json         # Your resume content
├── Makefile          # Build automation
├── scripts/          # Code for generating the resume
│   └── generate_resume.py  # JSON to HTML converter
├── styles/           # Visual styling
│   └── resume.css    # CSS styling for the resume
└── build/            # Generated output (created by make)
    ├── resume.html   # HTML version
    └── resume.pdf    # PDF version
```

## Manual PDF Generation

If automatic PDF generation doesn't work:

1. Open `build/resume.html` in a browser
2. Use the print function (Ctrl+P or Cmd+P)
3. Select "Save as PDF" as the destination
4. Disable headers and footers in the print options
5. Save the PDF