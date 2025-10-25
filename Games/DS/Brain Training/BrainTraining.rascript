// Dr. Kawashima's Brain Training: How Old Is Your Brain?
// #ID = 2141
// md5: dd00d38b784adcb92a0f089173f9645c

SCREEN_ID_ADDR = 0x000dd9c8
function screen_id() => byte(SCREEN_ID_ADDR)

SCREEN_ID_KAWASHIMA_SIGNATURE_LOGO               = 0x01
SCREEN_ID_NINTENDO_LOGO_2                        = 0x02
SCREEN_ID_MAIN_MENU                              = 0x03
SCREEN_ID_QUICK_PLAY                             = 0x04
SCREEN_ID_DOWNLOAD_MENU                          = 0x08
SCREEN_ID_DOWNLOAD_LOOKING_FOR_PARTNER_MENU      = 0x09
SCREEN_ID_GETTING_TOLD_YOUR_BRAIN_AGE            = 0x0e
SCREEN_ID_CALCULATIONS_100                       = 0x10
SCREEN_ID_CALCULATIONS_20                        = 0x11
SCREEN_ID_CALCULATIONS_100_HARD                  = 0x12
SCREEN_ID_VOICE_CALCULATION                      = 0x13
SCREEN_ID_DAILY_TRAINING_MENU                    = 0x18
SCREEN_ID_PROFILE_SELECT                         = 0x19
SCREEN_ID_STROOP_TEST                            = 0x1d
SCREEN_ID_TRIANGLE_MATH                          = 0x20
SCREEN_ID_TRIANGLE_MATH_HARD                     = 0x21
SCREEN_ID_SPEED_COUNTING                         = 0x27
SCREEN_ID_CONNECT_MAZE                           = 0x29
SCREEN_ID_WORD_MEMORY                            = 0x2a
SCREEN_ID_RESULTS                                = 0x2b
SCREEN_ID_SYLLABLE_COUNT                         = 0x2c
SCREEN_ID_LOW_TO_HIGH                            = 0x2d
SCREEN_ID_GRAPH_2_MONTH_VIEW                     = 0x2f
SCREEN_ID_PLACING_A_STAMP                        = 0x30
SCREEN_ID_NUMBER_CRUNCHER                        = 0x31
SCREEN_ID_GRAPH_TRAINING_MENU                    = 0x32
SCREEN_ID_PICTURE_DRAWING                        = 0x33
SCREEN_ID_PICTURE_DRAWING_RESULTS                = 0x34
SCREEN_ID_NEW_DATA_PROMPTS                       = 0x36
SCREEN_ID_HANDEDNESS_PROMPT                      = 0x38
SCREEN_ID_NAME_PROMPT                            = 0x3a
SCREEN_ID_NAME_RETURN_PROMPT                     = 0x3b
SCREEN_ID_AGE_YEAR_PROMPT                        = 0x3c
SCREEN_ID_AGE_YEAR_RETURN_PROMPT                 = 0x3d
SCREEN_ID_AGE_MONTH_PROMPT                       = 0x3e
SCREEN_ID_AGE_DAY_PROMPT                         = 0x3f
SCREEN_ID_DETAILS_CONFIRM_PROMPT                 = 0x40
SCREEN_ID_INSTRUCTIONS                           = 0x41
SCREEN_ID_DIFFICULTY_SELECTION_PROMPT            = 0x42
SCREEN_ID_COUNTDOWN                              = 0x43
SCREEN_ID_TIME_LAPSE                             = 0x44
SCREEN_ID_WRITING_PROMPT                         = 0x45
SCREEN_ID_STAMP_DESIGN                           = 0x46
SCREEN_ID_HEAD_COUNT                             = 0x47
SCREEN_ID_HEAD_COUNT_HARD                        = 0x48
SCREEN_ID_OTHER_OPTIONS_MENU                     = 0x49
SCREEN_ID_OTHER_OPTIONS_SETTINGS                 = 0x4a
SCREEN_ID_TIPS                                   = 0x4b
SCREEN_ID_CHANGE_HANDEDNESS                      = 0x4c
SCREEN_ID_FONT_SIZE                              = 0x4d
SCREEN_ID_CHANGE_SIGNATURE                       = 0x4e
SCREEN_ID_GRAPH_VIEW_AFTER_MINIGAME              = 0x4f
SCREEN_ID_UNLOCKING_SOMETHING                    = 0x50
SCREEN_ID_BRAIN_LECTURE                          = 0x57
SCREEN_ID_DELETING_PROFILE                       = 0x59
SCREEN_ID_FIRST_BRAIN_AGE_SPEAK_PROMPT           = 0x5b
SCREEN_ID_FIRST_BRAIN_AGE_RETURNING_SPEAK_PROMPT = 0x5c
SCREEN_ID_FIRST_BRAIN_AGE_FINISHING_LECTURE      = 0x5d
SCREEN_ID_CAN_YOU_SPEAK_OUT_LOUD_PROMPT          = 0x65
SCREEN_ID_PROFILE_GREETING                       = 0x67
SCREEN_ID_QUICK_PLAY_POST_RESULTS                = 0x68
SCREEN_ID_REPEAT_MINIGAME_PROMPT                 = 0x69
SCREEN_ID_READING_TOO_FAST                       = 0x6a
SCREEN_ID_READING_ALOUD                          = 0x6e
SCREEN_ID_CREDITS                                = 0x6f
SCREEN_ID_TOP_3_LIST_RESULTS                     = 0x76
SCREEN_ID_TOP_3_LIST                             = 0x77
SCREEN_ID_NINTENDO_LOGO                          = 0x79
SCREEN_ID_LANGUAGE_SELECT                        = 0x7a
SCREEN_ID_SUDOKU                                 = 0x7e
SCREEN_ID_QUICK_PLAY_SUDOKU                      = 0x7f
SCREEN_ID_SUDOKU_DIFFICULTY_MENU                 = 0x80
SCREEN_ID_SUDOKU_PUZZLE_SELECT                   = 0x81
SCREEN_ID_SUDOKU_CHEAT_MODE_PROMPT               = 0x84
SCREEN_ID_SUDOKU_HOW_TO_PLAY                     = 0x89


BRAIN_AGE_ADDR = 0x000ede28
function brain_age() => byte(BRAIN_AGE_ADDR)

function brain_age_check_completed() => screen_id() == SCREEN_ID_GETTING_TOLD_YOUR_BRAIN_AGE && prev(screen_id()) == SCREEN_ID_RESULTS

achievement(
    title = "Young at Brain",
    description = "Get a Brain Age of 20 after a three minigame Check",
    points = 5,
    id = 554239,
    trigger = brain_age_check_completed() && brain_age() == 20
)

leaderboard(
    title = "Brain Age",
    description = "Score the youngest Brain Age",
    id = 144040,
    start = brain_age_check_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = brain_age(),
    format = "VALUE",
    lower_is_better = true
)


STAMPS_COLLECTED_ADDR = 0x000d8552
function stamps_collected() => word(STAMPS_COLLECTED_ADDR)

function did_player_just_collect_stamp(num_stamps) => screen_id() == SCREEN_ID_PLACING_A_STAMP && stamps_collected() == num_stamps

class StampAchievementDetails {
    title = "DUMMY TITLE"
    description = "DUMMY DESCRIPTION"
    points = 0
    id = 0
    stamps_required = 0
    function trigger() => did_player_just_collect_stamp(this.stamps_required)
}

STAMP_ACHIEVEMENTS = [
    // This first one accidentally unlocks as you enter the screen with one stamp already, but since it's so easy to achieve on a new save, and you have to get one stamp before the second one, I won't look towards fixing this bug.
    StampAchievementDetails(
        title = "Stamp of Approval",
        description = "Earn your 1st stamp and unlock Low To High",
        points = 1,
        id = 554240,
        stamps_required = 1
    ),
    StampAchievementDetails(
        title = "There Are Two Syllables in \"Stamp Two\"",
        description = "Earn your 2nd stamp and unlock Syllable Count",
        points = 1,
        id = 554241,
        stamps_required = 2
    ),
    StampAchievementDetails(
        title = "The Magic Number",
        description = "Earn your 3rd stamp and unlock Head Count",
        points = 1,
        id = 554242,
        stamps_required = 3
    ),
    StampAchievementDetails(
        title = "Tip Your Hat",
        description = "Earn your 5th stamp and unlock the tips section",
        points = 2,
        id = 554243,
        stamps_required = 5
    ),
    StampAchievementDetails(
        title = "Weeklong Trainer",
        description = "Earn your 7th stamp and unlock the stamp designer",
        points = 2,
        id = 554244,
        stamps_required = 7
    ),
    StampAchievementDetails(
        title = "The Magic Number Multiplied by the Magic Number",
        description = "Earn your 9th stamp and unlock the Hard mode for Head Count",
        points = 2,
        id = 554245,
        stamps_required = 9
    ),
    StampAchievementDetails(
        title = "Divide and Conquer",
        description = "Earn your 11th stamp and unlock the Hard mode for Calculations x100 (unless you already got it, then it's just another stamp)",
        points = 2,
        id = 554246,
        stamps_required = 11
    ),
    StampAchievementDetails(
        title = "Geometric Stimuli",
        description = "Earn your 13th stamp and unlock Triangle Math",
        points = 2,
        id = 554247,
        stamps_required = 13
    ),
    StampAchievementDetails(
        title = "Time for a Stamp",
        description = "Earn your 15th stamp and unlock Time Lapse",
        points = 2,
        id = 554248,
        stamps_required = 15
    ),
    StampAchievementDetails(
        title = "Fractal Stamper",
        description = "Earn your 17th stamp and unlock Hard mode for Triangle Math",
        points = 2,
        id = 554249,
        stamps_required = 17
    ),
    StampAchievementDetails(
        title = "Tip Collector",
        description = "Earn your 20th stamp and unlock Voice Calculation",
        points = 3,
        id = 554250,
        stamps_required = 20
    ),
    StampAchievementDetails(
        title = "A Full Tip Jar",
        description = "Earn your 23rd stamp and complete your tip collection",
        points = 3,
        id = 554251,
        stamps_required = 23
    )
]

for stamp_achievement in STAMP_ACHIEVEMENTS {
    if (stamp_achievement.stamps_required == 23) {
        type = ""
    } else {
        type = "progression"
    }
    achievement(
        title = stamp_achievement.title,
        description = stamp_achievement.description,
        points = stamp_achievement.points,
        id = stamp_achievement.id,
        trigger = stamp_achievement.trigger(),
        type = type
    )
}


CONNECT_MAZE_TIME_USED_ADDR = 0x000dda1c
function connect_maze_time_used() => word(CONNECT_MAZE_TIME_USED_ADDR)

function connect_maze_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_CONNECT_MAZE

achievement(
    title = "Now I Know My A-1-B-2-C-3s",
    description = "Get a time of 50 seconds or less in Connect Maze",
    points = 5,
    id = 554252,
    trigger = connect_maze_completed() && connect_maze_time_used() <= 3000
)

leaderboard(
    title = "Connect Maze",
    description = "Score the best time in Connect Maze",
    id = 144041,
    start = connect_maze_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = connect_maze_time_used(),
    format = "FRAMES",
    lower_is_better = true
)


WORD_MEMORY_SCORE_ADDR = 0x000dd9b0
function word_memory_score() => word(WORD_MEMORY_SCORE_ADDR)

function word_memory_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_WORD_MEMORY

achievement(
    title = "Look See Cover Write Check",
    description = "Get a score of at least 22 in Word Memory",
    points = 5,
    id = 554253,
    trigger = word_memory_completed() && word_memory_score() >= 22
)

achievement(
    title = "I Am a Camera",
    description = "Get a perfect score of 30 in Word Memory",
    points = 1,
    id = 554254,
    trigger = word_memory_completed() && word_memory_score() == 30
)

leaderboard(
    title = "Word Memory",
    description = "Score the best score in Word Memory",
    id = 144042,
    start = word_memory_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = word_memory_score(),
    format = "VALUE"
)


NUMBER_CRUNCHER_TIME_USED_ADDR = 0x000dd9d0
function number_cruncher_time_used() => word(NUMBER_CRUNCHER_TIME_USED_ADDR)

function number_cruncher_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_NUMBER_CRUNCHER

achievement(
    title = "Putting Sherlock to Shame",
    description = "Get a time of 60 seconds or less in Number Cruncher",
    points = 5,
    id = 554255,
    trigger = number_cruncher_time_used() <= 3600
)

leaderboard(
    title = "Number Cruncher",
    description = "Score the best time in Number Cruncher",
    id = 144043,
    start = number_cruncher_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = number_cruncher_time_used(),
    format = "FRAMES",
    lower_is_better = true
)


STROOP_TEST_TIME_USED_ADDR = 0x000dda1c
function stroop_test_time_used() => word(STROOP_TEST_TIME_USED_ADDR)

function stroop_test_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_STROOP_TEST

achievement(
    title = "One Stroop, Two Stroop, Red Stroop, Blue Stroop",
    description = "Get a time of 50 seconds or less in Stroop Test",
    points = 5,
    id = 554256,
    trigger = stroop_test_completed() && stroop_test_time_used() <= 3000
)

leaderboard(
    title = "Stroop Test",
    description = "Score the best time in Stroop Test",
    id = 144044,
    start = stroop_test_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = stroop_test_time_used(),
    format = "FRAMES",
    lower_is_better = true
)


SPEED_COUNTING_TIME_USED_ADDR = 0x000dda1c
function speed_counting_time_used() => word(SPEED_COUNTING_TIME_USED_ADDR)

SCREEN_TAP_ADDR = 0x000dd974
function is_screen_tapped() => byte(SCREEN_TAP_ADDR)

function speed_counting_completed(screen_tap_lock) {
    if (screen_tap_lock == true) {
        return trigger_when(screen_id() == SCREEN_ID_RESULTS)
            && prev(screen_id()) == SCREEN_ID_SPEED_COUNTING
            && disable_when(repeated(2, is_screen_tapped() == 1 && prev(is_screen_tapped()) == 0), until = screen_id() == SCREEN_ID_COUNTDOWN)
    } else {
        return screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_SPEED_COUNTING
    }
}

achievement(
    title = "Onetwothreefourfivesixseveneightnineten",
    description = "Get a time of 45 seconds or less in Speed Counting (and you must only tap the screen once)",
    points = 1,
    id = 554257,
    trigger = speed_counting_completed(true) && speed_counting_time_used() <= 3000
)

achievement(
    title = "Ticketmaster Practise",
    description = "Get a time of under 16 seconds in Speed Counting",
    points = 1,
    id = 554258,
    trigger = speed_counting_completed(false) && speed_counting_time_used() <= 3000
)

leaderboard(
    title = "Speed Counting",
    description = "Score the best time in Speed Counting",
    id = 144045,
    start = speed_counting_completed(false),
    cancel = always_false(),
    submit = always_true(),
    value = speed_counting_time_used(),
    format = "FRAMES",
    lower_is_better = true
)


CALCULATIONS_TIME_USED_ADDR = 0x000ed74c
function calculations_time_used() => word(CALCULATIONS_TIME_USED_ADDR)

CALCULATIONS_CORRECT_QUESTIONS_ADDR = 0x000ed748
function calculations_correct_questions() => word(CALCULATIONS_CORRECT_QUESTIONS_ADDR)

function calculations_completed(calculations_screen) => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == calculations_screen

function calculations_score(questions) => (questions - calculations_correct_questions()) * 5 * 60 + calculations_time_used()

function was_calculations_beaten_in_time(calculations_screen, questions, frames) {
    return calculations_completed(calculations_screen)
        && calculations_score(questions) <= frames
}

achievement(
    title = "Simple Mathematics",
    description = "Get a Rocket Speed time of 12 seconds or less in Calculations x20",
    points = 10,
    id = 554259,
    trigger = was_calculations_beaten_in_time(SCREEN_ID_CALCULATIONS_20, 20, 12 * 60)
)

leaderboard(
    title = "Calculations x20",
    description = "Score the best time in Calculations x20",
    id = 144046,
    start = calculations_completed(SCREEN_ID_CALCULATIONS_20),
    cancel = always_false(),
    submit = always_true(),
    value = calculations_score(20),
    format = "FRAMES",
    lower_is_better = true
)

achievement(
    title = "Century Cruiser",
    description = "Get a Rocket Speed time of 65 seconds or less in Calculations x100 Normal",
    points = 10,
    id = 554260,
    trigger = was_calculations_beaten_in_time(SCREEN_ID_CALCULATIONS_100, 100, 65 * 60)
)

leaderboard(
    title = "Calculations x100 Normal",
    description = "Score the best time in Calculations x100 Normal",
    id = 144047,
    start = calculations_completed(SCREEN_ID_CALCULATIONS_100),
    cancel = always_false(),
    submit = always_true(),
    value = calculations_score(100),
    format = "FRAMES",
    lower_is_better = true
)

achievement(
    title = "Quotient Crusher",
    description = "Get a Rocket Speed time of 65 seconds or less in Calculations x100 Hard",
    points = 10,
    id = 554261,
    trigger = was_calculations_beaten_in_time(SCREEN_ID_CALCULATIONS_100_HARD, 100, 65 * 60)
)

leaderboard(
    title = "Calculations x100 Hard",
    description = "Score the best time in Calculations x100 Hard",
    id = 144048,
    start = calculations_completed(SCREEN_ID_CALCULATIONS_100_HARD),
    cancel = always_false(),
    submit = always_true(),
    value = calculations_score(100),
    format = "FRAMES",
    lower_is_better = true
)


READING_ALOUD_SYLLABLES_PER_SECOND_ADDR = 0x000dd9b0
function reading_aloud_syllables_per_ten_seconds() => word(READING_ALOUD_SYLLABLES_PER_SECOND_ADDR)

function reading_aloud_failed() => screen_id() == SCREEN_ID_READING_TOO_FAST && prev(screen_id()) == SCREEN_ID_READING_ALOUD
function reading_aloud_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_READING_ALOUD

achievement(
    title = "Greedy Reader",
    description = "Get told off for speed reading",
    points = 0,
    id = 554262,
    trigger = reading_aloud_failed()
)

achievement(
    title = "Intergalactic Prose",
    description = "Get a Rocket Speed score of 12.0 syllables per second or higher in Reading Aloud",
    points = 5,
    id = 554263,
    trigger = reading_aloud_completed() && reading_aloud_syllables_per_ten_seconds() >= 120
)

leaderboard(
    title = "Reading Aloud",
    description = "Score the best syllables per second in Reading Aloud (value in this leaderboard is x10)",
    id = 144049,
    start = reading_aloud_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = reading_aloud_syllables_per_ten_seconds(),
    format = "VALUE"
)


LOW_TO_HIGH_SCORE_ADDR = 0x000edef4
function low_to_high_score() => word(LOW_TO_HIGH_SCORE_ADDR)

function low_to_high_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_LOW_TO_HIGH

achievement(
    title = "Order Up",
    description = "Get a score of at least 60 in Low To High",
    points = 5,
    id = 554264,
    trigger = low_to_high_completed() && low_to_high_score() >= 60
)

achievement(
    title = "The Big O",
    description = "Get a perfect score of 91 in Low To High",
    points = 3,
    id = 554265,
    trigger = low_to_high_completed() && low_to_high_score() == 91
)

leaderboard(
    title = "Low To High",
    description = "Score the best score in Low To High",
    id = 144050,
    start = low_to_high_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = low_to_high_score(),
    format = "VALUE"
)


SYLLABLE_COUNT_TIME_USED_ADDR = 0x000dda1c
function syllable_count_time_used() => word(SYLLABLE_COUNT_TIME_USED_ADDR)

SYLLABLE_COUNT_CORRECT_QUESTIONS_ADDR = 0x000ed754
function syllable_count_correct_questions() => word(SYLLABLE_COUNT_CORRECT_QUESTIONS_ADDR)

function syllable_count_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_SYLLABLE_COUNT

function syllable_count_score() => (10 - syllable_count_correct_questions()) * 20 * 60 + syllable_count_time_used()

achievement(
    title = "How Man-y Sy-lla-bles Are In This Sen-tence?",
    description = "Get a Rocket Speed time of 60 seconds or less in Syllable Count",
    points = 5,
    id = 554266,
    trigger = syllable_count_completed() && syllable_count_score() <= 60 * 60
)

leaderboard(
    title = "Syllable Count",
    description = "Score the best time in Syllable Count",
    id = 144051,
    start = syllable_count_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = syllable_count_score(),
    format = "FRAMES",
    lower_is_better = true
)


HEAD_COUNT_SCORE_ADDR = 0x000ed86c
function head_count_score() => word(HEAD_COUNT_SCORE_ADDR)

function head_count_completed(head_count_screen) => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == head_count_screen

achievement(
    title = "House Party",
    description = "Get a perfect score of 5 in Head Count Normal",
    points = 3,
    id = 554267,
    trigger = head_count_completed(SCREEN_ID_HEAD_COUNT) && head_count_score() == 5
)

leaderboard(
    title = "Head Count Normal",
    description = "Score the best score in Head Count Normal",
    id = 144052,
    start = head_count_completed(SCREEN_ID_HEAD_COUNT),
    cancel = always_false(),
    submit = always_true(),
    value = head_count_score(),
    format = "VALUE"
)

achievement(
    title = "In Through the Out Door",
    description = "Get a perfect score of 5 in Head Count Hard",
    points = 3,
    id = 554268,
    trigger = head_count_completed(SCREEN_ID_HEAD_COUNT_HARD) && head_count_score() == 5
)

leaderboard(
    title = "Head Count Hard",
    description = "Score the best score in Head Count Hard",
    id = 144053,
    start = head_count_completed(SCREEN_ID_HEAD_COUNT_HARD),
    cancel = always_false(),
    submit = always_true(),
    value = head_count_score(),
    format = "VALUE"
)


TRIANGLE_MATH_TIME_USED_ADDR = 0x000dda1c
function triangle_math_time_used() => word(TRIANGLE_MATH_TIME_USED_ADDR)

TRIANGLE_MATH_CORRECT_QUESTIONS_ADDR = 0x000ed730
function triangle_math_correct_questions() => word(TRIANGLE_MATH_CORRECT_QUESTIONS_ADDR)

function triangle_math_completed(head_count_screen) => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == head_count_screen

function triangle_math_score() => (10 - triangle_math_correct_questions()) * 20 * 60 + triangle_math_time_used()

achievement(
    title = "Pascal Performer",
    description = "Get a Rocket Speed time of 30 seconds or less in Triangle Math Normal",
    points = 5,
    id = 554269,
    trigger = triangle_math_completed(SCREEN_ID_TRIANGLE_MATH) && triangle_math_score() <= 1800
)

leaderboard(
    title = "Triangle Math Normal",
    description = "Score the best time in Triangle Math Normal",
    id = 144054,
    start = triangle_math_completed(SCREEN_ID_TRIANGLE_MATH),
    cancel = always_false(),
    submit = always_true(),
    value = triangle_math_score(),
    format = "FRAMES",
    lower_is_better = true
)

achievement(
    title = "Isoceles Imagination",
    description = "Get a Rocket Speed score of 30 seconds or less in Triangle Math Hard",
    points = 10,
    id = 554270,
    trigger = triangle_math_completed(SCREEN_ID_TRIANGLE_MATH_HARD) && triangle_math_score() <= 1800
)

leaderboard(
    title = "Triangle Math Hard",
    description = "Score the best score in Triangle Math Hard",
    id = 144055,
    start = triangle_math_completed(SCREEN_ID_TRIANGLE_MATH_HARD),
    cancel = always_false(),
    submit = always_true(),
    value = triangle_math_score(),
    format = "FRAMES",
    lower_is_better = true
)


TIME_LAPSE_TIME_USED_ADDR = 0x000dda1c
function time_lapse_time_used() => word(TIME_LAPSE_TIME_USED_ADDR)

TIME_LAPSE_CORRECT_QUESTIONS_ADDR = 0x000ed728
function time_lapse_correct_questions() => word(TIME_LAPSE_CORRECT_QUESTIONS_ADDR)

function time_lapse_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_TIME_LAPSE

function time_lapse_score() => (10 - time_lapse_correct_questions()) * 20 * 60 + time_lapse_time_used()

achievement(
    title = "No Lapses in Judgement",
    description = "Get a Rocket Speed time of 40 seconds or less in Time Lapse",
    points = 5,
    id = 554271,
    trigger = time_lapse_completed() && time_lapse_score() <= 2400
)

leaderboard(
    title = "Time Lapse",
    description = "Score the best time in Time Lapse",
    id = 144056,
    start = time_lapse_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = time_lapse_score(),
    format = "FRAMES",
    lower_is_better = true
)


VOICE_CALCULATION_TIME_USED_ADDR = 0x000dda1c
function voice_calculation_time_used() => word(VOICE_CALCULATION_TIME_USED_ADDR)

function voice_calculation_completed() => screen_id() == SCREEN_ID_RESULTS && prev(screen_id()) == SCREEN_ID_VOICE_CALCULATION

achievement(
    title = "Hear Me Count",
    description = "Get a Rocket Speed time of 55 seconds or less in Voice Calculation",
    points = 5,
    id = 554272,
    trigger = voice_calculation_completed() && voice_calculation_time_used() <= 3300
)

leaderboard(
    title = "Voice Calculation",
    description = "Score the best time in Voice Calculation",
    id = 144057,
    start = voice_calculation_completed(),
    cancel = always_false(),
    submit = always_true(),
    value = voice_calculation_time_used(),
    format = "FRAMES",
    lower_is_better = true
)


achievement(
    title = "Note-table",
    description = "Get asked something you did in the past by Dr. Kawashima",
    points = 1,
    id = 554273,
    trigger = screen_id() == SCREEN_ID_DAILY_TRAINING_MENU && prev(screen_id()) == SCREEN_ID_WRITING_PROMPT
)

achievement(
    title = "Pocket Picasso",
    description = "Try your hand at some art",
    points = 1,
    id = 554274,
    trigger = screen_id() == SCREEN_ID_DAILY_TRAINING_MENU && prev(screen_id()) == SCREEN_ID_PICTURE_DRAWING_RESULTS
)


SUDOKU_DATA_ADDR = 0x000eddf4
SUDOKU_STATUS_NA       = 0x00
SUDOKU_STATUS_LOCKED   = 0x01
SUDOKU_STATUS_UNSOLVED = 0x02
SUDOKU_STATUS_SOLVED   = 0x03
function sudoku_puzzle_status(i) {
    assert(i >= 0 && i < 120, message = "This isn't handling the right number of sudokus!")
    return byte(SUDOKU_DATA_ADDR + 4 * i) & 0x03
}
function previous_sudoku_puzzle_status(i) {
    assert(i >= 0 && i < 120, message = "This isn't handling the right number of sudokus!")
    return prev(byte(SUDOKU_DATA_ADDR + 4 * i)) & 0x03
}

class SudokuAchievementDetails {
    title = "DUMMY TITLE"
    description = "DUMMY DESCRIPTION"
    points = 0
    id = 0
    function trigger(n) {
        last_frame_only_had_three_sudokus_condition = always_false()
        current_frame_sudokus_condition = always_true()
        for i in range(0, 3) {
            iteration_condition = always_true()
            for j in range(0, 3) {
                if (i == j) {
                    iteration_condition = iteration_condition && previous_sudoku_puzzle_status(4 * n + j) != SUDOKU_STATUS_SOLVED
                } else {
                    iteration_condition = iteration_condition && previous_sudoku_puzzle_status(4 * n + j) == SUDOKU_STATUS_SOLVED
                }
            }
            last_frame_only_had_three_sudokus_condition = last_frame_only_had_three_sudokus_condition || iteration_condition
            current_frame_sudokus_condition = current_frame_sudokus_condition && sudoku_puzzle_status(4 * n + i) == SUDOKU_STATUS_SOLVED
        }
        return screen_id() == SCREEN_ID_SUDOKU
            && current_frame_sudokus_condition
            && last_frame_only_had_three_sudokus_condition
    }
}

SUDOKU_ACHIEVEMENTS = [
    SudokuAchievementDetails(
        title = "How to Count",
        description = "Solve the four tutorial puzzles in the Basic section of Sudoku",
        points = 1,
        id = 554275
    ),
    SudokuAchievementDetails(
        title = "The Numbers Game",
        description = "Solve the second row of four puzzles in the first page of the Basic section of Sudoku",
        points = 2,
        id = 554276
    ),
    SudokuAchievementDetails(
        title = "Nine in a Row",
        description = "Solve the third row of four puzzles in the first page of the Basic section of Sudoku",
        points = 2,
        id = 554277
    ),
    SudokuAchievementDetails(
        title = "Nine in a Column",
        description = "Solve the fourth row of four puzzles in the first page of the Basic section of Sudoku",
        points = 2,
        id = 554278
    ),
    SudokuAchievementDetails(
        title = "Nine in a Box",
        description = "Solve the fifth row of four puzzles in the first page of the Basic section of Sudoku",
        points = 2,
        id = 554279
    ),
    SudokuAchievementDetails(
        title = "Grid Guru",
        description = "Solve the first row of four puzzles in the second page of the Basic section of Sudoku",
        points = 2,
        id = 554280
    ),
    SudokuAchievementDetails(
        title = "Number Wizard",
        description = "Solve the second row of four puzzles in the second page of the Basic section of Sudoku",
        points = 2,
        id = 554281
    ),
    SudokuAchievementDetails(
        title = "Digit Decider",
        description = "Solve the third row of four puzzles in the second page of the Basic section of Sudoku",
        points = 2,
        id = 554282
    ),
    SudokuAchievementDetails(
        title = "The Count-meister",
        description = "Solve the fourth row of four puzzles in the second page of the Basic section of Sudoku",
        points = 2,
        id = 554283
    ),
    SudokuAchievementDetails(
        title = "Basically a Big Deal",
        description = "Solve the fifth row of four puzzles in the second page of the Basic section of Sudoku",
        points = 2,
        id = 554284
    ),
    SudokuAchievementDetails(
        title = "A Harder Challenge",
        description = "Solve the four tutorial puzzles in the Intermediate section of Sudoku",
        points = 1,
        id = 554285
    ),
    SudokuAchievementDetails(
        title = "Cell Solver",
        description = "Solve the second row of four puzzles in the first page of the Intermediate section of Sudoku",
        points = 3,
        id = 554286
    ),
    SudokuAchievementDetails(
        title = "Crunching Numbers",
        description = "Solve the third row of four puzzles in the first page of the Intermediate section of Sudoku",
        points = 3,
        id = 554287
    ),
    SudokuAchievementDetails(
        title = "Algorithmic Brilliance",
        description = "Solve the fourth row of four puzzles in the first page of the Intermediate section of Sudoku",
        points = 3,
        id = 554288
    ),
    SudokuAchievementDetails(
        title = "Halfway There!",
        description = "Solve the fifth row of four puzzles in the first page of the Intermediate section of Sudoku",
        points = 3,
        id = 554289
    ),
    SudokuAchievementDetails(
        title = "Grid-locked",
        description = "Solve the first row of four puzzles in the second page of the Intermediate section of Sudoku",
        points = 3,
        id = 554290
    ),
    SudokuAchievementDetails(
        title = "Square Up",
        description = "Solve the second row of four puzzles in the second page of the Intermediate section of Sudoku",
        points = 3,
        id = 554291
    ),
    SudokuAchievementDetails(
        title = "Pen to Paper",
        description = "Solve the third row of four puzzles in the second page of the Intermediate section of Sudoku",
        points = 3,
        id = 554292
    ),
    SudokuAchievementDetails(
        title = "Sudoku Scribe",
        description = "Solve the fourth row of four puzzles in the second page of the Intermediate section of Sudoku",
        points = 3,
        id = 554293
    ),
    SudokuAchievementDetails(
        title = "The Spaces Between",
        description = "Solve the fifth row of four puzzles in the second page of the Intermediate section of Sudoku",
        points = 3,
        id = 554294
    ),
    SudokuAchievementDetails(
        title = "No Puzzle Left Behind",
        description = "Solve the four tutorial puzzles in the Advanced section of Sudoku",
        points = 1,
        id = 554295
    ),
    SudokuAchievementDetails(
        title = "Clue Tracker",
        description = "Solve the second row of four puzzles in the first page of the Advanced section of Sudoku",
        points = 5,
        id = 554296
    ),
    SudokuAchievementDetails(
        title = "Strategy Supreme",
        description = "Solve the third row of four puzzles in the first page of the Advanced section of Sudoku",
        points = 5,
        id = 554297
    ),
    SudokuAchievementDetails(
        title = "Paint by Numbers",
        description = "Solve the fourth row of four puzzles in the first page of the Advanced section of Sudoku",
        points = 5,
        id = 554298
    ),
    SudokuAchievementDetails(
        title = "Numerical Scriptures",
        description = "Solve the fifth row of four puzzles in the first page of the Advanced section of Sudoku",
        points = 5,
        id = 554299
    ),
    SudokuAchievementDetails(
        title = "Square Dancing",
        description = "Solve the first row of four puzzles in the second page of the Advanced section of Sudoku",
        points = 5,
        id = 554300
    ),
    SudokuAchievementDetails(
        title = "Solver of the Squares",
        description = "Solve the second row of four puzzles in the second page of the Advanced section of Sudoku",
        points = 5,
        id = 554301
    ),
    SudokuAchievementDetails(
        title = "Seeing Numbers for Days",
        description = "Solve the third row of four puzzles in the second page of the Advanced section of Sudoku",
        points = 5,
        id = 554302
    ),
    SudokuAchievementDetails(
        title = "What Comes Before Ten?",
        description = "Solve the fourth row of four puzzles in the second page of the Advanced section of Sudoku",
        points = 5,
        id = 554303
    ),
    SudokuAchievementDetails(
        title = "Sudoku Champion",
        description = "Solve the fifth row of four puzzles in the second page of the Advanced section of Sudoku",
        points = 5,
        id = 554304
    ),
]

for i in range(0, 29) {
    sudoku_achievement = SUDOKU_ACHIEVEMENTS[i]
    achievement(
        title = sudoku_achievement.title,
        description = sudoku_achievement.description,
        points = sudoku_achievement.points,
        id = sudoku_achievement.id,
        trigger = sudoku_achievement.trigger(i)
    )
}


SCREEN_ID_TO_RICH_PRESENCE = {
    SCREEN_ID_KAWASHIMA_SIGNATURE_LOGO               : "Looking at Dr. Kawashima's Signature",
    SCREEN_ID_NINTENDO_LOGO_2                        : "Looking at the Nintendo logo",
    SCREEN_ID_MAIN_MENU                              : "Looking at the main menu",
    SCREEN_ID_QUICK_PLAY                             : "Choosing a Quick Play mode",
    SCREEN_ID_DOWNLOAD_MENU                          : "Choosing a Download Play mode",
    SCREEN_ID_DOWNLOAD_LOOKING_FOR_PARTNER_MENU      : "Looking for a Download Play partner",
    SCREEN_ID_GETTING_TOLD_YOUR_BRAIN_AGE            : "Calculating a Brain Age",
    SCREEN_ID_CALCULATIONS_100                       : "Solving Calculations x100",
    SCREEN_ID_CALCULATIONS_20                        : "Solving Calculations x20",
    SCREEN_ID_CALCULATIONS_100_HARD                  : "Solving Calculations x100 (Hard)",
    SCREEN_ID_VOICE_CALCULATION                      : "Solving Voice Calculation",
    SCREEN_ID_DAILY_TRAINING_MENU                    : "Choosing a Daily Training mode",
    SCREEN_ID_PROFILE_SELECT                         : "Choosing a profile",
    SCREEN_ID_STROOP_TEST                            : "Shouting colours in the Stroop Test",
    SCREEN_ID_TRIANGLE_MATH                          : "Solving Triangle Math",
    SCREEN_ID_TRIANGLE_MATH_HARD                     : "Solving Triangle Math (Hard)",
    SCREEN_ID_SPEED_COUNTING                         : "Cycling numbers in Speed Counting",
    SCREEN_ID_CONNECT_MAZE                           : "Connecting the dots in Connect Maze",
    SCREEN_ID_WORD_MEMORY                            : "Memorizing words in Word Memory",
    SCREEN_ID_RESULTS                                : "Seeing the results of a minigame",
    SCREEN_ID_SYLLABLE_COUNT                         : "Count-ing sy-la-bles in Syllable Count",
    SCREEN_ID_LOW_TO_HIGH                            : "Memorizing numbers in Low To High",
    SCREEN_ID_GRAPH_2_MONTH_VIEW                     : "Checking out some 2 month view graphs",
    SCREEN_ID_PLACING_A_STAMP                        : "Placing today's stamp",
    SCREEN_ID_NUMBER_CRUNCHER                        : "Counting digits in Number Cruncher",
    SCREEN_ID_GRAPH_TRAINING_MENU                    : "Checking out some graphs",
    SCREEN_ID_PICTURE_DRAWING                        : "Drawing some art",
    SCREEN_ID_PICTURE_DRAWING_RESULTS                : "Appreciating some art",
    SCREEN_ID_NEW_DATA_PROMPTS                       : "Making a new profile",
    SCREEN_ID_HANDEDNESS_PROMPT                      : "Choosing which hand to use",
    SCREEN_ID_NAME_PROMPT                            : "Signing a name",
    SCREEN_ID_NAME_RETURN_PROMPT                     : "Confirming a signature",
    SCREEN_ID_AGE_YEAR_PROMPT                        : "Inputting a birth year",
    SCREEN_ID_AGE_YEAR_RETURN_PROMPT                 : "Confirming a birth year",
    SCREEN_ID_AGE_MONTH_PROMPT                       : "Inputting a birth month",
    SCREEN_ID_AGE_DAY_PROMPT                         : "Inputting a birth day",
    SCREEN_ID_DETAILS_CONFIRM_PROMPT                 : "Confirming birthday details",
    SCREEN_ID_INSTRUCTIONS                           : "Learning how to play a minigame",
    SCREEN_ID_DIFFICULTY_SELECTION_PROMPT            : "Choosing whether to play on Normal or Hard",
    SCREEN_ID_COUNTDOWN                              : "Counting into a minigame",
    SCREEN_ID_TIME_LAPSE                             : "Passing time in Time Lapse",
    SCREEN_ID_WRITING_PROMPT                         : "Answering a question",
    SCREEN_ID_STAMP_DESIGN                           : "Drawing a new stamp design",
    SCREEN_ID_HEAD_COUNT                             : "Counting heads in Head Count",
    SCREEN_ID_HEAD_COUNT_HARD                        : "Counting heads in Head Count (Hard)",
    SCREEN_ID_OTHER_OPTIONS_MENU                     : "Checking out some other options",
    SCREEN_ID_OTHER_OPTIONS_SETTINGS                 : "Checking out the settings menu in the other options",
    SCREEN_ID_TIPS                                   : "Reading a tip",
    SCREEN_ID_CHANGE_HANDEDNESS                      : "Changing handedness",
    SCREEN_ID_FONT_SIZE                              : "Changing the font size",
    SCREEN_ID_CHANGE_SIGNATURE                       : "Changing a signature",
    SCREEN_ID_GRAPH_VIEW_AFTER_MINIGAME              : "Seeing the graph results after a minigame",
    SCREEN_ID_UNLOCKING_SOMETHING                    : "Unlocking something new",
    SCREEN_ID_BRAIN_LECTURE                          : "Understanding how the brain works",
    SCREEN_ID_DELETING_PROFILE                       : "Deleting a profile",
    SCREEN_ID_FIRST_BRAIN_AGE_SPEAK_PROMPT           : "Choosing whether to speak in the first test",
    SCREEN_ID_FIRST_BRAIN_AGE_RETURNING_SPEAK_PROMPT : "Choosing whether to speak in the first test",
    SCREEN_ID_FIRST_BRAIN_AGE_FINISHING_LECTURE      : "Finishing the first Brain Age Check",
    SCREEN_ID_CAN_YOU_SPEAK_OUT_LOUD_PROMPT          : "Choosing whether to speak out loud",
    SCREEN_ID_PROFILE_GREETING                       : "Greetings!",
    SCREEN_ID_QUICK_PLAY_POST_RESULTS                : "Finishing a Quick Play game",
    SCREEN_ID_REPEAT_MINIGAME_PROMPT                 : "Choosing to replay a minigame today",
    SCREEN_ID_READING_TOO_FAST                       : "Speed reading today's book",
    SCREEN_ID_READING_ALOUD                          : "Reading to one's self in Reading Aloud",
    SCREEN_ID_CREDITS                                : "Seeing the credits",
    SCREEN_ID_TOP_3_LIST_RESULTS                     : "Checking out the results in a Top 3 List",
    SCREEN_ID_TOP_3_LIST                             : "Checking out the Top 3 Lists",
    SCREEN_ID_NINTENDO_LOGO                          : "Looking at the Nintendo logo",
    SCREEN_ID_LANGUAGE_SELECT                        : "Choosing a language",
    SCREEN_ID_SUDOKU                                 : "Playing a Sudoku",
    SCREEN_ID_QUICK_PLAY_SUDOKU                      : "Playing a Quick Play Sudoku",
    SCREEN_ID_SUDOKU_DIFFICULTY_MENU                 : "Choosing which difficulty of Sudoku to play",
    SCREEN_ID_SUDOKU_PUZZLE_SELECT                   : "Choosing a Sudoku puzzle",
    SCREEN_ID_SUDOKU_CHEAT_MODE_PROMPT               : "Choosing whether to play a Sudoku with Cheat Mode",
    SCREEN_ID_SUDOKU_HOW_TO_PLAY                     : "Learning how to play Sudoku"
}

rich_presence_display(
    "{0}",
    rich_presence_lookup("Screen", screen_id(), SCREEN_ID_TO_RICH_PRESENCE, fallback = "Brain training with Dr. Kawashima")
)