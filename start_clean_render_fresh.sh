#!/bin/bash
rm -f melt_log.txt render_full.log final_output_*.mp4
./clean_and_render.sh && tail -f melt_log.txt
