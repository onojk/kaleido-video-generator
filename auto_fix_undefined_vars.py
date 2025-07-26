import re
from collections import defaultdict

APP_FILE = "app.py"
KNOWN_SUBSTITUTIONS = {
    'image_path': 'job_data["input_image"]',
    'output_path': 'job_data["output_path"]',
    'job_dir': 'job_data["job_dir"]',
    'duration': 'job_data["duration"]',
}

def extract_defined_vars(lines):
    defined_vars = set()
    for line in lines:
        assignments = re.findall(r'(\w+)\s*=', line)
        defined_vars.update(assignments)
        matches = re.findall(r'(\w+)\s*=', line)
        for var in matches:
            defined_vars.add(var.strip())
    return defined_vars

def extract_used_vars(lines):
    used_vars = set()
    for line in lines:
        tokens = re.findall(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\b', line)
        used_vars.update(tokens)
    return used_vars

def suggest_fixes(used_vars, defined_vars):
    undefined_vars = used_vars - defined_vars
    fixes = {}
    for var in undefined_vars:
        if var in KNOWN_SUBSTITUTIONS:
            fixes[var] = KNOWN_SUBSTITUTIONS[var]
    return fixes

def apply_fixes(lines, fixes):
    patched_lines = []
    for line in lines:
        for old, new in fixes.items():
            line = re.sub(rf'\b{old}\b', new, line)
        patched_lines.append(line)
    return patched_lines

def main():
    with open(APP_FILE, 'r') as f:
        lines = f.readlines()

    defined_vars = extract_defined_vars(lines)
    used_vars = extract_used_vars(lines)
    fixes = suggest_fixes(used_vars, defined_vars)

    if not fixes:
        print("✅ No undefined known variables to fix.")
        return

    print("🔧 Applying these fixes:")
    for k, v in fixes.items():
        print(f"  {k} → {v}")

    patched = apply_fixes(lines, fixes)

    # Backup original
    with open(APP_FILE + ".bak", 'w') as f:
        f.writelines(lines)

    # Overwrite with patched
    with open(APP_FILE, 'w') as f:
        f.writelines(patched)

    print("✅ Patch complete. Original saved as app.py.bak")

if __name__ == "__main__":
    main()
