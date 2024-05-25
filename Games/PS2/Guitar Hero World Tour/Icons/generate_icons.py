from PIL import Image, ImageFilter

SONGS = [
    "AboutAGirlUnplugged",
    "Aggro",
    "AmericanWoman",
    "Antisocial",
    "AreYouGonnaGoMyWay",
    "Assassin",
    "BandOnTheRun",
    "BeatIt",
    "BeautifulDisaster",
    "BYOB",
    "CrazyTrain",
    "Dammit",
    "DemolitionManLive",
    "DoItAgain",
    "EscuelaDeCalor",
    "Everlong",
    "EyeOfTheTiger",
    "FeelThePain",
    "FloatOn",
    "FreakOnALeash",
    "GoYourOwnWay",
    "GoodGod",
    "HailToTheFreaks",
    "HeartBreaker",
    "HeyManNiceShot",
    "HollywoodNights",
    "HotForTeacher",
    "HotelCalifornia",
    "TheJoker",
    "KickOutTheJams",
    "TheKill",
    "LaBamba",
    "LazyEye",
    "LivinOnAPrayer",
    "LoveMeTwoTimes",
    "LoveRemovalMachine",
    "LoveSpreads",
    "LViaLViaquez",
    "TheMiddle",
    "MiseryBusiness",
    "Monsoon",
    "MountainSong",
    "MrCrowley",
    "NeverTooLate",
    "NoSleepTillBrooklyn",
    "NuvoleELenzuola",
    "Obstacle1",
    "OnTheRoadAgainLive",
    "OneArmedScissor",
    "TheOneILove",
    "OneWayOrAnother",
    "OurTruth",
    "Overkill",
    "Parabola",
    "PrettyVacant",
    "PrisonerOfSociety",
    "PullMeUnder",
    "PurpleHazeLive",
    "RamblinMan",
    "RebelYell",
    "ReEducationThroughLabor",
    "RooftopsALiberationBroadcast",
    "Santeria",
    "SatchBoogie",
    "Schism",
    "ScreamAimFire",
    "Shiver",
    "SomeMightSay",
    "SoulDoubt",
    "Spiderwebs",
    "Stillborn",
    "Stranglehold",
    "SweetHomeAlabamaLive",
    "TedNugentGuitarDuel",
    "Today",
    "TooMuchTooYoungTooFast",
    "ToyBoy",
    "TrappedUnderIce",
    "UpAroundTheBend",
    "Vicarious",
    "Vinternoll2",
    "WeaponOfChoice",
    "WhatIveDone",
    "TheWindCriesMary",
    "YoureGonnaSayYeah",
    "ZakkWyldeGuitarDuel"
]

INSTRUMENTS = {
    "Guitar": [0.9, 0.5, 0.5, 1.0],
    "Bass": [0.5, 0.9, 0.5, 1.0],
    "Drums": [0.5, 0.5, 0.9, 1.0],
    "Vocals": [0.9, 0.9, 0.5, 1.0]
}

GIGS = [
    ("PhiPsiKappa", 0),
    ("WiltedOrchid", 0),
    ("BoneChurch", 0),
    ("PangTangBay", 0),
    ("AmoebaRecords", 0),
    ("Tool", 0),
    ("SwampShack", 1),
    ("RockBrigade", 0),
    ("StruttersFarm", 0),
    ("HouseOfBlues", 0),
    ("SwampShack", 2),
    ("WillHeilmsKeep", 1),
    ("WillHeilmsKeep", 2),
    ("ATnTPark", 0),
    ("Ozzfest", 1),
    ("Ozzfest", 2),
    ("TimesSquare", 0),
    ("SunnasChariot", 0)
]

DUAL_INSTRUMENT_ACHIEVEMENTS = {
    "AboutAGirlUnplugged": "Guitar",
    "BandOnTheRun": "Bass",
    "DemolitionManLive": "Bass",
    "Everlong": "Guitar",
    "HotelCalifornia": "Drums",
    "Overkill": "Bass",
    "PurpleHazeLive": "Guitar",
    "Stillborn": "Guitar",
    "Today": "Guitar",
    "TrappedUnderIce": "Guitar",
    "TheWindCriesMary": "Guitar"
}

CUSTOM_SONGS = [
    "Amazing",
    "Bee",
    "Bouree",
    "FurElise",
    "FutureFreak",
    "Greensleeves",
    "ILikeDirt",
    "JamAndToast",
    "LaNoche",
    "LaserBop",
    "MapleLeaf",
    "Porto",
    "RajaFunshine",
    "RockHop",
    "Rondo",
    "StarSpangled",
    "YandZ"
]

BORDER = Image.open("Icons/Layers/Border.png")


def main() -> None:
    generate_song_achievements()
    generate_gig_achievements()
    generate_career_rank_achievements()
    generate_dual_instrument_achievements()
    generate_custom_song_achievements()
    generate_misc_achievements()

def multiply_image(image: Image, r: float, g: float, b: float, a: float) -> Image:
    rc, gc, bc, ac = image.split()
    return Image.merge("RGBA", (
        rc.point(lambda z: z * r),
        gc.point(lambda z: z * g),
        bc.point(lambda z: z * b),
        ac.point(lambda z: z * a)
    ))

def add_shadow(image: Image) -> Image:
    shadow_radius = 2
    new_image = Image.new("RGBA", (image.size[0] + shadow_radius + shadow_radius, image.size[1] + shadow_radius + shadow_radius), "#00000000")
    new_image.paste(image, (shadow_radius, shadow_radius), image)
    new_image = multiply_image(new_image, 0, 0, 0, 1)
    new_image = new_image.filter(ImageFilter.BoxBlur(shadow_radius))
    new_image.paste(image, (shadow_radius, shadow_radius), image)
    return new_image

def add_border(image: Image) -> Image:
    border_radius = 1
    new_image = image.resize((image.size[0] + border_radius + border_radius, image.size[1] + border_radius + border_radius))
    new_image = multiply_image(new_image, 0, 0, 0, 1)
    new_image.paste(image, (border_radius, border_radius), image)
    return new_image

def generate_song_achievements() -> None:
    expert_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((24, 24))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    star_image = Image.open(f"Icons/Layers/Star.png")
    star_image = add_border(star_image)
    star_image = add_shadow(star_image)
    for song in SONGS:
        for instrument, color in INSTRUMENTS.items():
            if not (
                (song == "ZakkWyldeGuitarDuel" and instrument != "Guitar")
                    or (song == "TedNugentGuitarDuel" and instrument != "Guitar")
                    or (song == "SatchBoogie" and instrument == "Vocals")
            ):
                album_art = Image.open(f"Icons/Layers/Song-{song}.png")
                album_art.paste(BORDER, (0, 0), BORDER)
                instrument_image = Image.open(f"Icons/Layers/Instrument-{instrument}.png")
                instrument_image = instrument_image.resize((24, 24))
                instrument_image = multiply_image(instrument_image.resize((24, 24)), color[0], color[1], color[2], color[3])
                instrument_image = add_shadow(instrument_image)
                album_art.paste(instrument_image, (-2, -2), instrument_image)
                album_art.paste(expert_difficulty_image, (38, -2), expert_difficulty_image)
                album_art.paste(star_image, (-2, 44), star_image)
                album_art.paste(star_image, (10, 44), star_image)
                album_art.paste(star_image, (22, 44), star_image)
                album_art.paste(star_image, (34, 44), star_image)
                album_art.paste(star_image, (46, 44), star_image)
                album_art.save(f"Icons/Output/FiveStar-{song}-{instrument}.png")

def generate_gig_achievements() -> None:
    easy_difficulty_image = Image.open(f"Icons/Layers/Career-Clear-Easy.png")
    easy_difficulty_image = easy_difficulty_image.resize((32, 32))
    easy_difficulty_image = add_shadow(easy_difficulty_image)
    expert_difficulty_image = Image.open(f"Icons/Layers/Career-Clear-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((32, 32))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    for gig in GIGS:
        for instrument, color in INSTRUMENTS.items():
            gig_art = Image.open(f"Icons/Layers/Gig-{gig[0]}.png")
            gig_name = gig[0] if gig[1] == 0 else f"{gig[0]}-{gig[1]}"
            gig_art.paste(BORDER, (0, 0), BORDER)
            instrument_image = Image.open(f"Icons/Layers/Instrument-{instrument}.png")
            instrument_image = instrument_image.resize((24, 24))
            instrument_image = multiply_image(instrument_image.resize((24, 24)), color[0], color[1], color[2], color[3])
            instrument_image = add_shadow(instrument_image)
            gig_art.paste(instrument_image, (2, 2), instrument_image)
            if gig[1] == 1:
                one_image = Image.open(f"Icons/Layers/Font-1.png")
                one_image = add_border(one_image)
                one_image = add_shadow(one_image)
                gig_art.paste(one_image, (36, 1), one_image)
            elif gig[1] == 2:
                two_image = Image.open(f"Icons/Layers/Font-2.png")
                two_image = add_border(two_image)
                two_image = add_shadow(two_image)
                gig_art.paste(two_image, (36, 1), two_image)
            easy_gig_art = gig_art.copy()
            easy_gig_art.paste(easy_difficulty_image, (26, 26), easy_difficulty_image)
            easy_gig_art.save(f"Icons/Output/Gig-{gig_name}-{instrument}-Easy.png")
            expert_gig_art = gig_art.copy()
            expert_gig_art.paste(expert_difficulty_image, (26, 26), expert_difficulty_image)
            expert_gig_art.save(f"Icons/Output/Gig-{gig_name}-{instrument}-Expert.png")

def generate_career_rank_achievements() -> None:
    for rank in range(2, 52):
        new_image = Image.new("RGBA", (64, 64), color="#534e4e")
        rank_image = Image.open(f"Icons/Layers/Rank-{rank:02}.png")
        if rank == 51:
            new_image.paste(rank_image, (0, 0), rank_image)
            new_image.paste(BORDER, (0, 0), BORDER)
        else:
            new_image.paste(BORDER, (0, 0), BORDER)
            new_image.paste(rank_image, (0, 0), rank_image)
        new_image.save(f"Icons/Output/Rank-{rank:02}.png")

def generate_dual_instrument_achievements() -> None:
    expert_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((24, 24))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    star_image = Image.open(f"Icons/Layers/Star.png")
    star_image = add_border(star_image)
    star_image = add_shadow(star_image)
    vocals_image = Image.open(f"Icons/Layers/Instrument-Vocals.png")
    vocals_image = vocals_image.resize((24, 24))
    vocals_image = multiply_image(vocals_image.resize((24, 24)), INSTRUMENTS["Vocals"][0], INSTRUMENTS["Vocals"][1], INSTRUMENTS["Vocals"][2], INSTRUMENTS["Vocals"][3])
    vocals_image = add_shadow(vocals_image)
    for song, instrument in DUAL_INSTRUMENT_ACHIEVEMENTS.items():
        album_art = Image.open(f"Icons/Layers/Song-{song}.png")
        album_art.paste(BORDER, (0, 0), BORDER)
        album_art.paste(vocals_image, (18, -2), vocals_image)
        instrument_image = Image.open(f"Icons/Layers/Instrument-{instrument}.png")
        instrument_image = instrument_image.resize((24, 24))
        instrument_image = multiply_image(instrument_image.resize((24, 24)), INSTRUMENTS[instrument][0], INSTRUMENTS[instrument][1], INSTRUMENTS[instrument][2], INSTRUMENTS[instrument][3])
        instrument_image = add_shadow(instrument_image)
        album_art.paste(instrument_image, (-2, -2), instrument_image)
        album_art.paste(expert_difficulty_image, (38, -2), expert_difficulty_image)
        album_art.paste(star_image, (-2, 44), star_image)
        album_art.paste(star_image, (10, 44), star_image)
        album_art.paste(star_image, (22, 44), star_image)
        album_art.paste(star_image, (34, 44), star_image)
        album_art.paste(star_image, (46, 44), star_image)
        album_art.save(f"Icons/Output/FiveStar-{song}-Dual.png")

def generate_custom_song_achievements() -> None:
    expert_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((24, 24))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    star_image = Image.open(f"Icons/Layers/Star.png")
    star_image = add_border(star_image)
    star_image = add_shadow(star_image)
    for song in CUSTOM_SONGS:
        for instrument, color in INSTRUMENTS.items():
            if instrument != "Vocals":
                album_art = Image.open(f"Icons/Layers/CustomSong-{song}.png")
                album_art.paste(BORDER, (0, 0), BORDER)
                instrument_image = Image.open(f"Icons/Layers/Instrument-{instrument}.png")
                instrument_image = instrument_image.resize((24, 24))
                instrument_image = multiply_image(instrument_image.resize((24, 24)), color[0], color[1], color[2], color[3])
                instrument_image = add_shadow(instrument_image)
                album_art.paste(instrument_image, (-2, -2), instrument_image)
                album_art.paste(expert_difficulty_image, (38, -2), expert_difficulty_image)
                album_art.paste(star_image, (-2, 44), star_image)
                album_art.paste(star_image, (10, 44), star_image)
                album_art.paste(star_image, (22, 44), star_image)
                album_art.paste(star_image, (34, 44), star_image)
                album_art.paste(star_image, (46, 44), star_image)
                album_art.save(f"Icons/Output/FiveStarCustom-{song}-{instrument}.png")

def generate_misc_achievements() -> None:
    generate_john_cage_performance_achievement()
    generate_failed_dammit_achievement()
    generate_golden_performance_achievement()
    generate_midi_master_achievement()
    generate_modern_day_mozart_achievement()

def generate_john_cage_performance_achievement() -> None:
    beginner_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Beginner.png")
    beginner_difficulty_image = beginner_difficulty_image.resize((24, 24))
    beginner_difficulty_image = add_shadow(beginner_difficulty_image)
    lt_image = Image.open(f"Icons/Layers/Font-LT.png")
    lt_image = lt_image.resize((lt_image.size[0] * 3 // 4, lt_image.size[1] * 3 // 4))
    lt_image = add_border(lt_image)
    lt_image = add_shadow(lt_image)
    one_image = Image.open(f"Icons/Layers/Font-1.png")
    one_image = one_image.resize((one_image.size[0] * 3 // 4, one_image.size[1] * 3 // 4))
    one_image = add_border(one_image)
    one_image = add_shadow(one_image)
    zero_image = Image.open(f"Icons/Layers/Font-0.png")
    zero_image = zero_image.resize((zero_image.size[0] * 3 // 4, zero_image.size[1] * 3 // 4))
    zero_image = add_border(zero_image)
    zero_image = add_shadow(zero_image)
    image = Image.open(f"Icons/Layers/ActionPose-Drums.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.paste(beginner_difficulty_image, (38, -2), beginner_difficulty_image)
    image.paste(lt_image, (-2, 38), lt_image)
    image.paste(one_image, (11, 38), one_image)
    image.paste(zero_image, (22, 38), zero_image)
    image.paste(zero_image, (34, 38), zero_image)
    image.paste(zero_image, (46, 38), zero_image)
    image.save(f"Icons/Output/Misc-LowScoreBeginner.png")

def generate_failed_dammit_achievement() -> None:
    image = Image.open(f"Icons/Layers/Background-FailedDammit.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.save(f"Icons/Output/Misc-FailedDammit.png")

def generate_golden_performance_achievement() -> None:
    hard_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Hard.png")
    hard_difficulty_image = hard_difficulty_image.resize((24, 24))
    hard_difficulty_image = add_shadow(hard_difficulty_image)
    expert_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((24, 24))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    star_image = Image.open(f"Icons/Layers/Star.png")
    star_image = multiply_image(star_image, 0.9, 0.8, 0.3, 1.000)
    star_image = add_border(star_image)
    star_image = add_shadow(star_image)
    image = Image.open(f"Icons/Layers/ActionPose-Guitar.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.paste(hard_difficulty_image, (-2, -2), hard_difficulty_image)
    image.paste(expert_difficulty_image, (38, -2), expert_difficulty_image)
    image.paste(star_image, (-2, 44), star_image)
    image.paste(star_image, (10, 44), star_image)
    image.paste(star_image, (22, 44), star_image)
    image.paste(star_image, (34, 44), star_image)
    image.paste(star_image, (46, 44), star_image)
    image.save(f"Icons/Output/Misc-100AnySong.png")

def generate_midi_master_achievement() -> None:
    expert_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((24, 24))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    star_image = Image.open(f"Icons/Layers/Star.png")
    star_image = multiply_image(star_image, 0.9, 0.8, 0.3, 1.000)
    star_image = add_border(star_image)
    star_image = add_shadow(star_image)
    image = Image.open(f"Icons/Layers/ActionPose-Vocals.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.paste(expert_difficulty_image, (38, -2), expert_difficulty_image)
    image.paste(star_image, (-2, 44), star_image)
    image.paste(star_image, (10, 44), star_image)
    image.paste(star_image, (22, 44), star_image)
    image.paste(star_image, (34, 44), star_image)
    image.paste(star_image, (46, 44), star_image)
    image.save(f"Icons/Output/Misc-FCVocalsCustomSong.png")

def generate_modern_day_mozart_achievement() -> None:
    expert_difficulty_image = Image.open(f"Icons/Layers/Difficulty-Expert.png")
    expert_difficulty_image = expert_difficulty_image.resize((24, 24))
    expert_difficulty_image = add_shadow(expert_difficulty_image)
    star_image = Image.open(f"Icons/Layers/Star.png")
    star_image = add_border(star_image)
    star_image = add_shadow(star_image)
    image = Image.open(f"Icons/Layers/Background-Studio.png")
    image.paste(BORDER, (0, 0), BORDER)
    image.paste(expert_difficulty_image, (38, -2), expert_difficulty_image)
    image.paste(star_image, (-2, 44), star_image)
    image.paste(star_image, (10, 44), star_image)
    image.paste(star_image, (22, 44), star_image)
    image.paste(star_image, (34, 44), star_image)
    image.paste(star_image, (46, 44), star_image)
    image.save(f"Icons/Output/Misc-FiveStarOriginalSong.png")

if __name__ == "__main__":
    main()