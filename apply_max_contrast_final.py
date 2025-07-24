from PIL import Image, ImageEnhance
import numpy as np

def apply_max_contrast(image_path, output_path):
    image = Image.open(image_path).convert("RGB")
    np_image = np.asarray(image).astype(np.float32)

    # Scale each channel independently
    for c in range(3):
        channel = np_image[..., c]
        min_val = channel.min()
        max_val = channel.max()
        if max_val != min_val:
            np_image[..., c] = 255 * (channel - min_val) / (max_val - min_val)

    new_image = Image.fromarray(np.clip(np_image, 0, 255).astype(np.uint8))
    new_image.save(output_path)

if __name__ == "__main__":
    apply_max_contrast("current_abstract_video_image.jpg", "current_abstract_video_image.jpg")
