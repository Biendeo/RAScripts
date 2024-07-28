from PIL import Image, ImageFilter

SCORE_ACHIEVEMENTS = [
    "1M",
    "2M",
    "5M"
]

MISC_ACHIEVEMENTS = [
    "Energy",
    "Fuel",
    "SecretCredits"
]

BORDER = Image.open("Icons/Layers/Border.png")


def main() -> None:
    generate_level_achievements()
    generate_score_achievements()
    generate_misc_achievements()

def generate_level_achievements() -> None:
    for level in range(1, 10):
        for i, name in enumerate(["First", "Second", "Time"]):
            background_image = Image.open(f"Icons/Layers/Stage-{level}-{i + 1}.png")
            background_image.paste(BORDER, (0, 0), BORDER)
            background_image.save(f"Icons/Output/Achievement-Stage-{level}-{name}.png")

def generate_score_achievements() -> None:
    for score in SCORE_ACHIEVEMENTS:
        background_image = Image.open(f"Icons/Layers/Score-{score}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Score-{score}.png")

def generate_misc_achievements() -> None:
    for misc in MISC_ACHIEVEMENTS:
        background_image = Image.open(f"Icons/Layers/Misc-{misc}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Misc-{misc}.png")

if __name__ == "__main__":
    main()