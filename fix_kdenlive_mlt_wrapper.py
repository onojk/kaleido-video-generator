#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

INPUT = "effects_template_cleaned.kdenlive"
OUTPUT = "effects_template_base.kdenlive"

def main():
    if not os.path.exists(INPUT):
        print(f"[!] Missing file: {INPUT}")
        return

    tree = ET.parse(INPUT)
    root = tree.getroot()

    if root.tag == "mlt":
        print("[✓] Already wrapped with <mlt>")
        os.rename(INPUT, OUTPUT)
        print(f"[✓] Fixed project saved to: {OUTPUT}")
        return

    # Wrap current root with <mlt>
    mlt = ET.Element("mlt")
    mlt.append(root)
    tree._setroot(mlt)

    tree.write(OUTPUT)
    print(f"[✓] Wrapped with <mlt> and saved to: {OUTPUT}")

if __name__ == "__main__":
    main()
