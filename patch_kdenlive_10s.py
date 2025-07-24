import os
import sys
import xml.etree.ElementTree as ET
from argparse import ArgumentParser

def patch_kdenlive_template(template_path, input_image, output_path, duration):
    """Modify the Kdenlive template with new image and duration"""
    try:
        tree = ET.parse(template_path)
        root = tree.getroot()
        frame_count = str(duration * 25)

        # Update image producer
        for producer in root.findall('.//producer'):
            if producer.get('id') == 'image_producer':
                producer.set('resource', input_image)
                producer.set('length', frame_count)
                for prop in producer.findall('property'):
                    if prop.get('name') == 'resource':
                        prop.text = input_image

        # Update tractor (main length)
        for tractor in root.findall('.//tractor'):
            tractor.set('length', frame_count)
            for prop in tractor.findall('property'):
                if prop.get('name') == 'length':
                    prop.text = frame_count

        # Update playlist length (if present)
        for playlist in root.findall('.//playlist'):
            for entry in playlist.findall('entry'):
                entry.set('out', str(int(frame_count) - 1))

        tree.write(output_path)
        print(f"✅ Patched template saved to {output_path}")
        return True

    except Exception as e:
        print(f"❌ Error patching template: {str(e)}", file=sys.stderr)
        return False

def main():
    parser = ArgumentParser()
    parser.add_argument('--template', required=True)
    parser.add_argument('--input', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--duration', type=int, required=True)
    args = parser.parse_args()

    if not os.path.exists(args.template):
        print(f"❌ Template file not found: {args.template}", file=sys.stderr)
        sys.exit(1)

    if not os.path.exists(args.input):
        print(f"❌ Input image not found: {args.input}", file=sys.stderr)
        sys.exit(1)

    if not patch_kdenlive_template(args.template, args.input, args.output, args.duration):
        sys.exit(1)

if __name__ == "__main__":
    main()

def patch_project(image_path, output_path, duration=10):
    return patch_kdenlive_template("template_project.kdenlive", image_path, output_path, duration)
