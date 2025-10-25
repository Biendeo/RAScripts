from PIL import Image

STAMP_MILESTONES = [
    1,
    2,
    3,
    5,
    7,
    9,
    11,
    13,
    15,
    17,
    20,
    23
]

MINIGAME_NAMES = [
    "ConnectMaze",
    "WordMemory",
    "WordMemory-Perfect",
    "NumberCruncher",
    "StroopTest",
    "SpeedCounting",
    "SpeedCounting-Fast",
    "Calculations20",
    "Calculations100",
    "Calculations100-Hard",
    "ReadingAloud",
    "ReadingAloud-TooFast",
    "LowToHigh",
    "LowToHigh-Perfect",
    "SyllableCount",
    "HeadCount",
    "HeadCount-Hard",
    "TriangleMath",
    "TriangleMath-Hard",
    "TimeLapse",
    "VoiceCalculation"
]

SUDOKU_DIFFICULTIES = {
    "Basic": [0.0, 0.95, 0.0],
    "Intermediate": [0.9, 0.8, 0.0],
    "Advanced": [1.0, 0.0, 0.0],
}

BORDER = Image.open("Icons/Layers/Border.png")


def main() -> None:
    generate_stamp_achievements()
    generate_sudoku_achievements()
    generate_minigame_achievements()
    generate_misc_achievements()

def add_numbers(image: Image, number: str, x: int, y: int, r: float = 0.0, g: float = 0.0, b: float = 0.0) -> None:
    for i, c in enumerate(number):
        digit = Image.open(f"Icons/Layers/Layer-Digit-{c}.png")
        rc, gc, bc, ac = digit.split()
        digit = Image.merge("RGBA", (
            rc.point(lambda z: z * r),
            gc.point(lambda z: z * g),
            bc.point(lambda z: z * b),
            ac.point(lambda z: z)
        ))
        image.paste(digit, (x - (24 * (len(number) - i - 1)), y), digit)

def generate_stamp_achievements() -> None:
    for milestone in STAMP_MILESTONES:
        background = Image.open("Icons/Layers/Background-Stamp-OK.png")
        add_numbers(background, str(milestone), 37, 25, 0.1, 0.1, 0.1)
        background.paste(BORDER, (0, 0), BORDER)
        background.save(f"Icons/Output/Stamp-{milestone}.png")

def generate_minigame_achievements() -> None:
    for minigame in MINIGAME_NAMES:
        background = Image.open(f"Icons/Layers/Background-{minigame}.png")
        background.paste(BORDER, (0, 0), BORDER)
        background.save(f"Icons/Output/Minigame-{minigame}.png")

def generate_sudoku_achievements() -> None:
    for difficulty, color in SUDOKU_DIFFICULTIES.items():
        for number in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]:
            background = Image.open("Icons/Layers/Background-Sudoku.png")
            add_numbers(background, number, 37 if number != "X" else 0, 25 if number != "X" else 0, color[0], color[1], color[2])
            background.paste(BORDER, (0, 0), BORDER)
            background.save(f"Icons/Output/Sudoku-{difficulty}-{number}.png")

def generate_misc_achievements() -> None:
    generate_brain_age_achievement()
    generate_note_achievement()
    generate_art_achievement()

def generate_brain_age_achievement() -> None:
    image = Image.open(f"Icons/Layers/Background-BrainAge.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.save(f"Icons/Output/Misc-BrainAge.png")

def generate_note_achievement() -> None:
    image = Image.open(f"Icons/Layers/Background-Note.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.save(f"Icons/Output/Misc-Note.png")

def generate_art_achievement() -> None:
    image = Image.open(f"Icons/Layers/Background-Art.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.save(f"Icons/Output/Misc-Art.png")

if __name__ == "__main__":
    main()