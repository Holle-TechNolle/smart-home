#!/usr/bin/env python3
"""
GitHub Repository URL Generator
Scanner et GitHub repository og genererer alle tilgængelige GitHub Pages URLs
"""

import requests
import json
from pathlib import Path
from typing import List, Dict, Set

# Repository konfiguration
GITHUB_USER = "Holle-TechNolle"
REPO_NAME = "smart-home"
GITHUB_API_BASE = f"https://api.github.com/repos/{GITHUB_USER}/{REPO_NAME}"
GITHUB_PAGES_BASE = f"https://{GITHUB_USER.lower()}.github.io/{REPO_NAME}"

def get_repo_tree(branch: str = "main") -> Dict:
    """Hent komplet fil-træ fra GitHub API"""
    url = f"{GITHUB_API_BASE}/git/trees/{branch}?recursive=1"
    response = requests.get(url)
    
    if response.status_code != 200:
        print(f"❌ Fejl ved hentning af repository tree: {response.status_code}")
        print(f"   Response: {response.text}")
        return {}
    
    return response.json()

def filter_relevant_files(tree: Dict) -> List[str]:
    """Filtrer og returner kun relevante filer"""
    relevant_extensions = {
        '.md', '.yaml', '.yml', '.json', '.py', '.txt', 
        '.sh', '.gitignore', '.gitattributes'
    }
    
    exclude_patterns = {
        '__pycache__', '.pyc', '.git/', 'secure/', 
        '.DS_Store', 'thumbs.db'
    }
    
    files = []
    
    for item in tree.get('tree', []):
        if item['type'] != 'blob':  # Skip directories
            continue
            
        path = item['path']
        
        # Check if file should be excluded
        if any(pattern in path for pattern in exclude_patterns):
            continue
        
        # Check if file has relevant extension or is special file
        file_path = Path(path)
        if file_path.suffix.lower() in relevant_extensions or file_path.name.startswith('.'):
            files.append(path)
    
    return sorted(files)

def generate_urls(files: List[str]) -> List[str]:
    """Generer GitHub Pages URLs for alle filer"""
    return [f"{GITHUB_PAGES_BASE}/{file}" for file in files]

def categorize_urls(urls: List[str]) -> Dict[str, List[str]]:
    """Kategoriser URLs efter type/mappe"""
    categories = {
        "Dokumentation": [],
        "Home Assistant Konfiguration": [],
        "AppDaemon": [],
        "VS Code Konfiguration": [],
        "Git Konfiguration": [],
        "Scripts og Tools": [],
        "Python Kode": [],
        "Andet": []
    }
    
    for url in urls:
        path = url.replace(f"{GITHUB_PAGES_BASE}/", "")
        
        if path.startswith("docs/") or path.endswith("README.md") or path == "Arkitektur":
            categories["Dokumentation"].append(url)
        elif path.startswith("src/homeassistant/"):
            categories["Home Assistant Konfiguration"].append(url)
        elif path.startswith("src/appdaemon/"):
            categories["AppDaemon"].append(url)
        elif path.startswith(".vscode/"):
            categories["VS Code Konfiguration"].append(url)
        elif path.startswith(".git") or path in [".gitignore", ".gitattributes"]:
            categories["Git Konfiguration"].append(url)
        elif path.endswith(".sh") or path.startswith("tools/"):
            categories["Scripts og Tools"].append(url)
        elif path.endswith(".py") and not path.startswith("src/appdaemon/"):
            categories["Python Kode"].append(url)
        else:
            categories["Andet"].append(url)
    
    # Remove empty categories
    return {k: v for k, v in categories.items() if v}

def save_urls_to_file(categories: Dict[str, List[str]], filename: str = "repo_urls.txt"):
    """Gem URLs til fil"""
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(f"# GitHub Pages URLs for {GITHUB_USER}/{REPO_NAME}\n")
        f.write(f"# Genereret automatisk\n\n")
        
        for category, urls in categories.items():
            f.write(f"## {category}\n\n")
            for url in urls:
                f.write(f"{url}\n")
            f.write("\n")
        
        f.write(f"\n# Total antal filer: {sum(len(urls) for urls in categories.values())}\n")
    
    print(f"✅ URLs gemt til {filename}")

def print_summary(categories: Dict[str, List[str]]):
    """Print sammendrag af fundne filer"""
    print(f"\n{'='*70}")
    print(f"📊 Repository Scanning Sammendrag")
    print(f"{'='*70}\n")
    
    total_files = sum(len(urls) for urls in categories.values())
    
    for category, urls in categories.items():
        print(f"📁 {category}: {len(urls)} filer")
    
    print(f"\n{'='*70}")
    print(f"📈 Total: {total_files} filer fundet")
    print(f"{'='*70}\n")

def main():
    print(f"🔍 Scanner GitHub repository: {GITHUB_USER}/{REPO_NAME}\n")
    
    # Hent repository tree
    tree = get_repo_tree()
    
    if not tree:
        print("❌ Kunne ikke hente repository data")
        return
    
    # Filtrer relevante filer
    files = filter_relevant_files(tree)
    
    if not files:
        print("⚠️  Ingen relevante filer fundet")
        return
    
    print(f"✅ Fundet {len(files)} relevante filer\n")
    
    # Generer URLs
    urls = generate_urls(files)
    
    # Kategoriser URLs
    categories = categorize_urls(urls)
    
    # Print sammendrag
    print_summary(categories)
    
    # Gem til fil
    save_urls_to_file(categories)
    
    # Print alle URLs
    print("📋 Alle URLs:\n")
    for category, urls in categories.items():
        print(f"\n### {category}")
        print("```")
        for url in urls:
            print(url)
        print("```")
    
    print(f"\n✅ Færdig! URLs er gemt i 'repo_urls.txt'")
    print(f"💡 Kopier indholdet af repo_urls.txt og del det med Claude for fuld adgang")

if __name__ == "__main__":
    main()
