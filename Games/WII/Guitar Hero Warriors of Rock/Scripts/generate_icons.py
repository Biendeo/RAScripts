import copy, itertools, os, shutil

from tqdm import tqdm

from PIL import ImageFilter
from PIL import Image as PILImage
from PIL.Image import Image

from constants import get_all_songs, normalize_song_title_for_file, INSTRUMENT_GUITAR, INSTRUMENT_DRUMS, INSTRUMENT_VOCALS, INSTRUMENT_BASS, SOURCE_GHWOR, Song 

songs = get_all_songs()

INSTRUMENT_TO_NAME = {
    INSTRUMENT_GUITAR: "Guitar",
    INSTRUMENT_DRUMS: "Drums",
    INSTRUMENT_VOCALS: "Vocals",
    INSTRUMENT_BASS: "Bass"
}

CUSTOM_SONGS = [
    "BarrenMountain",
    "Brandenburg",
    "ChopinRevolution",
    "DelugeOfFire",
    "Echo",
    "FeedForward",
    "Moonlit",
    "PaintTheFires",
    "PointsOfOak",
    "Pwnaphone",
    "RavingMad"
]

QUEST_ACHIEVEMENTS = [
    "TheSiren",
    "TheTrickster",
    "TheVigil",
    "TheBrute",
    "TheEternal",
    "TheDynamo",
    "AxeClaimer",
    "TheExalted",
    "TheRecluse",
    "SaviorOfRock"
]

BORDER = PILImage.open("Icons/Layers/Border.png")

FONT_ATLAS = PILImage.open("Icons/Layers/Text-FontAtlas.png")

CHARACTERS = {
    ' ': (251, 370, 6, 36),
    '&': (312, 228, 30, 30),
    '(': (369, 47, 22, 36),
    ')': (0, 89, 22, 36),
    '-': (178, 344, 33, 16),
    '.': (162, 344, 16, 8),
    '0': (322, 162, 38, 32),
    '1': (342, 228, 18, 30),
    '2': (353, 195, 32, 32),
    '3': (385, 195, 32, 32),
    '4': (417, 195, 34, 32),
    '5': (451, 195, 30, 32),
    '6': (443, 126, 32, 32),
    '7': (360, 228, 31, 30),
    '8': (360, 162, 32, 32),
    '9': (392, 162, 32, 32),
    ';': (462, 162, 35, 32),
    'A': (424, 162, 38, 32),
    'B': (123, 258, 33, 30),
    'C': (50, 228, 35, 30),
    'D': (156, 258, 35, 30),
    'E': (391, 228, 36, 30),
    'F': (427, 228, 35, 30),
    'G': (475, 126, 37, 32),
    'H': (85, 228, 35, 30),
    'I': (462, 228, 19, 30),
    'J': (481, 195, 30, 32),
    'K': (462, 162, 35, 32),
    'L': (481, 228, 27, 30),
    'M': (120, 228, 44, 30),
    'N': (0, 195, 40, 32),
    'O': (40, 195, 37, 32),
    'P': (191, 258, 35, 30),
    'Q': (322, 89, 43, 35),
    'R': (214, 228, 36, 30),
    'S': (251, 228, 27, 30),
    'T': (50, 258, 33, 30),
    'U': (157, 195, 36, 32),
    'V': (193, 195, 40, 32),
    'W': (0, 162, 52, 32),
    'X': (233, 195, 41, 32),
    'Y': (83, 258, 40, 30),
    'Z': (278, 228, 33, 30),
    'a': (242, 258, 39, 30),
    'b': (105, 316, 34, 26),
    'c': (333, 258, 31, 30),
    'd': (139, 316, 36, 26),
    'e': (364, 256, 31, 30),
    'f': (314, 288, 34, 28),
    'g': (348, 288, 34, 28),
    'h': (382, 288, 34, 28),
    'i': (416, 288, 18, 28),
    'j': (396, 258, 30, 30),
    'k': (426, 258, 36, 30),
    'l': (175, 316, 26, 26),
    'm': (462, 258, 44, 30),
    'n': (434, 288, 40, 28),
    'o': (0, 288, 37, 28),
    'p': (201, 316, 34, 26),
    'q': (256, 126, 44, 32),
    'r': (474, 288, 36, 28),
    's': (84, 288, 29, 28),
    't': (0, 316, 34, 26),
    'u': (34, 316, 37, 26),
    'v': (141, 288, 40, 28),
    'w': (181, 288, 52, 28),
    'x': (233, 288, 40, 28),
    'y': (273, 288, 40, 28),
    'z': (71, 316, 34, 26),
}

def multiply_image(image: Image, r: float, g: float, b: float, a: float) -> Image:
    rc, gc, bc, ac = image.split()
    return PILImage.merge("RGBA", (
        rc.point(lambda z: z * r),
        gc.point(lambda z: z * g),
        bc.point(lambda z: z * b),
        ac.point(lambda z: z * a)
    ))

def add_border(image: Image) -> Image:
    border_radius = 1
    stroke_image = PILImage.new("RGBA", (image.size[0] + border_radius + border_radius, image.size[1] + border_radius + border_radius), (0, 0, 0, 255))
    new_image = PILImage.new("RGBA", (image.size[0] + border_radius + border_radius, image.size[1] + border_radius + border_radius))
    new_image.paste(image, (border_radius, border_radius))
    img_alpha = new_image.getchannel(3).point(lambda z: z * 2)
    stroke_alpha = img_alpha.filter(ImageFilter.MaxFilter(border_radius))
    stroke_alpha = stroke_alpha.filter(ImageFilter.SMOOTH)
    stroke_image.putalpha(stroke_alpha)
    new_image = PILImage.alpha_composite(stroke_image, new_image)
    return new_image

def resize_and_border_icon(path: str, size: tuple[int, int]) -> Image:
    return add_border(PILImage.open(path).resize(size, PILImage.Resampling.LANCZOS))

def resize_recolor_and_border_icon(path: str, size: tuple[int, int], color: tuple[float, float, float, float]) -> Image:
    return add_border(multiply_image(PILImage.open(path), color[0], color[1], color[2], color[3]).resize(size, PILImage.Resampling.LANCZOS))

DIFFICULTY_IMAGE = {
    "Hard": resize_and_border_icon("Icons/Layers/Difficulty-Hard.png", (24, 24)),
    "Expert": resize_and_border_icon("Icons/Layers/Difficulty-Expert.png", (24, 24)),
    "Expert+": resize_and_border_icon("Icons/Layers/Difficulty-Expert+.png", (24, 24)),
}
QUICKPLAY_STAR_IMAGE = resize_and_border_icon("Icons/Layers/QuickplayStar.png", (14, 14))
POWER_CHALLENGE_STAR_IMAGE = resize_and_border_icon("Icons/Layers/PowerChallengeStar.png", (24, 24))
FC_IMAGE = resize_and_border_icon("Icons/Layers/FC.png", (24, 24))
STAR_CHALLENGE_IMAGE = resize_and_border_icon("Icons/Layers/StarChallenge.png", (30, 30))
QUEST_IMAGE = resize_and_border_icon("Icons/Layers/Quest.png", (20, 20))
INSTRUMENT_IMAGE = {
    "Guitar": resize_recolor_and_border_icon("Icons/Layers/Instrument-Guitar.png", (24, 24), (0.9, 0.5, 0.5, 1.0)),
    "Drums": resize_recolor_and_border_icon("Icons/Layers/Instrument-Drums.png", (24, 24), (0.6, 0.6, 1.0, 1.0)),
    "Vocals": resize_recolor_and_border_icon("Icons/Layers/Instrument-Vocals.png", (24, 24), (0.9, 0.9, 0.5, 1.0)),
    "Bass": resize_recolor_and_border_icon("Icons/Layers/Instrument-Bass.png", (24, 24), (0.5, 0.9, 0.5, 1.0)),
    "Band": resize_and_border_icon("Icons/Layers/Instrument-Band.png", (20, 20))
}

CHARACTER_IMAGE = { k: FONT_ATLAS.crop((v[0], v[1], v[0] + v[2], v[1] + v[3])) for k, v in CHARACTERS.items() }

def main() -> None:
    shutil.rmtree("Icons/Output")
    for directory in ["Core", "Co-Op", "PowerChallenge", "FC", "DLC"]:
        os.makedirs(f"Icons/Output/{directory}", exist_ok=True)
    generate_song_achievements()
    generate_custom_song_achievements()
    generate_quest_achievements()
    generate_miscellaneous_achievements()

def get_text_image(s: str) -> Image:
    caption_width = 0
    for c in s:
        caption_width += CHARACTERS[c][2]
    caption_image = PILImage.new("RGBA", (caption_width, 36))
    x = 0
    for c in s:
        q = CHARACTERS[c]
        character_image = CHARACTER_IMAGE[c]
        caption_image.paste(character_image, (x, 36 - q[3]), character_image)
        x += CHARACTERS[c][2]

    return caption_image

def get_song_art(song: Song) -> Image:
    album_art = PILImage.open(f"Icons/Layers/Albums/{song.AlbumArt}.png")
    album_art.paste(BORDER, (0, 0), BORDER)
    if song.Caption == "":
        return album_art
    
    caption_image = get_text_image(song.Caption)
    if caption_image.width > 112:
        new_size = (56, int(36 * 56 / caption_image.width))
    else:
        new_size = (int(caption_image.width / 2), 18)
    caption_image = caption_image.resize(new_size, PILImage.Resampling.LANCZOS)
    caption_image = add_border(caption_image)
    album_art.paste(caption_image, (int(32 - new_size[0] / 2), 28), caption_image)
    return album_art

def generate_song_achievements() -> None:
    suicide_and_redemption_combined_song = copy.copy([s for s in songs if s.Title == "Suicide & Redemption J.H."][0])
    suicide_and_redemption_combined_song.Title = "Suicide & Redemption"
    suicide_and_redemption_combined_song.Caption = "S&R"

    for song in tqdm(list(itertools.chain(songs, [suicide_and_redemption_combined_song]))):
        if song.Title == "Sweet Home Alabama (Live) (GH5)":
            # All of the icons are handled by the GHWT version.
            continue
        # TODO: Remove this case to assert it's all good.
        if song.AlbumArt == "":
            tqdm.write(f"{song.Title} has no album art")
            continue
        song_art = get_song_art(song)
        for instrument_metadata in song.Instruments:
            if (
                (song.Title == "Suicide & Redemption J.H." or song.Title == "Suicide & Redemption K.H.")
                    and (instrument_metadata.Instrument == INSTRUMENT_DRUMS or instrument_metadata.Instrument == INSTRUMENT_BASS)
            ) or (
                song.Title == "Suicide & Redemption" and instrument_metadata.Instrument == INSTRUMENT_GUITAR
            ):
                # Five stars and FCs are combined for drums and bass, but not for guitar.
                continue
            song_and_instrument_art = song_art.copy()
            instrument_name = INSTRUMENT_TO_NAME[instrument_metadata.Instrument]
            instrument_image = INSTRUMENT_IMAGE[instrument_name]
            song_and_instrument_art.paste(instrument_image, (-2, -2), instrument_image)
            if instrument_metadata.ExpertPlusAvailable:
                difficulty_image = DIFFICULTY_IMAGE["Expert+"]
            else:
                difficulty_image = DIFFICULTY_IMAGE["Expert"]
            song_and_instrument_art.paste(difficulty_image, (38, -2), difficulty_image)

            quickplay_five_star_image = song_and_instrument_art.copy()
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (-2, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (10, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (22, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (34, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (46, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.save(f"Icons/Output/{"Core/" if song.Source == SOURCE_GHWOR else "DLC/"}Quickplay-{normalize_song_title_for_file(song)}-{instrument_name}.png")

            quickplay_fc_image = song_and_instrument_art.copy()
            quickplay_fc_image.paste(FC_IMAGE, (0, 37), FC_IMAGE)
            quickplay_fc_image.save(f"Icons/Output/FC/{normalize_song_title_for_file(song)}-{instrument_name}.png")

            if song.VocalChallengeAchievement is not None and not song.VocalChallengeAchievement.IsNull and song.VocalChallengeAchievement.Value.Instrument == instrument_metadata.Instrument:
                voxtar_image = quickplay_five_star_image.copy()
                voxtar_image.paste(INSTRUMENT_IMAGE["Vocals"], (18, -2), INSTRUMENT_IMAGE["Vocals"])
                voxtar_image.save(f"Icons/Output/Core/Quickplay-VocalChallenge-{normalize_song_title_for_file(song)}.png")

            # Uncomment if this can be figured out.
            # if song.Source == SOURCE_GHWOR:
            #     star_challenge_art = song_art.copy()
            #     star_challenge_art.paste(instrument_image, (-2, -2), instrument_image)
            #     star_challenge_art.paste(STAR_CHALLENGE_IMAGE, (36, -4), STAR_CHALLENGE_IMAGE)
            #     star_challenge_art.save(f"Icons/Output/Core/StarChallenge-{normalize_song_title_for_file(song)}-{instrument_name}.png")

        if song.Title != "Suicide & Redemption":
            # The band gets two achievements for this.
            hardest_difficulty_image = DIFFICULTY_IMAGE["Expert+"] if any((i.ExpertPlusAvailable for i in song.Instruments)) else DIFFICULTY_IMAGE["Expert"]
            band_five_star_image = song_art.copy()
            band_five_star_image.paste(INSTRUMENT_IMAGE["Band"], (0, 0), INSTRUMENT_IMAGE["Band"])
            band_five_star_image.paste(hardest_difficulty_image, (38, -2), hardest_difficulty_image)
            band_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (-2, 44), QUICKPLAY_STAR_IMAGE)
            band_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (10, 44), QUICKPLAY_STAR_IMAGE)
            band_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (22, 44), QUICKPLAY_STAR_IMAGE)
            band_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (34, 44), QUICKPLAY_STAR_IMAGE)
            band_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (46, 44), QUICKPLAY_STAR_IMAGE)
            band_five_star_image.save(f"Icons/Output/Co-Op/Quickplay-{normalize_song_title_for_file(song)}-Band.png")

        if song.Title != "Suicide & Redemption J.H." and song.Title != "Suicide & Redemption K.H.":
            # The Power Challenge is merged for this song.
            power_challenge_art = song_art.copy()
            power_challenge_art.paste(DIFFICULTY_IMAGE["Expert"], (38, -2), DIFFICULTY_IMAGE["Expert"])
            power_challenge_art.paste(POWER_CHALLENGE_STAR_IMAGE, (-2, -2), POWER_CHALLENGE_STAR_IMAGE)
            power_challenge_art.save(f"Icons/Output/PowerChallenge/{normalize_song_title_for_file(song)}.png")

            if song.Source == SOURCE_GHWOR and not song.Title.startswith("2112"):
                quest_art = song_art.copy()
                quest_art.paste(DIFFICULTY_IMAGE["Expert"], (38, -2), DIFFICULTY_IMAGE["Expert"])
                quest_art.paste(QUEST_IMAGE, (0, 0), QUEST_IMAGE)
                quest_art.save(f"Icons/Output/Core/Quest-Song-{normalize_song_title_for_file(song)}.png")

def generate_custom_song_achievements() -> None:
    for song in CUSTOM_SONGS:
        song_art = PILImage.open(f"Icons/Layers/CustomSong-{song}.png")
        song_art.paste(BORDER, (0, 0), BORDER)
        for instrument_name in ["Guitar", "Drums", "Bass", "Band"]:
            song_and_instrument_art = song_art.copy()
            instrument_image = INSTRUMENT_IMAGE[instrument_name]
            song_and_instrument_art.paste(instrument_image, (-2, -2), instrument_image)
            song_and_instrument_art.paste(DIFFICULTY_IMAGE["Expert"], (38, -2), DIFFICULTY_IMAGE["Expert"])

            quickplay_five_star_image = song_and_instrument_art.copy()
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (-2, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (10, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (22, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (34, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.paste(QUICKPLAY_STAR_IMAGE, (46, 44), QUICKPLAY_STAR_IMAGE)
            quickplay_five_star_image.save(f"Icons/Output/{"Co-Op" if instrument_name == "Band" else "Core"}/CustomSong-{song}-{instrument_name}.png")

            if instrument_name != "Band":
                quickplay_fc_image = song_and_instrument_art.copy()
                quickplay_fc_image.paste(FC_IMAGE, (0, 37), FC_IMAGE)
                quickplay_fc_image.save(f"Icons/Output/FC/CustomSong-{song}-{instrument_name}.png")

def generate_quest_achievements() -> None:
    for quest_achievement in QUEST_ACHIEVEMENTS:
        art = PILImage.open(f"Icons/Layers/Quest-{quest_achievement}.png")
        art.paste(BORDER, (0, 0), BORDER)
        art.save(f"Icons/Output/Core/Quest-Milestone-{quest_achievement}.png")

def generate_miscellaneous_achievements() -> None:
    ghtunes_art = PILImage.open(f"Icons/Layers/Misc-GHTunes.png")
    ghtunes_art.paste(BORDER, (0, 0), BORDER)
    ghtunes_art.paste(QUICKPLAY_STAR_IMAGE, (-2, 44), QUICKPLAY_STAR_IMAGE)
    ghtunes_art.paste(QUICKPLAY_STAR_IMAGE, (10, 44), QUICKPLAY_STAR_IMAGE)
    ghtunes_art.paste(QUICKPLAY_STAR_IMAGE, (22, 44), QUICKPLAY_STAR_IMAGE)
    ghtunes_art.paste(QUICKPLAY_STAR_IMAGE, (34, 44), QUICKPLAY_STAR_IMAGE)
    ghtunes_art.paste(QUICKPLAY_STAR_IMAGE, (46, 44), QUICKPLAY_STAR_IMAGE)
    ghtunes_art.save(f"Icons/Output/Core/Misc-FiveStarCustom.png")

    perfect_song = PILImage.open(f"Icons/Layers/Misc-LoadingScreen.png")
    perfect_song.paste(BORDER, (0, 0), BORDER)
    perfect_song.paste(DIFFICULTY_IMAGE["Hard"], (-2, -2), DIFFICULTY_IMAGE["Hard"])
    perfect_song.paste(DIFFICULTY_IMAGE["Expert"], (38, -2), DIFFICULTY_IMAGE["Expert"])
    perfect_song.paste(QUICKPLAY_STAR_IMAGE, (-2, 44), QUICKPLAY_STAR_IMAGE)
    perfect_song.paste(QUICKPLAY_STAR_IMAGE, (8, 44), QUICKPLAY_STAR_IMAGE)
    perfect_song.paste(QUICKPLAY_STAR_IMAGE, (18, 44), QUICKPLAY_STAR_IMAGE)
    perfect_song.paste(QUICKPLAY_STAR_IMAGE, (28, 44), QUICKPLAY_STAR_IMAGE)
    perfect_song.paste(QUICKPLAY_STAR_IMAGE, (38, 44), QUICKPLAY_STAR_IMAGE)
    perfect_song.paste(QUICKPLAY_STAR_IMAGE, (48, 44), QUICKPLAY_STAR_IMAGE)
    perfect_song.save(f"Icons/Output/Core/Misc-PerfectSong.png")

    # This achievement couldn't be implemented.
    # secret_unlock_art = PILImage.open(f"Icons/Layers/Misc-Unlock.png")
    # secret_unlock_art.paste(BORDER, (0, 0), BORDER)
    # secret_unlock_art.save("Icons/Output/Core/Misc-SecretUnlock.png")

    for stars in ["100", "500", "1000", "2000", "3300"]:
        star_art = PILImage.open(f"Icons/Layers/Misc-Star-{stars}.png")
        star_art.paste(BORDER, (0, 0), BORDER)
        star_art.save(f"Icons/Output/Core/Misc-Star-{stars}.png")

if __name__ == "__main__":
    main()