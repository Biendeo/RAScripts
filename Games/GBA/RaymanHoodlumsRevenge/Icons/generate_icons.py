from PIL import Image

LEVELS = [
    "FairyCouncil",
    "ClearleafForest",
    "ClearleafFalls",
    "InfernalMachine",
    "VertiginousRiddle",
    "DungeonOfMurk",
    "RiversOfMurk",
    "BogOfMurk",
    "BegoniaxBayou",
    "HoodlumMoor",
    "LandOfTheLividDead",
    "SulphurousSea",
    "MenhirsOfPower",
    "PitOfEndlessFire",
    "CloudsOfPeril",
    "CloudyCache",
    "HeartOfTheWorld",
    "ScaldingCascade",
    "MeleeMayhem",
    "RefluxsLair"
]

LEVELS_WITH_SCORE = [
    "FairyCouncil",
    "ClearleafForest",
    "ClearleafFalls",
    "VertiginousRiddle",
    "DungeonOfMurk",
    "RiversOfMurk",
    "BogOfMurk",
    "HoodlumMoor",
    "LandOfTheLividDead",
    "SulphurousSea",
    "MenhirsOfPower",
    "CloudsOfPeril",
    "CloudyCache",
    "HeartOfTheWorld",
    "ScaldingCascade",
    "MeleeMayhem"
]

LEVELS_WITH_TEENSIES = [
    "FairyCouncil",
    "ClearleafForest",
    "ClearleafFalls",
    "RiversOfMurk",
    "HoodlumMoor",
    "LandOfTheLividDead",
    "MenhirsOfPower",
    "CloudsOfPeril",
    "HeartOfTheWorld"
]

LEVELS_WITH_BOSS = [
    "InfernalMachine",
    "BegoniaxBayou",
    "PitOfEndlessFire",
    "RefluxsLair"
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_time_achievements()
    generate_score_achievements()
    generate_lum_achievements()
    generate_teensie_achievements()
    generate_boss_achievements()
    generate_other_achievements()

def generate_time_achievements() -> None:
    for level in LEVELS:
        background_image = Image.open(f"Icons/Layers/Background-{level}.png")
        clock_layer = Image.open(f"Icons/Layers/Clock.png")
        background_image.paste(clock_layer, (41, 36), clock_layer)
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Time-{level}.png")

def generate_score_achievements() -> None:
    for level in LEVELS_WITH_SCORE:
        background_image = Image.open(f"Icons/Layers/Background-{level}.png")
        stamp_layer = Image.open(f"Icons/Layers/MurfyStamp.png")
        background_image.paste(stamp_layer, (41, 41), stamp_layer)
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Score-{level}.png")

def generate_lum_achievements() -> None:
    for level in LEVELS_WITH_SCORE:
        background_image = Image.open(f"Icons/Layers/Background-{level}.png")
        lum_layer = Image.open(f"Icons/Layers/Lum.png")
        background_image.paste(lum_layer, (41, 41), lum_layer)
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Lums-{level}.png")

def generate_teensie_achievements() -> None:
    for level in LEVELS_WITH_TEENSIES:
        background_image = Image.open(f"Icons/Layers/Background-{level}.png")
        teensie_layer = Image.open(f"Icons/Layers/Teensie.png")
        background_image.paste(teensie_layer, (41, 41), teensie_layer)
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Teensies-{level}.png")

def generate_boss_achievements() -> None:
    for level in LEVELS_WITH_BOSS:
        background_image = Image.open(f"Icons/Layers/Background-{level}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-Boss-{level}.png")

        background_image = Image.open(f"Icons/Layers/Background-{level}.png")
        challenge_layer = Image.open(f"Icons/Layers/Challenge.png")
        background_image.paste(challenge_layer, (41, 41), challenge_layer)
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-BossChallenge-{level}.png")

def generate_other_achievements() -> None:
    combo_image = Image.open(f"Icons/Layers/Combo.png")
    combo_image.paste(BORDER, (0, 0), BORDER)
    combo_image.save(f"Icons/Output/Achievement-Combo.png")

if __name__ == "__main__":
    main()