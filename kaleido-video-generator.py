import argparse
import subprocess

def generate_video(length, output):
    # Example of how the kaleidoscope video is generated
    command = [
        'python3', 'kaleido_video_generator.py',  # Main video generation script
        '--length', str(length),
        '--output', output  # Path to save the generated video
    ]
    
    subprocess.run(command)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate kaleidoscopic video.")
    parser.add_argument('--length', type=int, required=True, help="Length of the video in seconds.")
    parser.add_argument('--output', type=str, required=True, help="Path to save the generated video.")
    
    args = parser.parse_args()
    generate_video(args.length, args.output)
