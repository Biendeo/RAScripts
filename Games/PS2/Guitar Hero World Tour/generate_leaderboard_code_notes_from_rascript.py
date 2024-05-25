INSTRUMENT_GUITAR = 0xbdc53cf2
INSTRUMENT_BASS   = 0xcb9fb4cf
INSTRUMENT_DRUMS  = 0x5cc16cdf
INSTRUMENT_VOCALS = 0xe8e6adcb

SONG_ABOUT_A_GIRL_UNPLUGGED          = 0x6b450446
SONG_AGGRO                           = 0xb6e223bd
SONG_AMERICAN_WOMAN                  = 0x49e39403
SONG_ANTISOCIAL                      = 0x40667489
SONG_ARE_YOU_GONNA_GO_MY_WAY         = 0x72de2ea1
SONG_ASSASSIN                        = 0x43f02e5d
SONG_BAND_ON_THE_RUN                 = 0x57c4ea83
SONG_BEAT_IT                         = 0x69e63d11
SONG_BEAUTIFUL_DISASTER              = 0x75a03c4c
SONG_BYOB                            = 0x556d3ba8
SONG_CRAZY_TRAIN                     = 0x1ac0a35e
SONG_DAMMIT                          = 0x131e5f8b
SONG_DEMOLITION_MAN_LIVE             = 0x21cbdb83
SONG_DO_IT_AGAIN                     = 0xcaac63ee
SONG_ESCUELA_DE_CALOR                = 0x070e1406
SONG_EVERLONG                        = 0x4c96306a
SONG_EYE_OF_THE_TIGER                = 0x1dbd592c
SONG_FEEL_THE_PAIN                   = 0x1b2ab04b
SONG_FLOAT_ON                        = 0x76ac1d3e
SONG_FREAK_ON_A_LEASH                = 0x18c24fbd
SONG_GO_YOUR_OWN_WAY                 = 0x60258cf3
SONG_GOOD_GOD                        = 0x9f246021
SONG_HAIL_TO_THE_FREAKS              = 0x5ef8b521
SONG_HEARTBREAKER                    = 0x29153005
SONG_HEY_MAN_NICE_SHOT               = 0x84854299
SONG_HOLLYWOOD_NIGHTS                = 0x6667d8cc
SONG_HOT_FOR_TEACHER                 = 0x2c8ab742
SONG_HOTEL_CALIFORNIA                = 0xcf38d2c6
SONG_THE_JOKER                       = 0x0063001d
SONG_KICK_OUT_THE_JAMS               = 0x53bf09ed
SONG_THE_KILL                        = 0xe9ac28c6
SONG_LA_BAMBA                        = 0xa0346e3c
SONG_LAZY_EYE                        = 0xc5419334
SONG_LIVIN_ON_A_PRAYER               = 0x0e6e7e09
SONG_LOVE_ME_TWO_TIMES               = 0x5a7417c3
SONG_LOVE_REMOVAL_MACHINE            = 0xf991002d
SONG_LOVE_SPREADS                    = 0x2d285d4a
SONG_LVIA_LVIAQUEZ                   = 0x73b900fc
SONG_THE_MIDDLE                      = 0x417b1aa8
SONG_MISERY_BUSINESS                 = 0x2d1f51f8
SONG_MONSOON                         = 0x253cc15f
SONG_MOUNTAIN_SONG                   = 0x6bb15c5a
SONG_MR_CROWLEY                      = 0x3b0ffd7a
SONG_NEVER_TOO_LATE                  = 0xd3957287
SONG_NO_SLEEP_TILL_BROOKLYN          = 0x2e71081b
SONG_NUVOLE_E_LENZUOLA               = 0xb4be9de8
SONG_OBSTACLE_1                      = 0xc0892c0f
SONG_ON_THE_ROAD_AGAIN_LIVE          = 0xc6349673
SONG_ONE_ARMED_SCISSOR               = 0xad64fbc0
SONG_THE_ONE_I_LOVE                  = 0x66d86e76
SONG_ONE_WAY_OR_ANOTHER              = 0xcc3e758d
SONG_OUR_TRUTH                       = 0xfcc810fc
SONG_OVERKILL                        = 0xe1e8d3a3
SONG_PARABOLA                        = 0xd8adc290
SONG_PRETTY_VACANT                   = 0x78fcbefe
SONG_PRISONER_OF_SOCIETY             = 0x96a9143e
SONG_PULL_ME_UNDER                   = 0xf6e52535
SONG_PURPLE_HAZE_LIVE                = 0x237e9f01
SONG_RAMBLIN_MAN                     = 0x5418ab8a
SONG_REBEL_YELL                      = 0x921d18b1
SONG_RE_EDUCATION_THROUGH_LABOR      = 0xc6514ca6
SONG_ROOFTOPS_A_LIBERATION_BROADCAST = 0xa76357b3
SONG_SANTERIA                        = 0x7e68e3be
SONG_SATCH_BOOGIE                    = 0x7f8b13a8
SONG_SCHISM                          = 0x939c343d
SONG_SCREAM_AIM_FIRE                 = 0x230d6fa8
SONG_SHIVER                          = 0xda1a3e26
SONG_SOME_MIGHT_SAY                  = 0x28998ecf
SONG_SOUL_DOUBT                      = 0x451bb698
SONG_SPIDERWEBS                      = 0xbced2caa
SONG_STILLBORN                       = 0xa0bf33ce
SONG_STRANGLEHOLD                    = 0xbbbbae42
SONG_SWEET_HOME_ALABAMA_LIVE         = 0x7ffcb8ef
SONG_TED_NUGENT_GUITAR_DUEL          = 0x414daf80
SONG_TODAY                           = 0x4c2b593a
SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST     = 0xf2761b90
SONG_TOY_BOY                         = 0x5334bfbf
SONG_TRAPPED_UNDER_ICE               = 0x98f7d349
SONG_UP_AROUND_THE_BEND              = 0x3c00bb86
SONG_VICARIOUS                       = 0x31ee4a17
SONG_VINTERNOLL2                     = 0x89d79adb
SONG_WEAPON_OF_CHOICE                = 0xda66b156
SONG_WHAT_IVE_DONE                   = 0x41bd670a
SONG_THE_WIND_CRIES_MARY             = 0x9f2ef665
SONG_YOURE_GONNA_SAY_YEAH            = 0xfcd93cdc
SONG_ZAKK_WYLDE_GUITAR_DUEL          = 0x57d7b57f

with open("Guitar Hero World Tour.rascript", "r") as f:
    FIRST_LINE = "SONG_INFO = {\n"
    lines = f.readlines()
    start_line_index = lines.index(FIRST_LINE)
    end_line_index = lines.index("}\n", start_line_index)
    song_info_buffer = "".join(lines[start_line_index:end_line_index + 1])[len(FIRST_LINE) - 3:]
SONG_INFO = eval(song_info_buffer)

from dataclasses import dataclass
import sys
@dataclass
class Row:
    index: int
    title: str
    difficulty: str
    instrument: str
    
rows: dict[int, Row] = {}

for value in SONG_INFO.values():
    leaderboard_indices: dict[str, list[int]] = {
        "Band": value.get("BandLeaderboardIndices", []),
        "Guitar": value.get("Instruments", {}).get(INSTRUMENT_GUITAR, {}).get("LeaderboardIndices", []),
        "Bass": value.get("Instruments", {}).get(INSTRUMENT_BASS, {}).get("LeaderboardIndices", []),
        "Drums": value.get("Instruments", {}).get(INSTRUMENT_DRUMS, {}).get("LeaderboardIndices", []),
        "Vocals": value.get("Instruments", {}).get(INSTRUMENT_VOCALS, {}).get("LeaderboardIndices", []),
    }
    for instrument, indices in leaderboard_indices.items():
        if (
            not (value["Title"] == "Zakk Wylde Guitar Duel" and instrument != "Guitar")
            and not (value["Title"] == "Ted Nugent Guitar Duel" and instrument != "Guitar")
            and not (value["Title"] == "Satch Boogie" and instrument == "Vocals")
        ):
            if len(indices) != 5:
                print(f'Song {value["Title"]} only has {len(indices)} leaderboard entries for instrument {instrument}', file=sys.stderr)
            else:
                for i, index in enumerate(indices):
                    if rows.get(index, None) != None:
                        print(f'Index {index} is already occupied by {rows.get(index, None)}', file=sys.stderr)
                    else:
                        rows[index] = Row(index, value["Title"], ["Beginner", "Easy", "Medium", "Hard", "Expert"][i], instrument)

missing_indices = [x for x in range(0, 2250) if x not in rows.keys()]
if len(missing_indices):
    print(f'These indices weren\'t found: [{", ".join((str(x) for x in missing_indices))}]', file=sys.stderr)

LEADERBOARD_ADDR = 0x01b2d820
LEADERBOARD_LENGTH = 0x38
for index, row in sorted(rows.items(), key=lambda item: item[0]):
    postfix = r"\r\nThis spot marks the start of 2250 (!) leaderboard entries, each 56 bytes large. Each leaderboard tracks the Top Rockers details as well as the career mode details for this song + instrument + difficulty.\r\n0x00 - [12 bytes] [ASCII] Top Rocker Name 1\r\n0x0c - [12 bytes] [ASCII] Top Rocker Name 2\r\n0x18 - [12 bytes] [ASCII] Top Rocker Name 3\r\n0x24 - [24-bit] Top Rocker Score 1\r\n0x27 - [24-bit] Top Rocker Score 2\r\n0x2a - [24-bit] Top Rocker Score 3\r\n0x2d - [24-bit] Unused?\r\n0x30 - [8-bit] Unused?\r\n0x31 - [8-bit] Career Stars (0x60 = 3-star, 0x80 = 4-star, 0xa0 = 5-star)\r\n0x32 - [24-bit] Career score\r\n0x35 - [8-bit] Gold stars for 100% (0x01 is gold, 0x00 is normal)\r\n0x36 - [16-bit] Unsure?" if index == 0 else ""
    print(f'N0:{(LEADERBOARD_ADDR + (index * LEADERBOARD_LENGTH)):#010x}:"[56 bytes] Leaderboard - {row.title} - {row.instrument} - {row.difficulty}{postfix}"')