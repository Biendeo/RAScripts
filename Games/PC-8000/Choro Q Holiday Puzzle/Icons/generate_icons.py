from PIL import Image
from dataclasses import dataclass

DIFFICULTIES = [
    "Beginner",
    "Junior",
    "Senior",
    "Professional"
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_difficulty_achievements()
    generate_misc_achievements()

def generate_difficulty_achievements() -> None:
    for difficulty in DIFFICULTIES:
        difficulty_image = Image.open(f"Icons/Layers/Difficulty-{difficulty}.png")
        difficulty_image.paste(BORDER, (0, 0), BORDER)
        difficulty_image.save(f"Icons/Output/Achievement-{difficulty}.png")
        stopwatch_image = Image.open("Icons/Layers/Layer-Stopwatch.png")
        difficulty_image.paste(stopwatch_image, (2, 2), stopwatch_image)
        difficulty_image.save(f"Icons/Output/Achievement-{difficulty}-Fast.png")

def generate_misc_achievements() -> None:
    rgb_image = Image.open("Icons/Layers/Layer-RGB.png")
    rgb_image.paste(BORDER, (0, 0), BORDER)
    rgb_image.save(f"Icons/Output/Achievement-RGB.png")

if __name__ == "__main__":
    main()