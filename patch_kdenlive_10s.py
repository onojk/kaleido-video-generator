import os
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

def main(job_id):
    job_dir = f"jobs/{job_id}"
    os.makedirs(job_dir, exist_ok=True)
    
    # Path to the original and patched files
    original_file = f"{job_dir}/original.kdenlive"
    patched_file = f"{job_dir}/patched.kdenlive"
    fixed_file = f"{job_dir}/fixed.mlt"
    
    try:
        # 1. Create a basic MLT structure if no original exists
        if not os.path.exists(original_file):
            basic_mlt = f"""<?xml version='1.0' encoding='utf-8'?>
<mlt>
  <profile description="HD 1080p 60 fps" width="1920" height="1080" 
           progressive="1" sample_aspect_num="1" sample_aspect_den="1" 
           display_aspect_num="16" display_aspect_den="9" frame_rate_num="60" 
           frame_rate_den="1" colorspace="709"/>
  <producer id="image_producer">
    <property name="resource">{job_dir}/current_abstract_video_image.jpg</property>
    <property name="mlt_service">qimage</property>
    <property name="length">600</property>
  </producer>
  <playlist id="playlist0">
    <entry producer="image_producer" in="0" out="599"/>
  </playlist>
</mlt>"""
            with open(original_file, 'w') as f:
                f.write(basic_mlt)

        # 2. Parse and patch the MLT file
        tree = ET.parse(original_file)
        root = tree.getroot()
        
        # Ensure all producers have correct length
        for producer in root.findall('.//producer'):
            length = producer.find(".//property[@name='length']")
            if length is not None:
                length.text = "600"
        
        # Save patched version
        tree.write(patched_file, encoding='utf-8', xml_declaration=True)
        
        # 3. Create the fixed.mlt version with absolute paths
        with open(patched_file, 'r') as f:
            content = f.read()
        
        # Convert relative paths to absolute
        content = content.replace('current_abstract_video_image.jpg', 
                                f'{os.path.abspath(job_dir)}/current_abstract_video_image.jpg')
        
        with open(fixed_file, 'w') as f:
            f.write(content)
            
        return True
        
    except Exception as e:
        print(f"Error patching MLT file: {str(e)}", file=sys.stderr)
        return False

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python patch_kdenlive_10s.py <job_id>")
        sys.exit(1)
    success = main(sys.argv[1])
    sys.exit(0 if success else 1)
