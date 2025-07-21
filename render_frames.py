#!/usr/bin/env python3
import os
import cv2
import numpy as np
from tqdm import tqdm
import argparse
from typing import Tuple, Optional

class RainbowCamouflageRenderer:
    def __init__(self):
        self.args = self.parse_arguments()
        self.validate_parameters()
        
    def parse_arguments(self) -> argparse.Namespace:
        """Parse command line arguments with rainbow_camouflage.jpg as default input"""
        parser = argparse.ArgumentParser(description='Render 4K frames from rainbow camouflage image')
        parser.add_argument('--input', type=str, default='rainbow_camouflage.jpg',
                          help='Input image path (default: rainbow_camouflage.jpg)')
        parser.add_argument('--output-dir', type=str, default='render_frames',
                          help='Output directory for frames')
        parser.add_argument('--zoom', type=float, default=13.0,
                          help='Zoom factor (1300% = 13.0)')
        parser.add_argument('--resolution', type=str, default='3840x2160',
                          help='Output resolution (default: 3840x2160)')
        parser.add_argument('--fps', type=int, default=60,
                          help='Frames per second (default: 60)')
        parser.add_argument('--duration', type=float, default=10.0,
                          help='Video duration in seconds (default: 10)')
        parser.add_argument('--threads', type=int, default=min(8, os.cpu_count()),
                          help=f'Threads to use (default: {min(8, os.cpu_count())})')
        parser.add_argument('--camera-path', type=str, choices=['horizontal', 'vertical', 'diagonal', 'spiral'], 
                          default='horizontal', help='Camera movement style')
        return parser.parse_args()

    def validate_parameters(self):
        """Validate input parameters with enhanced checks"""
        try:
            self.output_width, self.output_height = map(int, self.args.resolution.split('x'))
            if self.output_width < 3840 or self.output_height < 2160:
                print("Warning: Output resolution lower than 4K (3840x2160)")
        except:
            raise ValueError(f"Invalid resolution format: {self.args.resolution}")
        
        if not 1 < self.args.zoom <= 50:
            raise ValueError("Zoom factor must be between 1 and 50")
            
        if not os.path.exists(self.args.input):
            raise FileNotFoundError(f"Input file not found: {self.args.input}")

    def generate_camera_path(self, img_width: int, img_height: int) -> np.ndarray:
        """Generate camera path based on selected style"""
        total_frames = int(self.args.fps * self.args.duration)
        t = np.linspace(0, 1, total_frames)
        
        # Base path calculations
        if self.args.camera_path == 'horizontal':
            x = 0.1 * img_width + 0.8 * img_width * t
            y = 0.5 * img_height * np.ones_like(t)
        elif self.args.camera_path == 'vertical':
            x = 0.5 * img_width * np.ones_like(t)
            y = 0.1 * img_height + 0.8 * img_height * t
        elif self.args.camera_path == 'diagonal':
            x = 0.1 * img_width + 0.8 * img_width * t
            y = 0.1 * img_height + 0.8 * img_height * t
        elif self.args.camera_path == 'spiral':
            angle = 4 * np.pi * t  # 2 full rotations
            radius = 0.4 * min(img_width, img_height) * (1 - 0.5*t)  # Slowly zoom in
            x = 0.5 * img_width + radius * np.cos(angle)
            y = 0.5 * img_height + radius * np.sin(angle)
        
        return np.column_stack((x, y)).astype(int)

    def safe_crop(self, img: np.ndarray, center_x: int, center_y: int) -> Optional[np.ndarray]:
        """Smart cropping that handles edge cases"""
        h, w = img.shape[:2]
        crop_w = int(self.output_width / self.args.zoom)
        crop_h = int(self.output_height / self.args.zoom)
        
        # Calculate initial crop bounds
        x1 = center_x - crop_w // 2
        y1 = center_y - crop_h // 2
        x2 = x1 + crop_w
        y2 = y1 + crop_h
        
        # Adjust for image boundaries
        if x1 < 0:
            x1, x2 = 0, crop_w
        if y1 < 0:
            y1, y2 = 0, crop_h
        if x2 > w:
            x1, x2 = w - crop_w, w
        if y2 > h:
            y1, y2 = h - crop_h, h
            
        # Final validation
        if x1 >= x2 or y1 >= y2 or (x2 - x1) != crop_w or (y2 - y1) != crop_h:
            return None
            
        return img[y1:y2, x1:x2]

    def process_frame(self, img: np.ndarray, position: Tuple[int, int], frame_num: int) -> bool:
        """Process and save a single frame with error handling"""
        try:
            cropped = self.safe_crop(img, position[0], position[1])
            if cropped is None:
                return False
                
            upscaled = cv2.resize(
                cropped, 
                (self.output_width, self.output_height),
                interpolation=cv2.INTER_LANCZOS4
            )
            
            frame_path = os.path.join(self.args.output_dir, f"frame_{frame_num:04d}.png")
            if not cv2.imwrite(frame_path, upscaled, [cv2.IMWRITE_PNG_COMPRESSION, 3]):
                raise IOError(f"Failed to write {frame_path}")
                
            return True
            
        except Exception as e:
            print(f"\nError processing frame {frame_num}: {str(e)}")
            return False

    def render(self) -> bool:
        """Main rendering workflow"""
        print(f"\nLoading source image: {self.args.input}")
        img = cv2.imread(self.args.input, cv2.IMREAD_COLOR)
        if img is None:
            raise ValueError("Failed to load input image - check if rainbow_camouflage.jpg exists")
        
        os.makedirs(self.args.output_dir, exist_ok=True)
        
        # Generate and validate path
        path = self.generate_camera_path(img.shape[1], img.shape[0])
        total_frames = len(path)
        
        print(f"\nRendering {total_frames} frames from {img.shape[1]}x{img.shape[0]} source:")
        print(f"- Zoom: {self.args.zoom}x (Crop: {int(self.output_width/self.args.zoom)}x{int(self.output_height/self.args.zoom)})")
        print(f"- Output: {self.output_width}x{self.output_height} {self.args.fps}fps")
        print(f"- Path: {self.args.camera_path}")
        print(f"- Threads: {self.args.threads}")
        
        # Set OpenCV threads
        cv2.setNumThreads(self.args.threads)
        
        # Process frames with progress bar
        success_count = 0
        progress_bar = tqdm(range(total_frames), desc="Rendering frames")
        for i in progress_bar:
            if self.process_frame(img, path[i], i):
                success_count += 1
            progress_bar.set_postfix(success=f"{success_count}/{i+1}")
        
        success_rate = (success_count / total_frames) * 100
        print(f"\nCompleted: {success_count}/{total_frames} frames ({success_rate:.1f}% success)")
        
        return success_count > total_frames * 0.95  # Require 95% success

if __name__ == "__main__":
    try:
        renderer = RainbowCamouflageRenderer()
        if renderer.render():
            print("\nSUCCESS: Frame rendering completed")
            exit(0)
        else:
            print("\nWARNING: Frame rendering completed with errors")
            exit(1)
    except Exception as e:
        print(f"\nERROR: {str(e)}")
        exit(1)
