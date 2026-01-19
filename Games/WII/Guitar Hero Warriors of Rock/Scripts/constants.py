from dataclasses import dataclass
import re
from typing import Optional, TypeVar

INSTRUMENT_GUITAR = 0xbdc53cf2
INSTRUMENT_BASS   = 0xcb9fb4cf
INSTRUMENT_DRUMS  = 0x5cc16cdf
INSTRUMENT_VOCALS = 0xe8e6adcb

SOURCE_GHWOR     = 0
SOURCE_GHWOR_DLC = 1
SOURCE_GH5       = 2
SOURCE_GH5_DLC   = 3
SOURCE_GHWT      = 4
SOURCE_GHWT_DLC  = 5
SOURCE_GHM       = 6
SOURCE_GHSH      = 7
SOURCE_BH        = 8

T = TypeVar("T")

@dataclass
class Nullable[T]:
    IsNull: bool
    Value: T

@dataclass
class AchievementMetadata:
    Title: str = ""
    Id: int = -1
    Points: int = -1

@dataclass
class StarChallengeAchievementMetadata:
    ChallengeIndicies: list[int]
    Metadata: Optional[AchievementMetadata] = None

@dataclass
class InstrumentMetadata:
    Instrument: int
    ExpertNotesInChart: int
    ExpertBaseScore: int
    ExpertPlusAvailable: bool = False
    FiveStarAchievementMetadata: Optional[AchievementMetadata] = None
    FullComboAchievementMetadata: Optional[AchievementMetadata] = None
    StarChallengeAchievement: Optional[StarChallengeAchievementMetadata] = None
    QuickplayLeaderboardId: Optional[int] = None
    FourPowerQuestLeaderboardId: Optional[int] = None
    DominateQuestLeaderboardId: Optional[int] = None
    PowerChallengeScoreLeaderboardId: Optional[int] = None
    PowerChallengeStarLeaderboardId: Optional[int] = None

@dataclass
class PowerChallengeAchievementMetadata:
    StarTarget: int
    Metadata: AchievementMetadata

@dataclass
class VocalChallengeAchievementMetadata:
    Instrument: int = -1
    LeaderboardId: int = -1
    Metadata: Optional[AchievementMetadata] = None

@dataclass
class Song:
    Title: str
    Artist: str
    Source: int
    Id: int
    AudioFileName: str
    Instruments: list[InstrumentMetadata]
    QuickplayDetailsAddr: int = -1
    AlbumArt: str = ""
    Caption: str = ""
    FullBandFiveStarAchievementMetadata: Optional[AchievementMetadata] = None
    FullBandLeaderboardId: int = -1
    PowerChallengeAchievement: Optional[PowerChallengeAchievementMetadata] = None
    QuestDominateAchievement: Optional[Nullable[AchievementMetadata]] = None
    VocalChallengeAchievement: Optional[Nullable[VocalChallengeAchievementMetadata]] = None
    
def get_all_songs() -> list[Song]:
    with open("Guitar Hero Warriors of Rock.rascript", "r") as f:
        lines = f.readlines()
        FIRST_LINE = "GHWOR_SONGS = [\n"
        start_line_index = lines.index(FIRST_LINE)
        end_line_index = lines.index("SONGS = []\n", start_line_index)
        song_info_buffer = lines[start_line_index:end_line_index]

    songs: list[Song] = []
    current_buffer = ""
    REMOVE_BEGINNING_OF_ARRAY_REGEX = re.compile(r"^([A-Z0-9_]+ = )")
    REMOVE_COMMENTS_REGEX = re.compile(r"( \/\/.+)$")
    REPLACE_TRUE_SPACE_REGEX = re.compile(r"( true)")
    REPLACE_FALSE_SPACE_REGEX = re.compile(r"( false)")
    REPLACE_TRUE_BRACKET_REGEX = re.compile(r"(\(true)")
    REPLACE_FALSE_BRACKET_REGEX = re.compile(r"(\(false)")

    for line in song_info_buffer:
        line = re.sub(REMOVE_BEGINNING_OF_ARRAY_REGEX, "", line)
        line = re.sub(REMOVE_COMMENTS_REGEX, "", line)
        line = re.sub(REPLACE_TRUE_SPACE_REGEX, " True", line)
        line = re.sub(REPLACE_FALSE_SPACE_REGEX, " False", line)
        line = re.sub(REPLACE_TRUE_BRACKET_REGEX, "(True", line)
        line = re.sub(REPLACE_FALSE_BRACKET_REGEX, "(False", line)
        current_buffer += line
        if line == "\n":
            songs += eval("".join(current_buffer))
            current_buffer = ""
               
    return songs

NORMALIZED_SONG_RE = re.compile(r":|-|\.|,|\(|\)| |\?|'|\"")

def normalize_song_title_for_file(song: Song) -> str:
    return NORMALIZED_SONG_RE.sub("", song.Title).replace("ï", "i")