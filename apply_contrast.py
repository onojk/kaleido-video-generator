#!/usr/bin/env python3
import subprocess

# Create temporary scheme script
with open('temp_script.scm', 'w') as f:
    f.write('''(let* ((img (car (gimp-file-load RUN-NONINTERACTIVE "test_input.jpg" "test_input.jpg")))
           (layer (car (gimp-image-get-active-layer img))))
      (gimp-levels-stretch layer)
      (gimp-file-save RUN-NONINTERACTIVE img layer "output.jpg" "output.jpg")
      (gimp-image-delete img))''')

# Execute GIMP
subprocess.run(['gimp', '-i', '-b', '(load "temp_script.scm")', '-b', '(gimp-quit 0)'])

# Clean up
import os
os.remove('temp_script.scm')
