from PIL import Image
from dataclasses import dataclass

SONGS = [
    "WorldOfOurOwn",
    "MurderOnTheDancefloor",
    "ThankYou",
    "GetThePartyStarted",
    "Scandalous",
    "AceOfSpades",
    "Downtown",
    "LikeAVirgin",
    "NeverGonnaGiveYouUp",
    "OhPrettyWoman",
    "GrooveIsInTheHeart",
    "JustALittle",
    "TakeOnMe",
    "KungFuFighting",
    "IfYoureNotTheOne",
    "SuspiciousMinds",
    "HeartOfGlass",
    "CarelessWhisper",
    "RoundRound",
    "YMCA",
    "CrashedTheWedding",
    "Complicated",
    "LivinLaVidaLoca",
    "DontStopMovin",
    "Superstar",
    "IBelieveInAThingCalledLove",
    "GirlsAndBoys",
    "OneLove",
    "EternalFlame",
    "5050"
]

BONUS_SONGS = [
    "NeverGonnaGiveYouUp",
    "GrooveIsInTheHeart"
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

CAREER_EVENT_ACHIEVEMENTS = [
    AchievementDetails("Any", "blue"),
    AchievementDetails("Hard", "red")
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_song_achievements()
    generate_bonus_achievements()
    generate_career_rank_achievements()
    generate_career_event_achievements()

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
            background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 1}.png")
            background_image.paste(colored_border, (0, 0), colored_border)
            background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}.png")

def generate_bonus_achievements() -> None:
    colored_border = get_border("green")
    for song in BONUS_SONGS:
        background_image = Image.open(f"Icons/Layers/Song-{song}-Bonus.png")
        background_image.paste(colored_border, (0, 0), colored_border)
        background_image.save(f"Icons/Output/Achievement-Song-{song}-Bonus.png")

    background_image = Image.open(f"Icons/Layers/Bonus-9000.png")
    background_image.paste(colored_border, (0, 0), colored_border)
    background_image.save(f"Icons/Output/Achievement-Bonus-9000.png")

def generate_career_rank_achievements() -> None:
    colored_border = get_border("green")
    for i in range(1, 6):
        background_image = Image.open(f"Icons/Layers/Career-Rank-{i}.png")
        background_image.paste(colored_border, (0, 0), colored_border)
        background_image.save(f"Icons/Output/Achievement-Career-Rank-{i}.png")

def generate_career_event_achievements() -> None:
    for details in CAREER_EVENT_ACHIEVEMENTS:
        colored_border = get_border(details.border_color)
        for i in range(1, 5):
            background_image = Image.open(f"Icons/Layers/Career-Event-{i}.png")
            background_image.paste(colored_border, (0, 0), colored_border)
            background_image.save(f"Icons/Output/Achievement-Career-Event-{i}-{details.name}.png")

if __name__ == "__main__":
    main()