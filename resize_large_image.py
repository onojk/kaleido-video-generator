from PIL import Image

INPUT_PATH = "current_abstract_video_image.jpg"
OUTPUT_PATH = "rainbow_camouflage_resized.jpg"
TARGET_WIDTH = 1280
TARGET_HEIGHT = 720

def resize_image(input_path, output_path, width, height):
    image = Image.open(input_path)
    resized = image.resize((width, height), Image.LANCZOS)
    resized.save(output_path)
    print(f"[✓] Resized image saved to: {output_path}")

if __name__ == "__main__":
    resize_image(INPUT_PATH, OUTPUT_PATH, TARGET_WIDTH, TARGET_HEIGHT)
