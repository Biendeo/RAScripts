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
    // In most cases, this is set to 0 after the song results screen.
    // This does not set to 0 after the credits though, so as a best case this tries to detect that the player's money changed, which may potentially not be right.
    return player_money_cut(1) > 0 && prev(player_money_cut(1)) != player_money_cut(1)
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

IN_PRACTICE_MODE_ADDR = 0x00422c50
function is_in_practice_mode() {
    return dword(IN_PRACTICE_MODE_ADDR) == 0x08
}

NUMBER_OF_ACTIVE_PLAYERS_ADDR = 0x004287f4
function number_of_active_players() {
    return dword(NUMBER_OF_ACTIVE_PLAYERS_ADDR)
}

CURRENT_SONG_ID_ADDR = 0x004cf440
function current_song() {
    return dword(CURRENT_SONG_ID_ADDR)
}

P1_SCORE_ADDR = 0x00c42978
function p1_score() {
    return dword(P1_SCORE_ADDR)
}

BAND_SCORE_ADDR = 0x00e106c4
function band_score() {
    return dword(dword(BAND_SCORE_ADDR))
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
    [  2,     500, "Got Some Kicks", 427841],
    [  3,    1000, "Got A Look", 427842],
    [  4,    2000, "Became A Rebel", 427843],
    [  5,    3000, "Found Your Roots", 427844],
    [  6,    4500, "Got A Pet", 427845],
    [  7,    6000, "Signed Your First Deal", 427846],
    [  8,    8000, "Got An Ego", 427847],
    [  9,   11000, "Blew Your Dough", 427848],
    [ 10,   15000, "Had To Show Off", 427849],
    [ 11,   20000, "Signed An Endorsement Deal", 427850],
    [ 12,   25000, "Got Some Cold, Hard, Cash", 427851],
    [ 13,   30000, "Upgraded Your Look", 427852],
    [ 14,   40000, "Got Fancier Taste", 427853],
    [ 15,   50000, "Partied In Cannes", 427854],
    [ 16,   60000, "Vacationed In Egypt", 427855],
    [ 17,   70000, "Brought Back A Pet Lion", 427856],
    [ 18,   80000, "'Hear Me Roar' Became A Gold Record", 427857],
    [ 19,   90000, "Split Up The Band", 427858],
    [ 20,  105000, "Ate Only The Finest", 427859],
    [ 21,  120000, "Bought Your Own Island", 427860],
    [ 22,  135000, "Decided To Go Solo", 427861],
    [ 23,  150000, "Got Richer", 427862],
    [ 24,  165000, "Became Increasingly More Reclusive", 427863],
    [ 25,  180000, "Had A Cameo In A Hip-Hop Track", 427864],
    [ 26,  200000, "Collected Rare Muscle Cars", 427865],
    [ 27,  220000, "Bought A Venus de Milo Knock Off", 427866],
    [ 28,  240000, "Built An Enormous Fish Tank For The New Pet Shark", 427867],
    [ 29,  260000, "Won The 'Best Rock Performance In A Hip-Hop Cameo' Award", 427868],
    [ 30,  280000, "Wrecked Your Car Driving Home From The After Party", 427869],
    [ 31,  305000, "Went To Rehab In Palm Springs", 427870],
    [ 32,  330000, "Decided To Move To Arizona To 'Clear Your Head'", 427871],
    [ 33,  355000, "'Toms of Life' Becomes a Worldwide Hit", 427872],
    [ 34,  380000, "Did A Major Credit Card Commercial", 427873],
    [ 35,  410000, "Got A Weekend Gig in Vegas", 427874],
    [ 36,  440000, "Got Married In Vegas", 427875],
    [ 37,  470000, "Leased A Private Jet", 427876],
    [ 38,  500000, "Bought A Sarcophagus To Sleep In", 427877],
    [ 39,  530000, "Imported A Bengal Tiger", 427878],
    [ 40,  565000, "Got A Star In Hollywood Blvd", 427879],
    [ 41,  600000, "Burned One Million Dollars To Make A Statement", 427880],
    [ 42,  635000, "Started Your Own Beverage Company", 427881],
    [ 43,  670000, "Bought A Castle In France", 427882],
    [ 44,  705000, "Bought A Guitar Manufacturer", 427883],
    [ 45,  745000, "Demanded To Get Paid In Gold Bricks", 427884],
    [ 46,  785000, "Got A Cult Following In Norway", 427885],
    [ 47,  825000, "Became Blinded By Success", 427886],
    [ 48,  865000, "Bought A Decommissioned Submarine From Russia", 427887],
    [ 49,  910000, "Commissioned A Self Portrait", 427888],
    [ 50,  955000, "Replaced Your Butler With A Robot", 427889],
    [ 51, 1000000, "Immortalized Your Guitar In Frozen Carbonite", 427890]
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

SONG_INFO = {
    SONG_ABOUT_A_GIRL_UNPLUGGED: {
        "Title": "About a Girl (Unplugged)",
        "Artist": "Nirvana",
        "Year": 1994,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 58600,
                "FiveStarAchievementId": 428189,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I Need an Easy Friend",
                "LeaderboardIds": [0, 101574, 101575, 101576, 101573]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29150,
                "FiveStarAchievementId": 428190,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "You Hang Me Out to Dry",
                "LeaderboardIds": [0, 101578, 101579, 101580, 101577]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 64100,
                "FiveStarAchievementId": 428192,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I Do Keep a Date with You",
                "LeaderboardIds": [0, 101586, 101587, 101588, 101585]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 15500,
                "FiveStarAchievementId": 428191,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Free, I Do",
                "LeaderboardIds": [0, 101582, 101583, 101584, 101581]
            }
        }
    },
    SONG_AGGRO: {
        "Title": "Aggro",
        "Artist": "The Enemy",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 78936,
                "FiveStarAchievementId": 427943,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Things Are Getting Ugly",
                "LeaderboardIds": [0, 100590, 100591, 100592, 100589]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 26448,
                "FiveStarAchievementId": 427944,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I Want You Running with Me",
                "LeaderboardIds": [0, 100594, 100595, 100596, 100593]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 66375,
                "FiveStarAchievementId": 427946,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We'll Set the Streets on Fire",
                "LeaderboardIds": [0, 100602, 100603, 100604, 100601]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "FiveStarAchievementId": 427945,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Say What You Mean",
                "LeaderboardIds": [0, 100598, 100599, 100600, 100597]
            }
        }
    },
    SONG_AMERICAN_WOMAN: {
        "Title": "American Woman",
        "Artist": "The Guess Who",
        "Year": 1970,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 62584,
                "FiveStarAchievementId": 428132,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Mama, Let Me Be",
                "LeaderboardIds": [0, 101346, 101347, 101348, 101345]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 41073,
                "FiveStarAchievementId": 428133,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Got More Important Things to Do",
                "LeaderboardIds": [0, 101350, 101351, 101352, 101349]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 102900,
                "FiveStarAchievementId": 428135,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Colored Lights Can Hypnotize",
                "LeaderboardIds": [0, 101358, 101359, 101360, 101357]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28000,
                "FiveStarAchievementId": 428134,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Goodbye American Woman",
                "LeaderboardIds": [0, 101354, 101355, 101356, 101353]
            }
        }
    },
    SONG_ANTISOCIAL: {
        "Title": "Antisocial",
        "Artist": "Trust",
        "Year": 1980,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 88849,
                "FiveStarAchievementId": 428111,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Tu Masques Ton Visage en Lisant Ton Journal",
                "LeaderboardIds": [0, 101262, 101263, 101264, 101261]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 64450,
                "FiveStarAchievementId": 428112,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Tu Voudrais Donner Des Yeux à la Justice",
                "LeaderboardIds": [0, 101266, 101267, 101268, 101265]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 126528,
                "FiveStarAchievementId": 428114,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Bouge de Ta Retraite, Ta Conduite Est Trop Parfaite",
                "LeaderboardIds": [0, 101274, 101275, 101276, 101273]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26000,
                "FiveStarAchievementId": 428113,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Ceux Qui Hier T'enviaient, Aujourd'hui Te Jugeraient",
                "LeaderboardIds": [0, 101270, 101271, 101272, 101269]
            }
        }
    },
    SONG_ARE_YOU_GONNA_GO_MY_WAY: {
        "Title": "Are You Gonna Go My Way",
        "Artist": "Lenny Kravitz",
        "Year": 1993,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 53647,
                "FiveStarAchievementId": 428197,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Am the Chosen, I'm the One",
                "LeaderboardIds": [0, 101606, 101607, 101608, 101605]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29904,
                "FiveStarAchievementId": 428198,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Though I'm Not Paid, I Play This Game",
                "LeaderboardIds": [0, 101610, 101611, 101612, 101609]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 67225,
                "FiveStarAchievementId": 428200,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "We Must Engage and Rearrange",
                "LeaderboardIds": [0, 101618, 101619, 101620, 101617]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 16500,
                "FiveStarAchievementId": 428199,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We've Got to Hug and Rub-a-Dub",
                "LeaderboardIds": [0, 101614, 101615, 101616, 101613]
            }
        }
    },
    SONG_ASSASSIN: {
        "Title": "Assassin",
        "Artist": "Muse",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 84934,
                "FiveStarAchievementId": 428124,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "War Is Overdue",
                "LeaderboardIds": [0, 101314, 101315, 101316, 101313]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 63147,
                "FiveStarAchievementId": 428125,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "These People Are Torn",
                "LeaderboardIds": [0, 101318, 101319, 101320, 101317]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 95750,
                "FiveStarAchievementId": 428127,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Destroy Demonocracy",
                "LeaderboardIds": [0, 101326, 101327, 101328, 101325]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12000,
                "FiveStarAchievementId": 428126,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Oppose and Disagree",
                "LeaderboardIds": [0, 101322, 101323, 101324, 101321]
            }
        }
    },
    SONG_BAND_ON_THE_RUN: {
        "Title": "Band on the Run",
        "Artist": "Wings",
        "Year": 1973,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 70349,
                "FiveStarAchievementId": 428160,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Stuck Inside These Four Walls",
                "LeaderboardIds": [0, 101458, 101459, 101460, 101457]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 35769,
                "FiveStarAchievementId": 428161,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "If I Ever Get Out of Here",
                "LeaderboardIds": [0, 101462, 101463, 101464, 101461]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 86725,
                "FiveStarAchievementId": 428163,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "For the Rabbits on the Run",
                "LeaderboardIds": [0, 101470, 101471, 101472, 101469]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26000,
                "FiveStarAchievementId": 428162,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "In the Town They're Searching for Us Everywhere",
                "LeaderboardIds": [0, 101466, 101467, 101468, 101465]
            }
        }
    },
    SONG_BEAT_IT: {
        "Title": "Beat It",
        "Artist": "Michael Jackson",
        "Year": 1982,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54299,
                "FiveStarAchievementId": 428185,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Fire's in Their Eyes and Their Words Are Really Clear",
                "LeaderboardIds": [0, 101558, 101559, 101560, 101557]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 30967,
                "FiveStarAchievementId": 428186,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You Wanna Be Tough, Better Do What You Can",
                "LeaderboardIds": [0, 101562, 101563, 101564, 101561]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 101825,
                "FiveStarAchievementId": 428188,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Don't Wanna Be a Boy, You Wanna Be a Man",
                "LeaderboardIds": [0, 101570, 101571, 101572, 101569]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 27000,
                "FiveStarAchievementId": 428187,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Showin' How Funky and Strong Is Your Fight",
                "LeaderboardIds": [0, 101566, 101567, 101568, 101565]
            }
        }
    },
    SONG_BEAUTIFUL_DISASTER: {
        "Title": "Beautiful Disaster",
        "Artist": "311",
        "Year": 1997,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 61516,
                "FiveStarAchievementId": 428205,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Today Seems Like a Good Day to Burn a Bridge or Two",
                "LeaderboardIds": [0, 101638, 101639, 101640, 101637]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 43500,
                "FiveStarAchievementId": 428206,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Some People Really Suck",
                "LeaderboardIds": [0, 101642, 101643, 101644, 101641]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 114175,
                "FiveStarAchievementId": 428208,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Know a Drugstore Cowgirl So Afraid of Getting Bored",
                "LeaderboardIds": [0, 101650, 101651, 101652, 101649]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "FiveStarAchievementId": 428207,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You're a Butterfly in the Wind without a Care",
                "LeaderboardIds": [0, 101646, 101647, 101648, 101645]
            }
        }
    },
    SONG_BYOB: {
        "Title": "B.Y.O.B.",
        "Artist": "System Of A Down",
        "Year": 2005,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 103178,
                "FiveStarAchievementId": 428156,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Yet You Feed Us Lies from the Tablecloth",
                "LeaderboardIds": [0, 101442, 101443, 101444, 101441]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 73305,
                "FiveStarAchievementId": 428157,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Dancin' in the Desert, Blowin' up the Sunshine",
                "LeaderboardIds": [0, 101446, 101447, 101448, 101445]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 128700,
                "FiveStarAchievementId": 428159,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Blast Off, It's Party Time",
                "LeaderboardIds": [0, 101454, 101455, 101456, 101453]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28000,
                "FiveStarAchievementId": 428158,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Why Do They Always Send the Poor?",
                "LeaderboardIds": [0, 101450, 101451, 101452, 101449]
            }
        }
    },
        SONG_CRAZY_TRAIN: {
        "Title": "Crazy Train",
        "Artist": "Ozzy Osbourne",
        "Year": 1980,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 93714,
                "FiveStarAchievementId": 428047,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Crazy, but That's How It Goes",
                "LeaderboardIds": [0, 101006, 101007, 101008, 101005]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 49325,
                "FiveStarAchievementId": 428048,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "All Aboard",
                "LeaderboardIds": [0, 101010, 101011, 101012, 101009]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 131400,
                "FiveStarAchievementId": 428050,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Learn How to Love and Forget How to Hate",
                "LeaderboardIds": [0, 101018, 101019, 101020, 101017]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 428049,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Gotta Listen to My Words, Yeah, Yeah",
                "LeaderboardIds": [0, 101014, 101015, 101016, 101013]
            }
        }
    },
    SONG_DAMMIT: {
        "Title": "Dammit",
        "Artist": "Blink-182",
        "Year": 1997,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54450,
                "FiveStarAchievementId": 428039,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Won't Try to Argue",
                "LeaderboardIds": [0, 100974, 100975, 100976, 100973]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 45935,
                "FiveStarAchievementId": 428040,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Season Is Calling",
                "LeaderboardIds": [0, 100978, 100979, 100980, 100977]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 98225,
                "FiveStarAchievementId": 428042,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Charade, It Won't Last",
                "LeaderboardIds": [0, 100986, 100987, 100988, 100985]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 13000,
                "FiveStarAchievementId": 428041,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Well I Guess This Is Growing Up",
                "LeaderboardIds": [0, 100982, 100983, 100984, 100981]
            }
        }
    },
    SONG_DEMOLITION_MAN_LIVE: {
        "Title": "Demolition Man (Live)",
        "Artist": "Sting",
        "Year": 2005,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 60646,
                "FiveStarAchievementId": 428059,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Say That This Wasn't in Your Plan",
                "LeaderboardIds": [0, 101054, 101055, 101056, 101053]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 52127,
                "FiveStarAchievementId": 428060,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Don't Mess around with the Demolition Man",
                "LeaderboardIds": [0, 101058, 101059, 101060, 101057]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 115732,
                "FiveStarAchievementId": 428062,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Could Be My Greatest Fan",
                "LeaderboardIds": [0, 101066, 101067, 101068, 101065]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "FiveStarAchievementId": 428061,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'm the Sort of Thing They Ban",
                "LeaderboardIds": [0, 101062, 101063, 101064, 101061]
            }
        }
    },
    SONG_DO_IT_AGAIN: {
        "Title": "Do It Again",
        "Artist": "Steely Dan",
        "Year": 1972,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 61225,
                "FiveStarAchievementId": 427971,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "She's No High Climber",
                "LeaderboardIds": [0, 100702, 100703, 100704, 100701]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 56392,
                "FiveStarAchievementId": 427972,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You Love a Little Wild One",
                "LeaderboardIds": [0, 100706, 100707, 100708, 100705]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 123750,
                "FiveStarAchievementId": 427974,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "You're Not a Gambling Man",
                "LeaderboardIds": [0, 100714, 100715, 100716, 100713]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 16500,
                "FiveStarAchievementId": 427973,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Wheel Turnin' 'Round and 'Round",
                "LeaderboardIds": [0, 100710, 100711, 100712, 100709]
            }
        }
    },
    SONG_ESCUELA_DE_CALOR: {
        "Title": "Escuela de Calor",
        "Artist": "Radio Futura",
        "Year": 1984,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54064,
                "FiveStarAchievementId": 428031,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Arde la Calle Al Sol de Poniente",
                "LeaderboardIds": [0, 100942, 100943, 100944, 100941]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29173,
                "FiveStarAchievementId": 428032,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Tú Estés Loco Por Mí",
                "LeaderboardIds": [0, 100946, 100947, 100948, 100945]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 88775,
                "FiveStarAchievementId": 428034,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Esa Paloma Sobrevuela El Peligro",
                "LeaderboardIds": [0, 100954, 100955, 100956, 100953]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 15500,
                "FiveStarAchievementId": 428033,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Quiero Vivir Del Aire",
                "LeaderboardIds": [0, 100950, 100951, 100952, 100949]
            }
        }
    },
    SONG_EVERLONG: {
        "Title": "Everlong",
        "Artist": "Foo Fighters",
        "Year": 1997,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 102163,
                "FiveStarAchievementId": 428140,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Out of the Red, Out of Her Head, She Sang",
                "LeaderboardIds": [0, 101378, 101379, 101380, 101377]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51650,
                "FiveStarAchievementId": 428141,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Breathe Out, So I Can Breathe You In",
                "LeaderboardIds": [0, 101382, 101383, 101384, 101381]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 133575,
                "FiveStarAchievementId": 428143,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Gotta Promise Not To Stop When I Say When",
                "LeaderboardIds": [0, 101390, 101391, 101392, 101389]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 17000,
                "FiveStarAchievementId": 428142,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "When I Sing along with You",
                "LeaderboardIds": [0, 101386, 101387, 101388, 101385]
            }
        }
    },
    SONG_EYE_OF_THE_TIGER: {
        "Title": "Eye of the Tiger",
        "Artist": "Survivor",
        "Year": 1982,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 59151,
                "FiveStarAchievementId": 428055,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Risin' Up, Back on the Street",
                "LeaderboardIds": [0, 101038, 101039, 101040, 101037]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 28608,
                "FiveStarAchievementId": 428056,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Just a Man and His Will to Survive",
                "LeaderboardIds": [0, 101042, 101043, 101044, 101041]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 80425,
                "FiveStarAchievementId": 428058,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Had the Guts, Got the Glory",
                "LeaderboardIds": [0, 101050, 101051, 101052, 101049]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26000,
                "FiveStarAchievementId": 428057,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Risin' up to the Challenge of Our Rival",
                "LeaderboardIds": [0, 101046, 101047, 101048, 101045]
            }
        }
    },
    SONG_FEEL_THE_PAIN: {
        "Title": "Feel the Pain",
        "Artist": "Dinosaur Jr.",
        "Year": 1994,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 67560,
                "FiveStarAchievementId": 428051,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Then I Feel Nothing",
                "LeaderboardIds": [0, 101022, 101023, 101024, 101021]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 45550,
                "FiveStarAchievementId": 428052,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Is It up to Me?",
                "LeaderboardIds": [0, 101026, 101027, 101028, 101025]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 96850,
                "FiveStarAchievementId": 428054,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Hey Now, Take It Back",
                "LeaderboardIds": [0, 101034, 101035, 101036, 101033]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12000,
                "FiveStarAchievementId": 428053,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Just Try and Keep It Clean",
                "LeaderboardIds": [0, 101030, 101031, 101032, 101029]
            }
        }
    },
    SONG_FLOAT_ON: {
        "Title": "Float On",
        "Artist": "Modest Mouse",
        "Year": 2004,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 41133,
                "FiveStarAchievementId": 428209,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Backed My Car into a Cop Car the Other Day",
                "LeaderboardIds": [0, 101654, 101655, 101656, 101653]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 18075,
                "FiveStarAchievementId": 428210,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Well, You Just Laughed It Off, It Was All Okay",
                "LeaderboardIds": [0, 101658, 101659, 101660, 101657]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 69275,
                "FiveStarAchievementId": 428212,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It Was Worth It Just to Learn Some Sleight of Hand",
                "LeaderboardIds": [0, 101666, 101667, 101668, 101665]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18000,
                "FiveStarAchievementId": 428211,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Even If Things Get Heavy, We'll All Float On",
                "LeaderboardIds": [0, 101662, 101663, 101664, 101661]
            }
        }
    },
    SONG_FREAK_ON_A_LEASH: {
        "Title": "Freak on a Leash",
        "Artist": "Korn",
        "Year": 1998,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 43344,
                "FiveStarAchievementId": 428043,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Can't They Chill and Let Me Be Free?",
                "LeaderboardIds": [0, 100990, 100991, 100992, 100989]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 36362,
                "FiveStarAchievementId": 428044,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Somethin' Takes a Part of Me",
                "LeaderboardIds": [0, 100994, 100995, 100996, 100993]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 91925,
                "FiveStarAchievementId": 428046,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "How Many Times Have I Felt Disease",
                "LeaderboardIds": [0, 101002, 101003, 101004, 101001]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22500,
                "FiveStarAchievementId": 428045,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Boom-da-da-mmm-dum-na-ee-ma",
                "LeaderboardIds": [0, 100998, 100999, 101000, 100997]
            }
        }
    },
    SONG_GO_YOUR_OWN_WAY: {
        "Title": "Go Your Own Way",
        "Artist": "Fleetwood Mac",
        "Year": 1977,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 67201,
                "FiveStarAchievementId": 428173,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "How Can I Ever Change Things That I Feel?",
                "LeaderboardIds": [0, 101510, 101511, 101512, 101509]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51016,
                "FiveStarAchievementId": 428174,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Maybe I'd Give You My World",
                "LeaderboardIds": [0, 101514, 101515, 101516, 101513]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 109250,
                "FiveStarAchievementId": 428176,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Packing Up, Shacking Up's All You Wanna Do",
                "LeaderboardIds": [0, 101522, 101523, 101524, 101521]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18500,
                "FiveStarAchievementId": 428175,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Open Up, Everything's Waiting for You",
                "LeaderboardIds": [0, 101518, 101519, 101520, 101517]
            }
        }
    },
    SONG_GOOD_GOD: {
        "Title": "Good God",
        "Artist": "Anouk",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 48080,
                "FiveStarAchievementId": 427915,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Surely I Am Willing",
                "LeaderboardIds": [0, 100478, 100479, 100480, 100477]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 30549,
                "FiveStarAchievementId": 427916,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Know You're Trouble",
                "LeaderboardIds": [0, 100482, 100483, 100484, 100481]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 58525,
                "FiveStarAchievementId": 427918,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Haven't Got Me Yet, but You Might",
                "LeaderboardIds": [0, 100490, 100491, 100492, 100489]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 427917,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Freedom or Loyalty",
                "LeaderboardIds": [0, 100486, 100487, 100488, 100485]
            }
        }
    },
    SONG_HAIL_TO_THE_FREAKS: {
        "Title": "Hail to the Freaks",
        "Artist": "Beatsteaks",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52476,
                "FiveStarAchievementId": 428169,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Hashing Out Deals to Cover Lies",
                "LeaderboardIds": [0, 101494, 101495, 101496, 101493]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 40250,
                "FiveStarAchievementId": 428170,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I've Been Around and Around and Around I'll Come",
                "LeaderboardIds": [0, 101498, 101499, 101500, 101497]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 88075,
                "FiveStarAchievementId": 428172,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "To Weather the Storm and Set up the Sun",
                "LeaderboardIds": [0, 101506, 101507, 101508, 101505]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 17500,
                "FiveStarAchievementId": 428171,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Calling You from the Top of Friction",
                "LeaderboardIds": [0, 101502, 101503, 101504, 101501]
            }
        }
    },
    SONG_HEARTBREAKER: {
        "Title": "Heartbreaker",
        "Artist": "Pat Benatar",
        "Year": 1979,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 62778,
                "FiveStarAchievementId": 428079,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Your Love Is Like a Tidal Wave",
                "LeaderboardIds": [0, 101134, 101135, 101136, 101133]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38706,
                "FiveStarAchievementId": 428080,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Invincible Winner",
                "LeaderboardIds": [0, 101138, 101139, 101140, 101137]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 79623,
                "FiveStarAchievementId": 428082,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Taught Me the Ways of Desire",
                "LeaderboardIds": [0, 101146, 101147, 101148, 101145]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22000,
                "FiveStarAchievementId": 428081,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Don't You Mess around with Me",
                "LeaderboardIds": [0, 101142, 101143, 101144, 101141]
            }
        }
    },
    SONG_HEY_MAN_NICE_SHOT: {
        "Title": "Hey Man, Nice Shot",
        "Artist": "Filter",
        "Year": 1995,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 66619,
                "FiveStarAchievementId": 427891,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Wish I Would've Met You",
                "LeaderboardIds": [0, 100382, 100383, 100384, 100381]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 82000,
                "FiveStarAchievementId": 427892,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Think That Your Early Ending Was All Wrong",
                "LeaderboardIds": [0, 100386, 100387, 100388, 100385]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 74750,
                "FiveStarAchievementId": 427894,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "The Air Is All Clear",
                "LeaderboardIds": [0, 100394, 100395, 100396, 100393]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18500,
                "FiveStarAchievementId": 427893,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "That's What I Say",
                "LeaderboardIds": [0, 100390, 100391, 100392, 100389]
            }
        }
    },
    SONG_HOLLYWOOD_NIGHTS: {
        "Title": "Hollywood Nights",
        "Artist": "Bob Seger & The Silver Bullet Band",
        "Year": 1978,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 115275,
                "FiveStarAchievementId": 428177,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "He Was a Midwestern Boy on His Own",
                "LeaderboardIds": [0, 101526, 101527, 101528, 101525]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 75125,
                "FiveStarAchievementId": 428178,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "She Led Him along That Golden Beach",
                "LeaderboardIds": [0, 101530, 101531, 101532, 101529]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 163225,
                "FiveStarAchievementId": 428180,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "She Had Been Born with a Face That Would Let Her Get Her Way",
                "LeaderboardIds": [0, 101538, 101539, 101540, 101537]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28500,
                "FiveStarAchievementId": 428179,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "He Spent All Night Staring Down at the Lights of LA",
                "LeaderboardIds": [0, 101534, 101535, 101536, 101533]
            }
        }
    },
    SONG_HOT_FOR_TEACHER: {
        "Title": "Hot for Teacher",
        "Artist": "Van Halen",
        "Year": 1984,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 111351,
                "FiveStarAchievementId": 428083,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "My Homework Was Never Quite Like This",
                "LeaderboardIds": [0, 101150, 101151, 101152, 101149]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 48114,
                "FiveStarAchievementId": 428084,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Think the Clock Is Slow, Man",
                "LeaderboardIds": [0, 101154, 101155, 101156, 101153]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 146576,
                "FiveStarAchievementId": 428086,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Class Dismissed",
                "LeaderboardIds": [0, 101162, 101163, 101164, 101161]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 428085,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Brought My Pencil",
                "LeaderboardIds": [0, 101158, 101159, 101160, 101157]
            }
        }
    },
    SONG_HOTEL_CALIFORNIA: {
        "Title": "Hotel California",
        "Artist": "The Eagles",
        "Year": 1976,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 69092,
                "FiveStarAchievementId": 427979,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "On a Dark Desert Highway",
                "LeaderboardIds": [0, 100734, 100735, 100736, 100733]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 49851,
                "FiveStarAchievementId": 427980,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We Haven't Had That Spirit Here since 1969",
                "LeaderboardIds": [0, 100738, 100739, 100740, 100737]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 83375,
                "FiveStarAchievementId": 427982,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "We're Just Prisoners Here of Our Own Device",
                "LeaderboardIds": [0, 100746, 100747, 100748, 100745]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 29000,
                "FiveStarAchievementId": 427981,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Can Check Out Any Time You Like but You Can Never Leave",
                "LeaderboardIds": [0, 100742, 100743, 100744, 100741]
            }
        }
    },
    SONG_THE_JOKER: {
        "Title": "The Joker",
        "Artist": "The Steve Miller Band",
        "Year": 1973,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 47671,
                "FiveStarAchievementId": 428027,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Some People Call Me the Space Cowboy",
                "LeaderboardIds": [0, 100926, 100927, 100928, 100925]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 37161,
                "FiveStarAchievementId": 428028,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Some Call Me the Gangster of Love",
                "LeaderboardIds": [0, 100930, 100931, 100932, 100929]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 56875,
                "FiveStarAchievementId": 428030,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Some People Call Me Maurice",
                "LeaderboardIds": [0, 100938, 100939, 100940, 100937]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 428029,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'm Right Here, Right Here, Right Here, Right Here at Home",
                "LeaderboardIds": [0, 100934, 100935, 100936, 100933]
            }
        }
    },
    SONG_KICK_OUT_THE_JAMS: {
        "Title": "Kick Out the Jams",
        "Artist": "MC5's Wayne Kramer",
        "Year": 2008,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52626,
                "FiveStarAchievementId": 428148,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'm Starting to Sweat, You Know My Shirt's All Wet",
                "LeaderboardIds": [0, 101410, 101411, 101412, 101409]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 31646,
                "FiveStarAchievementId": 428149,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "When You Get That Feeling, You Gotta Sock 'Em Out",
                "LeaderboardIds": [0, 101414, 101415, 101416, 101413]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 67949,
                "FiveStarAchievementId": 428151,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It Gets in Your Brain, It Drives You Insane",
                "LeaderboardIds": [0, 101422, 101423, 101424, 101421]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "FiveStarAchievementId": 428150,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Let Me up on the Stand",
                "LeaderboardIds": [0, 101418, 101419, 101420, 101417]
            }
        }
    },
    SONG_THE_KILL: {
        "Title": "The Kill",
        "Artist": "30 Seconds To Mars",
        "Year": 2005,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 84010,
                "FiveStarAchievementId": 428003,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "What If I Wanted to Break?",
                "LeaderboardIds": [0, 100830, 100831, 100832, 100829]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51807,
                "FiveStarAchievementId": 428004,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "What If I Fell to the Floor?",
                "LeaderboardIds": [0, 100834, 100835, 100836, 100833]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 77950,
                "FiveStarAchievementId": 428006,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "What If I Wanted to Fight?",
                "LeaderboardIds": [0, 100842, 100843, 100844, 100841]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21500,
                "FiveStarAchievementId": 428005,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "What Would You Do, Do, Do?",
                "LeaderboardIds": [0, 100838, 100839, 100840, 100837]
            }
        }
    },
    SONG_LA_BAMBA: {
        "Title": "La Bamba",
        "Artist": "Los Lobos",
        "Year": 1987,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 51055,
                "FiveStarAchievementId": 427923,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Se Necesita Una Poca de Gracia",
                "LeaderboardIds": [0, 100510, 100511, 100512, 100509]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 25766,
                "FiveStarAchievementId": 427924,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Y Arriba y Arriba",
                "LeaderboardIds": [0, 100514, 100515, 100516, 100513]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 50825,
                "FiveStarAchievementId": 427926,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Yo No Soy Marinero, Soy Capitán",
                "LeaderboardIds": [0, 100522, 100523, 100524, 100521]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14500,
                "FiveStarAchievementId": 427925,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Por Ti Seré",
                "LeaderboardIds": [0, 100518, 100519, 100520, 100517]
            }
        }
    },
    SONG_LAZY_EYE: {
        "Title": "Lazy Eye",
        "Artist": "Silversun Pickups",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 125825,
                "FiveStarAchievementId": 427959,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I've Been Waiting for This Moment All My Life",
                "LeaderboardIds": [0, 100654, 100655, 100656, 100653]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 71449,
                "FiveStarAchievementId": 427960,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Aim Free, but So Untrue",
                "LeaderboardIds": [0, 100658, 100659, 100660, 100657]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 150175,
                "FiveStarAchievementId": 427962,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It's the Room, the Sun, and the Sky",
                "LeaderboardIds": [0, 100666, 100667, 100668, 100665]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14500,
                "FiveStarAchievementId": 427961,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "That's Why I Said I Relate",
                "LeaderboardIds": [0, 100662, 100663, 100664, 100661]
            }
        }
    },
    SONG_LIVIN_ON_A_PRAYER: {
        "Title": "Livin' On A Prayer",
        "Artist": "Bon Jovi",
        "Year": 1986,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 48739,
                "FiveStarAchievementId": 428035,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Tommy's Got His Six-String in Hock",
                "LeaderboardIds": [0, 100958, 100959, 100960, 100957]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 53149,
                "FiveStarAchievementId": 428036,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "She Brings Home Her Pay for Love",
                "LeaderboardIds": [0, 100962, 100963, 100964, 100961]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 79075,
                "FiveStarAchievementId": 428038,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Union's Been on Strike",
                "LeaderboardIds": [0, 100970, 100971, 100972, 100969]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 31500,
                "FiveStarAchievementId": 428037,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "It Doesn't Make a Difference If We Make It or Not",
                "LeaderboardIds": [0, 100966, 100967, 100968, 100965]
            }
        }
    },
    SONG_LOVE_ME_TWO_TIMES: {
        "Title": "Love Me Two Times",
        "Artist": "The Doors",
        "Year": 1967,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52103,
                "FiveStarAchievementId": 428165,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Love Me Twice Today",
                "LeaderboardIds": [0, 101478, 101479, 101480, 101477]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38625,
                "FiveStarAchievementId": 428166,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "My Knees Got Weak",
                "LeaderboardIds": [0, 101482, 101483, 101484, 101481]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 57075,
                "FiveStarAchievementId": 428168,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Last Me All through the Week",
                "LeaderboardIds": [0, 101490, 101491, 101492, 101489]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 428167,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'm Goin' Away",
                "LeaderboardIds": [0, 101486, 101487, 101488, 101485]
            }
        }
    },
    SONG_LOVE_REMOVAL_MACHINE: {
        "Title": "Love Removal Machine",
        "Artist": "The Cult",
        "Year": 1987,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 67136,
                "FiveStarAchievementId": 428015,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "She Got Me in Fear",
                "LeaderboardIds": [0, 100878, 100879, 100880, 100877]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 44705,
                "FiveStarAchievementId": 428016,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Baby, Baby, Baby, Baby, Baby",
                "LeaderboardIds": [0, 100882, 100883, 100884, 100881]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 90675,
                "FiveStarAchievementId": 428018,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Upside-down Psychotic Reaction",
                "LeaderboardIds": [0, 100890, 100891, 100892, 100889]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 30500,
                "FiveStarAchievementId": 428017,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Look Out, Here She Comes",
                "LeaderboardIds": [0, 100886, 100887, 100888, 100885]
            }
        }
    },
    SONG_LOVE_SPREADS: {
        "Title": "Love Spreads",
        "Artist": "The Stone Roses",
        "Year": 1994,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 82220,
                "FiveStarAchievementId": 428091,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'm Hiding in the Trees With a Picnic",
                "LeaderboardIds": [0, 101182, 101183, 101184, 101181]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 66063,
                "FiveStarAchievementId": 428092,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Forgive You Boy",
                "LeaderboardIds": [0, 101186, 101187, 101188, 101185]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 131125,
                "FiveStarAchievementId": 428094,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Let Me Show You What I Mean",
                "LeaderboardIds": [0, 101194, 101195, 101196, 101193]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 33000,
                "FiveStarAchievementId": 428093,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Ain't No King, Man, She's My Queen",
                "LeaderboardIds": [0, 101190, 101191, 101192, 101189]
            }
        }
    },
    SONG_LVIA_LVIAQUEZ: {
        "Title": "L'Via L'Viaquez",
        "Artist": "The Mars Volta",
        "Year": 2005,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 60325,
                "FiveStarAchievementId": 428201,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Sin Ojos Me Quieres Dar",
                "LeaderboardIds": [0, 101622, 101623, 101624, 101621]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 40193,
                "FiveStarAchievementId": 428202,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "¿Quién Te Va a Perseguir?",
                "LeaderboardIds": [0, 101626, 101627, 101628, 101625]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 97150,
                "FiveStarAchievementId": 428204,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Y Yo Te Lo Juro, Lo Van a Pagar",
                "LeaderboardIds": [0, 101634, 101635, 101636, 101633]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 25500,
                "FiveStarAchievementId": 428203,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Blackmailed, She Fell off Every Mountain",
                "LeaderboardIds": [0, 101630, 101631, 101632, 101629]
            }
        }
    },
    SONG_THE_MIDDLE: {
        "Title": "The Middle",
        "Artist": "Jimmy Eat World",
        "Year": 2001,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 74040,
                "FiveStarAchievementId": 428116,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Don't Write Yourself Off Yet",
                "LeaderboardIds": [0, 101282, 101283, 101284, 101281]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 39973,
                "FiveStarAchievementId": 428117,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Don't You Worry What They Tell Themselves When You're Away",
                "LeaderboardIds": [0, 101286, 101287, 101288, 101285]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 67875,
                "FiveStarAchievementId": 428119,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Know You're Doin' Better on Your Own",
                "LeaderboardIds": [0, 101294, 101295, 101296, 101293]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 428118,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Everything, Everything Will Be Alright, Alright",
                "LeaderboardIds": [0, 101290, 101291, 101292, 101289]
            }
        }
    },
    SONG_MISERY_BUSINESS: {
        "Title": "Misery Business",
        "Artist": "Paramore",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 66756,
                "FiveStarAchievementId": 428087,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Two Weeks and We Caught on Fire",
                "LeaderboardIds": [0, 101166, 101167, 101168, 101165]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38700,
                "FiveStarAchievementId": 428088,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Got Him Where I Want Him Now",
                "LeaderboardIds": [0, 101170, 101171, 101172, 101169]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 88050,
                "FiveStarAchievementId": 428090,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Watch My Wildest Dreams Come True",
                "LeaderboardIds": [0, 101178, 101179, 101180, 101177]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24500,
                "FiveStarAchievementId": 428089,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Refuse, I Refuse, I Refuse",
                "LeaderboardIds": [0, 101174, 101175, 101176, 101173]
            }
        }
    },
    SONG_MONSOON: {
        "Title": "Monsoon",
        "Artist": "Tokio Hotel",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 71577,
                "FiveStarAchievementId": 428071,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "My Room Is Cold, It's Making Me Insane",
                "LeaderboardIds": [0, 101102, 101103, 101104, 101101]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 61546,
                "FiveStarAchievementId": 428072,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "When I Lose Myself I Think of You",
                "LeaderboardIds": [0, 101106, 101107, 101108, 101105]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 74500,
                "FiveStarAchievementId": 428074,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I See Your Vision in Its Light",
                "LeaderboardIds": [0, 101114, 101115, 101116, 101113]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 29500,
                "FiveStarAchievementId": 428073,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I'm Fighting All Its Power",
                "LeaderboardIds": [0, 101110, 101111, 101112, 101109]
            }
        }
    },
    SONG_MOUNTAIN_SONG: {
        "Title": "Mountain Song",
        "Artist": "Jane's Addiction",
        "Year": 1988,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 57704,
                "FiveStarAchievementId": 428193,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Everybody Has Their Own Opinion",
                "LeaderboardIds": [0, 101590, 101591, 101592, 101589]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 71437,
                "FiveStarAchievementId": 428194,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Jumped Out of My Flesh and I Said Cash In",
                "LeaderboardIds": [0, 101594, 101595, 101596, 101593]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 98613,
                "FiveStarAchievementId": 428196,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "She Had Pin Eyes",
                "LeaderboardIds": [0, 101602, 101603, 101604, 101601]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "FiveStarAchievementId": 428195,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Cash In Now, Baby",
                "LeaderboardIds": [0, 101598, 101599, 101600, 101597]
            }
        }
    },
    SONG_MR_CROWLEY: {
        "Title": "Mr. Crowley",
        "Artist": "Ozzy Osbourne",
        "Year": 1980,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 72392,
                "FiveStarAchievementId": 428103,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Your Lifestyle, to Me, Seemed So Tragic",
                "LeaderboardIds": [0, 101230, 101231, 101232, 101229]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 61179,
                "FiveStarAchievementId": 428104,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "In Nocturnal Rapport",
                "LeaderboardIds": [0, 101234, 101235, 101236, 101233]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 86725,
                "FiveStarAchievementId": 428106,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Conceived in the Eye of a Secret",
                "LeaderboardIds": [0, 101242, 101243, 101244, 101241]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14000,
                "FiveStarAchievementId": 428105,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Won't You Ride My White Horse?",
                "LeaderboardIds": [0, 101238, 101239, 101240, 101237]
            }
        }
    },
    SONG_NEVER_TOO_LATE: {
        "Title": "Never Too Late",
        "Artist": "The Answer",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 66846,
                "FiveStarAchievementId": 427983,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Have Been Searchin' for Ten Thousand Years",
                "LeaderboardIds": [0, 100750, 100751, 100752, 100749]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 41047,
                "FiveStarAchievementId": 427984,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Contradictions Clearly State",
                "LeaderboardIds": [0, 100754, 100755, 100756, 100753]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 77300,
                "FiveStarAchievementId": 427986,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Fascination's All Around",
                "LeaderboardIds": [0, 100762, 100763, 100764, 100761]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 27000,
                "FiveStarAchievementId": 427985,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Have Met My Maker",
                "LeaderboardIds": [0, 100758, 100759, 100760, 100757]
            }
        }
    },
    SONG_NO_SLEEP_TILL_BROOKLYN: {
        "Title": "No Sleep Till Brooklyn",
        "Artist": "Beastie Boys",
        "Year": 1986,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 39863,
                "FiveStarAchievementId": 428095,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Engine Running Hotter than a Boiling Kettle",
                "LeaderboardIds": [0, 101198, 101199, 101200, 101197]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 17198,
                "FiveStarAchievementId": 428096,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Itchy Trigger Finger, but a Stable Turntable",
                "LeaderboardIds": [0, 101202, 101203, 101204, 101201]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 83550,
                "FiveStarAchievementId": 428098,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "He's Got His Own Room at the Back of the Bus",
                "LeaderboardIds": [0, 101210, 101211, 101212, 101209]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 28000,
                "FiveStarAchievementId": 428097,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Step Off, Holmes, Get out of My Way",
                "LeaderboardIds": [0, 101206, 101207, 101208, 101205]
            }
        }
    },
    SONG_NUVOLE_E_LENZUOLA: {
        "Title": "Nuvole E Lenzuola",
        "Artist": "Negramaro",
        "Year": 2005,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 62905,
                "FiveStarAchievementId": 427939,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Attraversano il Silenzio Del Mio Cielo",
                "LeaderboardIds": [0, 100574, 100575, 100576, 100573]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 30373,
                "FiveStarAchievementId": 427940,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Come Sempre Provo a Farlo",
                "LeaderboardIds": [0, 100578, 100579, 100580, 100577]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 66325,
                "FiveStarAchievementId": 427942,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Tutto Sembra Aver Trovato il Giusto Peso",
                "LeaderboardIds": [0, 100586, 100587, 100588, 100585]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 30500,
                "FiveStarAchievementId": 427941,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Non Dire Una Parola",
                "LeaderboardIds": [0, 100582, 100583, 100584, 100581]
            }
        }
    },
    SONG_OBSTACLE_1: {
        "Title": "Obstacle 1",
        "Artist": "Interpol",
        "Year": 2002,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 65566,
                "FiveStarAchievementId": 427955,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I'll Never See This Place Again",
                "LeaderboardIds": [0, 100638, 100639, 100640, 100637]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 43355,
                "FiveStarAchievementId": 427956,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Make Playing Only Logical Harm",
                "LeaderboardIds": [0, 100642, 100643, 100644, 100641]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 104400,
                "FiveStarAchievementId": 427958,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It's the Things That She Puts in My Head",
                "LeaderboardIds": [0, 100650, 100651, 100652, 100649]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23000,
                "FiveStarAchievementId": 427957,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "She Can Read, She Can Read, She Can Read, She Can Read She's Bad",
                "LeaderboardIds": [0, 100646, 100647, 100648, 100645]
            }
        }
    },
    SONG_ON_THE_ROAD_AGAIN_LIVE: {
        "Title": "On the Road Again (Live)",
        "Artist": "Willie Nelson",
        "Year": 1980,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 36197,
                "FiveStarAchievementId": 427963,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Life I Love Is Making Music with My Friends",
                "LeaderboardIds": [0, 100670, 100671, 100672, 100669]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 19209,
                "FiveStarAchievementId": 427964,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Goin' Places That I've Never Been",
                "LeaderboardIds": [0, 100674, 100675, 100676, 100673]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 69725,
                "FiveStarAchievementId": 427966,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "We're the Best of Friends",
                "LeaderboardIds": [0, 100682, 100683, 100684, 100681]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 13500,
                "FiveStarAchievementId": 427965,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Insisting That the World Keep Turning Our Way",
                "LeaderboardIds": [0, 100678, 100679, 100680, 100677]
            }
        }
    },
    SONG_ONE_ARMED_SCISSOR: {
        "Title": "One Armed Scissor",
        "Artist": "At The Drive-In",
        "Year": 2000,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 95641,
                "FiveStarAchievementId": 427935,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Yes This Is the Campaign",
                "LeaderboardIds": [0, 100558, 100559, 100560, 100557]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51574,
                "FiveStarAchievementId": 427936,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Pucker Up and Kiss the Asphalt Now",
                "LeaderboardIds": [0, 100562, 100563, 100564, 100561]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 101100,
                "FiveStarAchievementId": 427938,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Sputnik Sickles Found in the Seats",
                "LeaderboardIds": [0, 100570, 100571, 100572, 100569]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 27000,
                "FiveStarAchievementId": 427937,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Write To Remember",
                "LeaderboardIds": [0, 100566, 100567, 100568, 100565]
            }
        }
    },
    SONG_THE_ONE_I_LOVE: {
        "Title": "The One I Love",
        "Artist": "R.E.M.",
        "Year": 1987,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 32194,
                "FiveStarAchievementId": 428181,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "A Simple Prop to Occupy My Time",
                "LeaderboardIds": [0, 101542, 101543, 101544, 101541]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 25331,
                "FiveStarAchievementId": 428182,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "This One Goes Out to the One I've Left Behind",
                "LeaderboardIds": [0, 101546, 101547, 101548, 101545]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 75478,
                "FiveStarAchievementId": 428184,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "This One Goes Out to the One I Love",
                "LeaderboardIds": [0, 101554, 101555, 101556, 101553]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 11000,
                "FiveStarAchievementId": 428183,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Fiiiiirreeeeeee",
                "LeaderboardIds": [0, 101550, 101551, 101552, 101549]
            }
        }
    },
    SONG_ONE_WAY_OR_ANOTHER: {
        "Title": "One Way or Another",
        "Artist": "Blondie",
        "Year": 1978,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 56260,
                "FiveStarAchievementId": 427975,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'll See Who's Around",
                "LeaderboardIds": [0, 100718, 100719, 100720, 100717]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 36611,
                "FiveStarAchievementId": 427976,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I'll Follow Your Bus Downtown",
                "LeaderboardIds": [0, 100722, 100723, 100724, 100721]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 99225,
                "FiveStarAchievementId": 427978,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Lead You to the Supermarket Checkout",
                "LeaderboardIds": [0, 100730, 100731, 100732, 100729]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23500,
                "FiveStarAchievementId": 427977,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Where I Can See It All, Find Out Who You Call",
                "LeaderboardIds": [0, 100726, 100727, 100728, 100725]
            }
        }
    },
    SONG_OUR_TRUTH: {
        "Title": "Our Truth",
        "Artist": "Lacuna Coil",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 52189,
                "FiveStarAchievementId": 428019,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Clock Is Ticking While I'm Killing Time",
                "LeaderboardIds": [0, 100894, 100895, 100896, 100893]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 39648,
                "FiveStarAchievementId": 428020,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Wicked Partnership in This Crime",
                "LeaderboardIds": [0, 100898, 100899, 100900, 100897]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 72375,
                "FiveStarAchievementId": 428022,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Silent Sneaking along My Path",
                "LeaderboardIds": [0, 100906, 100907, 100908, 100905]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20500,
                "FiveStarAchievementId": 428021,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Feel It Like We're Flyin'",
                "LeaderboardIds": [0, 100902, 100903, 100904, 100901]
            }
        }
    },
    SONG_OVERKILL: {
        "Title": "Overkill",
        "Artist": "Motörhead",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 93561,
                "FiveStarAchievementId": 427999,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Don't Sweat It",
                "LeaderboardIds": [0, 100814, 100815, 100816, 100813]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 77885,
                "FiveStarAchievementId": 428000,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We'll Get It Back to You",
                "LeaderboardIds": [0, 100818, 100819, 100820, 100817]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 173218,
                "FiveStarAchievementId": 428002,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "So Good I Can't Believe It",
                "LeaderboardIds": [0, 100826, 100827, 100828, 100825]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 9500,
                "FiveStarAchievementId": 428001,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Ya Feel It in Your Guts",
                "LeaderboardIds": [0, 100822, 100823, 100824, 100821]
            }
        }
    },
    SONG_PARABOLA: {
        "Title": "Parabola",
        "Artist": "Tool",
        "Year": 2001,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 77071,
                "FiveStarAchievementId": 427987,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Choosing to Be Here In",
                "LeaderboardIds": [0, 100766, 100767, 100768, 100765]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 71070,
                "FiveStarAchievementId": 427988,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "This Body, This Body Holding Me",
                "LeaderboardIds": [0, 100770, 100771, 100772, 100769]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 112471,
                "FiveStarAchievementId": 427990,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Feeling Eternal, All This Pain Is an Illusion",
                "LeaderboardIds": [0, 100778, 100779, 100780, 100777]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20500,
                "FiveStarAchievementId": 427989,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "A Chance to Be Alive and Breathing",
                "LeaderboardIds": [0, 100774, 100775, 100776, 100773]
            }
        }
    },
    SONG_PRETTY_VACANT: {
        "Title": "Pretty Vacant",
        "Artist": "Sex Pistols",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 57351,
                "FiveStarAchievementId": 428213,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "There's No Point in Asking, You'll Get No Reply",
                "LeaderboardIds": [0, 101670, 101671, 101672, 101669]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 42575,
                "FiveStarAchievementId": 428214,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You'll Always Find Us Out to Lunch",
                "LeaderboardIds": [0, 101674, 101675, 101676, 101673]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 97200,
                "FiveStarAchievementId": 428216,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Don't Pretend 'Cause I Don't Care",
                "LeaderboardIds": [0, 101682, 101683, 101684, 101681]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22000,
                "FiveStarAchievementId": 428215,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I Just Remembered I Don't Decide",
                "LeaderboardIds": [0, 101678, 101679, 101680, 101677]
            }
        }
    },
    SONG_PRISONER_OF_SOCIETY: {
        "Title": "Prisoner of Society",
        "Artist": "The Living End",
        "Year": 1999,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 93758,
                "FiveStarAchievementId": 427907,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We're on Our Own",
                "LeaderboardIds": [0, 100446, 100447, 100448, 100445]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 66648,
                "FiveStarAchievementId": 427908,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'm a Brat",
                "LeaderboardIds": [0, 100450, 100451, 100452, 100449]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 105375,
                "FiveStarAchievementId": 427910,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You'll See I'm Not the Enemy",
                "LeaderboardIds": [0, 100458, 100459, 100460, 100457]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24500,
                "FiveStarAchievementId": 427909,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We Don't Need No One to Tell Us What to Do",
                "LeaderboardIds": [0, 100454, 100455, 100456, 100453]
            }
        }
    },
    SONG_PULL_ME_UNDER: {
        "Title": "Pull Me Under",
        "Artist": "Dream Theater",
        "Year": 1992,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 134316,
                "FiveStarAchievementId": 428011,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Clouds Roll by and I Roll with Them",
                "LeaderboardIds": [0, 100862, 100863, 100864, 100861]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 103879,
                "FiveStarAchievementId": 428012,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "This World Is Spinning around Me",
                "LeaderboardIds": [0, 100866, 100867, 100868, 100865]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 207419,
                "FiveStarAchievementId": 428014,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "All That I Feel Is Honor and Spite",
                "LeaderboardIds": [0, 100874, 100875, 100876, 100873]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24000,
                "FiveStarAchievementId": 428013,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Living My Life Too Much in the Sun",
                "LeaderboardIds": [0, 100870, 100871, 100872, 100869]
            }
        }
    },
    SONG_PURPLE_HAZE_LIVE: {
        "Title": "Purple Haze (Live)",
        "Artist": "The Jimi Hendrix Experience",
        "Year": 1968,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 54193,
                "FiveStarAchievementId": 428067,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Excuse Me While I Kiss That Guy",
                "LeaderboardIds": [0, 101086, 101087, 101088, 101085]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 45808,
                "FiveStarAchievementId": 428068,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Excuse Me While I Kiss the Sky",
                "LeaderboardIds": [0, 101090, 101091, 101092, 101089]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 75625,
                "FiveStarAchievementId": 428070,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Wait, Is It Kiss That Guy or Kiss the Sky?",
                "LeaderboardIds": [0, 101098, 101099, 101100, 101097]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23500,
                "FiveStarAchievementId": 428069,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "No, Definitely It's Kiss That Guy",
                "LeaderboardIds": [0, 101094, 101095, 101096, 101093]
            }
        }
    },
    SONG_RAMBLIN_MAN: {
        "Title": "Ramblin' Man",
        "Artist": "The Allman Brothers Band",
        "Year": 1973,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 77752,
                "FiveStarAchievementId": 428152,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Tryin' To Make a Livin' and Doin' the Best I Can",
                "LeaderboardIds": [0, 101426, 101427, 101428, 101425]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 55473,
                "FiveStarAchievementId": 428153,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "When It's Time For Leavin', I Hope You'll Understand",
                "LeaderboardIds": [0, 101430, 101431, 101432, 101429]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 152000,
                "FiveStarAchievementId": 428155,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Rollin' Down Highway 41",
                "LeaderboardIds": [0, 101438, 101439, 101440, 101437]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 14000,
                "FiveStarAchievementId": 428154,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "There's Always Having a Good Time Down on the Bayou",
                "LeaderboardIds": [0, 101434, 101435, 101436, 101433]
            }
        }
    },
    SONG_REBEL_YELL: {
        "Title": "Rebel Yell",
        "Artist": "Billy Idol",
        "Year": 1983,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 76381,
                "FiveStarAchievementId": 427899,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Got a License for Love",
                "LeaderboardIds": [0, 100414, 100415, 100416, 100413]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 70650,
                "FiveStarAchievementId": 427900,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "What Set You Free and Brought You Back to Me",
                "LeaderboardIds": [0, 100418, 100419, 100420, 100417]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 125150,
                "FiveStarAchievementId": 427902,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "He Lives in His Own Heaven",
                "LeaderboardIds": [0, 100426, 100427, 100428, 100425]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 37000,
                "FiveStarAchievementId": 427901,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'd Sell My Soul for You",
                "LeaderboardIds": [0, 100422, 100423, 100424, 100421]
            }
        }
    },
    SONG_RE_EDUCATION_THROUGH_LABOR: {
        "Title": "Re-Education (Through Labor)",
        "Artist": "Rise Against",
        "Year": 2008,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 76907,
                "FiveStarAchievementId": 427967,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Each Breath We Take Makes Us Thieves",
                "LeaderboardIds": [0, 100686, 100687, 100688, 100685]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 47336,
                "FiveStarAchievementId": 427968,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Under a Sky No Longer Blue",
                "LeaderboardIds": [0, 100690, 100691, 100692, 100689]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 77850,
                "FiveStarAchievementId": 427970,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We Don't Live, We Just Survive",
                "LeaderboardIds": [0, 100698, 100699, 100700, 100697]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 21000,
                "FiveStarAchievementId": 427969,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We Bring the Dawn Long Overdue",
                "LeaderboardIds": [0, 100694, 100695, 100696, 100693]
            }
        }
    },
    SONG_ROOFTOPS_A_LIBERATION_BROADCAST: {
        "Title": "Rooftops (A Liberation Broadcast)",
        "Artist": "Lostprophets",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 101012,
                "FiveStarAchievementId": 427931,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Will We Make Our Mark This Time",
                "LeaderboardIds": [0, 100542, 100543, 100544, 100541]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 47925,
                "FiveStarAchievementId": 427932,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Have No Regrets",
                "LeaderboardIds": [0, 100546, 100547, 100548, 100545]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 83825,
                "FiveStarAchievementId": 427934,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Watching Every Sunset",
                "LeaderboardIds": [0, 100554, 100555, 100556, 100553]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 26500,
                "FiveStarAchievementId": 427933,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Scream Your Heart Out",
                "LeaderboardIds": [0, 100550, 100551, 100552, 100549]
            }
        }
    },
    SONG_SANTERIA: {
        "Title": "Santeria",
        "Artist": "Sublime",
        "Year": 1996,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 36812,
                "FiveStarAchievementId": 428217,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Ain't Got No Crystal Ball",
                "LeaderboardIds": [0, 101686, 101687, 101688, 101685]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 34418,
                "FiveStarAchievementId": 428218,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "If He Knows What Is Good for Him",
                "LeaderboardIds": [0, 101690, 101691, 101692, 101689]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 70242,
                "FiveStarAchievementId": 428220,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "My Soul Will Have to Wait",
                "LeaderboardIds": [0, 101698, 101699, 101700, 101697]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "FiveStarAchievementId": 428219,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "What I Really Want to Say, I Can't Define",
                "LeaderboardIds": [0, 101694, 101695, 101696, 101693]
            }
        }
    },
    SONG_SATCH_BOOGIE: {
        "Title": "Satch Boogie",
        "Artist": "Joe Satriani",
        "Year": 1987,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 74469,
                "FiveStarAchievementId": 428221,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Surfing with the Alien",
                "LeaderboardIds": [0, 101702, 101703, 101704, 101701]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 33742,
                "FiveStarAchievementId": 428222,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Crushing Day",
                "LeaderboardIds": [0, 101706, 101707, 101708, 101705]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 78379,
                "FiveStarAchievementId": 428223,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Always with Me, Always with You",
                "LeaderboardIds": [0, 101710, 101711, 101712, 101709]
            }
        }
    },
    SONG_SCHISM: {
        "Title": "Schism",
        "Artist": "Tool",
        "Year": 2001,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 84100,
                "FiveStarAchievementId": 427903,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Know the Pieces Fit",
                "LeaderboardIds": [0, 100430, 100431, 100432, 100429]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 79989,
                "FiveStarAchievementId": 427904,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Crippling Our Communication",
                "LeaderboardIds": [0, 100434, 100435, 100436, 100433]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 108375,
                "FiveStarAchievementId": 427906,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Finding Beauty in the Dissonance",
                "LeaderboardIds": [0, 100442, 100443, 100444, 100441]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23000,
                "FiveStarAchievementId": 427905,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Between Supposed Lovers",
                "LeaderboardIds": [0, 100438, 100439, 100440, 100437]
            }
        }
    },
    SONG_SCREAM_AIM_FIRE: {
        "Title": "Scream Aim Fire",
        "Artist": "Bullet For My Valentine",
        "Year": 2008,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 103668,
                "FiveStarAchievementId": 428063,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Chaos Soon Ignites",
                "LeaderboardIds": [0, 101070, 101071, 101072, 101069]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 65986,
                "FiveStarAchievementId": 428064,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Call Is Made, It's One for All",
                "LeaderboardIds": [0, 101074, 101075, 101076, 101073]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 129444,
                "FiveStarAchievementId": 428066,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Such a Hurtful Sight",
                "LeaderboardIds": [0, 101082, 101083, 101084, 101081]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 24500,
                "FiveStarAchievementId": 428065,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Take No Prisoners",
                "LeaderboardIds": [0, 101078, 101079, 101080, 101077]
            }
        }
    },
    SONG_SHIVER: {
        "Title": "Shiver",
        "Artist": "Coldplay",
        "Year": 2000,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 96425,
                "FiveStarAchievementId": 427991,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "From the Moment I Wake to the Moment I Sleep",
                "LeaderboardIds": [0, 100782, 100783, 100784, 100781]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 27100,
                "FiveStarAchievementId": 427992,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Is This My Final Chance of Gettin' You?",
                "LeaderboardIds": [0, 100786, 100787, 100788, 100785]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 109725,
                "FiveStarAchievementId": 427994,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Look in Your Direction but You Pay Me No Attention",
                "LeaderboardIds": [0, 100794, 100795, 100796, 100793]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 25500,
                "FiveStarAchievementId": 427993,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Sing It Loud and Clear",
                "LeaderboardIds": [0, 100790, 100791, 100792, 100789]
            }
        }
    },
    SONG_SOME_MIGHT_SAY: {
        "Title": "Some Might Say",
        "Artist": "Oasis",
        "Year": 1995,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 75171,
                "FiveStarAchievementId": 428075,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We Will Find a Brighter Day",
                "LeaderboardIds": [0, 101118, 101119, 101120, 101117]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 63066,
                "FiveStarAchievementId": 428076,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "In Need of Education in the Rain",
                "LeaderboardIds": [0, 101122, 101123, 101124, 101121]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 120525,
                "FiveStarAchievementId": 428078,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "She's Got Dirty Dishes on the Brain",
                "LeaderboardIds": [0, 101130, 101131, 101132, 101129]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "FiveStarAchievementId": 428077,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Itchin' in the Kitchen Once Again",
                "LeaderboardIds": [0, 101126, 101127, 101128, 101125]
            }
        }
    },
    SONG_SOUL_DOUBT: {
        "Title": "Soul Doubt",
        "Artist": "Nofx",
        "Year": 1992,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 68264,
                "FiveStarAchievementId": 428128,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Sometimes I Feel My Life Is Going 'Round in Circles",
                "LeaderboardIds": [0, 101330, 101331, 101332, 101329]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 47226,
                "FiveStarAchievementId": 428129,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Stick My Head out of the Window When It's Closed",
                "LeaderboardIds": [0, 101334, 101335, 101336, 101333]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 102375,
                "FiveStarAchievementId": 428131,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "A Frameless Erté, a Painting without a Signature",
                "LeaderboardIds": [0, 101342, 101343, 101344, 101341]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19000,
                "FiveStarAchievementId": 428130,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Gotta Know What She's All About",
                "LeaderboardIds": [0, 101338, 101339, 101340, 101337]
            }
        }
    },
    SONG_SPIDERWEBS: {
        "Title": "Spiderwebs",
        "Artist": "No Doubt",
        "Year": 1995,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 74276,
                "FiveStarAchievementId": 427951,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You're Taking up My Time",
                "LeaderboardIds": [0, 100622, 100623, 100624, 100621]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 63888,
                "FiveStarAchievementId": 427952,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You're Ringing in My Ears",
                "LeaderboardIds": [0, 100626, 100627, 100628, 100625]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 124675,
                "FiveStarAchievementId": 427954,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "No Matter Who Calls",
                "LeaderboardIds": [0, 100634, 100635, 100636, 100633]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 37000,
                "FiveStarAchievementId": 427953,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Leave a Message and I'll Call You Back",
                "LeaderboardIds": [0, 100630, 100631, 100632, 100629]
            }
        }
    },
    SONG_STILLBORN: {
        "Title": "Stillborn",
        "Artist": "Black Label Society",
        "Year": 2003,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 48989,
                "FiveStarAchievementId": 427927,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Just a Shell of a Man",
                "LeaderboardIds": [0, 100526, 100527, 100528, 100525]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 37470,
                "FiveStarAchievementId": 427928,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "This I Understand",
                "LeaderboardIds": [0, 100530, 100531, 100532, 100529]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 80075,
                "FiveStarAchievementId": 427930,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Feelings I Once Felt Are Now Dead and Gone",
                "LeaderboardIds": [0, 100538, 100539, 100540, 100537]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12000,
                "FiveStarAchievementId": 427929,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "I've Waited Here for You for So Very Long",
                "LeaderboardIds": [0, 100534, 100535, 100536, 100533]
            }
        }
    },
    SONG_STRANGLEHOLD: {
        "Title": "Stranglehold",
        "Artist": "Ted Nugent",
        "Year": 1975,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 117622,
                "FiveStarAchievementId": 427947,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Here I Come Again Now Baby",
                "LeaderboardIds": [0, 100606, 100607, 100608, 100605]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 109643,
                "FiveStarAchievementId": 427948,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Like to Tear up the Street",
                "LeaderboardIds": [0, 100610, 100611, 100612, 100609]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 191150,
                "FiveStarAchievementId": 427950,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Know I'm Here to Stay",
                "LeaderboardIds": [0, 100618, 100619, 100620, 100617]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 18000,
                "FiveStarAchievementId": 427949,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You Know You Can't Turn Me 'Round",
                "LeaderboardIds": [0, 100614, 100615, 100616, 100613]
            }
        }
    },
    SONG_SWEET_HOME_ALABAMA_LIVE: {
        "Title": "Sweet Home Alabama (Live)",
        "Artist": "Lynyrd Skynyrd",
        "Year": 1976,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 131954,
                "FiveStarAchievementId": 428224,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Big Wheels Keep on Turnin'",
                "LeaderboardIds": [0, 101714, 101715, 101716, 101713]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 68447,
                "FiveStarAchievementId": 428225,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "They Pick Me Up When I'm Feelin' Blue",
                "LeaderboardIds": [0, 101718, 101719, 101720, 101717]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 121770,
                "FiveStarAchievementId": 428227,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Well, I Hope Neil Young Will Remember",
                "LeaderboardIds": [0, 101726, 101727, 101728, 101725]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22500,
                "FiveStarAchievementId": 428226,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Does Your Conscience Bother You?",
                "LeaderboardIds": [0, 101722, 101723, 101724, 101721]
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
                "FiveStarAchievementId": 428115,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Outshine the Motor City Madman",
                "LeaderboardIds": [0, 101278, 101279, 101280, 101277]
            }
        }
    },
    SONG_TODAY: {
        "Title": "Today",
        "Artist": "The Smashing Pumpkins",
        "Year": 1993,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 42853,
                "FiveStarAchievementId": 428136,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Tomorrow's Much Too Long",
                "LeaderboardIds": [0, 101362, 101363, 101364, 101361]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 32113,
                "FiveStarAchievementId": 428137,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Wanted More than Life Could Ever Grant Me",
                "LeaderboardIds": [0, 101366, 101367, 101368, 101365]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 73625,
                "FiveStarAchievementId": 428139,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "My Angel Wings",
                "LeaderboardIds": [0, 101374, 101375, 101376, 101373]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 20000,
                "FiveStarAchievementId": 428138,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I Want to Turn You On",
                "LeaderboardIds": [0, 101370, 101371, 101372, 101369]
            }
        }
    },
    SONG_TOO_MUCH_TOO_YOUNG_TOO_FAST: {
        "Title": "Too Much, Too Young, Too Fast",
        "Artist": "Airbourne",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 51090,
                "FiveStarAchievementId": 428007,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Some People Like to Make All the Rules",
                "LeaderboardIds": [0, 100846, 100847, 100848, 100845]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 37324,
                "FiveStarAchievementId": 428008,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I'm Gonna Drink It Up While It Lasts",
                "LeaderboardIds": [0, 100850, 100851, 100852, 100849]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 76000,
                "FiveStarAchievementId": 428010,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Paranoia on Every Street",
                "LeaderboardIds": [0, 100858, 100859, 100860, 100857]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 17500,
                "FiveStarAchievementId": 428009,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "I'm Goin' Out in Style",
                "LeaderboardIds": [0, 100854, 100855, 100856, 100853]
            }
        }
    },
    SONG_TOY_BOY: {
        "Title": "Toy Boy",
        "Artist": "Stuck In The Sound",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 114669,
                "FiveStarAchievementId": 428144,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Blame Me for the Day",
                "LeaderboardIds": [0, 101394, 101395, 101396, 101393]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 59450,
                "FiveStarAchievementId": 428145,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "She's above Love, Open Your Eyes",
                "LeaderboardIds": [0, 101398, 101399, 101400, 101397]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 122025,
                "FiveStarAchievementId": 428147,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Choked on a Bone, Some Chinese Food",
                "LeaderboardIds": [0, 101406, 101407, 101408, 101405]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 31500,
                "FiveStarAchievementId": 428146,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Please Baby Talk",
                "LeaderboardIds": [0, 101402, 101403, 101404, 101401]
            }
        }
    },
    SONG_TRAPPED_UNDER_ICE: {
        "Title": "Trapped Under Ice",
        "Artist": "Metallica",
        "Year": 1984,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 89315,
                "FiveStarAchievementId": 427911,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "I'm Still Locked in This Shell",
                "LeaderboardIds": [0, 100462, 100463, 100464, 100461]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 65587,
                "FiveStarAchievementId": 427912,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Break the Ice",
                "LeaderboardIds": [0, 100466, 100467, 100468, 100465]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 160875,
                "FiveStarAchievementId": 427914,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "I've Been Stricken by Fate",
                "LeaderboardIds": [0, 100474, 100475, 100476, 100473]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 16000,
                "FiveStarAchievementId": 427913,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Can't Hear My Call",
                "LeaderboardIds": [0, 100470, 100471, 100472, 100469]
            }
        }
    },
    SONG_UP_AROUND_THE_BEND: {
        "Title": "Up Around the Bend",
        "Artist": "Creedence Clearwater Revival",
        "Year": 1970,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 44299,
                "FiveStarAchievementId": 428107,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Bring a Song and a Smile for the Banjo",
                "LeaderboardIds": [0, 101246, 101247, 101248, 101245]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 33987,
                "FiveStarAchievementId": 428108,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Leave the Sinkin' Ship Behind",
                "LeaderboardIds": [0, 101250, 101251, 101252, 101249]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 64125,
                "FiveStarAchievementId": 428110,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "You Can Ponder Perpetual Motion",
                "LeaderboardIds": [0, 101258, 101259, 101260, 101257]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 19500,
                "FiveStarAchievementId": 428109,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "We'll Meet by the Big Red Tree",
                "LeaderboardIds": [0, 101254, 101255, 101256, 101253]
            }
        }
    },
    SONG_VICARIOUS: {
        "Title": "Vicarious",
        "Artist": "Tool",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 105988,
                "FiveStarAchievementId": 428099,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It's No Fun 'Till Someone Dies",
                "LeaderboardIds": [0, 101214, 101215, 101216, 101213]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 93755,
                "FiveStarAchievementId": 428100,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You All Need It Too, Don't Lie",
                "LeaderboardIds": [0, 101218, 101219, 101220, 101217]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 163550,
                "FiveStarAchievementId": 428102,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Why Can't We Just Admit It?",
                "LeaderboardIds": [0, 101226, 101227, 101228, 101225]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 31500,
                "FiveStarAchievementId": 428101,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Sing to the Death Rattle",
                "LeaderboardIds": [0, 101222, 101223, 101224, 101221]
            }
        }
    },
    SONG_VINTERNOLL2: {
        "Title": "VinterNoll2",
        "Artist": "Kent",
        "Year": 2002,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 61928,
                "FiveStarAchievementId": 427895,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Genom en Iskall Vinter",
                "LeaderboardIds": [0, 100398, 100399, 100400, 100397]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 51025,
                "FiveStarAchievementId": 427896,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Du är Min Hjälte",
                "LeaderboardIds": [0, 100402, 100403, 100404, 100401]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 118750,
                "FiveStarAchievementId": 427898,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Jag Behöver Dig Igen, Igen, Igen",
                "LeaderboardIds": [0, 100410, 100411, 100412, 100409]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 12500,
                "FiveStarAchievementId": 427897,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Staden är Precis Som Staden Alltid Varit",
                "LeaderboardIds": [0, 100406, 100407, 100408, 100405]
            }
        }
    },
    SONG_WEAPON_OF_CHOICE: {
        "Title": "Weapon of Choice",
        "Artist": "Black Rebel Motorcycle Club",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 56277,
                "FiveStarAchievementId": 427995,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I Won't Waste It",
                "LeaderboardIds": [0, 100798, 100799, 100800, 100797]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 29094,
                "FiveStarAchievementId": 427996,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "There Is No Weapon to Free Us All",
                "LeaderboardIds": [0, 100802, 100803, 100804, 100801]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 72075,
                "FiveStarAchievementId": 427998,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "I'll See You through to the After Life",
                "LeaderboardIds": [0, 100810, 100811, 100812, 100809]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 23000,
                "FiveStarAchievementId": 427997,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It's Too Hard to Stand Aside",
                "LeaderboardIds": [0, 100806, 100807, 100808, 100805]
            }
        }
    },
    SONG_WHAT_IVE_DONE: {
        "Title": "What I've Done",
        "Artist": "Linkin Park",
        "Year": 2007,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 46905,
                "FiveStarAchievementId": 428120,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "There's No Blood, There's No Alibi",
                "LeaderboardIds": [0, 101298, 101299, 101300, 101297]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 20175,
                "FiveStarAchievementId": 428121,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Put To Rest What You Thought of Me",
                "LeaderboardIds": [0, 101302, 101303, 101304, 101301]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 57975,
                "FiveStarAchievementId": 428123,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "So Let Mercy Come and Wash away What I've Done",
                "LeaderboardIds": [0, 101310, 101311, 101312, 101309]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 11500,
                "FiveStarAchievementId": 428122,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Today This Ends",
                "LeaderboardIds": [0, 101306, 101307, 101308, 101305]
            }
        }
    },
    SONG_THE_WIND_CRIES_MARY: {
        "Title": "The Wind Cries Mary",
        "Artist": "Jimi Hendrix",
        "Year": 1967,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 50366,
                "FiveStarAchievementId": 427919,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Clowns Have All Gone To Bed",
                "LeaderboardIds": [0, 100494, 100495, 100496, 100493]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 23686,
                "FiveStarAchievementId": 427920,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Traffic Lights Turn Blue Tomorrow",
                "LeaderboardIds": [0, 100498, 100499, 100500, 100497]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 49575,
                "FiveStarAchievementId": 427922,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Will the Wind Ever Remember",
                "LeaderboardIds": [0, 100506, 100507, 100508, 100505]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 10000,
                "FiveStarAchievementId": 427921,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Somewhere a Queen Is Weeping",
                "LeaderboardIds": [0, 100502, 100503, 100504, 100501]
            }
        }
    },
    SONG_YOURE_GONNA_SAY_YEAH: {
        "Title": "You're Gonna Say Yeah",
        "Artist": "The Hush Puppies",
        "Year": 2006,
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 73335,
                "FiveStarAchievementId": 428023,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You Would Call Me All the Time",
                "LeaderboardIds": [0, 100910, 100911, 100912, 100909]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 38900,
                "FiveStarAchievementId": 428024,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Ain't Got No Time to Look Behind Me Now",
                "LeaderboardIds": [0, 100914, 100915, 100916, 100913]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 86225,
                "FiveStarAchievementId": 428026,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "You Hope You Won't Be Left Behind",
                "LeaderboardIds": [0, 100922, 100923, 100924, 100921]
            },
            INSTRUMENT_VOCALS: {
                "ExpertBaseScore": 22000,
                "FiveStarAchievementId": 428025,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Listen to What I Have to Say",
                "LeaderboardIds": [0, 100918, 100919, 100920, 100917]
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
                "FiveStarAchievementId": 428164,
                "FiveStarAchievementPoints": 10,
                "FiveStarAchievementTitle": "Decimate the Master of Doom",
                "LeaderboardIds": [0, 101474, 101475, 101476, 101473]
            }
        }
    }
}

function did_achieve_expert_five_star_score(song_ids, instrument_id, base_score) {
    return did_reach_you_rock()
        && p1_score() >= base_score * 14 / 5
        && any_of(song_ids, song_id => current_song() == song_id)
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && !is_in_practice_mode()
        && are_all_cheats_off()
}

function leaderboard_start(song_ids, instrument_id, difficulty_id) {
    return (player_notes_passed(1) >= 1 || player_vocal_phrases_passed(1) >= 1)
        && prev(p1_score()) == 0
        && any_of(song_ids, song_id => current_song() == song_id)
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == difficulty_id
        && !is_in_practice_mode()
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
        achievement_points = SONG_INFO[song]["Instruments"][instrument]["FiveStarAchievementPoints"]
        achievement_title = SONG_INFO[song]["Instruments"][instrument]["FiveStarAchievementTitle"]
        achievement(
            title = achievement_title,
            description = format("Get five stars in {0} on Expert {1} with a score of at least {2}", song_name, instrument_name, format_int_with_commas(base_score * 14 / 5)),
            points = achievement_points,
            id = achievement_id,
            trigger = did_achieve_expert_five_star_score([song], instrument, base_score)
        )

        for difficulty_id in DIFFICULTY_TO_NAME {
            if (difficulty_id != DIFFICULTY_BEGINNER) { // Leaving out beginner difficulty for leaderboards.
                difficulty_name = DIFFICULTY_TO_NAME[difficulty_id]
                if (difficulty_id == DIFFICULTY_EASY) {
                    leaderboard_id = SONG_INFO[song]["Instruments"][instrument]["LeaderboardIds"][1]
                } else if (difficulty_id == DIFFICULTY_MEDIUM) {
                    leaderboard_id = SONG_INFO[song]["Instruments"][instrument]["LeaderboardIds"][2]
                } else if (difficulty_id == DIFFICULTY_HARD) {
                    leaderboard_id = SONG_INFO[song]["Instruments"][instrument]["LeaderboardIds"][3]
                } else if (difficulty_id == DIFFICULTY_EXPERT) {
                    leaderboard_id = SONG_INFO[song]["Instruments"][instrument]["LeaderboardIds"][4]
                }
                leaderboard(
                    title = format("{0} - {1} {2}", song_name, difficulty_name, instrument_name),
                    description = format("Get the highest score in {0} on {1} {2}", song_name, difficulty_name, instrument_name),
                    id = leaderboard_id,
                    start = leaderboard_start([song], instrument, difficulty_id),
                    cancel = leaderboard_cancel(),
                    submit = leaderboard_submit(),
                    value = p1_score(),
                    format = "VALUE"
                )
            }
        }
    }
}

function did_achieve_low_beginner_score() {
    return did_reach_you_rock()
        && p1_score() <= 1000
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && player_difficulty(1) == DIFFICULTY_BEGINNER
        && !is_in_practice_mode()
        && are_all_cheats_off()
}

achievement(
    title = "John Cage Performance",
    description = "Finish any non-custom song with any instrument on Beginner difficulty with 1,000 points or less",
    points = 2,
    id = 428423,
    trigger = did_achieve_low_beginner_score()
)

function did_fail_dammit() {
    return player_rock_meter(1) <= 0.0
        && prev(player_rock_meter(1)) > 0.0
        && current_song() == SONG_DAMMIT
        && !is_in_custom_song()
        && number_of_active_players() == 1
        && !is_in_practice_mode()
        && are_all_cheats_off()
}

achievement(
    title = "Failed Dammit",
    description = "Demonstrate the usefulness of commas",
    points = 0,
    id = 428424,
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
            && !is_in_practice_mode()
            && are_all_cheats_off()
    ) || (
        did_reach_you_rock()
            && player_vocal_phrases_hit(1) * 1.0 == player_vocal_phrases_passed(1)
            && !is_in_custom_song()
            && number_of_active_players() == 1
            && player_instrument(1) == INSTRUMENT_VOCALS
            && (player_difficulty(1) == DIFFICULTY_HARD || player_difficulty(1) == DIFFICULTY_EXPERT)
            && !is_in_practice_mode()
            && are_all_cheats_off()
    )
}

achievement(
    title = "Golden Performance",
    description = "Hit 100% of the notes in any non-custom song on any instrument on either Hard or Expert",
    points = 10,
    id = 428425,
    trigger = did_100_percent_song()
)

VOXTAR_ACHIEVEMENT_INFO = [
    {
        "Song": SONG_ABOUT_A_GIRL_UNPLUGGED,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 430140,
        "AchievementTitle": "Kurt Cobain Double Instrument Challenge",
        "LeaderboardId": 102895
    },
    {
        "Song": SONG_BAND_ON_THE_RUN,
        "Instrument": INSTRUMENT_BASS,
        "AchievementId": 428427,
        "AchievementTitle": "Paul McCartney Double Instrument Challenge",
        "LeaderboardId": 102896
    },
    {
        "Song": SONG_DEMOLITION_MAN_LIVE,
        "Instrument": INSTRUMENT_BASS,
        "AchievementId": 428428,
        "AchievementTitle": "Sting Double Instrument Challenge",
        "LeaderboardId": 102897
    },
    {
        "Song": SONG_EVERLONG,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 430141,
        "AchievementTitle": "Dave Grohl Double Instrument Challenge",
        "LeaderboardId": 102898
    },
    {
        "Song": SONG_HOTEL_CALIFORNIA,
        "Instrument": INSTRUMENT_DRUMS,
        "AchievementId": 428426,
        "AchievementTitle": "Don Henley Double Instrument Challenge",
        "LeaderboardId": 102899
    },
    {
        "Song": SONG_OVERKILL,
        "Instrument": INSTRUMENT_BASS,
        "AchievementId": 428429,
        "AchievementTitle": "Lemmy Double Instrument Challenge",
        "LeaderboardId": 102900
    },
    {
        "Song": SONG_PURPLE_HAZE_LIVE,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 428433,
        "AchievementTitle": "Jimi Hendrix Double Instrument Challenge 2",
        "LeaderboardId": 102901
    },
    {
        "Song": SONG_STILLBORN,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 428431,
        "AchievementTitle": "Zakk Wylde Double Instrument Challenge",
        "LeaderboardId": 102902
    },
    {
        "Song": SONG_TODAY,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 428430,
        "AchievementTitle": "Billy Corgan Double Instrument Challenge",
        "LeaderboardId": 102903
    },
    {
        "Song": SONG_TRAPPED_UNDER_ICE,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 428434,
        "AchievementTitle": "James Hetfield Double Instrument Challenge",
        "LeaderboardId": 102904
    },
    {
        "Song": SONG_THE_WIND_CRIES_MARY,
        "Instrument": INSTRUMENT_GUITAR,
        "AchievementId": 428432,
        "AchievementTitle": "Jimi Hendrix Double Instrument Challenge 1",
        "LeaderboardId": 102905
    }
]

BAND_STARS_ADDR = 0x005cc798
function band_stars() {
    return dword(BAND_STARS_ADDR)
}

function did_achieve_expert_five_star_score_dual_vocal(song, primary_instrument) {
    return (
        did_reach_you_rock()
        && band_stars() == 5
        && current_song() == song
        && !is_in_custom_song()
        && number_of_active_players() == 2
        && player_instrument(1) == primary_instrument
        && player_instrument(2) == INSTRUMENT_VOCALS
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && player_difficulty(2) == DIFFICULTY_EXPERT
        && !is_in_practice_mode()
        && are_all_cheats_off()
    ) || (
        did_reach_you_rock()
        && band_stars() == 5
        && current_song() == song
        && !is_in_custom_song()
        && number_of_active_players() == 2
        && player_instrument(1) == INSTRUMENT_VOCALS
        && player_instrument(2) == primary_instrument
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && player_difficulty(2) == DIFFICULTY_EXPERT
        && !is_in_practice_mode()
        && are_all_cheats_off()
    )
}

function dual_vocal_leaderboard_start(song, primary_instrument) {
    return (
        (player_notes_passed(1) >= 1 || player_vocal_phrases_passed(1) >= 1 || player_notes_passed(2) >= 1 || player_vocal_phrases_passed(2) >= 1)
        && prev(p1_score()) == 0
        && current_song() == song
        && !is_in_custom_song()
        && number_of_active_players() == 2
        && player_instrument(1) == primary_instrument
        && player_instrument(2) == INSTRUMENT_VOCALS
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && player_difficulty(2) == DIFFICULTY_EXPERT
        && !is_in_practice_mode()
        && are_all_cheats_off()
    ) || (
        (player_notes_passed(1) >= 1 || player_vocal_phrases_passed(1) >= 1 || player_notes_passed(2) >= 1 || player_vocal_phrases_passed(2) >= 1)
        && prev(p1_score()) == 0
        && current_song() == song
        && !is_in_custom_song()
        && number_of_active_players() == 2
        && player_instrument(1) == INSTRUMENT_VOCALS
        && player_instrument(2) == primary_instrument
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && player_difficulty(2) == DIFFICULTY_EXPERT
        && !is_in_practice_mode()
        && are_all_cheats_off()
    )
}

for achievement_info in VOXTAR_ACHIEVEMENT_INFO {
    song = achievement_info["Song"]
    song_name = SONG_INFO[song]["Title"]
    primary_instrument = achievement_info["Instrument"]
    instrument_name = INSTRUMENT_TO_NAME[primary_instrument]
    achievement_title = achievement_info["AchievementTitle"]
    achievement_id = achievement_info["AchievementId"]
    achievement(
        title = achievement_title,
        description = format("Get five stars in {0} playing both Expert {1} and Expert Vocals by yourself", song_name, instrument_name),
        id = achievement_id,
        points = 10,
        trigger = did_achieve_expert_five_star_score_dual_vocal(song, primary_instrument)
    )

    if (primary_instrument == INSTRUMENT_GUITAR) {
        combined_instrument_name = "Voxtar"
    } else if (primary_instrument == INSTRUMENT_BASS) {
        combined_instrument_name = "Voxbass"
    } else if (primary_instrument == INSTRUMENT_DRUMS) {
        combined_instrument_name = "Voxdrums"
    }

    leaderboard_id = achievement_info["LeaderboardId"]
    leaderboard(
        title = format("{0} - Expert {1}", song_name, combined_instrument_name),
        description = format("Get the highest score in {0} on both Expert {1} and Expert Vocals by yourself", song_name, instrument_name),
        id = leaderboard_id,
        start = dual_vocal_leaderboard_start(song, primary_instrument),
        cancel = leaderboard_cancel(),
        submit = leaderboard_submit(),
        value = band_score(),
        format = "VALUE"
    )
}

// #endregion

// #region CUSTOM SONGS
CUSTOM_SONG_AMAZING      = 0x2e2ffa47
CUSTOM_SONG_BEE          = 0x978d1559
CUSTOM_SONG_BOUREE       = 0x5def14a5
CUSTOM_SONG_FURELISE     = 0x3a28b18f
CUSTOM_SONG_FUTUREFREAK  = 0x7c727098
CUSTOM_SONG_GREENSLEEVES = 0xb47cc6e1
CUSTOM_SONG_ILIKEDIRT    = 0xb85d73e0
CUSTOM_SONG_JAMANDTOAST  = 0x7bee8fe8
CUSTOM_SONG_LANOCHE      = 0xa014beb7
CUSTOM_SONG_LASERBOP     = 0x4c5d2fb4
CUSTOM_SONG_MAPLELEAF    = 0x8f83e40d
CUSTOM_SONG_PORTO        = 0xe6defecf
CUSTOM_SONG_RAJAFUNSHINE = 0x3cf5557f
CUSTOM_SONG_ROCKHOP      = 0x1deca987
CUSTOM_SONG_RONDO        = 0xc626bb8d
CUSTOM_SONG_STARSPANGLED = 0x5617ba48
CUSTOM_SONG_YANDZ        = 0x897d90fe

CUSTOM_SONG_INFO = {
    CUSTOM_SONG_AMAZING: {
        "Title": "Amazing",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 13910,
                "FiveStarAchievementId": 428372,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Amazing Fretwork",
                "LeaderboardIds": [0, 101730, 101731, 101732, 101729]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 11100,
                "FiveStarAchievementId": 428373,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Amazing Grooves",
                "LeaderboardIds": [0, 101734, 101735, 101736, 101733]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 19250,
                "FiveStarAchievementId": 428374,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Amazing Percussion",
                "LeaderboardIds": [0, 101738, 101739, 101740, 101737]
            }
        }
    },
    CUSTOM_SONG_BEE: {
        "Title": "Bee",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 34374,
                "FiveStarAchievementId": 428399,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "An Interlude Turned Concerto",
                "LeaderboardIds": [0, 101838, 101839, 101840, 101837]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 15321,
                "FiveStarAchievementId": 428400,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "From the Tale of Tsar Saltan",
                "LeaderboardIds": [0, 101842, 101843, 101844, 101841]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 44700,
                "FiveStarAchievementId": 428401,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "A Rimsky-Korsakov Classic",
                "LeaderboardIds": [0, 101846, 101847, 101848, 101845]
            }
        }
    },
    CUSTOM_SONG_BOUREE: {
        "Title": "Bouree",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 16500,
                "FiveStarAchievementId": 428393,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "A Fifth Movement from BWV 996",
                "LeaderboardIds": [0, 101814, 101815, 101816, 101813]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 14750,
                "FiveStarAchievementId": 428394,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Bach to Basics",
                "LeaderboardIds": [0, 101818, 101819, 101820, 101817]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 48175,
                "FiveStarAchievementId": 428395,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "A Classical Rendition of a Jethro Tull Song",
                "LeaderboardIds": [0, 101822, 101823, 101824, 101821]
            }
        }
    },
    CUSTOM_SONG_FURELISE: {
        "Title": "FurElise",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 29612,
                "FiveStarAchievementId": 428390,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "A Famous Posthumous Composition",
                "LeaderboardIds": [0, 101802, 101803, 101804, 101801]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 17622,
                "FiveStarAchievementId": 428391,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Who Even Was Elise?",
                "LeaderboardIds": [0, 101806, 101807, 101808, 101805]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 44175,
                "FiveStarAchievementId": 428392,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Poco Moto",
                "LeaderboardIds": [0, 101810, 101811, 101812, 101809]
            }
        }
    },
    CUSTOM_SONG_FUTUREFREAK: {
        "Title": "FutureFreak",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 24979,
                "FiveStarAchievementId": 428378,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Future's So Bright, I Gotta Wear Shades",
                "LeaderboardIds": [0, 101754, 101755, 101756, 101753]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 15850,
                "FiveStarAchievementId": 428379,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Riding to Work in the Year 2025",
                "LeaderboardIds": [0, 101758, 101759, 101760, 101757]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 21500,
                "FiveStarAchievementId": 428380,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Tomorrow Never Knows",
                "LeaderboardIds": [0, 101762, 101763, 101764, 101761]
            }
        }
    },
    CUSTOM_SONG_GREENSLEEVES: {
        "Title": "Greensleeves",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 14573,
                "FiveStarAchievementId": 428381,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "It Does the More Enrapture Me",
                "LeaderboardIds": [0, 101766, 101767, 101768, 101765]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 11300,
                "FiveStarAchievementId": 428382,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "My Men Were Clothed All in Green",
                "LeaderboardIds": [0, 101770, 101771, 101772, 101769]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 29200,
                "FiveStarAchievementId": 428383,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "My Heart Remains in Captivity",
                "LeaderboardIds": [0, 101774, 101775, 101776, 101773]
            }
        }
    },
    CUSTOM_SONG_ILIKEDIRT: {
        "Title": "ILikeDirt",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 29464,
                "FiveStarAchievementId": 428387,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "The Carpet Crawlers Heed Their Callers",
                "LeaderboardIds": [0, 101790, 101791, 101792, 101789]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 14864,
                "FiveStarAchievementId": 428388,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "The More I Look, the More I Find",
                "LeaderboardIds": [0, 101794, 101795, 101796, 101793]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 20000,
                "FiveStarAchievementId": 428389,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "You Have the Talent to Make Me Feel like Dirt",
                "LeaderboardIds": [0, 101798, 101799, 101800, 101797]
            }
        }
    },
    CUSTOM_SONG_JAMANDTOAST: {
        "Title": "JamAndToast",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 39097,
                "FiveStarAchievementId": 428405,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "A Breakfast Classic",
                "LeaderboardIds": [0, 101862, 101863, 101864, 101861]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 9597,
                "FiveStarAchievementId": 428406,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Slapping That Bass",
                "LeaderboardIds": [0, 101866, 101867, 101868, 101865]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 29250,
                "FiveStarAchievementId": 428407,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Boots and Cats",
                "LeaderboardIds": [0, 101870, 101871, 101872, 101869]
            }
        }
    },
    CUSTOM_SONG_LANOCHE: {
        "Title": "LaNoche",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 18765,
                "FiveStarAchievementId": 428417,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Night Moves",
                "LeaderboardIds": [0, 101910, 101911, 101912, 101909]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 20732,
                "FiveStarAchievementId": 428418,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "End of the Night",
                "LeaderboardIds": [0, 101914, 101915, 101916, 101913]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 45400,
                "FiveStarAchievementId": 428419,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Night Fever",
                "LeaderboardIds": [0, 101918, 101919, 101920, 101917]
            }
        }
    },
    CUSTOM_SONG_LASERBOP: {
        "Title": "LaserBop",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 16192,
                "FiveStarAchievementId": 428402,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Light Amplification by Stimulated Emission of Radiation",
                "LeaderboardIds": [0, 101850, 101851, 101852, 101849]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 12082,
                "FiveStarAchievementId": 428403,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Bop",
                "LeaderboardIds": [0, 101854, 101855, 101856, 101853]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 27825,
                "FiveStarAchievementId": 428404,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Funky Groove Master",
                "LeaderboardIds": [0, 101858, 101859, 101860, 101857]
            }
        }
    },
    CUSTOM_SONG_MAPLELEAF: {
        "Title": "MapleLeaf",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 39263,
                "FiveStarAchievementId": 428414,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Scott Joplin's Funeral Song",
                "LeaderboardIds": [0, 101898, 101899, 101900, 101897]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 28126,
                "FiveStarAchievementId": 428415,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "A Ragtime Classic",
                "LeaderboardIds": [0, 101902, 101903, 101904, 101901]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 46550,
                "FiveStarAchievementId": 428416,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The 39th Greatest Song of All Time According to Canadians",
                "LeaderboardIds": [0, 101906, 101907, 101908, 101905]
            }
        }
    },
    CUSTOM_SONG_PORTO: {
        "Title": "Porto",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 24300,
                "FiveStarAchievementId": 428384,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "The Second Largest City in Portugal",
                "LeaderboardIds": [0, 101778, 101779, 101780, 101777]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 12494,
                "FiveStarAchievementId": 428385,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Not Quite Misirlou",
                "LeaderboardIds": [0, 101782, 101783, 101784, 101781]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 33550,
                "FiveStarAchievementId": 428386,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Porto of Entry",
                "LeaderboardIds": [0, 101786, 101787, 101788, 101785]
            }
        }
    },
    CUSTOM_SONG_RAJAFUNSHINE: {
        "Title": "RajaFunshine",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 17494,
                "FiveStarAchievementId": 428408,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "They Call Me the Working Man",
                "LeaderboardIds": [0, 101874, 101875, 101876, 101873]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 15010,
                "FiveStarAchievementId": 428409,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "The Walking Bass",
                "LeaderboardIds": [0, 101878, 101879, 101880, 101877]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 30950,
                "FiveStarAchievementId": 428410,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Mixed Meter Master",
                "LeaderboardIds": [0, 101882, 101883, 101884, 101881]
            }
        }
    },
    CUSTOM_SONG_ROCKHOP: {
        "Title": "RockHop",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 26871,
                "FiveStarAchievementId": 428396,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Rock Lobster",
                "LeaderboardIds": [0, 101826, 101827, 101828, 101825]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 17400,
                "FiveStarAchievementId": 428397,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "You Keep On Shouting",
                "LeaderboardIds": [0, 101830, 101831, 101832, 101829]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 36000,
                "FiveStarAchievementId": 428398,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Snare on Two",
                "LeaderboardIds": [0, 101834, 101835, 101836, 101833]
            }
        }
    },
    CUSTOM_SONG_RONDO: {
        "Title": "Rondo",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 46919,
                "FiveStarAchievementId": 428420,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Play With Me",
                "LeaderboardIds": [0, 101922, 101923, 101924, 101921]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 43706,
                "FiveStarAchievementId": 428421,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Master of the Turkish March",
                "LeaderboardIds": [0, 101926, 101927, 101928, 101925]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 69675,
                "FiveStarAchievementId": 428422,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Playing against the Piano",
                "LeaderboardIds": [0, 101930, 101931, 101932, 101929]
            }
        }
    },
    CUSTOM_SONG_STARSPANGLED: {
        "Title": "StarSpangled",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 8415,
                "FiveStarAchievementId": 428375,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "O Say Can You See",
                "LeaderboardIds": [0, 101742, 101743, 101744, 101741]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 7176,
                "FiveStarAchievementId": 428376,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "And the Rocket's Red Glare",
                "LeaderboardIds": [0, 101746, 101747, 101748, 101745]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 23400,
                "FiveStarAchievementId": 428377,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "O'er the Land of the Free",
                "LeaderboardIds": [0, 101750, 101751, 101752, 101749]
            }
        }
    },
    CUSTOM_SONG_YANDZ: {
        "Title": "YandZ",
        "Instruments": {
            INSTRUMENT_GUITAR: {
                "ExpertBaseScore": 63969,
                "FiveStarAchievementId": 428411,
                "FiveStarAchievementPoints": 5,
                "FiveStarAchievementTitle": "Alphabet Ender",
                "LeaderboardIds": [0, 101886, 101887, 101888, 101885]
            },
            INSTRUMENT_BASS: {
                "ExpertBaseScore": 19400,
                "FiveStarAchievementId": 428412,
                "FiveStarAchievementPoints": 3,
                "FiveStarAchievementTitle": "Counter Melody Champion",
                "LeaderboardIds": [0, 101890, 101891, 101892, 101889]
            },
            INSTRUMENT_DRUMS: {
                "ExpertBaseScore": 40350,
                "FiveStarAchievementId": 428413,
                "FiveStarAchievementPoints": 4,
                "FiveStarAchievementTitle": "Kick to the Beat",
                "LeaderboardIds": [0, 101894, 101895, 101896, 101893]
            }
        }
    }
}

CUSTOM_SONG_ADDR = 0x00be8b70
function current_custom_song_id() {
    return dword(dword(CUSTOM_SONG_ADDR) + 0x0c)
}

function custom_song_did_achieve_expert_five_star_score(song_id, instrument_id, base_score) {
    return did_reach_you_rock()
        && p1_score() >= base_score * 14 / 5
        && current_custom_song_id() == song_id
        && is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == instrument_id
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && are_all_cheats_off()
}

function custom_song_leaderboard_start(song_id, instrument_id, difficulty_id) {
    return (player_notes_passed(1) >= 1 || player_vocal_phrases_passed(1) >= 1)
        && prev(p1_score()) == 0
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
        achievement_points = CUSTOM_SONG_INFO[song]["Instruments"][instrument]["FiveStarAchievementPoints"]
        achievement_title = CUSTOM_SONG_INFO[song]["Instruments"][instrument]["FiveStarAchievementTitle"]
        achievement(
            title = achievement_title,
            description = format("Get five stars in the custom song {0} on Expert {1} with a score of at least {2}", song_name, instrument_name, format_int_with_commas(base_score * 14 / 5)),
            points = achievement_points,
            id = achievement_id,
            trigger = custom_song_did_achieve_expert_five_star_score(song, instrument, base_score)
        )

        for difficulty_id in DIFFICULTY_TO_NAME {
            if (difficulty_id != DIFFICULTY_BEGINNER) { // Leaving out beginner difficulty for leaderboards.
                difficulty_name = DIFFICULTY_TO_NAME[difficulty_id]
                leaderboard(
                    title = format("{0} - {1} {2}", song_name, difficulty_name, instrument_name),
                    description = format("Get the highest score in the custom song {0} on {1} {2}", song_name, difficulty_name, instrument_name),
                    id = 0,
                    start = custom_song_leaderboard_start(song, instrument, difficulty_id),
                    cancel = custom_song_leaderboard_cancel(),
                    submit = custom_song_leaderboard_submit(),
                    value = p1_score(),
                    format = "VALUE"
                )
            }
        }
    }
}

function custom_song_did_achieve_expert_vocals_full_combo() {
    neversoft_song_condition = always_false()
    for song in CUSTOM_SONG_INFO {
        neversoft_song_condition = neversoft_song_condition || current_custom_song_id() == song
    }
    return did_reach_you_rock()
        && player_vocal_phrases_hit(1) == 1 // This is the gag, all GHTunes songs are one phrase.
        && neversoft_song_condition
        && is_in_custom_song()
        && number_of_active_players() == 1
        && player_instrument(1) == INSTRUMENT_VOCALS
        && player_difficulty(1) == DIFFICULTY_EXPERT
        && !is_in_practice_mode()
        && are_all_cheats_off()
}

achievement(
    title = "MIDI Master",
    description = "Full combo any Neversoft-made custom song on Expert Vocals",
    points = 3,
    id = 428435,
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
        && !is_in_practice_mode()
        && are_all_cheats_off()
}

achievement(
    title = "Modern Day Mozart",
    description = "Five star your own GHTunes song on either Expert Guitar, Expert Bass, or Expert Drums (must have at least 500 notes). You also get brownie points if you post a video of your song to the RetroAchievements Discord.",
    points = 5,
    id = 428436,
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
            "Points": 3,
            "CompleteGigAnyAchievementId": 428228,
            "CompleteGigExpertAchievementId": 428229
        },
        {
            "Venue": "Wilted Orchid",
            "GigNumber": 0,
            "Songs": [
                SONG_BEAUTIFUL_DISASTER,
                SONG_OBSTACLE_1,
                SONG_THE_ONE_I_LOVE
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428230,
            "CompleteGigExpertAchievementId": 428231
        },
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_SOME_MIGHT_SAY,
                SONG_TODAY,
                SONG_WHAT_IVE_DONE
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428232,
            "CompleteGigExpertAchievementId": 428233
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428234,
            "CompleteGigExpertAchievementId": 428235
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428236,
            "CompleteGigExpertAchievementId": 428237
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "Points": 5,
            "CompleteGigAnyAchievementId": 428238,
            "CompleteGigExpertAchievementId": 428239
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428240,
            "CompleteGigExpertAchievementId": 428241
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428242,
            "CompleteGigExpertAchievementId": 428243
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428244,
            "CompleteGigExpertAchievementId": 428245
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428246,
            "CompleteGigExpertAchievementId": 428247
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428248,
            "CompleteGigExpertAchievementId": 428249
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428250,
            "CompleteGigExpertAchievementId": 428251
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428252,
            "CompleteGigExpertAchievementId": 428253
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428254,
            "CompleteGigExpertAchievementId": 428255
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428256,
            "CompleteGigExpertAchievementId": 428257
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428258,
            "CompleteGigExpertAchievementId": 428259
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428260,
            "CompleteGigExpertAchievementId": 428261
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428262,
            "CompleteGigExpertAchievementId": 428263
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
            "Points": 3,
            "CompleteGigAnyAchievementId": 428264,
            "CompleteGigExpertAchievementId": 428265
        },
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_WHAT_IVE_DONE,
                SONG_TODAY,
                SONG_SOME_MIGHT_SAY
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428266,
            "CompleteGigExpertAchievementId": 428267
        },
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_ABOUT_A_GIRL_UNPLUGGED,
                SONG_LIVIN_ON_A_PRAYER,
                SONG_MOUNTAIN_SONG
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428268,
            "CompleteGigExpertAchievementId": 428269
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428270,
            "CompleteGigExpertAchievementId": 428271
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428272,
            "CompleteGigExpertAchievementId": 428273
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "Points": 5,
            "CompleteGigAnyAchievementId": 428274,
            "CompleteGigExpertAchievementId": 428275
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428276,
            "CompleteGigExpertAchievementId": 428277
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428278,
            "CompleteGigExpertAchievementId": 428279
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428280,
            "CompleteGigExpertAchievementId": 428281
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428282,
            "CompleteGigExpertAchievementId": 428283
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428284,
            "CompleteGigExpertAchievementId": 428285
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428286,
            "CompleteGigExpertAchievementId": 428287
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428288,
            "CompleteGigExpertAchievementId": 428289
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428290,
            "CompleteGigExpertAchievementId": 428291
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428292,
            "CompleteGigExpertAchievementId": 428293
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428294,
            "CompleteGigExpertAchievementId": 428295
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428296,
            "CompleteGigExpertAchievementId": 428297
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428298,
            "CompleteGigExpertAchievementId": 428299
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
            "Points": 3,
            "CompleteGigAnyAchievementId": 428336,
            "CompleteGigExpertAchievementId": 428337
        },
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_EYE_OF_THE_TIGER,
                SONG_LIVIN_ON_A_PRAYER,
                SONG_ABOUT_A_GIRL_UNPLUGGED
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428338,
            "CompleteGigExpertAchievementId": 428339
        },
        {
            "Venue": "Wilted Orchid",
            "GigNumber": 0,
            "Songs": [
                SONG_THE_MIDDLE,
                SONG_THE_ONE_I_LOVE,
                SONG_BEAUTIFUL_DISASTER
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428340,
            "CompleteGigExpertAchievementId": 428341
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428342,
            "CompleteGigExpertAchievementId": 428343
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428344,
            "CompleteGigExpertAchievementId": 428345
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "Points": 5,
            "CompleteGigAnyAchievementId": 428346,
            "CompleteGigExpertAchievementId": 428347
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428348,
            "CompleteGigExpertAchievementId": 428349
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428350,
            "CompleteGigExpertAchievementId": 428351
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428352,
            "CompleteGigExpertAchievementId": 428353
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428354,
            "CompleteGigExpertAchievementId": 428355
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428356,
            "CompleteGigExpertAchievementId": 428357
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428358,
            "CompleteGigExpertAchievementId": 428359
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428360,
            "CompleteGigExpertAchievementId": 428361
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428362,
            "CompleteGigExpertAchievementId": 428363
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428364,
            "CompleteGigExpertAchievementId": 428365
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428366,
            "CompleteGigExpertAchievementId": 428367
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428368,
            "CompleteGigExpertAchievementId": 428369
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428370,
            "CompleteGigExpertAchievementId": 428371
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
            "Points": 3,
            "CompleteGigAnyAchievementId": 428300,
            "CompleteGigExpertAchievementId": 428301
        },
        {
            "Venue": "Bone Church",
            "GigNumber": 0,
            "Songs": [
                SONG_WHAT_IVE_DONE,
                SONG_TODAY,
                SONG_SOME_MIGHT_SAY
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428302,
            "CompleteGigExpertAchievementId": 428303
        },
        {
            "Venue": "Phi Psi Kappa",
            "GigNumber": 0,
            "Songs": [
                SONG_ABOUT_A_GIRL_UNPLUGGED,
                SONG_MOUNTAIN_SONG,
                SONG_LIVIN_ON_A_PRAYER
            ],
            "Points": 3,
            "CompleteGigAnyAchievementId": 428304,
            "CompleteGigExpertAchievementId": 428305
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428306,
            "CompleteGigExpertAchievementId": 428307
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
            "Points": 4,
            "CompleteGigAnyAchievementId": 428308,
            "CompleteGigExpertAchievementId": 428309
        },
        {
            "Venue": "Tool",
            "GigNumber": 0,
            "Songs": [
                SONG_PARABOLA,
                SONG_SCHISM,
                SONG_VICARIOUS
            ],
            "Points": 5,
            "CompleteGigAnyAchievementId": 428310,
            "CompleteGigExpertAchievementId": 428311
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428312,
            "CompleteGigExpertAchievementId": 428313
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428314,
            "CompleteGigExpertAchievementId": 428315
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428316,
            "CompleteGigExpertAchievementId": 428317
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428318,
            "CompleteGigExpertAchievementId": 428319
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428320,
            "CompleteGigExpertAchievementId": 428321
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428322,
            "CompleteGigExpertAchievementId": 428323
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428324,
            "CompleteGigExpertAchievementId": 428325
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428326,
            "CompleteGigExpertAchievementId": 428327
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428328,
            "CompleteGigExpertAchievementId": 428329
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428330,
            "CompleteGigExpertAchievementId": 428331
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428332,
            "CompleteGigExpertAchievementId": 428333
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
            "Points": 5,
            "CompleteGigAnyAchievementId": 428334,
            "CompleteGigExpertAchievementId": 428335
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
                && !is_in_practice_mode()
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
        points = gig["Points"]

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

        if (gig_venue == "Times Square") {
            type = "win_condition"
        } else {
            type = ""
        }

        achievement(
            title = any_difficulty_title,
            description = any_difficulty_description,
            points = points,
            id = any_difficulty_achievement_id,
            type = type,
            trigger = has_player_completed_all_songs_in_gig(gig["Songs"], instrument, false)
        )

        achievement(
            title = expert_difficulty_title,
            description = expert_difficulty_description,
            points = points,
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

CUSTOM_SONG_TO_NAME = {}
for custom_song in CUSTOM_SONG_INFO {
    CUSTOM_SONG_TO_NAME[custom_song] = "the custom song " + CUSTOM_SONG_INFO[custom_song]["Title"]
}

BAND_STAR_POWER_ADDR = 0x005cc768
function band_star_power() {
    return float(BAND_STAR_POWER_ADDR)
}

BAND_STREAK_ADDR = 0x00e115dc
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

rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && !is_in_custom_song() && number_of_active_players() > 1 && band_score() > 0 && !is_in_practice_mode(), "Rockin' out to {0} as a band - Score: {1}, Streak: {2}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_macro("Number", band_score()),
    rich_presence_macro("Number", band_streak())
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && !is_in_custom_song() && number_of_active_players() == 1 && player_instrument(1) == INSTRUMENT_VOCALS && p1_score() > 0 && !is_in_practice_mode(), "Rockin' out to {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", p1_score()),
    rich_presence_macro("Number", player_streak(1) / 10)
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && !is_in_custom_song() && number_of_active_players() == 1 && p1_score() > 0 && !is_in_practice_mode(), "Rockin' out to {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", p1_score()),
    rich_presence_macro("Number", player_streak(1))
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && is_in_custom_song() && number_of_active_players() > 1 && band_score() > 0 && !is_in_practice_mode(), "Rockin' out to {0} as a band - Score: {1}, Streak: {2}",
    rich_presence_lookup("CustomSong", current_custom_song_id(), CUSTOM_SONG_TO_NAME, "an original custom song"),
    rich_presence_macro("Number", band_score()),
    rich_presence_macro("Number", band_streak())
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && is_in_custom_song() && number_of_active_players() == 1 && player_instrument(1) == INSTRUMENT_VOCALS && p1_score() > 0 && !is_in_practice_mode(), "Rockin' out to {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("CustomSong", current_custom_song_id(), CUSTOM_SONG_TO_NAME, "an original custom song"),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", p1_score()),
    rich_presence_macro("Number", player_streak(1) / 10)
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && is_in_custom_song() && number_of_active_players() == 1 && p1_score() > 0 && !is_in_practice_mode(), "Rockin' out to {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("CustomSong", current_custom_song_id(), CUSTOM_SONG_TO_NAME, "an original custom song"),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", p1_score()),
    rich_presence_macro("Number", player_streak(1))
)
rich_presence_conditional_display(is_in_song() && !is_background_menu_music_playing_addr() && !in_gig_select() && number_of_active_players() == 1 && p1_score() > 0 && is_in_practice_mode(), "Practising {0} on {1} {2} - Score: {3}, Streak: {4}",
    rich_presence_lookup("Song", current_song(), SONG_TO_NAME),
    rich_presence_lookup("Difficulty", player_difficulty(1), DIFFICULTY_TO_NAME),
    rich_presence_lookup("Instrument", player_instrument(1), INSTRUMENT_TO_NAME),
    rich_presence_macro("Number", p1_score()),
    rich_presence_macro("Number", player_streak(1))
)
rich_presence_display("Tuning instruments...")

// #endregion