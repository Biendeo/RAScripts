from PIL import Image
from dataclasses import dataclass

SONGS = [
    "Fallin",
    "Solid",
    "ALittleTime",
    "AintNoSunshine",
    "HitEmUpStyleOops",
    "NoWomanNoCry",
    "VideoKilledTheRadioStar",
    "Year3000",
    "GirlsJustWannaHaveFun",
    "Survivor",
    "WhiteFlag",
    "HungryLikeTheWolf",
    "DontGoBreakingMyHeart",
    "WayDown",
    "BuildMeUpButtercup",
    "TakeMeOut",
    "Faith",
    "CosmicGirl",
    "RealThings",
    "IShouldBeSoLucky",
    "TuttiFrutti",
    "ThisLove",
    "Single",
    "JustLikeAPill",
    "EveryBreathYouTake",
    "TakeYourMama",
    "IGotYouBabe",
    "Gold",
    "WhoDoYouThinkYouAre",
    "IThinkWereAloneNow"
]

TWO_PART_SONGS = [
    "Solid",
    "ALittleTime",
    "VideoKilledTheRadioStar",
    "Survivor",
    "DontGoBreakingMyHeart",
    "IGotYouBabe"
]

@dataclass
class AchievementDetails:
    name: str
    border_color: str

BORDER_COLORS = {
    "blue": [0.000, 0.722, 0.937, 1.000],
    "red": [0.918, 0.078, 0.176, 1.000],
    "orange": [1.000, 0.545, 0.000, 1.000],
    "green": [0.012, 0.793, 0.000, 1.000]
}

SONG_ACHIEVEMENTS = [
    AchievementDetails("Easy", "blue"),
    AchievementDetails("Hard", "red"),
    AchievementDetails("FC", "orange")
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_song_achievements()
    generate_bonus_achievements()

def get_border(color: str) -> Image:
    r, g, b, a = BORDER.split()
    colors = BORDER_COLORS[color]
    return Image.merge("RGBA", (
        r.point(lambda z: z * colors[0]),
        g.point(lambda z: z * colors[1]),
        b.point(lambda z: z * colors[2]),
        a.point(lambda z: z * colors[3])
    ))

def generate_song_achievements() -> None:
    for i, details in enumerate(SONG_ACHIEVEMENTS):
        r, g, b, a = BORDER.split()
        colored_border = get_border(details.border_color)
        for song in SONGS:
            if details.name == "FC" and song in TWO_PART_SONGS:
                background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 1}.png")
                background_image.paste(colored_border, (0, 0), colored_border)
                background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}-1.png")
                background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 2}.png")
                background_image.paste(colored_border, (0, 0), colored_border)
                background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}-2.png")
            else:
                background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 1}.png")
                background_image.paste(colored_border, (0, 0), colored_border)
                background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}.png")

def generate_bonus_achievements() -> None:
    colored_border = get_border("green")

    background_image = Image.open(f"Icons/Layers/Bonus-9000.png")
    background_image.paste(colored_border, (0, 0), colored_border)
    background_image.save(f"Icons/Output/Achievement-Bonus-9000.png")

    background_image = Image.open(f"Icons/Layers/Bonus-Eyetoy.png")
    background_image.paste(colored_border, (0, 0), colored_border)
    background_image.save(f"Icons/Output/Achievement-Bonus-Eyetoy.png")

if __name__ == "__main__":
    main()