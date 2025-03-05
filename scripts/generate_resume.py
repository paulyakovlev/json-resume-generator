#!/usr/bin/env python3
"""
Generate a resume HTML file directly from JSON data
Usage: python3 generate_resume.py <json_file> <css_file> <output_file>
"""
import json
import sys
from datetime import datetime

def format_date(date_str):
    """Format date from YYYY-MM-DD to Month YYYY"""
    if date_str == "Present":
        return "Present"
    try:
        date = datetime.strptime(date_str, "%Y-%m-%d")
        return date.strftime("%B %Y")
    except:
        return date_str

def generate_resume_html(json_file, css_file, output_file):
    # Load data
    with open(json_file, 'r') as f:
        data = json.load(f)
    
    # Load CSS
    with open(css_file, 'r') as f:
        css_content = f.read()
    
    basics = data['basics']
    
    # Start HTML document
    html = ['<!DOCTYPE html>',
            '<html lang="en">',
            '<head>',
            '  <meta charset="UTF-8">',
            '  <meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '  <title>Resume</title>',
            '  <style>',
            css_content,
            '  </style>',
            '</head>',
            '<body>']
    
    # Header
    html.append(f'  <h1>{basics["name"]}</h1>')
    
    # Contact info
    html.append('  <div class="contact-info">')
    html.append(f'    <p>{basics.get("email", "")}</p>')
    
    # Create the website and github line
    website = basics.get('website', '')
    github = basics.get('github', '')
    
    # Look for GitHub in profiles if it doesn't exist directly
    if not github and 'profiles' in basics:
        for profile in basics['profiles']:
            if profile.get('network', '').lower() == 'github':
                github = profile.get('url', '')
                break
    
    if website and github:
        html.append(f'    <p>{website} ⋄ {github}</p>')
    elif website:
        html.append(f'    <p>{website}</p>')
    elif github:
        html.append(f'    <p>{github}</p>')
        
    html.append('  </div>')
    
    # Experience
    html.append('  <section>')
    html.append('    <h2>EXPERIENCE</h2>')
    
    for job in data.get('work', []):
        html.append('    <div class="job">')
        html.append('      <div class="job-header">')
        html.append(f'        <span class="job-company">{job["company"]}</span>')
        html.append(f'        <span class="job-date">{format_date(job.get("startDate", ""))} - {format_date(job.get("endDate", ""))}</span>')
        html.append('      </div>')
        
        html.append('      <div class="job-title-row">')
        html.append(f'        <span class="job-title">{job.get("position", "")}</span>')
        html.append(f'        <span class="job-location">{job.get("location", "")}</span>')
        html.append('      </div>')
        
        # Use proper list for bullet points
        html.append('      <ul class="job-details">')
        for highlight in job.get('highlights', []):
            html.append(f'        <li>{highlight}</li>')
        html.append('      </ul>')
        
        html.append('    </div>')
    
    html.append('  </section>')
    
    # Projects
    if 'projects' in data:
        html.append('  <section>')
        html.append('    <h2>PROJECTS</h2>')
        
        for project in data['projects']:
            html.append('    <div class="project">')
            html.append('      <div class="project-header">')
            html.append(f'        <span class="project-name">{project.get("name", "")}</span>')
            html.append(f'        <span class="project-link">{project.get("url", "")}</span>')
            html.append('      </div>')
            
            html.append(f'      <div class="project-tech">{project.get("technologies", "")}</div>')
            
            # Use proper list for bullet points
            html.append('      <ul class="project-details">')
            html.append(f'        <li>{project.get("description", "")}</li>')
            html.append('      </ul>')
            
            html.append('    </div>')
        
        html.append('  </section>')
    
    # Education
    if 'education' in data:
        html.append('  <section>')
        html.append('    <h2>EDUCATION</h2>')
        
        for edu in data['education']:
            html.append('    <div class="education">')
            html.append('      <div class="edu-header">')
            html.append(f'        <span class="edu-institution">{edu.get("institution", "")}</span>')
            html.append(f'        <span class="edu-date">Graduated {format_date(edu.get("endDate", ""))}</span>')
            html.append('      </div>')
            
            html.append(f'      <div class="edu-degree">{edu.get("studyType", "")} in {edu.get("area", "")}</div>')
            html.append('    </div>')
        
        html.append('  </section>')
    
    # Skills
    if 'skills' in data:
        html.append('  <section>')
        html.append('    <h2>SKILLS</h2>')
        
        for skill in data['skills']:
            html.append('    <div class="skill">')
            html.append(f'      <span class="skills-category">{skill.get("name", "")}:</span> {", ".join(skill.get("keywords", []))}')
            html.append('    </div>')
        
        html.append('  </section>')
    
    # Close HTML document
    html.append('</body>')
    html.append('</html>')
    
    # Write the output file
    with open(output_file, 'w') as f:
        f.write('\n'.join(html))
    
    return True

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python3 generate_resume.py <json_file> <css_file> <output_file>")
        sys.exit(1)
    
    json_file = sys.argv[1]
    css_file = sys.argv[2]
    output_file = sys.argv[3]
    
    if generate_resume_html(json_file, css_file, output_file):
        print(f"Resume HTML generated successfully at {output_file}")
    else:
        sys.exit(1)