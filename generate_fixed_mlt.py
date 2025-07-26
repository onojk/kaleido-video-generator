import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument("--input", required=True)
parser.add_argument("--output", required=True)
parser.add_argument("--resolution", default="1920x1080", help="Resolution as WIDTHxHEIGHT (default: 1920x1080)")
parser.add_argument("--frames", type=int, default=600, help="Total number of frames (default: 600 for 10s @ 60fps)")
args = parser.parse_args()

width, height = args.resolution.lower().split("x")

mlt = f"""<mlt>
  <producer id="main" resource="{os.path.abspath(args.input)}" mlt_service="pixbuf">
    <property name="length">{args.frames}</property>
    <filter>
      <property name="mlt_service">frei0r.scale0tilt</property>
      <property name="SCALE_X">{width}</property>
      <property name="SCALE_Y">{height}</property>
    </filter>
    <filter>
      <property name="mlt_service">frei0r.kaleid0sc0pe</property>
    </filter>
  </producer>
  <tractor>
    <property name="length">{args.frames}</property>
    <track producer="main"/>
  </tractor>
</mlt>
"""

with open(args.output, "w") as f:
    f.write(mlt)
