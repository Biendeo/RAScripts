// Led Storm Rally 2011
// #ID = 15823

// #region SCORE

SCORE_UPPER_WORD_ADDR = 0x8836
SCORE_LOWER_WORD_ADDR = 0x8838
function score() {
	return bcd(word(SCORE_UPPER_WORD_ADDR)) * 10000 + bcd(word(SCORE_LOWER_WORD_ADDR))
}
function prev_score() {
    return prev(high4(SCORE_UPPER_WORD_ADDR + 1)) * 10000000
        + prev(low4(SCORE_UPPER_WORD_ADDR + 1)) * 1000000
        + prev(high4(SCORE_UPPER_WORD_ADDR)) * 100000
        + prev(low4(SCORE_UPPER_WORD_ADDR)) * 10000
        + prev(high4(SCORE_LOWER_WORD_ADDR + 1)) * 1000
        + prev(low4(SCORE_LOWER_WORD_ADDR + 1)) * 100
        + prev(high4(SCORE_LOWER_WORD_ADDR)) * 10
        + prev(low4(SCORE_LOWER_WORD_ADDR)) * 1
}

SCORE_ACHIEVEMENT_INFO = [
    {
        "Title": "Millionaire",
        "Description": "Reach 1,000,000 points",
        "Id": 450394,
        "Points": 5,
        "ScoreToReach": 1000000
    },
    {
        "Title": "Double Millionaire",
        "Description": "Beat the leaderboard record of 2,000,000 points",
        "Id": 450395,
        "Points": 5,
        "ScoreToReach": 2000000
    },
    {
        "Title": "Penta Millionaire",
        "Description": "Pull off a long run and reach 5,000,000 points",
        "Id": 450396,
        "Points": 10,
        "ScoreToReach": 5000000
    }
]

function did_pass_score(score_to_reach) {
    return prev_score() < score_to_reach && score() >= score_to_reach
}

for info in SCORE_ACHIEVEMENT_INFO {
    achievement(
        title = info["Title"],
        description = info["Description"],
        points = info["Points"],
        id = info["Id"],
        trigger = did_pass_score(info["ScoreToReach"])
    )
}

SECONDS_REMAINING_ON_LEADERBOARD_ADDR = 0x88f5
function did_just_enter_leaderboard_entry() {
	return byte(SECONDS_REMAINING_ON_LEADERBOARD_ADDR) == 0x30 && prev(byte(SECONDS_REMAINING_ON_LEADERBOARD_ADDR)) == 0x00
}

leaderboard(
	title = "High Score",
	description = "Get the highest score",
	id = 109713,
	start = did_just_enter_leaderboard_entry(),
	cancel = always_false(),
	submit = always_true(),
	value = score(),
	format = "VALUE"
)

// #endregion

// #region LEVELS

LEVEL_CAPITAL             = 0
LEVEL_NETWOOD_FOREST      = 1
LEVEL_CORAL_SEA           = 2
LEVEL_BIG_CAVE_TUNNEL     = 3
LEVEL_RUINS_DESERT        = 4
LEVEL_MILLON_VALLEY       = 5
LEVEL_THUNDER_ROAD        = 6
LEVEL_MARINE_SNOW_PIPEWAY = 7
LEVEL_SKYCITY_009         = 8

LEVEL_TO_NAME = {
    LEVEL_CAPITAL:             "Capital",
    LEVEL_NETWOOD_FOREST:      "Netwood Forest",
    LEVEL_CORAL_SEA:           "Coral Sea",
    LEVEL_BIG_CAVE_TUNNEL:     "Big Cave Tunnel",
    LEVEL_RUINS_DESERT:        "Ruins Desert",
    LEVEL_MILLON_VALLEY:       "Millon Valley",
    LEVEL_THUNDER_ROAD:        "Thunder Road",
    LEVEL_MARINE_SNOW_PIPEWAY: "Marine Snow Pipeway",
    LEVEL_SKYCITY_009:         "SkyCity.009"
}

ATTRACT_MODE_DETECTOR_ADDR = 0x80e0
function is_in_attract_mode() {
    return word(ATTRACT_MODE_DETECTOR_ADDR) != 0
}

IN_GAMEPLAY_DETECTOR_ADDR = 0x2261c
function is_in_gameplay() {
    return word(IN_GAMEPLAY_DETECTOR_ADDR) == 0x5084 && !is_in_attract_mode()
}

CAR_PROGRESS_REPRESENTATION_ADDR = 0x90a6
function car_progress() {
    return word(CAR_PROGRESS_REPRESENTATION_ADDR)
}

LEVEL_END_DETECTOR = 0x875a
function is_level_end_on_screen() {
    return word(LEVEL_END_DETECTOR) == 0x00dd
}

LEVEL_9_END_LEVEL_DETECTOR = 0x0219ba
function is_level_9_end_level_on_screen() {
    return word(LEVEL_9_END_LEVEL_DETECTOR) == 0xa0b5
}

TIME_CENTISECONDS_HUNDREDTHS_ADDR = 0x8828
TIME_CENTISECONDS_ADDR = 0x8829
function did_just_cross_finish_line() {
    return (is_level_end_on_screen() || is_level_9_end_level_on_screen()) && car_progress() == prev(car_progress()) && byte(TIME_CENTISECONDS_ADDR) == prev(byte(TIME_CENTISECONDS_ADDR)) && is_in_gameplay()
}

TIME_MINUTES_ADDR = 0x8827
TIME_SECONDS_ADDR = 0x8826
function level_time() {
    return byte(TIME_MINUTES_ADDR) * 6000
        + high4(TIME_SECONDS_ADDR) * 1000
        + low4(TIME_SECONDS_ADDR) * 100
        + high4(TIME_CENTISECONDS_ADDR) * 10
        + low4(TIME_CENTISECONDS_ADDR) * 1
}

CURRENT_LEVEL_ADDR = 0x881f
function current_level() {
    return byte(CURRENT_LEVEL_ADDR)
}

TIME_LEADERBOARD_INFO = [
    {
        "Level": LEVEL_CAPITAL,
        "FirstAchievementName": "The First of Many",
        "FirstAchievementId": 450397,
        "FirstAchievementPoints": 2,
        "SecondAchievementName": "Caps Lock",
        "SecondAchievementId": 450398,
        "SecondAchievementPoints": 2,
        "TimeAchievementName": "Shift Key Speeder",
        "TimeAchievementId": 450399,
        "TimeAchievementPoints": 2,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 36,
        "TimeAchievementCentiseconds": 87,
        "LeaderboardId": 109714
    },
    {
        "Level": LEVEL_NETWOOD_FOREST,
        "FirstAchievementName": "Watch for Rolling Rocks",
        "FirstAchievementId": 450400,
        "FirstAchievementPoints": 2,
        "SecondAchievementName": "Sébastien Loeb Zooming",
        "SecondAchievementId": 450401,
        "SecondAchievementPoints": 2,
        "TimeAchievementName": "CMD> TREE /F",
        "TimeAchievementId": 450402,
        "TimeAchievementPoints": 2,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 39,
        "TimeAchievementCentiseconds": 22,
        "LeaderboardId": 109715
    },
    {
        "Level": LEVEL_CORAL_SEA,
        "FirstAchievementName": "Weaving Overtakes",
        "FirstAchievementId": 450403,
        "FirstAchievementPoints": 2,
        "SecondAchievementName": "Slippery When Wet",
        "SecondAchievementId": 450404,
        "SecondAchievementPoints": 2,
        "TimeAchievementName": "Corolla Cruise",
        "TimeAchievementId": 450405,
        "TimeAchievementPoints": 2,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 37,
        "TimeAchievementCentiseconds": 32,
        "LeaderboardId": 109716
    },
    {
        "Level": LEVEL_BIG_CAVE_TUNNEL,
        "FirstAchievementName": "Traffic Weaver",
        "FirstAchievementId": 450406,
        "FirstAchievementPoints": 3,
        "SecondAchievementName": "Tunnel Snake Ruler",
        "SecondAchievementId": 450407,
        "SecondAchievementPoints": 3,
        "TimeAchievementName": "Fast and Furious 4 Finale",
        "TimeAchievementId": 450408,
        "TimeAchievementPoints": 3,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 36,
        "TimeAchievementCentiseconds": 29,
        "LeaderboardId": 109717
    },
    {
        "Level": LEVEL_RUINS_DESERT,
        "FirstAchievementName": "Dinosaur Drive",
        "FirstAchievementId": 450409,
        "FirstAchievementPoints": 3,
        "SecondAchievementName": "Fanging It",
        "SecondAchievementId": 450410,
        "SecondAchievementPoints": 3,
        "TimeAchievementName": "Jurassic Top Gear",
        "TimeAchievementId": 450411,
        "TimeAchievementPoints": 3,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 38,
        "TimeAchievementCentiseconds": 48,
        "LeaderboardId": 109718
    },
    {
        "Level": LEVEL_MILLON_VALLEY,
        "FirstAchievementName": "Road Works, I Sure Hope It Does",
        "FirstAchievementId": 450412,
        "FirstAchievementPoints": 3,
        "SecondAchievementName": "Crumbling Chase",
        "SecondAchievementId": 450413,
        "SecondAchievementPoints": 3,
        "TimeAchievementName": "Speed, the 1994 Movie",
        "TimeAchievementId": 450414,
        "TimeAchievementPoints": 3,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 37,
        "TimeAchievementCentiseconds": 55,
        "LeaderboardId": 109719
    },
    {
        "Level": LEVEL_THUNDER_ROAD,
        "FirstAchievementName": "Big Thunder Mountain Racer",
        "FirstAchievementId": 450415,
        "FirstAchievementPoints": 4,
        "SecondAchievementName": "Kachow",
        "SecondAchievementId": 450416,
        "SecondAchievementPoints": 4,
        "TimeAchievementName": "Faster than the Speed of Sound",
        "TimeAchievementId": 450417,
        "TimeAchievementPoints": 4,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 35,
        "TimeAchievementCentiseconds": 59,
        "LeaderboardId": 109720
    },
    {
        "Level": LEVEL_MARINE_SNOW_PIPEWAY,
        "FirstAchievementName": "Snow Way Like Pipeway",
        "FirstAchievementId": 450418,
        "FirstAchievementPoints": 4,
        "SecondAchievementName": "Aquarium Drive",
        "SecondAchievementId": 450419,
        "SecondAchievementPoints": 4,
        "TimeAchievementName": "Sewer Shark",
        "TimeAchievementId": 450420,
        "TimeAchievementPoints": 4,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 46,
        "TimeAchievementCentiseconds": 74,
        "LeaderboardId": 109721
    },
    {
        "Level": LEVEL_SKYCITY_009,
        "FirstAchievementName": "Lap 1",
        "FirstAchievementId": 450421,
        "FirstAchievementPoints": 4,
        "SecondAchievementName": "I AM VARY GIAD THAT I WAS WITH,YOU",
        "SecondAchievementId": 450422,
        "SecondAchievementPoints": 4,
        "TimeAchievementName": "Reach for the Sky",
        "TimeAchievementId": 450423,
        "TimeAchievementPoints": 4,
        "TimeAchievementMinutes": 1,
        "TimeAchievementSeconds": 40,
        "TimeAchievementCentiseconds": 10,
        "LeaderboardId": 109722
    }
]

for info in TIME_LEADERBOARD_INFO {
    first_achievement_type = "progression"
    if (info["Level"] == LEVEL_SKYCITY_009) {
        first_achievement_type = "win_condition"
    }
    achievement(
        title = info["FirstAchievementName"],
        points = info["FirstAchievementPoints"],
        id = info["FirstAchievementId"],
        description = format(
            "Finish {0} (level {1})",
            LEVEL_TO_NAME[info["Level"]],
            info["Level"] + 1
        ),
        trigger = did_just_cross_finish_line()
            && current_level() == info["Level"],
        type = first_achievement_type
    )
    achievement(
        title = info["SecondAchievementName"],
        points = info["SecondAchievementPoints"],
        id = info["SecondAchievementId"],
        description = format(
            "Finish {0} (level {1})",
            LEVEL_TO_NAME[info["Level"]],
            info["Level"] + 10
        ),
        trigger = did_just_cross_finish_line()
            && current_level() == info["Level"] + 9
    )

    if (info["Level"] == LEVEL_SKYCITY_009) {
        time_achievement_description_format = "Beat an unofficial best time for {0} (level {1} or level {2}) in {3}:{4}.{5} or less"
    } else {
        time_achievement_description_format = "Beat Today's Best Time for {0} (level {1} or level {2}) in {3}:{4}.{5} or less"
    }
    achievement(
        title = info["TimeAchievementName"],
        points = info["TimeAchievementPoints"],
        id = info["TimeAchievementId"],
        description = format(
            time_achievement_description_format,
            LEVEL_TO_NAME[info["Level"]],
            info["Level"] + 1,
            info["Level"] + 10,
            info["TimeAchievementMinutes"],
            info["TimeAchievementSeconds"],
            info["TimeAchievementCentiseconds"]
        ),
        trigger = did_just_cross_finish_line()
            && (
                current_level() == info["Level"] || current_level() == info["Level"] + 9
            )
            && level_time() <= (info["TimeAchievementMinutes"] * 6000 + info["TimeAchievementSeconds"] * 100 + info["TimeAchievementCentiseconds"])
    )

    leaderboard(
        title = format("Best Time in {0}", LEVEL_TO_NAME[info["Level"]]),
        description = format("Finish level {0} or level {1} in the quickest time", info["Level"] + 1, info["Level"] + 10),
        id = info["LeaderboardId"],
        start = did_just_cross_finish_line()
            && (
                current_level() == info["Level"] || current_level() == info["Level"] + 9
            ),
        cancel = always_false(),
        submit = always_true(),
        value = level_time(),
        format = "MILLISECS",
        lower_is_better = true
    )
}

// #endregion

// #region MISCELLANEOUS

FUEL_CAN_ENERGY_ADDR = 0x882d
function did_fuel_can_energy_activate() {
    return byte(FUEL_CAN_ENERGY_ADDR) == 0 && prev(byte(FUEL_CAN_ENERGY_ADDR)) == 5
}

achievement(
    title = "Ener-Ener-Ener-Ener-Energy",
    points = 2,
    id = 450424,
    description = "Collect 6 fuel cans and get an energy boost",
    trigger = is_in_gameplay() && did_fuel_can_energy_activate()
)

ENERGY_ADDR = 0x8847
function energy() {
    return byte(ENERGY_ADDR)
}

achievement(
    title = "Running on Fumes",
    points = 3,
    id = 450425,
    description = "With zero energy remaining, stay in the game by either crossing the finish line of a stage or collecting more energy from a checkpoint or powerup",
    trigger = is_in_gameplay()
        && prev(energy()) == 0
        && (
            
            did_just_cross_finish_line()
            || (
                energy() > 0
                && byte(TIME_CENTISECONDS_ADDR) != prev(byte(TIME_CENTISECONDS_ADDR))
            )
        )
)

PLAY_CREDITS_ADDR = 0x87e2
function play_credits() {
    return byte(PLAY_CREDITS_ADDR)
}

IN_CREDITS_ADDR = 0x881e
function is_in_credits() {
    return byte(IN_CREDITS_ADDR) == 0x0a
}

achievement(
    title = "Proove the Justice of Our Culture",
    points = 1,
    id = 450426,
    description = "Finish stage 18 with one credit in the machine and witness a somewhat secret credits sequence",
    trigger = is_in_credits() && prev(current_level()) == 0x11 && play_credits() == 1,
    type = "missable"
)

// #endregion

// #region RICH PRESENCE

rich_presence_conditional_display(is_in_credits(), "Watching the credits")
rich_presence_conditional_display(is_in_attract_mode(), "Watching the attract mode")
rich_presence_conditional_display(!is_in_gameplay(), "In an intermission screen after level {0}, 💯 {1}",
    rich_presence_value("VALUE", current_level() + 1),
    rich_presence_value("VALUE", score())
)
rich_presence_conditional_display(is_in_gameplay(), "Rallying through level {0}, 💯 {1}, ⏱️ {2}, ⛽ {3}%, 🏁 {4}%",
    rich_presence_value("VALUE", current_level() + 1),
    rich_presence_value("VALUE", score()),
    rich_presence_value("LEVEL_TIME", level_time(), "MILLISECS"),
    rich_presence_value("VALUE", energy() * 3.5714285712),
    rich_presence_value("VALUE", car_progress() * 0.0024112)
)
rich_presence_display("Playing Led Storm Rally 2011")

// #endregion