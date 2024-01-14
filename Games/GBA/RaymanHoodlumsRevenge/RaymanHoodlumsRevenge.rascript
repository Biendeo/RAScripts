// Rayman: Hoodlums' Revenge
// #ID = 9367
// md5: 7b06540616a35ca1cf4465f1fabe50b6

// == CODE NOTES ==

// $004ab8: Input (2 bytes)
//          Each bit is 1 while unpressed and 0 while pressed
//          0 - A
//          1 - B
//          2 - Select
//          3 - Start
//          4 - Right
//          5 - Left
//          6 - Up
//          7 - Down
//          8 - R
//          9 - L
function input() => word(0x004AB8)

// $005a68: Input Increment (2 bytes)
//          Goes up by 1 for most actions (Rayman jumping/landing/locking on), also goes up in menus.
function input_increment() => word(0x005A68)

// $007ff8: Is In Level Transition (1 byte)
//          0x01 when the screen is completely black when transitioning screens, 0x00 when not.
function is_in_level_transition() => byte(0x007FF8)

// $008184: End Level Behavior Function Pointer (4 bytes)
//          0x0802c5ed when the level is completed and transitioning
//          0x0802c631 when finishing the final boss fight
//          0x0802c5dd when game over
//          0x0802c549, 0802c58d and 0x0802c539 in the US ROM
//          0x00000000 otherwise
//          This is probably a pointer to some function.
function end_level_behavior_function_pointer() => dword(0x008184)

// $008720: Screen Detector (4 bytes)
//          0x08030119 when in map screen
//          0x08025b9d when in game over screen
//          0x08030075 and 0x08025af9 in US version
//          Varies between levels
function screen_detector() => dword(0x008720)

// $008CC8: Language (4 bytes)
//          0x00 - English
//          0x01 - French
//          0x02 - German
//          0x03 - Spanish
//          0x04 - Italian
//          0x05 - Dutch
function language() => word(0x008CC8)

// $00a170: Current Level (1 byte)
//          0x00 - Fairy Council
//          0x01 - Clearleaf Forest
//          0x02 - Clearleaf Falls
//          0x03 - Infernal Machine
//          0x04 - Dungeon of Murk
//          0x05 - Bog of Murk
//          0x06 - Begoniax Bayou
//          0x07 - Rivers of Murk
//          0x08 - Hoodlum Moor
//          0x09 - Land of the Livid Dead
//          0x0a - Menhirs of Power
//          0x0b - Pit of Endless Fire
//          0x0c - Clouds of Peril
//          0x0d - Heart of the World
//          0x0e - Reflux's Lair
//          0x0f - Vertiginous Riddle
//          0x10 - Cloudy Cache
//          0x11 - Melee Mayhem
//          0x12 - Scalding Cascade
//          0x13 - Sulphurous Sea
function level() => byte(0x00A170)

// $00aa10: Current Save Slot Name (8 bytes)
//          ASCII string of profile (not zero terminated)
function current_save_slot_name() => byte(0x00AA10)

// $00aa1c: Current Save Slot Pointer (4 bytes)
function current_save_slot_pointer() => byte(0x00AA1C)

// $00aa23: Credits Unlocked (1 byte)
//          This is used in the battery save and not directly read otherwise
function credits_unlocked() => byte(0x00AA23)

// $00aa24: Language Saved (1 byte)
//          This is used in the battery save and not directly read otherwise
function language_saved() => byte(0x00AA24)

// $00aa88: Profile Save Data Array (400 bytes)
//          This array contains all the data relating to each save file. There are 4 objects, each of size 0x64 (offset by 0x64 for each of the saves).
//          Structure:
//            0x00-0x02 - Not sure
//            0x03-0x06 - Score
//            0x07-0x08 - Lums
//            0x09-0x0a - Teensies
//            0x0b - Unused
//            0x0c-0x13 - Profile name (8 characters ASCII, not zero-terminated)
//            0x14-0x63 - Array of level save data (4 byte structures, 20 array size)
//          Level data structure:
//            0x00 - Score (2 bytes, unsigned short)
//            0x02 - Lums (1 byte, unsigned byte)
//            0x03 - Extra (1 byte, bit 0 is true if the level is unlocked, bit 1 is true if the level is completed, bits 5-7 represent how many Teensies were acquired, unsigned)
//          If you want to be lazy, setting everything from 0x00aa9c to 0x00aaeb as 0xff will unlock every level and max out the score to unrealistic levels for profile 1.
function profile_save_data_array() => byte(0x00AA88)

// $00ac18: Currently Selected Save Slot (1 byte)
//          0x00 to 0x03
function currently_selected_save_slot() => byte(0x00AC18)

// $00b0b8: Current Combo (4 bytes)
//          0x00 to 0x03
function current_combo() => dword(0x00B0B8)

// $00b0bc: Current Score (4 bytes)
function current_score() => dword(0x00B0BC)

// $00b0c0: Total Teensies In Level (4 bytes)
function total_teensies_in_level() => dword(0x00B0C0)

// $00b0c4: Total Lums In Level (4 bytes)
function total_lums_in_level() => dword(0x00B0C4)

// $00b0c8: Teensies Remaining (4 bytes)
function teensies_remaining() => dword(0x00B0C8)

// $00b0cc: Lums Remaining (4 bytes)
function lums_remaining() => dword(0x00B0CC)

// $00b0d0: Combo Presentation (4 bytes)
function combo_presentation() => dword(0x00B0D0)

// $00b0d4: Score Presentation (4 bytes)
//          The current numerical value used by the on-screen score, is not the actual value.
function score_presentation() => dword(0x00B0D4)

// $00b0e6: Combo Frames Remaining (1 byte)
//          Sets to 0x78 when score is gotten, reduces by 1 per frame, score is committed when value is 0x00.
function combo_frames_remaining() => byte(0x00B0E6)

// $00b0e7: Combo Frames Remaining Initial (1 byte)
//          Sets to 0x5f on the first bit of combo (when showing the word "combo"), flickers visible on even frames.
function combo_frames_remaining_initial() => byte(0x00B0E7)

// $00b0e8: Is Player In Control (1 byte)
//          0x00 if in menu or cutscene
//          0x01 if in control
function is_player_in_control() => byte(0x00B0E8)

// $00b0ed: Player Character (1 byte)
//          0x00 - Rayman
//          0x01 - Globox
function player_character() => byte(0x00B0ED)

// $00b0fc: Powerup (4 bytes)
//          0x00 - No powerup
//          0x06 - Throttle Copter
//          0x12 - Fire Protection
//          0x1d - Heavy Metal Fist
//          0x34 - Frog
function powerup() => byte(0x00B0FC)

// $00c92a: Reflux Barrel Left State (1 byte)
//          0x00 - Sitting there
//          0x03 - Destroyed or mid-drink
function reflux_barrel_left_state() => byte(0x00C92A)

// $00c972: Reflux Barrel Top State (1 byte)
//          0x00 - Sitting there
//          0x03 - Destroyed or mid-drink
function reflux_barrel_top_state() => byte(0x00C972)

// $00c9ba: Reflux Barrel Right State (1 byte)
//          0x00 - Sitting there
//          0x03 - Destroyed or mid-drink
function reflux_barrel_right_state() => byte(0x00C9BA)

// $0142d1: Begoniax Frog State (1 byte)
//          0x02 - Alive
//          0x04 - Frog
function begoniax_frog_state() => byte(0x0142D1)

// $02ce88: X Position (4 bytes)
//          Up-left is negative, down-right is positive.
function x_position() => dword(0x02CE88)

// $02ce8c: Y Position (4 bytes)
//          Up-right is negative, down-left is positive.
function y_position() => dword(0x02CE8C)

// $02ce90: Z Position (4 bytes)
//          Most platforms are multiples of 0x1000.
//          Rayman has a jump height of 0x1ef0.
function z_position() => dword(0x02CE90)

// $047d48: Status Flag (4 bytes)
//          0x00000000 - In menus or game over screen
//          0x0000003d - In most levels
//          0x0003fffd - Paused in most levels
//          0x00000f7d - In boss fights
//          0x00ffff7d - Paused in boss fights
function status_flag() => dword(0x047D48)

// $047d60: Player Health (4 bytes)
//          0x00 to 0x63 (max health)
//          Presentation is only updated when health changes (either picking up a lum or taking damage).
function player_health() => dword(0x047D60)

// $047d64: Max Health (4 bytes)
//          Always 0x64, changing this changes how far right the presentation bar goes
function max_health() => dword(0x047D64)

// $047d78: Boss Health (4 bytes)
//          0x00 to 0x63 (max health)
function boss_health() => dword(0x047D78)

// $047d7c: Boss Max Health (4 bytes)
//          Usually 0x64
function boss_max_health() => dword(0x047D7C)

// == CONSTANTS ==

POWERUP_NONE             = 0x00
POWERUP_THROTTLE_COPTER  = 0x06
POWERUP_FIRE_PROTECTION  = 0x12
POWERUP_HEAVY_METAL_FIST = 0x1D
POWERUP_FROG             = 0x34

// The order here is not the actual playing order!
LEVEL_FAIRY_COUNCIL          = 0x00
LEVEL_CLEARLEAF_FOREST       = 0x01
LEVEL_CLEARLEAF_FALLS        = 0x02
LEVEL_INFERNAL_MACHINE       = 0x03
LEVEL_DUNGEON_OF_MURK        = 0x04
LEVEL_BOG_OF_MURK            = 0x05
LEVEL_BEGONIAX_BAYOU         = 0x06
LEVEL_RIVERS_OF_MURK         = 0x07
LEVEL_HOODLUM_MOOR           = 0x08
LEVEL_LAND_OF_THE_LIVID_DEAD = 0x09
LEVEL_MENHIRS_OF_POWER       = 0x0A
LEVEL_PIT_OF_ENDLESS_FIRE    = 0x0B
LEVEL_CLOUDS_OF_PERIL        = 0x0C
LEVEL_HEART_OF_THE_WORLD     = 0x0D
LEVEL_REFLUXS_LAIR           = 0x0E
LEVEL_VERTIGINOUS_RIDDLE     = 0x0F
LEVEL_CLOUDY_CACHE           = 0x10
LEVEL_MELEE_MAYHEM           = 0x11
LEVEL_SCALDING_CASCADE       = 0x12
LEVEL_SULPHUROUS_SEA         = 0x13

// The order here is playing order!
LEVEL_TO_NAME = {
    LEVEL_FAIRY_COUNCIL          : "Fairy Council",
    LEVEL_CLEARLEAF_FOREST       : "Clearleaf Forest",
    LEVEL_CLEARLEAF_FALLS        : "Clearleaf Falls",
    LEVEL_INFERNAL_MACHINE       : "Infernal Machine",
    LEVEL_VERTIGINOUS_RIDDLE     : "Vertiginous Riddle",
    LEVEL_DUNGEON_OF_MURK        : "Dungeon of Murk",
    LEVEL_RIVERS_OF_MURK         : "Rivers of Murk",
    LEVEL_BOG_OF_MURK            : "Bog of Murk",
    LEVEL_BEGONIAX_BAYOU         : "Begoniax Bayou",
    LEVEL_HOODLUM_MOOR           : "Hoodlum Moor",
    LEVEL_LAND_OF_THE_LIVID_DEAD : "Land of the Livid Dead",
    LEVEL_SULPHUROUS_SEA         : "Sulphurous Sea",
    LEVEL_MENHIRS_OF_POWER       : "Menhirs of Power",
    LEVEL_PIT_OF_ENDLESS_FIRE    : "Pit of Endless Fire",
    LEVEL_CLOUDS_OF_PERIL        : "Clouds of Peril",
    LEVEL_CLOUDY_CACHE           : "Cloudy Cache",
    LEVEL_HEART_OF_THE_WORLD     : "Heart of the World",
    LEVEL_SCALDING_CASCADE       : "Scalding Cascade",
    LEVEL_MELEE_MAYHEM           : "Mélée Mayhem",
    LEVEL_REFLUXS_LAIR           : "Reflux's Lair"
}

// Levels with no stamps are ommitted
LEVEL_TO_THREE_STAMP_SCORE = {
    LEVEL_FAIRY_COUNCIL          : 8000,
    LEVEL_CLEARLEAF_FOREST       : 14000,
    LEVEL_CLEARLEAF_FALLS        : 19000,
    LEVEL_VERTIGINOUS_RIDDLE     : 28000,
    LEVEL_DUNGEON_OF_MURK        : 16000,
    LEVEL_RIVERS_OF_MURK         : 21000,
    LEVEL_BOG_OF_MURK            : 26000,
    LEVEL_HOODLUM_MOOR           : 30000,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 23000,
    LEVEL_SULPHUROUS_SEA         : 22000,
    LEVEL_MENHIRS_OF_POWER       : 42000,
    LEVEL_CLOUDS_OF_PERIL        : 42000,
    LEVEL_CLOUDY_CACHE           : 28000,
    LEVEL_HEART_OF_THE_WORLD     : 33000,
    LEVEL_SCALDING_CASCADE       : 28000,
    LEVEL_MELEE_MAYHEM           : 26000
}

LEVEL_TO_SCORE_ACHIEVEMENT_ID = {
    LEVEL_FAIRY_COUNCIL          : 389149,
    LEVEL_CLEARLEAF_FOREST       : 389150,
    LEVEL_CLEARLEAF_FALLS        : 389151,
    LEVEL_VERTIGINOUS_RIDDLE     : 389160,
    LEVEL_DUNGEON_OF_MURK        : 389152,
    LEVEL_RIVERS_OF_MURK         : 389154,
    LEVEL_BOG_OF_MURK            : 389153,
    LEVEL_HOODLUM_MOOR           : 389155,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 389156,
    LEVEL_SULPHUROUS_SEA         : 389164,
    LEVEL_MENHIRS_OF_POWER       : 389157,
    LEVEL_CLOUDS_OF_PERIL        : 389158,
    LEVEL_CLOUDY_CACHE           : 389161,
    LEVEL_HEART_OF_THE_WORLD     : 389159,
    LEVEL_SCALDING_CASCADE       : 389163,
    LEVEL_MELEE_MAYHEM           : 389162
}

// Levels that don't need achievements are ommitted (i.e. boss levels)
LEVEL_TO_LUM_COUNT = {
    LEVEL_FAIRY_COUNCIL          : 48,
    LEVEL_CLEARLEAF_FOREST       : 69,
    LEVEL_CLEARLEAF_FALLS        : 99,
    LEVEL_VERTIGINOUS_RIDDLE     : 82,
    LEVEL_DUNGEON_OF_MURK        : 75,
    LEVEL_RIVERS_OF_MURK         : 58,
    LEVEL_BOG_OF_MURK            : 76,
    LEVEL_HOODLUM_MOOR           : 96,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 85,
    LEVEL_SULPHUROUS_SEA         : 63,
    LEVEL_MENHIRS_OF_POWER       : 98,
    LEVEL_CLOUDS_OF_PERIL        : 87,
    LEVEL_CLOUDY_CACHE           : 99,
    LEVEL_HEART_OF_THE_WORLD     : 90,
    LEVEL_SCALDING_CASCADE       : 53,
    LEVEL_MELEE_MAYHEM           : 92
}

LEVEL_TO_LUM_ACHIEVEMENT_ID = {
    LEVEL_FAIRY_COUNCIL          : 389165,
    LEVEL_CLEARLEAF_FOREST       : 389166,
    LEVEL_CLEARLEAF_FALLS        : 389167,
    LEVEL_VERTIGINOUS_RIDDLE     : 389176,
    LEVEL_DUNGEON_OF_MURK        : 389169,
    LEVEL_RIVERS_OF_MURK         : 389170,
    LEVEL_BOG_OF_MURK            : 389169,
    LEVEL_HOODLUM_MOOR           : 389171,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 389172,
    LEVEL_SULPHUROUS_SEA         : 389180,
    LEVEL_MENHIRS_OF_POWER       : 389173,
    LEVEL_CLOUDS_OF_PERIL        : 389174,
    LEVEL_CLOUDY_CACHE           : 389177,
    LEVEL_HEART_OF_THE_WORLD     : 389175,
    LEVEL_SCALDING_CASCADE       : 389179,
    LEVEL_MELEE_MAYHEM           : 389178
}

// Levels that don't need achievements are ommitted (i.e. no teensies)
LEVEL_TO_TEENSIE_COUNT = {
    LEVEL_FAIRY_COUNCIL          : 4,
    LEVEL_CLEARLEAF_FOREST       : 4,
    LEVEL_CLEARLEAF_FALLS        : 4,
    LEVEL_RIVERS_OF_MURK         : 4,
    LEVEL_HOODLUM_MOOR           : 4,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 4,
    LEVEL_MENHIRS_OF_POWER       : 4,
    LEVEL_CLOUDS_OF_PERIL        : 4,
    LEVEL_HEART_OF_THE_WORLD     : 4
}

LEVEL_TO_TEENSIE_ACHIEVEMENT_ID = {
    LEVEL_FAIRY_COUNCIL          : 389181,
    LEVEL_CLEARLEAF_FOREST       : 389182,
    LEVEL_CLEARLEAF_FALLS        : 389183,
    LEVEL_RIVERS_OF_MURK         : 389184,
    LEVEL_HOODLUM_MOOR           : 389185,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 389186,
    LEVEL_MENHIRS_OF_POWER       : 389187,
    LEVEL_CLOUDS_OF_PERIL        : 389188,
    LEVEL_HEART_OF_THE_WORLD     : 389189
}

// All levels have one achievement, time is in frames
LEVEL_TO_ACHIEVEMENT_TIMES = {
    LEVEL_FAIRY_COUNCIL          : 3600,
    LEVEL_CLEARLEAF_FOREST       : 7200,
    LEVEL_CLEARLEAF_FALLS        : 6600,
    LEVEL_INFERNAL_MACHINE       : 3060,
    LEVEL_VERTIGINOUS_RIDDLE     : 1800,
    LEVEL_DUNGEON_OF_MURK        : 13500,
    LEVEL_RIVERS_OF_MURK         : 10500,
    LEVEL_BOG_OF_MURK            : 15600,
    LEVEL_BEGONIAX_BAYOU         : 5400,
    LEVEL_HOODLUM_MOOR           : 14400,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 10800,
    LEVEL_SULPHUROUS_SEA         : 8400,
    LEVEL_MENHIRS_OF_POWER       : 25200,
    LEVEL_PIT_OF_ENDLESS_FIRE    : 1200,
    LEVEL_CLOUDS_OF_PERIL        : 8700,
    LEVEL_CLOUDY_CACHE           : 7800,
    LEVEL_HEART_OF_THE_WORLD     : 12600,
    LEVEL_SCALDING_CASCADE       : 8400,
    LEVEL_MELEE_MAYHEM           : 14400,
    LEVEL_REFLUXS_LAIR           : 2400
}

LEVEL_TO_TIME_ACHIEVEMENT_ID = {
    LEVEL_FAIRY_COUNCIL          : 389190,
    LEVEL_CLEARLEAF_FOREST       : 389191,
    LEVEL_CLEARLEAF_FALLS        : 389192,
    LEVEL_INFERNAL_MACHINE       : 389193,
    LEVEL_VERTIGINOUS_RIDDLE     : 389205,
    LEVEL_DUNGEON_OF_MURK        : 389194,
    LEVEL_RIVERS_OF_MURK         : 389197,
    LEVEL_BOG_OF_MURK            : 389195,
    LEVEL_BEGONIAX_BAYOU         : 389196,
    LEVEL_HOODLUM_MOOR           : 389198,
    LEVEL_LAND_OF_THE_LIVID_DEAD : 389199,
    LEVEL_SULPHUROUS_SEA         : 389209,
    LEVEL_MENHIRS_OF_POWER       : 389200,
    LEVEL_PIT_OF_ENDLESS_FIRE    : 389201,
    LEVEL_CLOUDS_OF_PERIL        : 389202,
    LEVEL_CLOUDY_CACHE           : 389206,
    LEVEL_HEART_OF_THE_WORLD     : 389203,
    LEVEL_SCALDING_CASCADE       : 389208,
    LEVEL_MELEE_MAYHEM           : 389207,
    LEVEL_REFLUXS_LAIR           : 389204
}

CHARACTER_RAYMAN = 0x00
CHARACTER_GLOBOX = 0x01

CHARACTER_TO_NAME = {
    CHARACTER_RAYMAN: "Rayman",
    CHARACTER_GLOBOX: "Globox"
}

// == FUNCTIONS ==

function did_level_just_complete(level_id) {
    return did_level_complete_signal_trigger(level_id)
        && is_in_level(level_id)
        && once(is_player_in_control() == 0x01)
        && never(is_in_map_screen())
}

function did_level_complete_signal_trigger(level_id) {
    if (level_id == LEVEL_REFLUXS_LAIR) {
        return prev(end_level_behavior_function_pointer()) == 0x00000000 && (end_level_behavior_function_pointer() == 0x0802c631 || end_level_behavior_function_pointer() == 0x0802c58d)
    } else {
        return prev(end_level_behavior_function_pointer()) == 0x00000000 && (end_level_behavior_function_pointer() == 0x0802c5ed || end_level_behavior_function_pointer() == 0x0802c549)
    }
}

function is_in_level(level_id) {
    return level() == level_id
}

function is_in_map_screen() {
    return screen_detector() == 0x08030119 || screen_detector() == 0x08030075
}

function is_in_game_over() {
    return screen_detector() == 0x08025b9d || screen_detector() == 0x08025af9
//     return end_level_behavior_function_pointer() == 0x0802c5dd || end_level_behavior_function_pointer() == 0x0802c539
}

// == ACHIEVEMENTS ==

// === MISC ACHIEVEMENTS ===

achievement(
    title = "Rolling with the Punches", points = 10, id = 389210,
    description = "Make Murfy proud and achieve a combo of at least 5000 points",
    trigger = current_combo() >= 5000 && is_player_in_control() == 0x01
)

// === BOSS PROGRESSION ACHIEVEMENTS ===
// There's four bosses evenly through the game, these are your easy progression achievements.

achievement(
    title = "Decommissioned Machinery", points = 5, id = 389141,
    description = "Deprive the world of plum juice production by turning off the Infernal Machine",
    trigger = did_level_just_complete(LEVEL_INFERNAL_MACHINE)
)

achievement(
    title = "Controlled Demolition", points = 5, id = 389142,
    description = "Destroy the Infernal Machine while picking up the Heavy Metal Fist powerup at most 2 times",
    trigger = did_level_just_complete(LEVEL_INFERNAL_MACHINE)
        && disable_when(repeated(3, prev(powerup()) == POWERUP_NONE && powerup() == POWERUP_HEAVY_METAL_FIST), is_in_game_over() || is_in_map_screen())
)

achievement(
    title = "Ding Dong the Witch Is Dead", points = 5, id = 389143,
    description = "Refuse to be her Prince Charming and defeat Begoniax",
    trigger = did_level_just_complete(LEVEL_BEGONIAX_BAYOU)
)

achievement(
    title = "Frog Allergy", points = 5, id = 389144,
    description = "Defeat Begoniax with her only turning into a frog at most 2 times",
    trigger = did_level_just_complete(LEVEL_BEGONIAX_BAYOU)
        && disable_when(repeated(3, prev(begoniax_frog_state()) == 0x02 && begoniax_frog_state() == 0x04), is_in_game_over() || is_in_map_screen())
)

achievement(
    title = "Knaaren or Knever", points = 5, id = 389145,
    description = "End the levels of Endless Fire by ending the endable Firemonster",
    trigger = did_level_just_complete(LEVEL_PIT_OF_ENDLESS_FIRE)
)

achievement(
    title = "Achoooo!", points = 5, id = 389146,
    description = "Defeat the Firemonster by grabbing the Fire Protection powerup only once, hitting him twice, and never switching to Globox",
    trigger = did_level_just_complete(LEVEL_PIT_OF_ENDLESS_FIRE)
        && disable_when(
            repeated(2, prev(powerup()) == POWERUP_NONE && powerup() == POWERUP_FIRE_PROTECTION)
                || repeated(3, prev(boss_health()) > boss_health())
                || player_character() == CHARACTER_GLOBOX,
            is_in_game_over() || is_in_map_screen())
)

achievement(
    title = "Acid Reflux", points = 25, id = 389147,
    description = "Stop the plum juice guzzling Reflux and save the day",
    trigger = did_level_just_complete(LEVEL_REFLUXS_LAIR)
)

// For this achievement I also wanted to make it so the player beat Reflux he picks up any barrels, but that's really difficult and not even the TAS does that.
achievement(
    title = "Plum Preservation", points = 5, id = 389148,
    description = "Defeat Reflux by grabbing the Heavy Metal Fist powerup at most 2 times",
    trigger = did_level_just_complete(LEVEL_REFLUXS_LAIR)
        && disable_when(
            repeated(3, prev(powerup()) == POWERUP_NONE && powerup() == POWERUP_HEAVY_METAL_FIST),
            is_in_game_over() || is_in_map_screen())
)

// === LEVEL ACHIEVEMENTS ===

for level_id in LEVEL_TO_THREE_STAMP_SCORE {
    level_name = LEVEL_TO_NAME[level_id]
    score_target = LEVEL_TO_THREE_STAMP_SCORE[level_id]
    achievement_id = LEVEL_TO_SCORE_ACHIEVEMENT_ID[level_id]
    achievement(
        title = format("Three Stamps in {0}", level_name), points = 10, id = achievement_id,
        description = format("Get three stamps in {0} by achieving a score of {1}", level_name, score_target),
        trigger = did_level_just_complete(level_id) && (current_score() + current_combo()) >= score_target
    )
}

for level_id in LEVEL_TO_LUM_COUNT {
    level_name = LEVEL_TO_NAME[level_id]
    lum_count = LEVEL_TO_LUM_COUNT[level_id]
    achievement_id = LEVEL_TO_LUM_ACHIEVEMENT_ID[level_id]
    achievement(
        title = format("Lums in {0}", level_name), points = 5, id = achievement_id,
        description = format("Finish {0} after collecting all {1} lums", level_name, lum_count),
        trigger = did_level_just_complete(level_id) && lums_remaining() == 0
    )
}

for level_id in LEVEL_TO_TEENSIE_COUNT {
    level_name = LEVEL_TO_NAME[level_id]
    teensie_count = LEVEL_TO_TEENSIE_COUNT[level_id]
    achievement_id = LEVEL_TO_TEENSIE_ACHIEVEMENT_ID[level_id]
    achievement(
        title = format("Teensies in {0}", level_name), points = 5, id = achievement_id,
        description = format("Finish {0} after rescuing all {1} Teensies", level_name, teensie_count),
        trigger = did_level_just_complete(level_id) && teensies_remaining() == 0
    )
}

for level_id in LEVEL_TO_ACHIEVEMENT_TIMES {
    level_name = LEVEL_TO_NAME[level_id]
    achievement_time = LEVEL_TO_ACHIEVEMENT_TIMES[level_id]
    seconds = achievement_time / 60
    achievement_id = LEVEL_TO_TIME_ACHIEVEMENT_ID[level_id]
    achievement(
        title = format("Quick Finish in {0}", level_name), points = 10, id = achievement_id,
        description = format("Finish {0} within {1} seconds", level_name, seconds),
        trigger = disable_when(repeated(achievement_time, is_player_in_control() == 0x01), !is_in_level(level_id) || is_in_map_screen())
            && is_in_level(level_id)
            && once(is_player_in_control() == 0x01)
            && never(is_in_map_screen())
            && trigger_when(did_level_complete_signal_trigger(level_id))
    )
}

// == LEADERBOARDS ==

for level_id in LEVEL_TO_THREE_STAMP_SCORE {
    level_name = LEVEL_TO_NAME[level_id]
    score_target = LEVEL_TO_THREE_STAMP_SCORE[level_id]
    leaderboard(
        title = format("{0} - Highest Score", level_name),
        description = format("Highest score when finishing {0}", level_name),
        start  = is_in_level(level_id) && is_player_in_control() == 0x01,
        cancel = !is_in_level(level_id) || is_in_map_screen(),
        submit = did_level_complete_signal_trigger(level_id),
        value = current_score() + current_combo(),
        format = "VALUE"
    )
}

for level_id in LEVEL_TO_ACHIEVEMENT_TIMES {
    level_name = LEVEL_TO_NAME[level_id]
    achievement_time = LEVEL_TO_ACHIEVEMENT_TIMES[level_id]
    seconds = achievement_time / 60
    leaderboard(
        title = format("{0} - Fastest Finish", level_name),
        description = format("Fastest time to finish {0}", level_name),
        start  = is_in_level(level_id) && is_player_in_control() == 0x01,
        cancel = !is_in_level(level_id) || is_in_map_screen(),
        submit = did_level_complete_signal_trigger(level_id),
        value = measured(tally(0, is_player_in_control() == 0x01)),
        format = "FRAMES", lower_is_better = true
    )
}

// == RICH PRESENCE ==

rich_presence_conditional_display(is_in_map_screen(), "Looking at the map screen")
rich_presence_conditional_display(is_in_game_over(), "Looking at the game over screen")
rich_presence_conditional_display(status_flag() == 0x00000000, "Looking at a menu")
rich_presence_conditional_display(player_character() == CHARACTER_RAYMAN, "Rayman in {0} 💖: {1}% 🧝: {2}/{3} 🟡: {4}/{5} 🔢: {6}",
    rich_presence_lookup("Level", level(), LEVEL_TO_NAME),
    rich_presence_value("VALUE", player_health() + 1),
    rich_presence_value("VALUE", total_teensies_in_level() - teensies_remaining()),
    rich_presence_value("VALUE", total_teensies_in_level()),
    rich_presence_value("VALUE", total_lums_in_level() - lums_remaining()),
    rich_presence_value("VALUE", total_lums_in_level()),
    rich_presence_value("VALUE", current_score())
)
rich_presence_conditional_display(player_character() == CHARACTER_GLOBOX, "Globox in {0} 🧝: {1}/{2} 🟡: {3}/{4} 🔢: {5}",
    rich_presence_lookup("Level", level(), LEVEL_TO_NAME),
    rich_presence_value("VALUE", total_teensies_in_level() - teensies_remaining()),
    rich_presence_value("VALUE", total_teensies_in_level()),
    rich_presence_value("VALUE", total_lums_in_level() - lums_remaining()),
    rich_presence_value("VALUE", total_lums_in_level()),
    rich_presence_value("VALUE", current_score())
)
rich_presence_display("Playing Rayman Hoodlums' Revenge")