// Guitar Hero: World Tour
// #ID = 5796

// #region ACCESSORS

function format_int_with_commas(i) {
    is_negative = i < 0
    if (is_negative == true) {
        i = i * -1
    }
    s = ""
    for index in range(0, 100) {
        if (i > 0) {
            s = (i % 10) + s
            i = i / 10
            if (index % 3 == 2 && i > 0) {
                s = "," + s
            }
        }
    }
    if (is_negative == true) {
        s = "-" + s
    }
    if (s == "") {
        return "0"
    }
    return s
}

// Returns the address of the linked list node after iterating next "steps" times. 0 steps returns the same value.
function iterate_linked_list_node(starting_node, steps) {
    step = 0
    current_node = starting_node
    for step in range(1, steps) {
        current_node = dword(current_node + 0x0c)
    }
    return current_node
}

function iterate_prev_linked_list_node(starting_node, steps) {
    if (steps == 0) {
        return starting_node
    }
    step = 0
    current_node = starting_node
    for step in range(1, steps) {
        current_node = prev(dword(current_node + 0x0c))
        step = step + 1
    }
    return current_node
}

function get_linked_list_node_type(node) {
    return dword(node + 0x04)
}

function get_linked_list_node_value(node) {
    return dword(node + 0x08)
}

// These are properly where the money is stored (somewhere in the linked list), but they're too hard to use for RA.
STATIONARY_MONEY_ADDR = 0x00948dc0
LINKED_LIST_START = 0x00912778
function money_earned_linked_list() {
    return get_linked_list_node_value(iterate_linked_list_node(STATIONARY_MONEY_ADDR, 84))
}
function money_spent_linked_list() {
    return get_linked_list_node_value(iterate_linked_list_node(STATIONARY_MONEY_ADDR, 85))
}

function did_reach_you_rock() {
    return player_money_cut(1) > 0 && prev(player_money_cut(1)) == 0
}

IN_SONG_ADDR = 0x00420174
function is_in_song() {
    return dword(IN_SONG_ADDR) == 0x01
}

CUSTOM_SONG_DETECTOR_ADDR = 0x004201ac
function is_in_custom_song() {
    return dword(CUSTOM_SONG_DETECTOR_ADDR) == 0x01
}

IN_CAREER_MODE_GIG_ADDR = 0x004201d0
function is_in_career_mode_gig() {
    return dword(IN_CAREER_MODE_GIG_ADDR) == 0x01
}

NUMBER_OF_ACTIVE_PLAYERS_ADDR = 0x004287f4
function number_of_active_players() {
    return dword(NUMBER_OF_ACTIVE_PLAYERS_ADDR)
}

CURRENT_SONG_ID_ADDR = 0x004cf440
function current_song() {
    return dword(CURRENT_SONG_ID_ADDR)
}

SCORE_ADDR = 0x00c42978
function score() {
    return dword(SCORE_ADDR)
}

PLAYER_INFO_ARRAY_ADDR = 0x008d62c0
PLAYER_INFO_LENGTH = 0x09e0
PLAYER_DIFFICULTY_OFFSET = 0x0018
PLAYER_STAR_POWER_OFFSET = 0x0048
PLAYER_STREAK_OFFSET = 0x00a8
PLAYER_NOTES_HIT_OFFSET = 0x0378
PLAYER_NOTES_PASSED_OFFSET = 0x0388
PLAYER_NOTES_IN_SONG_OFFSET = 0x03c8
PLAYER_STARS_EARNED_OFFSET = 0x03e8
PLAYER_VOCAL_PHRASES_HIT_OFFSET = 0x0438
PLAYER_VOCAL_PHRASES_HIT_FRACTION_OFFSET = 0x0448
PLAYER_VOCAL_PHRASES_PASSED_OFFSET = 0x0458
PLAYER_ROCK_METER = 0x0848
PLAYER_MONEY_CUT_OFFSET = 0x0888
PLAYER_INSTRUMENT_OFFSET = 0x09c8
PLAYER_IS_ACTIVE_OFFSET = 0x0338

function get_player_addr(player_num) {
    return PLAYER_INFO_ARRAY_ADDR + ((player_num - 1) * PLAYER_INFO_LENGTH)
}

function player_difficulty(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_DIFFICULTY_OFFSET)
}

function player_star_power(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_STAR_POWER_OFFSET)
}

function player_streak(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_STREAK_OFFSET)
}

function player_notes_hit(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_NOTES_HIT_OFFSET)
}

function player_notes_passed(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_NOTES_PASSED_OFFSET)
}

function player_notes_in_song(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_NOTES_IN_SONG_OFFSET)
}

function player_stars_earned(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_STARS_EARNED_OFFSET)
}

function player_vocal_phrases_hit(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_VOCAL_PHRASES_HIT_OFFSET)
}

function player_vocal_phrases_hit_fraction(player_num) {
    return float(get_player_addr(player_num) + PLAYER_VOCAL_PHRASES_HIT_FRACTION_OFFSET)
}

function player_vocal_phrases_passed(player_num) {
    return float(get_player_addr(player_num) + PLAYER_VOCAL_PHRASES_PASSED_OFFSET)
}

function player_rock_meter(player_num) {
    return float(get_player_addr(player_num) + PLAYER_ROCK_METER)
}

function player_money_cut(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_MONEY_CUT_OFFSET)
}

function player_instrument(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_INSTRUMENT_OFFSET)
}

function is_player_active(player_num) {
    return dword(get_player_addr(player_num) + PLAYER_IS_ACTIVE_OFFSET) == 0x01
}

INSTRUMENT_GUITAR = 0xbdc53cf2
INSTRUMENT_BASS   = 0xcb9fb4cf
INSTRUMENT_DRUMS  = 0x5cc16cdf
INSTRUMENT_VOCALS = 0xe8e6adcb

INSTRUMENT_TO_NAME = {
    INSTRUMENT_GUITAR : "Guitar",
    INSTRUMENT_BASS   : "Bass",
    INSTRUMENT_DRUMS  : "Drums",
    INSTRUMENT_VOCALS : "Vocals",
}

DIFFICULTY_BEGINNER = 0x1032b444
DIFFICULTY_EASY     = 0xb69d6568
DIFFICULTY_MEDIUM   = 0x398cba48
DIFFICULTY_HARD     = 0x3eeae02d
DIFFICULTY_EXPERT   = 0xb0e46cbd

DIFFICULTY_TO_NAME = {
    DIFFICULTY_BEGINNER : "Beginner",
    DIFFICULTY_EASY     : "Easy",
    DIFFICULTY_MEDIUM   : "Medium",
    DIFFICULTY_HARD     : "Hard",
    DIFFICULTY_EXPERT   : "Expert"
}

LEADERBOARD_ADDR = 0x01b2d820
LEADERBOARD_LENGTH = 0x38
LEADERBOARD_CAREER_STARS_OFFSET = 0x31
function career_stars_for_song(leaderboard_id) {
    return byte(LEADERBOARD_ADDR + (leaderboard_id * LEADERBOARD_LENGTH) + LEADERBOARD_CAREER_STARS_OFFSET)
}

CHEAT_ALWAYS_SLIDE_ADDR = 0x005f5a90
function is_always_slide_on() {
    return dword(CHEAT_ALWAYS_SLIDE_ADDR) == 0x01
}

CHEAT_AUTO_KICK_ADDR = 0x005f5abc
function is_auto_kick_on() {
    return dword(CHEAT_AUTO_KICK_ADDR) == 0x01
}

function are_all_cheats_off() {
    return !is_always_slide_on() && !is_auto_kick_on()
}

// #endregion

// #region MONEY AND RANK

// This is just updated at the You Rock screen but it works well enough for the achievement.
TOTAL_EARNINGS_PRESENTATION_ADDR = 0x008d6b68
function total_earnings() {
    return dword(TOTAL_EARNINGS_PRESENTATION_ADDR)
}

// [Rank number, money to reach, rank name, achievement ID]
RANK_INFO = [
    [  2,     500, "Got Some Kicks", 0],
    [  3,    1000, "Got A Look", 0],
    [  4,    2000, "Became A Rebel", 0],
    [  5,    3000, "Found Your Roots", 0],
    [  6,    4500, "Got A Pet", 0],
    [  7,    6000, "Signed Your First Deal", 0],
    [  8,    8000, "Got An Ego", 0],
    [  9,   11000, "Blew Your Dough", 0],
    [ 10,   15000, "Had To Show Off", 0],
    [ 11,   20000, "Signed An Endorsement Deal", 0],
    [ 12,   25000, "Got Some Cold, Hard, Cash", 0],
    [ 13,   30000, "Upgraded Your Look", 0],
    [ 14,   40000, "Got Fancier Taste", 0],
    [ 15,   50000, "Partied In Cannes", 0],
    [ 16,   60000, "Vacationed In Egypt", 0],
    [ 17,   70000, "Brought Back A Pet Lion", 0],
    [ 18,   80000, "'Hear Me Roar' Became A Gold Record", 0],
    [ 19,   90000, "Split Up The Band", 0],
    [ 20,  105000, "Ate Only The Finest", 0],
    [ 21,  120000, "Bought Your Own Island", 0],
    [ 22,  135000, "Decided To Go Solo", 0],
    [ 23,  150000, "Got Richer", 0],
    [ 24,  165000, "Became Increasingly More Reclusive", 0],
    [ 25,  180000, "Had A Cameo In A Hip-Hop Track", 0],
    [ 26,  200000, "Collected Rare Muscle Cars", 0],
    [ 27,  220000, "Bought A Venus de Milo Knock Off", 0],
    [ 28,  240000, "Built An Enormous Fish Tank For The New Pet Shark", 0],
    [ 29,  260000, "Won The 'Best Rock Performance In A Hip-Hop Cameo' Award", 0],
    [ 30,  280000, "Wrecked Your Car Driving Home From The After Party", 0],
    [ 31,  305000, "Went To Rehab In Palm Springs", 0],
    [ 32,  330000, "Decided To Move To Arizona To 'Clear Your Head'", 0],
    [ 33,  355000, "'Toms of Life' Becomes a Worldwide Hit", 0],
    [ 34,  380000, "Did A Major Credit Card Commercial", 0],
    [ 35,  410000, "Got A Weekend Gig in Vegas", 0],
    [ 36,  440000, "Got Married In Vegas", 0],
    [ 37,  470000, "Leased A Private Jet", 0],
    [ 38,  500000, "Bought A Sarcophagus To Sleep In", 0],
    [ 39,  530000, "Imported A Bengal Tiger", 0],
    [ 40,  565000, "Got A Star In Hollywood Blvd", 0],
    [ 41,  600000, "Burned One Million Dollars To Make A Statement", 0],
    [ 42,  635000, "Started Your Own Beverage Company", 0],
    [ 43,  670000, "Bought A Castle In France", 0],
    [ 44,  705000, "Bought A Guitar Manufacturer", 0],
    [ 45,  745000, "Demanded To Get Paid In Gold Bricks", 0],
    [ 46,  785000, "Got A Cult Following In Norway", 0],
    [ 47,  825000, "Became Blinded By Success", 0],
    [ 48,  865000, "Bought A Decommissioned Submarine From Russia", 0],
    [ 49,  910000, "Commissioned A Self Portrait", 0],
    [ 50,  955000, "Replaced Your Butler With A Robot", 0],
    [ 51, 1000000, "Immortalized Your Guitar In Frozen Carbonite", 0]
    // The ranks below have no icon and are also so much of a grind to get to so they're excluded from achievements.
    // [101, 2000000, "Became 'The Bomb' Literally", 0]
    // [151, 3000000, "Got Your Own Scent - 'Eau de Shred'", 0]
    // [201, 4000000, "Performed In The Space Station, Millions Watched", 0]
    // [251, 5000000, "Received the Fiddle of Gold From Lou", 0]
]

function did_money_just_pass_threshold(money_for_rank) {
    // This measurement doesn't update until after the first song, but it triggers correctly.
    return measured(total_earnings() >= money_for_rank)
        && (total_earnings() - player_money_cut(1) - player_money_cut(2) - player_money_cut(3) - player_money_cut(4)) < money_for_rank
        && is_in_song()
}

for rank_info in RANK_INFO {
    rank_num = rank_info[0]
    money_for_rank = rank_info[1]
    rank_name = rank_info[2]
    achievement_id = rank_info[3]
    achievement(
        title = rank_name,
        description = format("Acquire ${0} total earnings and reach Rocker Rank {1}", format_int_with_commas(money_for_rank), rank_num),
        points = 1,
        id = achievement_id,
        trigger = did_money_just_pass_threshold(money_for_rank)
    )
}

// #endregion

// #region SONGS

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
SONG_SANTERIA                        =  0x7e68e3be
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

SONG_INFO = {
    SONG_ABOUT_A_GIRL_UNPLUGGED: {
        "Title": "About a Girl (Unplugged)",
        "Artist": "Nirvana",
        "Year": 1994,
        "BandLeaderboardIndices": [1125, 1188, 206, 1859, 1560],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 58600,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [786, 57, 1838, 1108, 233],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29150,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [229, 663, 2163, 350, 265],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 64100,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [751, 1233, 1971, 789, 907],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 15500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [627, 838, 974, 1364, 2019],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_AGGRO: {
        "Title": "Aggro",
        "Artist": "The Enemy",
        "Year": 2007,
        "BandLeaderboardIndices": [1297, 1621, 521, 2182, 1664],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 78936,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [490, 1923, 1592,  981, 2070],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 26448,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1463, 559, 277, 1238, 1409],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 66375,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [185, 631, 904, 1451, 935],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [526, 1781, 1878, 1509, 1892],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_AMERICAN_WOMAN: {
        "Title": "American Woman",
        "Artist": "The Guess Who",
        "Year": 1970,
        "BandLeaderboardIndices": [2072, 993, 2190, 2049, 1215],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 62584,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2082, 440, 892, 1758, 883],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 41073,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [509, 524, 2239, 199, 667],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 102900,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [715, 215, 1395, 131, 1917],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [31, 2145, 655, 1528, 1353],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ANTISOCIAL: {
        "Title": "Antisocial",
        "Artist": "Trust",
        "Year": 1980,
        "BandLeaderboardIndices": [607, 155, 1159, 1566, 2160],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 88849,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1526, 2125, 66, 2249, 232],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 64450,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2185, 1464, 1831, 1582, 178],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 126528,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1512, 1423, 1071, 2141, 396],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1676, 2233, 162, 51, 1843],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ARE_YOU_GONNA_GO_MY_WAY: {
        "Title": "Are You Gonna Go My Way",
        "Artist": "Lenny Kravitz",
        "Year": 1993,
        "BandLeaderboardIndices": [1434, 2135, 1672, 971, 2173],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 53647,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [987, 563, 1722, 641, 2241],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29904,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1565, 556, 1432, 1049, 373],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 67225,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [802, 2039, 1508, 620, 1139],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 16500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1042, 731, 653, 1270, 1895],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ASSASSIN: {
        "Title": "Assassin",
        "Artist": "Muse",
        "Year": 2006,
        "BandLeaderboardIndices": [1855, 123, 2048, 771, 1207],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 84934,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [52, 69, 2130, 765, 1688],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 63147,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [312, 1097, 1839, 401, 836],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 95750,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [510, 555, 1471, 840, 260],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [113, 2139, 287, 80, 1002],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_BAND_ON_THE_RUN: {
        "Title": "Band on the Run",
        "Artist": "Wings",
        "Year": 1973,
        "BandLeaderboardIndices": [103, 467, 281, 482, 177],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 70349,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2114, 1360, 322, 1689, 160],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 35769,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1068, 436, 1833, 1914, 1638],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 86725,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1022, 2186, 2119, 672, 89],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [169, 2060, 1273, 1955, 2010],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_BEAT_IT: {
        "Title": "Beat It",
        "Artist": "Michael Jackson",
        "Year": 1982,
        "BandLeaderboardIndices": [132, 58, 369, 2, 477],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54299,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2155, 2017, 1746, 2073, 1120],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 30967,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [224, 2159, 998, 282, 1272],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 101825,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [909, 1435, 407, 496, 875],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 27000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [737, 1329, 1177, 604, 970],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_BEAUTIFUL_DISASTER: {
        "Title": "Beautiful Disaster",
        "Artist": "311",
        "Year": 1997,
        "BandLeaderboardIndices": [1161, 1411, 2212, 1369, 1549],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 61516,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [591, 70, 1234, 776, 1332],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 43500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [5, 814, 962, 1863, 957],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 114175,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [815, 2071, 2088, 410, 74],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [447, 1184, 49, 740, 2055],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_BYOB: {
        "Title": "B.Y.O.B.",
        "Artist": "System Of A Down",
        "Year": 2005,
        "BandLeaderboardIndices": [1825, 242, 2121, 1145, 1803],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 103178,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1628, 1027, 1, 1836, 1339],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 73305,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [610, 1337, 1523, 702, 460],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 128700,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [332, 1860, 494, 430, 546],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1170, 2009, 887, 1099, 459],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
        SONG_CRAZY_TRAIN: {
        "Title": "Crazy Train",
        "Artist": "Ozzy Osbourne",
        "Year": 1980,
        "BandLeaderboardIndices": [956, 856, 1154, 493, 1650],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 93714,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1187, 1656, 1312, 560, 1636],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 49325,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [925, 780, 976, 1102, 1269],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 131400,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2066, 1100, 492, 637, 1335],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2087, 1841, 756, 495, 1539],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_DAMMIT: {
        "Title": "Dammit",
        "Artist": "Blink-182",
        "Year": 1997,
        "BandLeaderboardIndices": [182, 1229, 2219, 2144, 1846],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54450,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1192, 17, 1038, 1611, 26],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 45935,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [320, 2184, 2223, 701, 144],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 98225,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1759, 434, 1023, 1674, 311],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 13000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1115, 1871, 285, 1217, 1537],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_DEMOLITION_MAN_LIVE: {
        "Title": "Demolition Man (Live)",
        "Artist": "Sting",
        "Year": 2005,
        "BandLeaderboardIndices": [1422, 1416, 2228, 1034, 721],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 60646,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [41, 1163, 1629, 810, 944],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 52127,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1950, 1807, 1149, 1293, 461],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 115732,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1389, 1823, 2032, 1039, 1352],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1160, 1136, 1870, 916, 2033],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_DO_IT_AGAIN: {
        "Title": "Do It Again",
        "Artist": "Steely Dan",
        "Year": 1972,
        "BandLeaderboardIndices": [1153, 323, 289, 1357, 1466],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 61225,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1101, 1006, 406, 996, 2025],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 56392,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1662, 1355, 386, 2128, 550],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 123750,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [643, 512, 1225, 543, 1450],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 16500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [353, 1980, 1294, 1239, 1276],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ESCUELA_DE_CALOR: {
        "Title": "Escuela de Calor",
        "Artist": "Radio Futura",
        "Year": 1984,
        "BandLeaderboardIndices": [811, 1213, 558, 685, 2086],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54064,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1378, 1279, 1987, 746, 2000],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29173,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [808, 1167, 1287, 2084, 1994],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 88775,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1498, 8, 190, 1104, 995],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 15500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1454, 1334, 472, 1285, 1820],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_EVERLONG: {
        "Title": "Everlong",
        "Artist": "Foo Fighters",
        "Year": 1997,
        "BandLeaderboardIndices": [1911, 2104, 2247, 150, 1777],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 102163,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [431, 252, 1216, 1964, 934],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51650,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2011, 114, 1744, 1135, 1693],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 133575,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [361, 1921, 20, 719, 2143],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 17000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [936, 140, 1220, 166, 337],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_EYE_OF_THE_TIGER: {
        "Title": "Eye of the Tiger",
        "Artist": "Survivor",
        "Year": 1982,
        "BandLeaderboardIndices": [1771, 1764, 1359, 2098, 1591],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 59151,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2122, 1111, 1570, 231, 1206],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 28608,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [283, 1461, 276, 978, 139],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 80425,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [398, 708, 1176, 1811, 2237],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1928, 855, 790, 718, 683],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_FEEL_THE_PAIN: {
        "Title": "Feel the Pain",
        "Artist": "Dinosaur Jr.",
        "Year": 1994,
        "BandLeaderboardIndices": [1374, 1793, 801, 1854, 1535],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 67560,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [897, 379, 1048, 221, 659],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 45550,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1117, 959, 2106, 130, 1644],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 96850,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [984, 78, 298, 487, 418],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1906, 1458, 1708, 2161, 344],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_FLOAT_ON: {
        "Title": "Float On",
        "Artist": "Modest Mouse",
        "Year": 2004,
        "BandLeaderboardIndices": [262, 1956, 2243, 1990, 222],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 41133,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [329, 1578, 1934, 1830, 1304],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 18075,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [529, 1452, 1527, 402, 2031],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 69275,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2026, 1976, 1379, 1148, 1119],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [979, 908, 551, 1277, 1430],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_FREAK_ON_A_LEASH: {
        "Title": "Freak on a Leash",
        "Artist": "Korn",
        "Year": 1998,
        "BandLeaderboardIndices": [1058, 1445, 238, 1927, 844],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 43344,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [111, 1129, 2167, 259, 1665],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 36362,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [926, 471, 871, 1882, 456],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 91925,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1745, 76, 582, 362, 1652],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1669, 1469, 1118, 1446, 249],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_GO_YOUR_OWN_WAY: {
        "Title": "Go Your Own Way",
        "Artist": "Fleetwood Mac",
        "Year": 1977,
        "BandLeaderboardIndices": [1223, 1721, 914, 674, 561],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 67201,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1593, 133, 640, 1986, 767],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51016,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [384, 1737, 2109, 1261, 849],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 109250,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [769, 194, 888, 1783, 2222],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [579, 1879, 53, 1179, 1456],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_GOOD_GOD: {
        "Title": "Good God",
        "Artist": "Anouk",
        "Year": 2007,
        "BandLeaderboardIndices": [425, 1885, 2236, 752, 483],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 48080,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1200, 105, 2085, 1375, 536],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 30549,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [63, 1919, 1929, 21, 1635],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 58525,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [196, 1112, 1037, 1245, 723],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1174, 541, 2044, 455, 466],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_HAIL_TO_THE_FREAKS: {
        "Title": "Hail to the Freaks",
        "Artist": "Beatsteaks",
        "Year": 2007,
        "BandLeaderboardIndices": [710, 986, 1618, 6, 1649],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52476,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1318, 2004, 1105, 1826, 1784],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 40250,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1973, 827, 1959, 1574, 2027],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 88075,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1790, 1845, 930, 967, 427],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 17500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [578, 927, 1778, 1743, 1654],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_HEARTBREAKER: {
        "Title": "Heartbreaker",
        "Artist": "Pat Benatar",
        "Year": 1979,
        "BandLeaderboardIndices": [2207, 824, 1908, 1440, 562],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 62778,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1169, 2195, 866, 711, 198],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38706,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1944, 1952, 253, 1470, 1465],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 79623,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1488, 2234, 56, 1495, 1224],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1065, 696, 763, 205, 1138],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_HEY_MAN_NICE_SHOT: {
        "Title": "Hey Man, Nice Shot",
        "Artist": "Filter",
        "Year": 1995,
        "BandLeaderboardIndices": [2091, 1082, 1399, 1195, 102],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 66619,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [548, 913, 1835, 116, 1645],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 82000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1095, 1232, 1007, 1975, 1713],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 74750,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1935, 449, 1796, 2148, 1873],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [197, 416, 1064, 1497, 1044],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_HOLLYWOOD_NIGHTS: {
        "Title": "Hollywood Nights",
        "Artist": "Bob Seger & The Silver Bullet Band",
        "Year": 1978,
        "BandLeaderboardIndices": [1030, 828, 381, 839, 296],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 115275,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [764, 365, 1051, 230, 544],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 75125,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [444, 1681, 946, 660, 1340],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 163225,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2131, 632, 1012, 67, 973],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1553, 1608, 1321, 1025, 390],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_HOT_FOR_TEACHER: {
        "Title": "Hot for Teacher",
        "Artist": "Van Halen",
        "Year": 1984,
        "BandLeaderboardIndices": [1056, 2244, 848, 819, 1580],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 111351,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2245, 2218, 358, 498, 2213],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 48114,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [797, 1210, 223, 1555, 331],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 146576,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1997, 724, 267, 97, 473],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1028, 1513, 1483, 980, 2204],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_HOTEL_CALIFORNIA: {
        "Title": "Hotel California",
        "Artist": "The Eagles",
        "Year": 1976,
        "BandLeaderboardIndices": [393, 305, 1610, 1589, 575],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 69092,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1436, 2126, 1506, 1687, 519],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 49851,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2090, 40, 217, 1209, 1622],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 83375,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [759, 624, 1370, 2231, 1484],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 29000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2172, 247, 273, 315, 618],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_THE_JOKER: {
        "Title": "The Joker",
        "Artist": "The Steve Miller Band",
        "Year": 1973,
        "BandLeaderboardIndices": [872, 705, 107, 1989, 274],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 47671,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [136, 1768, 1055, 698, 1837],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 37161,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [940, 426, 1538, 2238, 1948],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 56875,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1852, 1992, 175, 241, 514],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1602, 497, 1280, 364, 1849],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_KICK_OUT_THE_JAMS: {
        "Title": "Kick Out the Jams",
        "Artist": "MC5's Wayne Kramer",
        "Year": 2008,
        "BandLeaderboardIndices": [520, 2203, 576, 1551, 945],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52626,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1888, 812, 1307, 1235, 1741],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 31646,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1281, 1309, 161, 2214, 1388],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 67949,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [173, 137, 193, 2129, 803],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1103, 784, 1183, 255, 697],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_THE_KILL: {
        "Title": "The Kill",
        "Artist": "30 Seconds To Mars",
        "Year": 2005,
        "BandLeaderboardIndices": [1383, 1901, 885, 1969, 572],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 84010,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1816, 2089, 1062, 1203, 2156],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51807,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1612, 278, 1815, 395, 1205],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 77950,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [367, 1945, 1847, 1905, 1604],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [284, 142, 891, 922, 1358],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LA_BAMBA: {
        "Title": "La Bamba",
        "Artist": "Los Lobos",
        "Year": 1987,
        "BandLeaderboardIndices": [409, 2179, 1960, 1151, 1958],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 51055,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2215, 1438, 201, 622, 1380],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 25766,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [794, 1311, 745, 1494, 2067],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 50825,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1475, 859, 2127, 480, 357],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1754, 433, 319, 2050, 310],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LAZY_EYE: {
        "Title": "Lazy Eye",
        "Artist": "Silversun Pickups",
        "Year": 2006,
        "BandLeaderboardIndices": [896, 902, 1728, 570, 1162],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 125825,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [868, 1173, 2197, 1050, 1271],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 71449,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [923, 886, 168, 2034, 1041],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 150175,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1196, 917, 503, 334, 1712],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2092, 293, 772, 507, 189],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LIVIN_ON_A_PRAYER: {
        "Title": "Livin' On A Prayer",
        "Artist": "Bon Jovi",
        "Year": 1986,
        "BandLeaderboardIndices": [583, 1001, 1696, 1851, 1547],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 48739,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1267, 783, 1834, 469, 694],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 53149,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1797, 2150, 1350, 348, 1789],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 79075,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1403, 2059, 1981, 413, 1609],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 31500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2146, 15, 552, 1363, 1583],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LOVE_ME_TWO_TIMES: {
        "Title": "Love Me Two Times",
        "Artist": "The Doors",
        "Year": 1967,
        "BandLeaderboardIndices": [1426, 1077, 1227, 739, 2110],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52103,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [355, 244, 1865, 647, 299],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38625,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [403, 906, 1036, 1264, 1766],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 57075,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2138, 1316, 1931, 1106, 947],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1594, 788, 798, 877, 237],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LOVE_REMOVAL_MACHINE: {
        "Title": "Love Removal Machine",
        "Artist": "The Cult",
        "Year": 1987,
        "BandLeaderboardIndices": [1731, 118, 82, 1396, 2168],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 67136,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [905, 2105, 1779, 1333, 1524],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 44705,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1116, 1236, 963, 774, 1147],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 90675,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2206, 372, 225, 286, 1202],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 30500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1899, 2038, 1419, 817, 1414],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LOVE_SPREADS: {
        "Title": "Love Spreads",
        "Artist": "The Stone Roses",
        "Year": 1994,
        "BandLeaderboardIndices": [1903, 829, 1266, 2132, 534],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 82220,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [982, 2232, 275, 1052, 1016],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 66063,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [117, 23, 1770, 975, 1702],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 131125,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [757, 1212, 1141, 1562, 2117],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 33000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1325, 881, 1623, 1556, 1572],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_LVIA_LVIAQUEZ: {
        "Title": "L'Via L'Viaquez",
        "Artist": "The Mars Volta",
        "Year": 2005,
        "BandLeaderboardIndices": [1967, 2028, 1624, 435, 88],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 60325,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [34, 602, 1367, 2196, 1561],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 40193,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [505, 880, 2095, 2118, 1573],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 97150,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [768, 371, 157, 2051, 1482],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 25500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1850, 2040, 915, 1496, 1121],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_THE_MIDDLE: {
        "Title": "The Middle",
        "Artist": "Jimmy Eat World",
        "Year": 2001,
        "BandLeaderboardIndices": [2062, 1775, 1045, 738, 1557],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 74040,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [346, 1010, 1480, 129, 463],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 39973,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [865, 429, 183, 1107, 1317],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 67875,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [580, 2047, 476, 388, 1408],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1567, 1584, 1979, 681, 1844],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_MISERY_BUSINESS: {
        "Title": "Misery Business",
        "Artist": "Paramore",
        "Year": 2007,
        "BandLeaderboardIndices": [84, 48, 747, 1647, 121],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 66756,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [268, 167, 1684, 1137, 1247],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38700,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1780, 830, 227, 1372, 446],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 88050,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [961, 75, 513, 1500, 983],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [720, 1953, 330, 1485, 778],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_MONSOON: {
        "Title": "Monsoon",
        "Artist": "Tokio Hotel",
        "Year": 2007,
        "BandLeaderboardIndices": [1673, 893, 2192, 874, 1406],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 71577,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1478, 1802, 1130, 2191, 2108],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 61546,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1362, 2200, 2078, 1398, 99],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 74500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [122, 1083, 648, 3, 1182],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 29500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [598, 1543, 1999, 1769, 220],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_MOUNTAIN_SONG: {
        "Title": "Mountain Song",
        "Artist": "Jane's Addiction",
        "Year": 1988,
        "BandLeaderboardIndices": [1384, 535, 304, 1175, 1397],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 57704,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [725, 307, 1144, 1349, 1300],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 71437,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [588, 1709, 1296, 451, 2183],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 98613,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [423, 91, 1011, 385, 1747],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1804, 164, 1093, 1241, 2177],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_MR_CROWLEY: {
        "Title": "Mr. Crowley",
        "Artist": "Ozzy Osbourne",
        "Year": 1980,
        "BandLeaderboardIndices": [669, 952, 36, 1714, 1354],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 72392,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [911, 294, 592, 1663, 1330],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 61179,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [502, 800, 464, 1301, 2015],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 86725,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1415, 635, 545, 1457, 1004],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [470, 1818, 1545, 1324, 1660],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_NEVER_TOO_LATE: {
        "Title": "Never Too Late",
        "Artist": "The Answer",
        "Year": 2006,
        "BandLeaderboardIndices": [1256, 2083, 766, 860, 313],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 66846,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1559, 98, 1904, 597, 485],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 41047,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1678, 1641, 933, 1605, 1918],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 77300,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [39, 1514, 899, 862, 1308],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 27000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [92, 2188, 1544, 614, 573],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_NO_SLEEP_TILL_BROOKLYN: {
        "Title": "No Sleep Till Brooklyn",
        "Artist": "Beastie Boys",
        "Year": 1986,
        "BandLeaderboardIndices": [79, 1000, 574, 1961, 2081],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 39863,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1087, 775, 652, 325, 450],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 17198,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1761, 1185, 953, 1706, 1150],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 83550,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1800, 760, 2097, 2216, 106],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1197, 1703, 823, 101, 1336],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_NUVOLE_E_LENZUOLA: {
        "Title": "Nuvole E Lenzuola",
        "Artist": "Negramaro",
        "Year": 2005,
        "BandLeaderboardIndices": [251, 554, 972, 1424, 623],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 62905,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [138, 93, 19, 4, 1686],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 30373,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [46, 1548, 1653, 1444, 1134],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 66325,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [207, 843, 1748, 1319, 684],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 30500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1949, 951, 468, 1529, 1546],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_OBSTACLE_1: {
        "Title": "Obstacle 1",
        "Artist": "Interpol",
        "Year": 2002,
        "BandLeaderboardIndices": [1158, 785, 1152, 1536, 921],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 65566,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1668, 309, 1534, 1907, 360],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 43355,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1883, 1587, 417, 326, 2199],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 104400,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [538, 1421, 203, 1479, 924],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [796, 2158, 686, 1700, 1943],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ON_THE_ROAD_AGAIN_LIVE: {
        "Title": "On the Road Again (Live)",
        "Artist": "Willie Nelson",
        "Year": 1980,
        "BandLeaderboardIndices": [1511, 744, 1701, 845, 1462],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 36197,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1723, 1268, 1856, 1156, 181],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 19209,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1607, 2115, 1642, 1704, 179],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 69725,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1606, 1092, 2175, 270, 212],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 13500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1401, 1894, 7, 115, 1530],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ONE_ARMED_SCISSOR: {
        "Title": "One Armed Scissor",
        "Artist": "At The Drive-In",
        "Year": 2000,
        "BandLeaderboardIndices": [2187, 1655, 1096, 1827, 1813],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 95641,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1178, 1157, 1491, 700, 1459],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51574,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1753, 1476, 1504, 368, 1848],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 101100,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1858, 1710, 639, 1003, 522],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 27000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [709, 1659, 1288, 1240, 2235],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_THE_ONE_I_LOVE: {
        "Title": "The One I Love",
        "Artist": "R.E.M.",
        "Year": 1987,
        "BandLeaderboardIndices": [1631, 1734, 1490, 1824, 397],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 32194,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [352, 1061, 1086, 474, 408],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 25331,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [713, 1164, 741, 1577, 1926],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 75478,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1373, 174, 489, 1382, 1338],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 11000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [343, 1916, 22, 240, 1348],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ONE_WAY_OR_ANOTHER: {
        "Title": "One Way or Another",
        "Artist": "Blondie",
        "Year": 1978,
        "BandLeaderboardIndices": [1518, 1063, 415, 758, 2065],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 56260,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [441, 2030, 86, 577, 2061],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 36611,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [248, 518, 508, 873, 376],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 99225,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [679, 1968, 2037, 1875, 1862],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1792, 1752, 1715, 2246, 1059],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_OUR_TRUTH: {
        "Title": "Our Truth",
        "Artist": "Lacuna Coil",
        "Year": 2006,
        "BandLeaderboardIndices": [1394, 308, 809, 263, 1076],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52189,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1503, 1751, 1705, 733, 108],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 39648,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2166, 882, 404, 991, 1595],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 72375,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1626, 243, 246, 2035, 1817],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [673, 1140, 690, 1486, 1079],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_OVERKILL: {
        "Title": "Overkill",
        "Artist": "Motörhead",
        "Year": 2007,
        "BandLeaderboardIndices": [1381, 254, 1995, 1788, 846],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 93561,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [929, 392, 1900, 2058, 2076],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 77885,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1920, 128, 831, 820, 1683],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 173218,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1420, 1840, 1974, 71, 821],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 9500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1942, 68, 605, 1772, 1794],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_PARABOLA: {
        "Title": "Parabola",
        "Artist": "Tool",
        "Year": 2001,
        "BandLeaderboardIndices": [2054, 960, 619, 1634, 1756],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 77071,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [454, 1738, 1047, 200, 1732],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 71070,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [910, 303, 2230, 1443, 988],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 112471,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2099, 734, 531, 825, 125],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [419, 1289, 359, 1922, 1341],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_PRETTY_VACANT: {
        "Title": "Pretty Vacant",
        "Artist": "Sex Pistols",
        "Year": 2007,
        "BandLeaderboardIndices": [9, 941, 1810, 38, 858],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 57351,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1143, 770, 2221, 1492, 2169],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 42575,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1550, 1874, 1315, 1014, 1046],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 97200,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1405, 853, 851, 171, 1460],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [448, 1806, 594, 1542, 1962],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_PRISONER_OF_SOCIETY: {
        "Title": "Prisoner of Society",
        "Artist": "The Living End",
        "Year": 1999,
        "BandLeaderboardIndices": [1226, 264, 1786, 657, 1402],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 93758,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [192, 542, 457, 606, 736],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 66648,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [210, 349, 2176, 1785, 1667],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 105375,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2013, 992, 1387, 245, 1468],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1303, 1155, 1204, 55, 72],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_PULL_ME_UNDER: {
        "Title": "Pull Me Under",
        "Artist": "Dream Theater",
        "Year": 1992,
        "BandLeaderboardIndices": [2205, 2029, 10, 2021, 533],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 134316,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1651, 1832, 488, 540, 1505],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 103879,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [339, 1371, 742, 258, 1166],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 207419,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1208, 292, 1109, 1502, 1391],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1679, 2170, 1310, 1275, 2068],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_PURPLE_HAZE_LIVE: {
        "Title": "Purple Haze (Live)",
        "Artist": "The Jimi Hendrix Experience",
        "Year": 1968,
        "BandLeaderboardIndices": [112, 1884, 1410, 942, 156],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54193,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1417, 1088, 1377, 753, 1877],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 45808,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2103, 279, 1385, 1998, 1983],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 75625,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [676, 1331, 60, 1801, 954],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [564, 64, 1680, 484, 792],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_RAMBLIN_MAN: {
        "Title": "Ramblin' Man",
        "Artist": "The Allman Brothers Band",
        "Year": 1973,
        "BandLeaderboardIndices": [590, 1930, 1520, 755, 1757],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 77752,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1260, 363, 1181, 1521, 216],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 55473,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1393, 822, 732, 347, 2041],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 152000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [833, 1677, 65, 889, 1345],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1691, 671, 692, 779, 549],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_REBEL_YELL: {
        "Title": "Rebel Yell",
        "Artist": "Billy Idol",
        "Year": 1983,
        "BandLeaderboardIndices": [612, 351, 1127, 1893, 1165],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 76381,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2133, 1939, 1344, 997, 184],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 70650,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [617, 83, 2002, 1323, 948],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 125150,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1933, 1070, 1575, 1692, 2220],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 37000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [134, 2100, 2003, 1211, 1924],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_RE_EDUCATION_THROUGH_LABOR: {
        "Title": "Re-Education Through Labor",
        "Artist": "Rise Against",
        "Year": 2008,
        "BandLeaderboardIndices": [1646, 1253, 2210, 735, 1886],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 76907,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2116, 1760, 2226, 716, 2012],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 47336,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2137, 900, 1913, 288, 2189],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 77850,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [110, 2124, 1089, 158, 1627],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1864, 280, 1009, 682, 1474],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ROOFTOPS_A_LIBERATION_BROADCAST: {
        "Title": "Rooftops (A Liberation Broadcast)",
        "Artist": "Lostprophets",
        "Year": 2006,
        "BandLeaderboardIndices": [186, 547, 2151, 209, 567],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 101012,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1941, 2152, 211, 2056, 236],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 47925,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2093, 1412, 1090, 2053, 1040],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 83825,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [609, 94, 1829, 1180, 593],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2046, 61, 1221, 414, 1596],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SANTERIA: {
        "Title": "Santeria",
        "Artist": "Sublime",
        "Year": 1996,
        "BandLeaderboardIndices": [1984, 399, 382, 1767, 30],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 36812,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1519, 969, 475, 2024, 1286],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 34418,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1126, 318, 852, 1477, 135],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 70242,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [596, 1648, 1091, 1881, 442],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1569, 804, 525, 218, 1809],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SATCH_BOOGIE: {
        "Title": "Satch Boogie",
        "Artist": "Joe Satriani",
        "Year": 1987,
        "BandLeaderboardIndices": [691, 300, 1094, 613, 932],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 74469,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1493, 2140, 1735, 761, 1517],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 33742,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [28, 2022, 119, 1060, 1015],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 78379,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1814, 87, 1418, 1302, 1228],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SCHISM: {
        "Title": "Schism",
        "Artist": "Tool",
        "Year": 2001,
        "BandLeaderboardIndices": [340, 1857, 90, 1248, 1201],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 84100,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [515, 1258, 32, 1876, 863],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 79989,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [271, 1828, 1522, 1322, 638],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 108375,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1437, 1657, 1698, 1915, 1029],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1763, 327, 1822, 2005, 968],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SCREAM_AIM_FIRE: {
        "Title": "Scream Aim Fire",
        "Artist": "Bullet For My Valentine",
        "Year": 2008,
        "BandLeaderboardIndices": [16, 141, 1067, 528, 1053],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 103668,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [228, 688, 1671, 443, 100],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 65986,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [226, 43, 878, 1554, 1643],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 129444,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [977, 2075, 1982, 1219, 1866],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [832, 1365, 1191, 670, 1630],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SHIVER: {
        "Title": "Shiver",
        "Artist": "Coldplay",
        "Year": 2000,
        "BandLeaderboardIndices": [27, 1035, 1993, 295, 805],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 96425,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1552, 599, 955, 1342, 1073],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 27100,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [511, 1791, 1774, 176, 1501],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 109725,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1682, 1404, 581, 901, 42],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 25500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1637, 586, 1230, 714, 202],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SOME_MIGHT_SAY: {
        "Title": "Some Might Say",
        "Artist": "Oasis",
        "Year": 1995,
        "BandLeaderboardIndices": [1821, 1347, 750, 1080, 1376],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 75171,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2180, 356, 1439, 1711, 730],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 63066,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2036, 0, 793, 1531, 903],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 120525,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [153, 636, 500, 458, 1428],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2142, 234, 143, 29, 33],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SOUL_DOUBT: {
        "Title": "Soul Doubt",
        "Artist": "Nofx",
        "Year": 1992,
        "BandLeaderboardIndices": [316, 918, 1685, 989, 1868],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 68264,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2120, 795, 841, 1720, 1449],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 47226,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1442, 2229, 1639, 787, 615],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 102375,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1598, 1563, 504, 1750, 1254],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1328, 1640, 1198, 539, 1278],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SPIDERWEBS: {
        "Title": "Spiderwebs",
        "Artist": "No Doubt",
        "Year": 1995,
        "BandLeaderboardIndices": [1361, 1525, 1314, 1033, 1284],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 74276,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [807, 195, 743, 628, 726],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 63888,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [341, 1585, 595, 1532, 870],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 124675,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1013, 895, 204, 2123, 2198],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 37000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [837, 1977, 2208, 1222, 387],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_STILLBORN: {
        "Title": "Stillborn",
        "Artist": "Black Label Society",
        "Year": 2003,
        "BandLeaderboardIndices": [626, 2107, 306, 884, 421],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 48989,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [453, 2096, 370, 1425, 894],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 37470,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [666, 1897, 920, 1054, 1661],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 80075,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1729, 876, 879, 2101, 1244],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1588, 2042, 644, 1576, 693],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_STRANGLEHOLD: {
        "Title": "Stranglehold",
        "Artist": "Ted Nugent",
        "Year": 1975,
        "BandLeaderboardIndices": [35, 159, 420, 1586, 486],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 117622,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [180, 336, 1069, 147, 1617],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 109643,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2134, 394, 345, 530, 2057],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 191150,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [405, 2020, 1305, 321, 2194],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [257, 678, 1320, 1447, 661],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_SWEET_HOME_ALABAMA_LIVE: {
        "Title": "Sweet Home Alabama (Live)",
        "Artist": "Lynyrd Skynyrd",
        "Year": 1976,
        "BandLeaderboardIndices": [1819, 1448, 1799, 452, 850],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 131954,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [239, 985, 1008, 291, 1718],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 68447,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [73, 1880, 151, 867, 491],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 121770,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [290, 568, 2202, 411, 633],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1146, 338, 1074, 584, 2018],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_TED_NUGENT_GUITAR_DUEL: {
        "Title": "Ted Nugent Guitar Duel",
        "Artist": "Ted Nugent",
        "Year": 2008,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54352,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1776, 680, 1313, 2001, 1392],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_TODAY: {
        "Title": "Today",
        "Artist": "The Smashing Pumpkins",
        "Year": 1993,
        "BandLeaderboardIndices": [1142, 727, 1564, 1733, 1966],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 42853,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1725, 704, 1765, 834, 96],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 32113,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1168, 1730, 571, 1936, 1991],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 73625,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1633, 1429, 1453, 1694, 81],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [375, 380, 869, 1972, 1250],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST: {
        "Title": "Too Much, Too Young, Too Fast",
        "Artist": "Airbourne",
        "Year": 2007,
        "BandLeaderboardIndices": [465, 931, 2045, 1571, 754],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 51090,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1113, 527, 1699, 1098, 1306],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 37324,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [854, 479, 1695, 1351, 1938],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 76000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1433, 314, 532, 1597, 1616],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 17500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [317, 1327, 566, 266, 1853],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_TOY_BOY: {
        "Title": "Toy Boy",
        "Artist": "Stuck In The Sound",
        "Year": 2007,
        "BandLeaderboardIndices": [335, 432, 1808, 664, 516],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 114669,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1726, 1937, 2112, 1740, 565],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 59450,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [651, 712, 1675, 1190, 378],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 122025,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1717, 600, 1742, 1326, 2149],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 31500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [826, 1985, 269, 2178, 2171],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_TRAPPED_UNDER_ICE: {
        "Title": "Trapped Under Ice",
        "Artist": "Metallica",
        "Year": 1984,
        "BandLeaderboardIndices": [1812, 208, 2007, 1343, 1259],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 89315,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1489, 50, 261, 1940, 806],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 65587,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [928, 342, 424, 1131, 1909],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 160875,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [439, 2225, 2201, 523, 1427],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 16000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [383, 154, 1282, 1473, 537],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_UP_AROUND_THE_BEND: {
        "Title": "Up Around the Bend",
        "Artist": "Creedence Clearwater Revival",
        "Year": 1970,
        "BandLeaderboardIndices": [126, 163, 172, 1249, 689],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 44299,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [608, 919, 2174, 990, 2111],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 33987,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2043, 2064, 2217, 1947, 569],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 64125,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1346, 662, 1805, 54, 1787],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1005, 37, 1114, 1132, 1773],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_VICARIOUS: {
        "Title": "Vicarious",
        "Artist": "Tool",
        "Year": 2006,
        "BandLeaderboardIndices": [656, 1292, 1262, 1951, 1499],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 105988,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1400, 478, 553, 630, 707],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 93755,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2164, 1172, 762, 1171, 835],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 163550,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [214, 668, 1218, 1625, 104],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 31500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1243, 256, 1601, 695, 1515],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_VINTERNOLL2: {
        "Title": "Vinternoll2",
        "Artist": "Kent",
        "Year": 2002,
        "BandLeaderboardIndices": [2080, 1085, 1925, 1697, 445],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 61928,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1255, 77, 937, 374, 1965],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51025,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1441, 1861, 861, 2074, 1066],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 118750,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1257, 389, 152, 1124, 601],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [428, 2069, 2094, 13, 965],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_WEAPON_OF_CHOICE: {
        "Title": "Weapon of Choice",
        "Artist": "Black Rebel Motorcycle Club",
        "Year": 2007,
        "BandLeaderboardIndices": [2102, 2224, 1842, 149, 603],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 56277,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [943, 1263, 1795, 1078, 1658],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29094,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2023, 857, 1123, 324, 2248],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 72075,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1632, 616, 62, 47, 2147],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [301, 675, 1666, 1670, 1891],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_WHAT_IVE_DONE: {
        "Title": "What I've Done",
        "Artist": "Linkin Park",
        "Year": 2007,
        "BandLeaderboardIndices": [165, 1128, 847, 146, 1867],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 46905,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2052, 1481, 687, 999, 1615],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 20175,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [645, 127, 813, 170, 1727],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 57975,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [722, 1081, 649, 120, 1133],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 11500,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [377, 634, 2113, 366, 1558],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_THE_WIND_CRIES_MARY: {
        "Title": "The Wind Cries Mary",
        "Artist": "Jimi Hendrix",
        "Year": 1967,
        "BandLeaderboardIndices": [1199, 272, 1019, 517, 2211],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 50366,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [2157, 2154, 950, 1110, 842],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 23686,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [799, 557, 2165, 703, 2008],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 49575,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1707, 1487, 773, 748, 1568],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 10000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [642, 1890, 1613, 1749, 782],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_YOURE_GONNA_SAY_YEAH: {
        "Title": "You're Gonna Say Yeah",
        "Artist": "The Hush Puppies",
        "Year": 2006,
        "BandLeaderboardIndices": [1291, 302, 949, 1872, 791],
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 73335,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1910, 816, 1024, 1755, 646],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38900,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [939, 1251, 1533, 777, 1252],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 86225,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1540, 1283, 1736, 1690, 1386],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22000,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [1996, 45, 1889, 1472, 187],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    SONG_ZAKK_WYLDE_GUITAR_DUEL: {
        "Title": "Zakk Wylde Guitar Duel",
        "Artist": "Zakk Wylde",
        "Year": 2008,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52082,
                "LeaderboardHashes": [0xdeadbeef, 0xffffbeef, 0xaaaabeef, 0xbbbbbeef, 0xccccbeef],
                "LeaderboardIndices": [391, 1368, 25, 1467, 1298],
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    }
}

function did_achieve_expert_five_star_score(song_ids, instrument_id, base_score) {
    return did_reach_you_rock()
        && score() >= base_score * 14 / 5
        && any_of(song_ids, song_id => current_song() == song_id)
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
}

function leaderboard_start(song_ids, instrument_id, difficulty_id) {
    return (player_notes_passed(1) >= 1 || player_vocal_phrases_passed(1) >= 1)
        && prev(score()) == 0
        && any_of(song_ids, song_id => current_song() == song_id)
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == difficulty_id
        && are_all_cheats_off()
}

function leaderboard_cancel() {
    return !is_in_song()
}

function leaderboard_submit() {
    return did_reach_you_rock()
}

for song in SONG_INFO {
    song_name = SONG_INFO[song]["Title"]
    for instrument in SONG_INFO[song]["Instruments"] {
        instrument_name = INSTRUMENT_TO_NAME[instrument]
        base_score = SONG_INFO[song]["Instruments"][instrument]["ExpertBaseScore"]
        achievement_id = SONG_INFO[song]["Instruments"][instrument]["FiveStarAchievementId"]
        achievement(
            title = format("{0} - Expert {1} Five Star", song_name, instrument_name),
            description = format("Reach a score of {0} in {1} on Expert {2}", format_int_with_commas(base_score * 14 / 5), song_name, instrument_name),
            points = 5,
            id = achievement_id,
            trigger = did_achieve_expert_five_star_score([song], instrument, base_score)
        )

        for difficulty_id in DIFFICULTY_TO_NAME {
            if (difficulty_id != DIFFICULTY_BEGINNER) { // Leaving out beginner difficulty for leaderboards.
                difficulty_name = DIFFICULTY_TO_NAME[difficulty_id]
                leaderboard(
                    title = format("{0} - {1} {2}", song_name, difficulty_name, instrument_name),
                    description = format("Get the highest score in {1} on {2} {3}", format_int_with_commas(base_score * 14 / 5), song_name, difficulty_name, instrument_name),
                    id = 0,
                    start = leaderboard_start([song], instrument, difficulty_id),
                    cancel = leaderboard_cancel(),
                    submit = leaderboard_submit(),
                    value = score(),
                    format = "VALUE"
                )
            }
        }
    }
}

function did_achieve_low_beginner_score() {
    return did_reach_you_rock()
        && score() <= 1000
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && player_difficulty(1) == DIFFICULTY_BEGINNER
        && are_all_cheats_off()
}

achievement(
    title = "John Cage Performance",
    description = "Finish any non-custom song with any instrument on Beginner difficulty with 1,000 points or less",
    points = 2,
    id = 0,
    trigger = did_achieve_low_beginner_score()
)

function did_fail_dammit() {
    return player_rock_meter(1) <= 0.0
        && prev(player_rock_meter(1)) > 0.0
        && player_notes_passed(1) > 0
        && current_song() == SONG_DAMMIT
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && are_all_cheats_off()
}

achievement(
    title = "Failed Dammit",
    description = "Demonstrate the usefulness of commas",
    points = 0,
    id = 0,
    trigger = did_fail_dammit()
)

function did_100_percent_song() {
    return (
        did_reach_you_rock()
            && player_notes_hit(1) == player_notes_passed(1)
            && !is_in_custom_song()
            && number_of_active_players() == 1
            && (player_instrument(1) == INSTRUMENT_GUITAR || player_instrument(1) == INSTRUMENT_BASS || player_difficulty(1) == INSTRUMENT_DRUMS)
            && (player_difficulty(1) == DIFFICULTY_HARD || player_difficulty(1) == DIFFICULTY_EXPERT)
            && are_all_cheats_off()
    ) || (
        did_reach_you_rock()
            && player_vocal_phrases_hit(1) * 1.0 == player_vocal_phrases_passed(1)
            && !is_in_custom_song()
            && number_of_active_players() == 1
            && player_instrument(1) == INSTRUMENT_VOCALS
            && (player_difficulty(1) == DIFFICULTY_HARD || player_difficulty(1) == DIFFICULTY_EXPERT)
            && are_all_cheats_off()
    )
}

achievement(
    title = "Golden Performance",
    description = "Hit 100% of the notes in any non-custom song on any instrument on either Hard or Expert",
    points = 10,
    id = 0,
    trigger = did_100_percent_song()
)

VOXTAR_ACHIEVEMENT_INFO = [
    {
        "Song": SONG_HOTEL_CALIFORNIA,
        "Instrument": INSTRUMENT_DRUMS,
        "AchievementId": 0,
        "AchievementTitle": "They Just Can't Kill the Beast"
    },
    {
        "Song": SONG_BAND_ON_THE_RUN,
        "Instrument": INSTRUMENT_BASS,
        "AchievementId": 0,
        "AchievementTitle": "I Hope You're Having Fun"
    },
    {
        "Song": SONG_DEMOLITION_MAN_LIVE,
        "Instrument": INSTRUMENT_BASS,
        "AchievementId": 0,
        "AchievementTitle": "I'm a Walking Nightmare"
    },
    {
        "Song": SONG_OVERKILL,
        "Instrument": INSTRUMENT_BASS,
        "AchievementId": 0,
        "AchievementTitle": "Shut It Down"
    },
    {
        "Song": SONG_TODAY,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 0,
        "AchievementTitle": "My Angel Wings"
    },
    {
        "Song": SONG_STILLBORN,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 0,
        "AchievementTitle": "I've Waited Here For You"
    },
    {
        "Song": SONG_THE_WIND_CRIES_MARY,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 0,
        "AchievementTitle": "Will the Wind Ever Remember"
    },
    {
        "Song": SONG_PURPLE_HAZE_LIVE,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 0,
        "AchievementTitle": "You Make Me Blow My Mind"
    },
    {
        "Song": SONG_TRAPPED_UNDER_ICE,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 0,
        "AchievementTitle": "No Release From My Cryonic State"
    }
]

function did_achieve_expert_five_star_score_dual_vocal(song, primary_instrument, base_score) {
    return (
        did_reach_you_rock()
        && score() >= base_score * 14 / 5
        && current_song() == song
        && !is_in_custom_song()
        && number_of_active_players() == 2
        && player_instrument(1) == primary_instrument
        && player_instrument(2) == INSTRUMENT_VOCALS
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && player_difficulty(2) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
    ) || (
        did_reach_you_rock()
        && score() >= base_score * 14 / 5
        && current_song() == song
        && !is_in_custom_song()
        && number_of_active_players() == 2
        && player_instrument(1) == INSTRUMENT_VOCALS
        && player_instrument(2) == primary_instrument
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && player_difficulty(2) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
    )
}

for achievement_info in VOXTAR_ACHIEVEMENT_INFO {
    song = achievement_info["Song"]
    song_name = SONG_INFO[song]["Title"]
    primary_instrument = achievement_info["Instrument"]
    instrument_name = INSTRUMENT_TO_NAME[primary_instrument]
    base_score = SONG_INFO[song]["Instruments"][primary_instrument]["ExpertBaseScore"] + SONG_INFO[song]["Instruments"][INSTRUMENT_VOCALS]["ExpertBaseScore"]
    achievement_title = achievement_info["AchievementTitle"]
    achievement_id = achievement_info["AchievementId"]
    achievement(
        title = achievement_title,
        description = format("Reach a score of {0} in {1} playing both Expert {2} and Expert Vocals by yourself", format_int_with_commas(base_score * 14 / 5), song_name, instrument_name),
        points = 10,
        id = achievement_id,
        trigger = did_achieve_expert_five_star_score_dual_vocal(song, primary_instrument, base_score)
    )
}

// #endregion

// #region CUSTOM SONGS
CUSTOM_SONG_AMAZING      = 0x0032
CUSTOM_SONG_BEE          = 0x00ca
CUSTOM_SONG_BOUREE       = 0x00c4
CUSTOM_SONG_FURELISE     = 0x00bd
CUSTOM_SONG_FUTUREFREAK  = 0x0065
CUSTOM_SONG_GREENSLEEVES = 0x007c
CUSTOM_SONG_ILIKEDIRT    = 0x00a4
CUSTOM_SONG_JAMANDTOAST  = 0x00f1
CUSTOM_SONG_LANOCHE      = 0x0151
CUSTOM_SONG_LASERBOP     = 0x00db
CUSTOM_SONG_MAPLELEAF    = 0x0125
CUSTOM_SONG_PORTO        = 0x007f
CUSTOM_SONG_RAJAFUNSHINE = 0x00f8
CUSTOM_SONG_ROCKHOP      = 0x00c6
CUSTOM_SONG_RONDO        = 0x0162
CUSTOM_SONG_STARSPANGLED = 0x0062
CUSTOM_SONG_YANDZ        = 0x0116

CUSTOM_SONG_INFO = {
    CUSTOM_SONG_AMAZING: {
        "Title": "Amazing",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 13910,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 11100,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 19250,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_BEE: {
        "Title": "Bee",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 34374,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 15321,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 44700,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_BOUREE: {
        "Title": "Bouree",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 16500,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 14750,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 48175,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_FURELISE: {
        "Title": "FurElise",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 29612,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 17622,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 44175,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_FUTUREFREAK: {
        "Title": "FutureFreak",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 24979,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 15850,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 21500,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_GREENSLEEVES: {
        "Title": "Greensleeves",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 14573,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 11300,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 29200,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_ILIKEDIRT: {
        "Title": "ILikeDirt",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 29464,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 14864,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 20000,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_JAMANDTOAST: {
        "Title": "JamAndToast",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 39097,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 9597,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 29250,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_LANOCHE: {
        "Title": "LaNoche",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 18765,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 20732,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 45400,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_LASERBOP: {
        "Title": "LaserBop",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 16192,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 12082,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 27825,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_MAPLELEAF: {
        "Title": "MapleLeaf",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 39263,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 28126,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 46550,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_PORTO: {
        "Title": "Porto",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 24300,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 12494,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 33550,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_RAJAFUNSHINE: {
        "Title": "RajaFunshine",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 17494,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 15010,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 30950,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_ROCKHOP: {
        "Title": "RockHop",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 26871,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 17400,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 36000,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_RONDO: {
        "Title": "Rondo",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 46919,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 43706,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 69675,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_STARSPANGLED: {
        "Title": "StarSpangled",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 8415,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 7176,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 23400,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    },
    CUSTOM_SONG_YANDZ: {
        "Title": "YandZ",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 63969,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 19400,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 40350,
                "FiveStarAchievementId": 0,
                "LeaderboardIds": [0, 0, 0, 0, 0]
            }
        }
    }
}

CUSTOM_SONG_ADDR = 0x00426bf0
function current_custom_song_id() {
    return dword(CUSTOM_SONG_ADDR)
}

function custom_song_did_achieve_expert_five_star_score(song_id, instrument_id, base_score) {
    return did_reach_you_rock()
        && score() >= base_score * 14 / 5
        && current_custom_song_id() == song_id
        && is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
}

function custom_song_leaderboard_start(song_id, instrument_id, difficulty_id) {
    return (player_notes_passed(1) >= 1 || player_vocal_phrases_passed(1) >= 1)
        && prev(score()) == 0
        && current_custom_song_id() == song_id
        && is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == difficulty_id
        && are_all_cheats_off()
}

function custom_song_leaderboard_cancel() {
    return !is_in_song()
}

function custom_song_leaderboard_submit() {
    return did_reach_you_rock()
}

for song in CUSTOM_SONG_INFO {
    song_name = CUSTOM_SONG_INFO[song]["Title"]
    for instrument in CUSTOM_SONG_INFO[song]["Instruments"] {
        instrument_name = INSTRUMENT_TO_NAME[instrument]
        base_score = CUSTOM_SONG_INFO[song]["Instruments"][instrument]["ExpertBaseScore"]
        achievement_id = CUSTOM_SONG_INFO[song]["Instruments"][instrument]["FiveStarAchievementId"]
        achievement(
            title = format("{0} - Expert {1} Five Star", song_name, instrument_name),
            description = format("Reach a score of {0} in the custom song {1} on Expert {2}", format_int_with_commas(base_score * 14 / 5), song_name, instrument_name),
            points = 5,
            id = achievement_id,
            trigger = custom_song_did_achieve_expert_five_star_score(song, instrument, base_score)
        )

        for difficulty_id in DIFFICULTY_TO_NAME {
            if (difficulty_id != DIFFICULTY_BEGINNER) { // Leaving out beginner difficulty for leaderboards.
                difficulty_name = DIFFICULTY_TO_NAME[difficulty_id]
                leaderboard(
                    title = format("{0} - {1} {2}", song_name, difficulty_name, instrument_name),
                    description = format("Get the highest score in the custom song {1} on {2} {3}", format_int_with_commas(base_score * 14 / 5), song_name, difficulty_name, instrument_name),
                    id = 0,
                    start = custom_song_leaderboard_start(song, instrument, difficulty_id),
                    cancel = custom_song_leaderboard_cancel(),
                    submit = custom_song_leaderboard_submit(),
                    value = score(),
                    format = "VALUE"
                )
            }
        }
    }
}

function custom_song_did_achieve_expert_vocals_full_combo() {
    neversoft_song_condition = always_true()
    for song in CUSTOM_SONG_INFO {
        neversoft_song_condition = neversoft_song_condition && current_custom_song_id() == song
    }
    return did_reach_you_rock()
        && player_vocal_phrases_hit(1) == 1 // This is the gag, all GHTunes songs are one phrase.
        && neversoft_song_condition
        && is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == INSTRUMENT_VOCALS
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
}

achievement(
    title = "MIDI Master",
    description = "Full combo any Neversoft-made custom song on Expert Vocals",
    points = 3,
    id = 0,
    trigger = custom_song_did_achieve_expert_vocals_full_combo()
)

function original_custom_song_did_achieve_expert_five_star_score() {
    original_song_condition = always_true()
    for song in CUSTOM_SONG_INFO {
        original_song_condition = original_song_condition && current_custom_song_id() != song
    }
    return did_reach_you_rock()
        && player_stars_earned(1) == 5
        && player_notes_passed(1) >= 500
        && original_song_condition
        && is_in_custom_song()
        && number_of_active_players() == 1
        && (player_instrument(1) == INSTRUMENT_GUITAR || player_instrument(1) == INSTRUMENT_BASS || player_instrument(1) == INSTRUMENT_DRUMS)
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
}

achievement(
    title = "Modern Day Mozart",
    description = "Five star your own GHTunes song on either Expert Guitar, Expert Bass, or Expert Drums (must have at least 500 notes)",
    points = 5,
    id = 0,
    trigger = original_custom_song_did_achieve_expert_five_star_score()
)

// #endregion

// #region CAREER

CAREER_INFO = {
    INSTRUMENT_GUITAR: [
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_LIVIN_ON_A_PRAYER,
                SONG_ABOUT_A_GIRL_UNPLUGGED,
                SONG_MOUNTAIN_SONG
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Wilted Orchid",
            "GigNumber": 0,
            "Songs": [
                SONG_BEAUTIFUL_DISASTER,
                SONG_OBSTACLE_1,
                SONG_THE_ONE_I_LOVE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_SOME_MIGHT_SAY,
                SONG_TODAY,
                SONG_WHAT_IVE_DONE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Pang Tang Bay",
            "GigNumber": 0,
            "Songs": [
                SONG_BAND_ON_THE_RUN,
                SONG_YOURE_GONNA_SAY_YEAH,
                SONG_UP_AROUND_THE_BEND,
                SONG_NO_SLEEP_TILL_BROOKLYN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Amoeba Records",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_JOKER,
                SONG_FREAK_ON_A_LEASH,
                SONG_MISERY_BUSINESS,
                SONG_HOTEL_CALIFORNIA
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 1,
            "Songs": [
                SONG_EYE_OF_THE_TIGER,
                SONG_DO_IT_AGAIN,
                SONG_SPIDERWEBS,
                SONG_ONE_WAY_OR_ANOTHER,
                SONG_ZAKK_WYLDE_GUITAR_DUEL,
                SONG_STILLBORN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Rock Brigade",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_MIDDLE,
                SONG_HEY_MAN_NICE_SHOT,
                SONG_FEEL_THE_PAIN,
                SONG_DAMMIT,
                SONG_EVERLONG
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Strutter's Farm",
            "GigNumber": 0,
            "Songs": [
                SONG_HEARTBREAKER,
                SONG_AMERICAN_WOMAN,
                SONG_RAMBLIN_MAN,
                SONG_GO_YOUR_OWN_WAY,
                SONG_TED_NUGENT_GUITAR_DUEL,
                SONG_STRANGLEHOLD
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "House of Blues",
            "GigNumber": 0,
            "Songs": [
                SONG_LVIA_LVIAQUEZ,
                SONG_KICK_OUT_THE_JAMS,
                SONG_SANTERIA,
                SONG_ON_THE_ROAD_AGAIN_LIVE,
                SONG_LOVE_ME_TWO_TIMES
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 2,
            "Songs": [
                SONG_MONSOON,
                SONG_AGGRO,
                SONG_ROOFTOPS_A_LIBERATION_BROADCAST,
                SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST,
                SONG_FLOAT_ON
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 1,
            "Songs": [
                SONG_THE_KILL,
                SONG_SHIVER,
                SONG_REBEL_YELL,
                SONG_DEMOLITION_MAN_LIVE,
                SONG_BEAT_IT
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 2,
            "Songs": [
                SONG_LAZY_EYE,
                SONG_PRETTY_VACANT,
                SONG_NUVOLE_E_LENZUOLA,
                SONG_TOY_BOY,
                SONG_HAIL_TO_THE_FREAKS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "AT&T Park",
            "GigNumber": 0,
            "Songs": [
                SONG_ARE_YOU_GONNA_GO_MY_WAY,
                SONG_SWEET_HOME_ALABAMA_LIVE,
                SONG_ASSASSIN,
                SONG_ESCUELA_DE_CALOR,
                SONG_THE_WIND_CRIES_MARY,
                SONG_PURPLE_HAZE_LIVE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 1,
            "Songs": [
                SONG_VINTERNOLL2,
                SONG_WEAPON_OF_CHOICE,
                SONG_GOOD_GOD,
                SONG_ONE_ARMED_SCISSOR,
                SONG_HOLLYWOOD_NIGHTS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 2,
            "Songs": [
                SONG_LOVE_REMOVAL_MACHINE,
                SONG_OUR_TRUTH,
                SONG_ANTISOCIAL,
                SONG_PRISONER_OF_SOCIETY,
                SONG_MR_CROWLEY,
                SONG_CRAZY_TRAIN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Times Square",
            "GigNumber": 0,
            "Songs": [
                SONG_RE_EDUCATION_THROUGH_LABOR,
                SONG_LA_BAMBA,
                SONG_SCREAM_AIM_FIRE,
                SONG_OVERKILL,
                SONG_BYOB,
                SONG_TRAPPED_UNDER_ICE,
                SONG_HOT_FOR_TEACHER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Sunna's Chariot",
            "GigNumber": 0,
            "Songs": [
                SONG_LOVE_SPREADS,
                SONG_NEVER_TOO_LATE,
                SONG_SOUL_DOUBT,
                SONG_PULL_ME_UNDER,
                SONG_SATCH_BOOGIE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        }
    ],
    INSTRUMENT_BASS: [
        {
            "Venue": "Wilted Orchid",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_ONE_I_LOVE,
                SONG_OBSTACLE_1,
                SONG_BEAUTIFUL_DISASTER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_WHAT_IVE_DONE,
                SONG_TODAY,
                SONG_SOME_MIGHT_SAY
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_ABOUT_A_GIRL_UNPLUGGED,
                SONG_LIVIN_ON_A_PRAYER,
                SONG_MOUNTAIN_SONG
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Pang Tang Bay",
            "GigNumber": 0,
            "Songs": [
                SONG_NO_SLEEP_TILL_BROOKLYN,
                SONG_BAND_ON_THE_RUN,
                SONG_UP_AROUND_THE_BEND,
                SONG_YOURE_GONNA_SAY_YEAH
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Amoeba Records",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_JOKER,
                SONG_HOTEL_CALIFORNIA,
                SONG_MISERY_BUSINESS,
                SONG_FREAK_ON_A_LEASH
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 1,
            "Songs": [
                SONG_ONE_WAY_OR_ANOTHER,
                SONG_EYE_OF_THE_TIGER,
                SONG_SPIDERWEBS,
                SONG_STILLBORN,
                SONG_DO_IT_AGAIN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Rock Brigade",
            "GigNumber": 0,
            "Songs": [
                SONG_FEEL_THE_PAIN,
                SONG_THE_MIDDLE,
                SONG_EVERLONG,
                SONG_DAMMIT,
                SONG_HEY_MAN_NICE_SHOT
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Strutter's Farm",
            "GigNumber": 0,
            "Songs": [
                SONG_AMERICAN_WOMAN,
                SONG_GO_YOUR_OWN_WAY,
                SONG_HEARTBREAKER,
                SONG_STRANGLEHOLD,
                SONG_RAMBLIN_MAN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 1,
            "Songs": [
                SONG_BEAT_IT,
                SONG_SHIVER,
                SONG_REBEL_YELL,
                SONG_DEMOLITION_MAN_LIVE,
                SONG_THE_KILL
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 2,
            "Songs": [
                SONG_MONSOON,
                SONG_AGGRO,
                SONG_ROOFTOPS_A_LIBERATION_BROADCAST,
                SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST,
                SONG_FLOAT_ON
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "House of Blues",
            "GigNumber": 0,
            "Songs": [
                SONG_ON_THE_ROAD_AGAIN_LIVE,
                SONG_KICK_OUT_THE_JAMS,
                SONG_LOVE_ME_TWO_TIMES,
                SONG_SANTERIA,
                SONG_LVIA_LVIAQUEZ
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 2,
            "Songs": [
                SONG_LAZY_EYE,
                SONG_PRETTY_VACANT,
                SONG_NUVOLE_E_LENZUOLA,
                SONG_TOY_BOY,
                SONG_HAIL_TO_THE_FREAKS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "AT&T Park",
            "GigNumber": 0,
            "Songs": [
                SONG_SWEET_HOME_ALABAMA_LIVE,
                SONG_ARE_YOU_GONNA_GO_MY_WAY,
                SONG_ESCUELA_DE_CALOR,
                SONG_ASSASSIN,
                SONG_THE_WIND_CRIES_MARY,
                SONG_PURPLE_HAZE_LIVE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 1,
            "Songs": [
                SONG_VINTERNOLL2,
                SONG_WEAPON_OF_CHOICE,
                SONG_GOOD_GOD,
                SONG_ONE_ARMED_SCISSOR,
                SONG_HOLLYWOOD_NIGHTS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 2,
            "Songs": [
                SONG_LOVE_REMOVAL_MACHINE,
                SONG_OUR_TRUTH,
                SONG_ANTISOCIAL,
                SONG_PRISONER_OF_SOCIETY,
                SONG_MR_CROWLEY,
                SONG_CRAZY_TRAIN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Times Square",
            "GigNumber": 0,
            "Songs": [
                SONG_LA_BAMBA,
                SONG_RE_EDUCATION_THROUGH_LABOR,
                SONG_SCREAM_AIM_FIRE,
                SONG_TRAPPED_UNDER_ICE,
                SONG_HOT_FOR_TEACHER,
                SONG_OVERKILL,
                SONG_BYOB
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Sunna's Chariot",
            "GigNumber": 0,
            "Songs": [
                SONG_LOVE_SPREADS,
                SONG_NEVER_TOO_LATE,
                SONG_SOUL_DOUBT,
                SONG_PULL_ME_UNDER,
                SONG_SATCH_BOOGIE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        }
    ],
    INSTRUMENT_DRUMS: [
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_WHAT_IVE_DONE,
                SONG_TODAY,
                SONG_SOME_MIGHT_SAY
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_EYE_OF_THE_TIGER,
                SONG_LIVIN_ON_A_PRAYER,
                SONG_ABOUT_A_GIRL_UNPLUGGED
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Wilted Orchid",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_MIDDLE,
                SONG_THE_ONE_I_LOVE,
                SONG_BEAUTIFUL_DISASTER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Pang Tang Bay",
            "GigNumber": 0,
            "Songs": [
                SONG_BAND_ON_THE_RUN,
                SONG_NO_SLEEP_TILL_BROOKLYN,
                SONG_UP_AROUND_THE_BEND,
                SONG_YOURE_GONNA_SAY_YEAH
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Amoeba Records",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_JOKER,
                SONG_HOTEL_CALIFORNIA,
                SONG_MISERY_BUSINESS,
                SONG_RAMBLIN_MAN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 1,
            "Songs": [
                SONG_DO_IT_AGAIN,
                SONG_ONE_WAY_OR_ANOTHER,
                SONG_SPIDERWEBS,
                SONG_STILLBORN,
                SONG_OBSTACLE_1
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Strutter's Farm",
            "GigNumber": 0,
            "Songs": [
                SONG_HEARTBREAKER,
                SONG_GO_YOUR_OWN_WAY,
                SONG_AMERICAN_WOMAN,
                SONG_STRANGLEHOLD,
                SONG_FREAK_ON_A_LEASH
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Rock Brigade",
            "GigNumber": 0,
            "Songs": [
                SONG_FEEL_THE_PAIN,
                SONG_MOUNTAIN_SONG,
                SONG_HEY_MAN_NICE_SHOT,
                SONG_DAMMIT,
                SONG_EVERLONG
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 1,
            "Songs": [
                SONG_BEAT_IT,
                SONG_REBEL_YELL,
                SONG_SHIVER,
                SONG_DEMOLITION_MAN_LIVE,
                SONG_THE_KILL
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 2,
            "Songs": [
                SONG_MONSOON,
                SONG_AGGRO,
                SONG_ROOFTOPS_A_LIBERATION_BROADCAST,
                SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST,
                SONG_FLOAT_ON
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "House of Blues",
            "GigNumber": 0,
            "Songs": [
                SONG_ON_THE_ROAD_AGAIN_LIVE,
                SONG_LOVE_ME_TWO_TIMES,
                SONG_LVIA_LVIAQUEZ,
                SONG_KICK_OUT_THE_JAMS,
                SONG_SANTERIA
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 2,
            "Songs": [
                SONG_LAZY_EYE,
                SONG_PRETTY_VACANT,
                SONG_NUVOLE_E_LENZUOLA,
                SONG_TOY_BOY,
                SONG_HAIL_TO_THE_FREAKS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "AT&T Park",
            "GigNumber": 0,
            "Songs": [
                SONG_ARE_YOU_GONNA_GO_MY_WAY,
                SONG_ESCUELA_DE_CALOR,
                SONG_SWEET_HOME_ALABAMA_LIVE,
                SONG_ASSASSIN,
                SONG_THE_WIND_CRIES_MARY,
                SONG_PURPLE_HAZE_LIVE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 1,
            "Songs": [
                SONG_VINTERNOLL2,
                SONG_WEAPON_OF_CHOICE,
                SONG_GOOD_GOD,
                SONG_ONE_ARMED_SCISSOR,
                SONG_HOLLYWOOD_NIGHTS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 2,
            "Songs": [
                SONG_LOVE_REMOVAL_MACHINE,
                SONG_ANTISOCIAL,
                SONG_PRISONER_OF_SOCIETY,
                SONG_OUR_TRUTH,
                SONG_MR_CROWLEY,
                SONG_CRAZY_TRAIN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Times Square",
            "GigNumber": 0,
            "Songs": [
                SONG_RE_EDUCATION_THROUGH_LABOR,
                SONG_OVERKILL,
                SONG_LA_BAMBA,
                SONG_SCREAM_AIM_FIRE,
                SONG_TRAPPED_UNDER_ICE,
                SONG_BYOB,
                SONG_HOT_FOR_TEACHER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Sunna's Chariot",
            "GigNumber": 0,
            "Songs": [
                SONG_LOVE_SPREADS,
                SONG_NEVER_TOO_LATE,
                SONG_SOUL_DOUBT,
                SONG_PULL_ME_UNDER,
                SONG_SATCH_BOOGIE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        }
    ],
    INSTRUMENT_VOCALS: [
        {
            "Venue": "Wilted Orchid",
            "GigNumber": 0,
            "Songs": [
                SONG_FEEL_THE_PAIN,
                SONG_THE_ONE_I_LOVE,
                SONG_BEAUTIFUL_DISASTER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_WHAT_IVE_DONE,
                SONG_TODAY,
                SONG_SOME_MIGHT_SAY
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_ABOUT_A_GIRL_UNPLUGGED,
                SONG_MOUNTAIN_SONG,
                SONG_LIVIN_ON_A_PRAYER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Amoeba Records",
            "GigNumber": 0,
            "Songs": [
                SONG_FREAK_ON_A_LEASH,
                SONG_HOTEL_CALIFORNIA,
                SONG_MISERY_BUSINESS,
                SONG_THE_JOKER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Pang Tang Bay",
            "GigNumber": 0,
            "Songs": [
                SONG_NO_SLEEP_TILL_BROOKLYN,
                SONG_UP_AROUND_THE_BEND,
                SONG_YOURE_GONNA_SAY_YEAH,
                SONG_BAND_ON_THE_RUN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 1,
            "Songs": [
                SONG_RAMBLIN_MAN,
                SONG_DO_IT_AGAIN,
                SONG_EYE_OF_THE_TIGER,
                SONG_STILLBORN,
                SONG_SPIDERWEBS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Rock Brigade",
            "GigNumber": 0,
            "Songs": [
                SONG_OBSTACLE_1,
                SONG_HEY_MAN_NICE_SHOT,
                SONG_THE_MIDDLE,
                SONG_DAMMIT,
                SONG_EVERLONG
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Strutter's Farm",
            "GigNumber": 0,
            "Songs": [
                SONG_HEARTBREAKER,
                SONG_GO_YOUR_OWN_WAY,
                SONG_AMERICAN_WOMAN,
                SONG_STRANGLEHOLD,
                SONG_ONE_WAY_OR_ANOTHER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "House of Blues",
            "GigNumber": 0,
            "Songs": [
                SONG_OVERKILL,
                SONG_TRAPPED_UNDER_ICE,
                SONG_SANTERIA,
                SONG_ON_THE_ROAD_AGAIN_LIVE,
                SONG_LOVE_ME_TWO_TIMES
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Swamp Shack",
            "GigNumber": 2,
            "Songs": [
                SONG_MONSOON,
                SONG_AGGRO,
                SONG_ROOFTOPS_A_LIBERATION_BROADCAST,
                SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST,
                SONG_FLOAT_ON
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 1,
            "Songs": [
                SONG_SCREAM_AIM_FIRE,
                SONG_REBEL_YELL,
                SONG_THE_KILL,
                SONG_DEMOLITION_MAN_LIVE,
                SONG_SHIVER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Will Heilm's Keep",
            "GigNumber": 2,
            "Songs": [
                SONG_LAZY_EYE,
                SONG_PRETTY_VACANT,
                SONG_NUVOLE_E_LENZUOLA,
                SONG_TOY_BOY,
                SONG_HAIL_TO_THE_FREAKS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 1,
            "Songs": [
                SONG_PRISONER_OF_SOCIETY,
                SONG_LOVE_REMOVAL_MACHINE,
                SONG_OUR_TRUTH,
                SONG_ANTISOCIAL,
                SONG_MR_CROWLEY,
                SONG_CRAZY_TRAIN
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Ozzfest",
            "GigNumber": 2,
            "Songs": [
                SONG_VINTERNOLL2,
                SONG_WEAPON_OF_CHOICE,
                SONG_GOOD_GOD,
                SONG_ONE_ARMED_SCISSOR,
                SONG_HOLLYWOOD_NIGHTS
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "AT&T Park",
            "GigNumber": 0,
            "Songs": [
                SONG_ARE_YOU_GONNA_GO_MY_WAY,
                SONG_ASSASSIN,
                SONG_SWEET_HOME_ALABAMA_LIVE,
                SONG_ESCUELA_DE_CALOR,
                SONG_THE_WIND_CRIES_MARY,
                SONG_PURPLE_HAZE_LIVE
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Times Square",
            "GigNumber": 0,
            "Songs": [
                SONG_HOT_FOR_TEACHER,
                SONG_LA_BAMBA,
                SONG_KICK_OUT_THE_JAMS,
                SONG_RE_EDUCATION_THROUGH_LABOR,
                SONG_BYOB,
                SONG_LVIA_LVIAQUEZ,
                SONG_BEAT_IT
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        },
        {
            "Venue": "Sunna's Chariot",
            "GigNumber": 0,
            "Songs": [
                SONG_LOVE_SPREADS,
                SONG_NEVER_TOO_LATE,
                SONG_SOUL_DOUBT,
                SONG_PULL_ME_UNDER
            ],
            "CompleteGigAnyAchievementId": 0,
            "CompleteGigExpertAchievementId": 0
        }
    ]
}

// If expert_only is false, this is easy+normal+hard+expert.
function has_player_completed_all_songs_in_gig(gig_songs, instrument, expert_only) {
    difficulty_restriction = always_true()
    if (expert_only) {
        difficulty_restriction = player_difficulty(1) == DIFFICULTY_EXPERT
    } else {
        difficulty_restriction = player_difficulty(1) != DIFFICULTY_BEGINNER
    }
    songs_cleared = []
    for song in gig_songs {
        array_push(songs_cleared, once(
            did_reach_you_rock()
                && number_of_active_players() == 1
                && current_song() == song
                && player_instrument(1) == instrument
                && difficulty_restriction
                && are_all_cheats_off()
        ))
    }
    return measured(
        tally(
            length(gig_songs),
            songs_cleared
        )
    )
        && never(!is_in_career_mode_gig())
}

for instrument in CAREER_INFO {
    instrument_name = INSTRUMENT_TO_NAME[instrument]
    for gig in CAREER_INFO[instrument] {
        gig_venue = gig["Venue"]
        any_difficulty_achievement_id = gig["CompleteGigAnyAchievementId"]
        expert_difficulty_achievement_id = gig["CompleteGigExpertAchievementId"]

        if (gig["GigNumber"] == 0) {
            any_difficulty_title = format("{0} Gig at {1}", instrument_name, gig_venue)
            any_difficulty_description = format("Clear the {0} song setlist at the {1} gig in the {2} career on at least Easy difficulty in a single sitting", length(gig["Songs"]), gig_venue, instrument_name)
            expert_difficulty_title = format("{0} Gig at {1} (Expert)", instrument_name, gig_venue)
            expert_difficulty_description = format("Clear the {0} song setlist at the {1} gig in the {2} career on Expert difficulty in a single sitting", length(gig["Songs"]), gig_venue, instrument_name)
        } else if (gig["GigNumber"] == 1) {
            any_difficulty_title = format("{0} Gig at {1} 1", instrument_name, gig_venue)
            any_difficulty_description = format("Clear the {0} song setlist at the first {1} gig in the {2} career on at least Easy difficulty in a single sitting", length(gig["Songs"]), gig_venue, instrument_name)
            expert_difficulty_title = format("{0} Gig at {1} 1 (Expert)", instrument_name, gig_venue)
            expert_difficulty_description = format("Clear the {0} song setlist at the first {1} gig in the {2} career on Expert difficulty in a single sitting", length(gig["Songs"]), gig_venue, instrument_name)
        } else if (gig["GigNumber"] == 2) {
            any_difficulty_title = format("{0} Gig at {1} 2", instrument_name, gig_venue)
            any_difficulty_description = format("Clear the {0} song setlist at the second {1} gig in the {2} career on at least Easy difficulty in a single sitting", length(gig["Songs"]), gig_venue, instrument_name)
            expert_difficulty_title = format("{0} Gig at {1} 2 (Expert)", instrument_name, gig_venue)
            expert_difficulty_description = format("Clear the {0} song setlist at the second {1} gig in the {2} career on Expert difficulty in a single sitting", length(gig["Songs"]), gig_venue, instrument_name)
        }

        achievement(
            title = any_difficulty_title,
            description = any_difficulty_description,
            points = 5,
            id = any_difficulty_achievement_id,
            trigger = has_player_completed_all_songs_in_gig(gig["Songs"], instrument, false)
        )

        achievement(
            title = expert_difficulty_title,
            description = expert_difficulty_description,
            points = 5,
            id = expert_difficulty_achievement_id,
            trigger = has_player_completed_all_songs_in_gig(gig["Songs"], instrument, true)
        )
    }
}

// #endregion

// #region RICH PRESENCE

SONG_TO_NAME = {}
for song in SONG_INFO {
    SONG_TO_NAME[song] = SONG_INFO[song]["Title"]
}

BAND_STAR_POWER_ADDR = 0x005cc768
function band_star_power() {
    return float(BAND_STAR_POWER_ADDR)
}

BAND_STREAK_ADDR = 0x005cc7c8
function band_streak() {
    return dword(BAND_STREAK_ADDR)
}

BACKGROUND_MENU_MUSIC_PLAYING_ADDR = 0x00432c04
function is_background_menu_music_playing_addr() {
    return dword(BACKGROUND_MENU_MUSIC_PLAYING_ADDR) == 0x01
}

IN_GIG_SELECT_ADDR = 0x00451368
function in_gig_select() {
    return dword(IN_GIG_SELECT_ADDR) == 0x01
}

rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && !is_in_custom_song() && number_of_active_players() > 1 && score() > 0, "Rockin' out to {0} as a band - Score: {1}, Streak: {2}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_macro("Number", score()),
    rich_presence_macro("Number", band_streak())
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && !is_in_custom_song() && number_of_active_players() == 1 && player_instrument(1) == INSTRUMENT_VOCALS && score() > 0, "Rockin' out to {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", score()),
    rich_presence_macro("Number", player_streak(1) / 10)
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && !is_in_custom_song() && number_of_active_players() == 1 && score() > 0, "Rockin' out to {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", score()),
    rich_presence_macro("Number", player_streak(1))
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && is_in_custom_song() && number_of_active_players() > 1 && score() > 0, "Rockin' out to a custom song as a band - Score: {0}, Streak: {1}",
    rich_presence_macro("Number", score()),
    rich_presence_macro("Number", band_streak())
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && is_in_custom_song() && number_of_active_players() == 1 && player_instrument(1) == INSTRUMENT_VOCALS && score() > 0, "Rockin' out to a custom song on {0} {1} - Score: {2}, Streak: {3}",
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", score()),
    rich_presence_macro("Number", player_streak(1) / 10)
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && is_in_custom_song() && number_of_active_players() == 1 && score() > 0, "Rockin' out to a custom song on {0} {1} - Score: {2}, Streak: {3}",
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", score()),
    rich_presence_macro("Number", player_streak(1))
)
rich_presence_display("Tuning instruments...")

// #endregion