from PIL import Image

LEVELS = [
    "Nohma",
    "Huma",
    "Versai",
    "Kengola",
    "Jinarl1",
    "Jinarl2",
    "Laysark1",
    "Laysark2",
    "Elguala1",
    "Elguala2",
    "Jaroa1",
    "Jaroa2",
    "Jaroa3",
    "Galandia",
    "Ellita1",
    "Ellita2",
    "Nickeeyu1",
    "Nickeeyu2",
    "Nobborn1",
    "Nobborn2",
    "Belose1",
    "Belose2",
    "Belose3",
    "NobbornS",
    "EllitaS",
    "ElgualaS",
    "BeloseS",
    "NickeeyuS",
    "LaysarkS",
    "JaroaS",
    "JinarlS"
]

ENDINGS = [
    "FaliallFail",
    "FaliallWin",
    "StefanFail",
    "StefanWin",
    "Snuggle"
]

MISC_ACHIEVEMENTS = [
    "MaxMoney",
    "MaxUnits",
    "ConquerBuildings",
    "DestroyBase"
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_scenario_mode_icons()
    generate_level_icons()
    generate_misc_icons()

def generate_scenario_mode_icons() -> None:
    for ending in ENDINGS:
        ending_image = Image.open(f"Icons/Layers/Ending-{ending}.png")
        ending_image.paste(BORDER, (0, 0), BORDER)
        ending_image.save(f"Icons/Output/Achievement-Ending-{ending}.png")

def generate_level_icons() -> None:
    for level in LEVELS:
        for side in ["Faliall", "Stefan"]:
            level_image = Image.open(f"Icons/Layers/Level-{level}-{side}.png")
            letter_image = Image.open(f"Icons/Layers/Icon-{side}.png")
            level_image.paste(BORDER, (0, 0), BORDER)
            level_image.paste(letter_image, (41, 41), letter_image)
            level_image.save(f"Icons/Output/Achievement-Level-{level}-{side}.png")

def generate_misc_icons() -> None:
    for misc in MISC_ACHIEVEMENTS:
        misc_image = Image.open(f"Icons/Layers/Misc-{misc}.png")
        misc_image.paste(BORDER, (0, 0), BORDER)
        misc_image.save(f"Icons/Output/Achievement-Misc-{misc}.png")

if __name__ == "__main__":
    main()