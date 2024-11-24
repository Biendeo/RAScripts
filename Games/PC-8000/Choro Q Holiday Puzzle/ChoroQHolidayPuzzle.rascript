// Choro Q Holiday Puzzle
// #ID = 14928

GAME_STATE_DIFFICULTY_SELECT = 0x01
GAME_STATE_ABOUT_TO_START = 0x02
GAME_STATE_IN_GAME = 0x03
GAME_STATE_TIME_OUT = 0x04
GAME_STATE_MOVING_TO_CLEAR = 0x05
GAME_STATE_TRY_AGAIN = 0x0d
GAME_STATE_CLEAR_BEGINNER = 0x0f
GAME_STATE_CLEAR_JUNIOR = 0x11
GAME_STATE_CLEAR_SENIOR = 0x12
GAME_STATE_CLEAR_PROFESSIONAL = 0x14

GAME_STATE_ADDR = 0x9334
function game_state() => byte(GAME_STATE_ADDR)

DIFFICULTY_BEGINNER = 0x00
DIFFICULTY_JUNIOR = 0x01
DIFFICULTY_SENIOR = 0x02
DIFFICULTY_PROFESSIONAL = 0x03

PUZZLE_WIDTH_TO_DIFFICULTY = {
    3: DIFFICULTY_BEGINNER,
    4: DIFFICULTY_JUNIOR,
    5: DIFFICULTY_SENIOR,
    6: DIFFICULTY_PROFESSIONAL,
}
DIFFICULTY_TO_PUZZLE_WIDTH = {}
for width in PUZZLE_WIDTH_TO_DIFFICULTY {
    DIFFICULTY_TO_PUZZLE_WIDTH[PUZZLE_WIDTH_TO_DIFFICULTY[width]] = width
}

DIFFICULTY_TO_NAME = {
    DIFFICULTY_BEGINNER: "Beginner",
    DIFFICULTY_JUNIOR: "Junior",
    DIFFICULTY_SENIOR: "Senior",
    DIFFICULTY_PROFESSIONAL: "Professional"
}

DIFFICULTY_TO_CLEAR_STATE = {
    DIFFICULTY_BEGINNER: GAME_STATE_CLEAR_BEGINNER,
    DIFFICULTY_JUNIOR: GAME_STATE_CLEAR_JUNIOR,
    DIFFICULTY_SENIOR: GAME_STATE_CLEAR_SENIOR,
    DIFFICULTY_PROFESSIONAL: GAME_STATE_CLEAR_PROFESSIONAL
}

PUZZLE_WIDTH_TO_DIFFICULTY_NAME = {}
for width in PUZZLE_WIDTH_TO_DIFFICULTY {
    PUZZLE_WIDTH_TO_DIFFICULTY_NAME[width] = DIFFICULTY_TO_NAME[PUZZLE_WIDTH_TO_DIFFICULTY[width]]
}

PUZZLE_WIDTH_ADDR = 0x9359
function puzzle_width() => byte(PUZZLE_WIDTH_ADDR)

COLOR_BLUE = 0x00
COLOR_RED = 0x01
COLOR_GREEN = 0x02

TILE_START_ADDR = {
    COLOR_BLUE: 0x938b,
    COLOR_RED: 0x93d3,
    COLOR_GREEN: 0x941b,
}
BLUE_TILE_START_ADDR = 0x938b
RED_TILE_START_ADDR = 0x93d3
GREEN_TILE_START_ADDR = 0x941b

// The Rich Presence mapping needs an integer here.
function is_tile_correct_int(color, index) => byte(TILE_START_ADDR[color] + 2 * index) - index

CORRECT_TILE_RP_CHAR = {
    0: "#"
}

function did_puzzle_get_solved(difficulty) {
    target_width = DIFFICULTY_TO_PUZZLE_WIDTH[difficulty]
    return
        puzzle_width() == DIFFICULTY_TO_PUZZLE_WIDTH[difficulty]
            && prev(game_state()) == GAME_STATE_IN_GAME
            && game_state() == GAME_STATE_MOVING_TO_CLEAR
}

ACHIEVEMENT_INFO = [
    {
        "Difficulty": DIFFICULTY_BEGINNER,
        "SpeedyTimeSeconds": 120,
        "ClearTitle": "The Only Sliding We're Doing",
        "SpeedyTitle": "Switch to Power Transmission",
        "ClearPoints": 2,
        "SpeedyPoints": 2,
        "ClearId": 479319,
        "SpeedyId": 479320,
        "LeaderboardId": 121420
    },
    {
        "Difficulty": DIFFICULTY_JUNIOR,
        "SpeedyTimeSeconds": 600,
        "ClearTitle": "The Princess of Peach Town",
        "SpeedyTitle": "Bearer of Big Tires",
        "ClearPoints": 4,
        "SpeedyPoints": 4,
        "ClearId": 479321,
        "SpeedyId": 479322,
        "LeaderboardId": 121421
    },
    {
        "Difficulty": DIFFICULTY_SENIOR,
        "SpeedyTimeSeconds": 1200,
        "ClearTitle": "The Depths of Blue Lake",
        "SpeedyTitle": "Jet Turbine Weilder",
        "ClearPoints": 10,
        "SpeedyPoints": 10,
        "ClearId": 479323,
        "SpeedyId": 479324,
        "LeaderboardId": 121422
    },
    {
        "Difficulty": DIFFICULTY_PROFESSIONAL,
        "SpeedyTimeSeconds": 1800,
        "ClearTitle": "Body Choro-Q000",
        "SpeedyTitle": "Owner of a Devil Engine",
        "ClearPoints": 25,
        "SpeedyPoints": 25,
        "ClearId": 479325,
        "SpeedyId": 479326,
        "LeaderboardId": 121423
    }
]

for achievement in ACHIEVEMENT_INFO {
    achievement(
        title = achievement["ClearTitle"],
        points = achievement["ClearPoints"],
        id = achievement["ClearId"],
        description = format("Solve the puzzle on {0} difficulty", DIFFICULTY_TO_NAME[achievement["Difficulty"]]),
        trigger = did_puzzle_get_solved(achievement["Difficulty"])
            && disable_when(
                game_state() == GAME_STATE_TIME_OUT,
                until=(
                    game_state() == GAME_STATE_ABOUT_TO_START
                )
            ),
        type = "progression"
    )
    achievement(
        title = achievement["SpeedyTitle"],
        points = achievement["SpeedyPoints"],
        id = achievement["SpeedyId"],
        description = format("Quickly solve the puzzle on {0} difficulty in {1} seconds", DIFFICULTY_TO_NAME[achievement["Difficulty"]], achievement["SpeedyTimeSeconds"]),
        trigger = did_puzzle_get_solved(achievement["Difficulty"])
            && disable_when(
                repeated(
                    achievement["SpeedyTimeSeconds"] * 60,
                    game_state() == GAME_STATE_IN_GAME
                )
                    || game_state() == GAME_STATE_TIME_OUT,
                until=(
                    game_state() == GAME_STATE_ABOUT_TO_START
                )
            )
    )
    leaderboard(
        title = format("{0} - Quickest Time", DIFFICULTY_TO_NAME[achievement["Difficulty"]]),
        description = format("Solve the puzzle on {0} difficulty in the quickest time", DIFFICULTY_TO_NAME[achievement["Difficulty"]]),
        id = achievement["LeaderboardId"],
        start = prev(game_state()) == GAME_STATE_ABOUT_TO_START && game_state() == GAME_STATE_IN_GAME && puzzle_width() == DIFFICULTY_TO_PUZZLE_WIDTH[achievement["Difficulty"]],
        cancel = (
            game_state() != GAME_STATE_IN_GAME
                && game_state() != GAME_STATE_MOVING_TO_CLEAR
        ),
        submit = did_puzzle_get_solved(achievement["Difficulty"]),
        value = measured(tally(0, game_state() == GAME_STATE_IN_GAME)),
        format = "FRAMES",
        lower_is_better = true
    )
}

CURRENT_COLOR_ADDR = 0x936b
function current_color() => byte(CURRENT_COLOR_ADDR)

achievement(
    title = "RGB Is All I See",
    points = 5,
    id = 479327,
    description = "Solve the puzzle on Junior difficulty or higher by only switching colors twice (i.e. solve each color entirely before moving on)",
    trigger = (
        prev(game_state()) == GAME_STATE_IN_GAME
            && puzzle_width() != DIFFICULTY_TO_PUZZLE_WIDTH[DIFFICULTY_BEGINNER]
            && disable_when(
                repeated(5, prev(current_color()) != current_color()) // The game starts with two hits onto the color immediately, so the player can change color two more times.
                    || game_state() == GAME_STATE_TIME_OUT,
                until=(
                    game_state() == GAME_STATE_ABOUT_TO_START
                )
            )
            && trigger_when(
                did_puzzle_get_solved(DIFFICULTY_JUNIOR)
                    || did_puzzle_get_solved(DIFFICULTY_SENIOR)
                    || did_puzzle_get_solved(DIFFICULTY_PROFESSIONAL)
            )
    )
)

rich_presence_conditional_display(
    game_state() == GAME_STATE_DIFFICULTY_SELECT,
    "Choosing a difficulty level"
)
rich_presence_conditional_display(
    game_state() == GAME_STATE_ABOUT_TO_START,
    "Observing the puzzle on {0} difficulty",
    rich_presence_lookup("PuzzleWidthToDifficultyName", puzzle_width(), PUZZLE_WIDTH_TO_DIFFICULTY_NAME, "???")
)
// See generate_rp_text.py for generating this.
rich_presence_conditional_display(
    game_state() == GAME_STATE_IN_GAME && puzzle_width() == 3,
    "Sliding on Beginner difficulty - Correct Tiles: Blue {0}{1}{2}/{3}{4}{5}/{6}{7}{8}, Red {9}{10}{11}/{12}{13}{14}/{15}{16}{17}, Green {18}{19}{20}/{21}{22}{23}/{24}{25}{26}",
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 6), CORRECT_TILE_RP_CHAR, ".")
)
rich_presence_conditional_display(
    game_state() == GAME_STATE_IN_GAME && puzzle_width() == 4,
    "Sliding on Junior difficulty - Correct Tiles: Blue {0}{1}{2}{3}/{4}{5}{6}{7}/{8}{9}{10}{11}/{12}{13}{14}{15}, Red {16}{17}{18}{19}/{20}{21}{22}{23}/{24}{25}{26}{27}/{28}{29}{30}{31}, Green {32}{33}{34}{35}/{36}{37}{38}{39}/{40}{41}{42}{43}/{44}{45}{46}{47}",
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 12), CORRECT_TILE_RP_CHAR, ".")
)
rich_presence_conditional_display(
    game_state() == GAME_STATE_IN_GAME && puzzle_width() == 5,
    "Sliding on Senior difficulty - Correct Tiles: Blue {0}{1}{2}{3}{4}/{5}{6}{7}{8}{9}/{10}{11}{12}{13}{14}/{15}{16}{17}{18}{19}/{20}{21}{22}{23}{24}, Red {25}{26}{27}{28}{29}/{30}{31}{32}{33}{34}/{35}{36}{37}{38}{39}/{40}{41}{42}{43}{44}/{45}{46}{47}{48}{49}, Green {50}{51}{52}{53}{54}/{55}{56}{57}{58}{59}/{60}{61}{62}{63}{64}/{65}{66}{67}{68}{69}/{70}{71}{72}{73}{74}",
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 19), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 18), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 17), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 16), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 24), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 23), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 22), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 21), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 20), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 19), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 18), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 17), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 16), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 24), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 23), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 22), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 21), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 20), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 19), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 18), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 17), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 16), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 24), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 23), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 22), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 21), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 20), CORRECT_TILE_RP_CHAR, ".")
)
rich_presence_conditional_display(
    game_state() == GAME_STATE_IN_GAME && puzzle_width() == 6,
    "Sliding on Professional difficulty - Correct Tiles: Blue {0}{1}{2}{3}{4}{5}/{6}{7}{8}{9}{10}{11}/{12}{13}{14}{15}{16}{17}/{18}{19}{20}{21}{22}{23}/{24}{25}{26}{27}{28}{29}/{30}{31}{32}{33}{34}{35}, Red {36}{37}{38}{39}{40}{41}/{42}{43}{44}{45}{46}{47}/{48}{49}{50}{51}{52}{53}/{54}{55}{56}{57}{58}{59}/{60}{61}{62}{63}{64}{65}/{66}{67}{68}{69}{70}{71}, Green {72}{73}{74}{75}{76}{77}/{78}{79}{80}{81}{82}{83}/{84}{85}{86}{87}{88}{89}/{90}{91}{92}{93}{94}{95}/{96}{97}{98}{99}{100}{101}/{102}{103}{104}{105}{106}{107}",
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 17), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 16), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 23), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 22), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 21), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 20), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 19), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 18), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 29), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 28), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 27), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 26), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 25), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 24), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 35), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 34), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 33), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 32), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 31), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_BLUE, 30), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 17), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 16), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 23), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 22), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 21), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 20), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 19), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 18), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 29), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 28), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 27), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 26), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 25), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 24), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 35), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 34), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 33), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 32), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 31), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_RED, 30), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 5), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 4), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 3), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 2), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 1), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 0), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 11), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 10), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 9), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 8), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 7), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 6), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 17), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 16), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 15), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 14), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 13), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 12), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 23), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 22), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 21), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 20), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 19), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 18), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 29), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 28), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 27), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 26), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 25), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 24), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 35), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 34), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 33), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 32), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 31), CORRECT_TILE_RP_CHAR, "."),
    rich_presence_lookup("CorrectTile", is_tile_correct_int(COLOR_GREEN, 30), CORRECT_TILE_RP_CHAR, ".")
)
rich_presence_conditional_display(
    game_state() == GAME_STATE_CLEAR_BEGINNER || game_state() == GAME_STATE_CLEAR_JUNIOR || game_state() == GAME_STATE_CLEAR_SENIOR || game_state() == GAME_STATE_CLEAR_PROFESSIONAL,
    "Admiring a solved puzzle on {0} difficulty",
    rich_presence_lookup("PuzzleWidthToDifficultyName", puzzle_width(), PUZZLE_WIDTH_TO_DIFFICULTY_NAME, "???")
)
rich_presence_conditional_display(
    game_state() == GAME_STATE_TRY_AGAIN,
    "Deciding to try again"
)
rich_presence_display("Sliding the Choro Q Holiday Puzzle")