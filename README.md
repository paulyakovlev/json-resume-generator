# JSON Resume Generator
JSON to PDF resume using Chrome's headless rendering

`JSON → Python → HTML/CSS → Chrome headless → PDF`

## Requirements

- Python 3.x
- Make
- Chrome

## Usage
1. Add your resume details to `data.json`:
```json
{
  "basics": {
    "name": "Jane Doe",
    "email": "jane@example.com",
    "github": "github.com/janedoe",
    "website": "janedoe.com"
  },
  "work": [
    {
      "company": "Tech Company",
      "position": "Software Engineer",
      "location": "San Francisco, CA",
      "startDate": "2021-01",
      "endDate": "Present",
      "highlights": [
        "Developed REST API serving 1M+ requests daily",
        "Reduced server response time by 30%"
      ]
    }
  ],
 "projects": [
    {
      "name": "Personal Website",
      "url": "github.com/janedoe/website",
      "description": "Responsive portfolio website built with React",
      "highlights": [
        "Implemented custom animations",
        "Optimized for mobile devices"
       ]
    }
  ],
  "education": [
    {
      "institution": "University of Technology",
      "area": "Computer Science",
      "studyType": "Bachelor's Degree",
      "graduationYear": "Class of 2020"
    }
  ],
  "skills": [
    {
      "name": "Languages",
      "keywords": ["JavaScript", "Python", "Java"]
    },
    {
      "name": "Tools",
      "keywords": ["React", "Git", "Docker"]
    }
  ]
}
```

2. Generate resume:
   ```bash
   make

   ### To generate anonymized resume from resume-anon.json
   make anon
   ```

3. Resume PDF can be found in the `build` directory:
   - `build/resume.html` - HTML version
   - `build/resume.pdf` - PDF version


## Project Structure

```
resume/
├── data.json         # Resume content
├── Makefile          # Build automation
├── scripts/           
│   └── generate_resume.py  # JSON to HTML converter
├── styles/           
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
