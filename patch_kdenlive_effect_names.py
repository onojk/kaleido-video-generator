#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

PROJECT_FILE = "patched_render_final.kdenlive"
BACKUP_FILE = "patched_render_final.kdenlive.bak"

REPLACEMENTS = {
    "frei0r.kaleidoscope": "frei0r.kaleid0sc0pe",
    "movit.lift_gamma_gain": "frei0r.liftgammagain"
}

def patch_and_print_ids(filename):
    if not os.path.exists(filename):
        print(f"[!] Project file not found: {filename}")
        return False

    os.rename(filename, BACKUP_FILE)
    print(f"[🔄] Backup saved to {BACKUP_FILE}")

    tree = ET.parse(BACKUP_FILE)
    root = tree.getroot()

    found_ids = set()
    patched_count = 0

    for filter_node in root.findall(".//filter"):
        fx_id = filter_node.get("id")
        found_ids.add(fx_id)

        if fx_id in REPLACEMENTS:
            new_id = REPLACEMENTS[fx_id]
            print(f"[✓] Replacing {fx_id} → {new_id}")
            filter_node.set("id", new_id)
            patched_count += 1

    print(f"\n[🔍] Found {len(found_ids)} unique filter IDs:")
    for fx in sorted(found_ids):
        print(f"    • {fx}")

    if patched_count:
        tree.write(PROJECT_FILE)
        print(f"\n[✅] Patched and saved → {PROJECT_FILE} ({patched_count} changes)")
    else:
        print("\n[ℹ️] No matching effects were patched.")

    return True

if __name__ == "__main__":
    patch_and_print_ids(PROJECT_FILE)
