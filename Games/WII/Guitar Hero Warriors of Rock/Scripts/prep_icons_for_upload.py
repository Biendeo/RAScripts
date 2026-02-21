import os, json, requests, shutil, sys, uuid

from io import BytesIO
from typing import Any

from tqdm import tqdm

from PIL import Image, ImageChops

from constants import get_all_songs, get_all_custom_songs, normalize_song_title_for_file, INSTRUMENT_GUITAR, INSTRUMENT_DRUMS, INSTRUMENT_VOCALS, INSTRUMENT_BASS, SOURCE_GHWOR, SOURCE_GHWOR_DLC

songs = get_all_songs()
custom_songs = get_all_custom_songs()

INSTRUMENT_TO_NAME = {
    INSTRUMENT_GUITAR: "Guitar",
    INSTRUMENT_DRUMS: "Drums",
    INSTRUMENT_VOCALS: "Vocals",
    INSTRUMENT_BASS: "Bass"
}

MANUAL_ACHIEVEMENT_MAPPINGS = {
    574320: "Icons/Output/Core/Quest-Milestone-TheTrickster.png",
    574321: "Icons/Output/Core/Quest-Milestone-TheDynamo.png",
    574322: "Icons/Output/Core/Quest-Milestone-TheSiren.png",
    574323: "Icons/Output/Core/Quest-Milestone-TheRecluse.png",
    574324: "Icons/Output/Core/Quest-Milestone-AxeClaimer.png",
    574325: "Icons/Output/Core/Quest-Milestone-TheExalted.png",
    574326: "Icons/Output/Core/Quest-Milestone-TheBrute.png",
    574327: "Icons/Output/Core/Quest-Milestone-TheVigil.png",
    574328: "Icons/Output/Core/Quest-Milestone-TheEternal.png",
    574329: "Icons/Output/Core/Quest-Milestone-SaviorOfRock.png",
    574363: "Icons/Output/Core/Misc-PerfectSong.png",
    574364: "Icons/Output/Core/Misc-FiveStarCustom.png",
    574365: "Icons/Output/Core/Misc-Star-100.png",
    574366: "Icons/Output/Core/Misc-Star-500.png",
    574367: "Icons/Output/Core/Misc-Star-1000.png",
    574368: "Icons/Output/Core/Misc-Star-2000.png",
    574369: "Icons/Output/Core/Misc-Star-3300.png"
}

def main() -> None:
    if len(sys.argv) != 2:
        print("Pass the location of the GHWOR 34685.json file as the second argument.")
        sys.exit(1)
    with open(sys.argv[1], "r") as f:
        ra_info = json.load(f)

    achievement_mappings = get_song_achievement_mappings() | MANUAL_ACHIEVEMENT_MAPPINGS
    verify_icon_counts(achievement_mappings)
    verify_icons_exist(achievement_mappings)
    generate_user_text_and_files(achievement_mappings, ra_info)

def get_song_achievement_mappings() -> dict[int, str]:
    achievement_mappings: dict[int, str] = {}

    for song in songs:
        if song.Source == SOURCE_GHWOR:
            folder = "Core/"
        elif song.Source == SOURCE_GHWOR_DLC:
            folder = "DLC/"
        else:
            continue
        achievement_mappings[song.PowerChallengeAchievement.Metadata.Id] = f"Icons/Output/{folder}PowerChallenge-{normalize_song_title_for_file(song)}.png"
        achievement_mappings[song.FullBandFiveStarAchievementMetadata.Id] = f"Icons/Output/Co-Op/Quickplay-{normalize_song_title_for_file(song)}-Band.png"
        if song.QuestDominateAchievement and not song.QuestDominateAchievement.IsNull:
            achievement_mappings[song.QuestDominateAchievement.Value.Id] = f"Icons/Output/{folder}Quest-Song-{normalize_song_title_for_file(song)}.png"
        if song.VocalChallengeAchievement and not song.VocalChallengeAchievement.IsNull:
            achievement_mappings[song.VocalChallengeAchievement.Value.Metadata.Id] = f"Icons/Output/{folder}Quickplay-VocalChallenge-{normalize_song_title_for_file(song)}.png"
        for instrument in song.Instruments:
            if not instrument.FiveStarAchievementMetadata:
                print(f"{song.Title} - {INSTRUMENT_TO_NAME[instrument.Instrument]} does not have a Five Star Achievement metadata")
            else:
                achievement_mappings[instrument.FiveStarAchievementMetadata.Id] = f"Icons/Output/{folder}Quickplay-{normalize_song_title_for_file(song)}-{INSTRUMENT_TO_NAME[instrument.Instrument]}.png"
            if not instrument.FullComboAchievementMetadata:
                print(f"{song.Title} - {INSTRUMENT_TO_NAME[instrument.Instrument]} does not have a Full Combo Achievement metadata")
            else:
                achievement_mappings[instrument.FullComboAchievementMetadata.Id] = f"Icons/Output/FC/{normalize_song_title_for_file(song)}-{INSTRUMENT_TO_NAME[instrument.Instrument]}.png"

    for custom_song in custom_songs:
        achievement_mappings[custom_song.FullBandFiveStarAchievementMetadata.Id] = f"Icons/Output/Co-Op/CustomSong-{normalize_song_title_for_file(custom_song)}-Band.png"
        for instrument in custom_song.Instruments:
            if not instrument.FiveStarAchievementMetadata:
                print(f"{custom_song.Title} - {INSTRUMENT_TO_NAME[instrument.Instrument]} does not have a Five Star Achievement metadata")
            else:
                achievement_mappings[instrument.FiveStarAchievementMetadata.Id] = f"Icons/Output/Core/CustomSong-{normalize_song_title_for_file(custom_song)}-{INSTRUMENT_TO_NAME[instrument.Instrument]}.png"
            if not instrument.FullComboAchievementMetadata:
                print(f"{custom_song.Title} - {INSTRUMENT_TO_NAME[instrument.Instrument]} does not have a Full Combo Achievement metadata")
            else:
                achievement_mappings[instrument.FullComboAchievementMetadata.Id] = f"Icons/Output/FC/CustomSong-{normalize_song_title_for_file(custom_song)}-{INSTRUMENT_TO_NAME[instrument.Instrument]}.png"

    return achievement_mappings

def verify_icon_counts(achievement_mappings: dict[int, str]) -> None:
    EXPECTED_ICON_COUNTS = {
        "Icons/Output/Core": 634,
        "Icons/Output/DLC": 414,
        "Icons/Output/Co-Op": 181,
        "Icons/Output/FC": 706,
    }

    for start, count in EXPECTED_ICON_COUNTS.items():
        icons_that_start_with_path = [path for path in achievement_mappings.values() if path.startswith(start)]
        if len(icons_that_start_with_path) != count:
            print(f"Expected {count} icons that start with {start} but found only {len(icons_that_start_with_path)}")
            sys.exit(1)

def verify_icons_exist(achievement_mappings: dict[int, str]) -> None:
    for path in achievement_mappings.values():
        if not os.path.isfile(path):
            print(f"Icon {path} does not exist, re-run generate_icons.py!")
            sys.exit(1)

def generate_user_text_and_files(achievement_mappings: dict[int, str], ra_info: dict[str, Any]) -> None:
    os.makedirs("Icons/local", exist_ok=True)
    text_to_copy: list[str] = []
    all_achievements = [a for s in ra_info["Sets"] for a in s["Achievements"]]
    for id, path in tqdm(achievement_mappings.items()):
        if not path.startswith("Icons/Output/FC"):
            continue
        matching_achievements = [a for a in all_achievements if a["ID"] == id]
        if len(matching_achievements) != 1:
            tqdm.write(f"Achievement {id} could not be found!?")
            sys.exit(1)
        original_achievement = [a for a in all_achievements if a["ID"] == id][0]

        if original_achievement["BadgeURL"] != "https://media.retroachievements.org/Badge/00000.png":
            # Verify the new icon is any different.
            response = requests.get(original_achievement["BadgeURL"], headers={"User-Agent": "Biendeo - I'm figuring if any GHWOR icons need updating"})
            server_image = Image.open(BytesIO(response.content)).convert("RGB")
            local_iamge = Image.open(path).convert("RGB")
            if not ImageChops.difference(server_image, local_iamge).getbbox():
                tqdm.write(f"{original_achievement["BadgeURL"]} is identical to {path}, skipping...")
                continue
        new_id = str(uuid.uuid4())
        shutil.copyfile(path, f"Icons/local/{new_id}.png")
        text_to_copy.append(f"{id}:\"{original_achievement["MemAddr"]}\":\"{original_achievement["Title"]}\":\"{original_achievement["Description"].replace("\"", "\\\"")}\"::::{original_achievement["Author"]}:{original_achievement["Points"]}:::::local\\{new_id}.png")
    print("Writing to out.txt")
    with open("out.txt", "w") as f:
        for line in text_to_copy:
            f.write(f"{line}\n")

if __name__ == "__main__":
    main()