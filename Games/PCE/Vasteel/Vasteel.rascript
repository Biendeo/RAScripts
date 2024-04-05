// Vastee
// #ID = 12888
// md5: f4e63bd19d179d54a1d4417781a1aacf

// == RICH PRESENCE ==

// Turns numbers like 0x46 into 46. Used for the turn number.
function denormalize_digit_word(x) {
    n0 = x % 10
    n1 = (x / 10) % 10
    n2 = (x / 100) % 10
    n3 = (x / 1000) % 10
    return n0 + (n1 * 16) + (n2 * 256) * (n3 * 4096)
}
function normalize_digit_word(x) {
    n0 = x % 16
    n1 = (x / 16) % 16
    n2 = (x / 256) % 16
    n3 = (x / 4096) % 16
    return n0 + (n1 * 10) + (n2 * 100) * (n3 * 1000)
}
NORMALIZED_DIGIT_WORDS = {}
for x in range(0, 10000) {
    NORMALIZED_DIGIT_WORDS[denormalize_digit_word(x)] = format("{0}", x)
}


function is_in_game_addr() => byte(0x006c)
function is_in_game() => is_in_game_addr() == 0x80
function is_p1_ai_addr() => byte(0xaf9)
function is_p1_ai() => is_p1_ai_addr() == 0x01
function is_p2_ai_addr() => byte(0xafa)
function is_p2_ai() => is_p2_ai_addr() == 0x01
function is_in_single_player_game_as_p1() => is_in_game() && !is_p1_ai() && is_p2_ai()
function is_in_single_player_game_as_p2() => is_in_game() && is_p1_ai() && !is_p2_ai()
function is_in_two_player_game() => is_in_game() && !is_p1_ai() && !is_p2_ai()
function is_in_ai_game() => is_in_game() && is_p1_ai() && is_p2_ai()

MAP_NOHMA      = 0x02
MAP_HUMA       = 0x03
MAP_VERSAI     = 0x04
MAP_KENGOLA    = 0x05
MAP_JINARL_1   = 0x06
MAP_JINARL_2   = 0x07
MAP_LAYSARK_1  = 0x08
MAP_LAYSARK_2  = 0x09
MAP_ELGUALA_1  = 0x0a
MAP_ELGUALA_2  = 0x0b
MAP_JAROA_1    = 0x0c
MAP_JAROA_2    = 0x0d
MAP_JAROA_3    = 0x0e
MAP_GALANDIA   = 0x0f
MAP_ELLITA_1   = 0x10
MAP_ELLITA_2   = 0x11
MAP_NICKEEYU_1 = 0x12
MAP_NICKEEYU_2 = 0x13
MAP_NOBBORN_1  = 0x14
MAP_NOBBORN_2  = 0x15
MAP_BELOSE_1   = 0x16
MAP_BELOSE_2   = 0x17
MAP_BELOSE_3   = 0x18
MAP_NOBBORN_S  = 0x19
MAP_ELLITA_S   = 0x1a
MAP_ELGUALA_S  = 0x1b
MAP_BELOSE_S   = 0x1c
MAP_NICKEEYU_S = 0x1d
MAP_LAYSARK_S  = 0x1e
MAP_JAROA_S    = 0x1f
MAP_JINARL_S   = 0x20

MAP_TO_NAME = {
    MAP_NOHMA      : "Nohma",
    MAP_HUMA       : "Huma",
    MAP_VERSAI     : "Versai",
    MAP_KENGOLA    : "Kengola",
    MAP_JINARL_1   : "Jinarl 1",
    MAP_JINARL_2   : "Jinarl 2",
    MAP_LAYSARK_1  : "Laysark 1",
    MAP_LAYSARK_2  : "Laysark 2",
    MAP_ELGUALA_1  : "Elguala 1",
    MAP_ELGUALA_2  : "Elguala 2",
    MAP_JAROA_1    : "Jaroa 1",
    MAP_JAROA_2    : "Jaroa 2",
    MAP_JAROA_3    : "Jaroa 3",
    MAP_GALANDIA   : "Galandia",
    MAP_ELLITA_1   : "Ellita 1",
    MAP_ELLITA_2   : "Ellita 2",
    MAP_NICKEEYU_1 : "Nickeeyu 1",
    MAP_NICKEEYU_2 : "Nickeeyu 2",
    MAP_NOBBORN_1  : "Nobborn 1",
    MAP_NOBBORN_2  : "Nobborn 2",
    MAP_BELOSE_1   : "Belose 1",
    MAP_BELOSE_2   : "Belose 2",
    MAP_BELOSE_3   : "Belose 3",
    MAP_NOBBORN_S  : "Nobborn S",
    MAP_ELLITA_S   : "Ellita S",
    MAP_ELGUALA_S  : "Elguala S",
    MAP_BELOSE_S   : "Belose S",
    MAP_NICKEEYU_S : "Nickeeyu S",
    MAP_LAYSARK_S  : "Laysark S",
    MAP_JAROA_S    : "Jaroa S",
    MAP_JINARL_S   : "Jinarl S"
}

function current_map() => byte(0x0af6)
TURN_NUMBER_ADDR = 0x0b07
function turn_number_normalized() =>
    low4(TURN_NUMBER_ADDR)
        + 10 * high4(TURN_NUMBER_ADDR)
        + 100 * low4(TURN_NUMBER_ADDR + 1)
        + 1000 * high4(TURN_NUMBER_ADDR + 1)
function p1_cities() => byte(0x0b01)
function p1_factories() => byte(0x0b03)
function p1_unit_count() => byte(0x0b05)
function p1_money() => word(0x0afd)
function p1_base_health() => byte(0x0ab4)
function p2_cities() => byte(0x0b02)
function p2_factories() => byte(0x0b04)
function p2_unit_count() => byte(0x0b06)
function p2_money() => word(0x0aff)
function p2_base_health() => byte(0x0ab5)

IN_GAME_RP_STRING = "Turn {1} - Fallial C: {2}, F: {3}, U: {4}, M: {5}, Base: {6}/255, Stefan C: {7}, F: {8}, U: {9}, M: {10}, Base: {11}/255"
CONDITIONS_TO_RP_STRING = [
    [is_in_ai_game(), "Watching an AI battle on {0}"],
    [is_in_single_player_game_as_p1(), "Playing as Faliall on {0}"],
    [is_in_single_player_game_as_p2(), "Playing as Stefan on {0}"],
    [is_in_two_player_game(), "Playing a two-player game on {0}"]
]

for condition in CONDITIONS_TO_RP_STRING {
    rich_presence_conditional_display(condition[0], format("{0} - {1}", condition[1], IN_GAME_RP_STRING),
        rich_presence_lookup("Map", current_map(), MAP_TO_NAME),
        rich_presence_value("VALUE", turn_number_normalized()),
        rich_presence_value("VALUE", p1_cities()),
        rich_presence_value("VALUE", p1_factories()),
        rich_presence_value("VALUE", p1_unit_count()),
        rich_presence_value("VALUE", p1_money()),
        rich_presence_value("VALUE", p1_base_health()),
        rich_presence_value("VALUE", p2_cities()),
        rich_presence_value("VALUE", p2_factories()),
        rich_presence_value("VALUE", p2_unit_count()),
        rich_presence_value("VALUE", p2_money()),
        rich_presence_value("VALUE", p2_base_health())
    )
}

rich_presence_display("Planning the next battle in Vasteel...")


// == LEADERBOARDS ==

function is_in_results_screen_addr() => byte(0x1054)
function just_entered_results_screen() => is_in_results_screen_addr() == 0x01 && prev(is_in_results_screen_addr()) == 0x00
function just_entered_game() => is_in_game_addr() == 0x80 && prev(is_in_game_addr()) != 0x80

function p1_place_units_at_start_addr() => byte(0x0b3d)
function p2_place_units_at_start_addr() => byte(0x0b3e)

function is_loading_from_save() => byte(0x0b38) == 0x01
function is_loading_results_screen() => byte(0x0281) == 0x01

CHARACTER_FALIALL = 0x00
CHARACTER_STEFAN  = 0x01

function winning_character() => byte(0x0b09)

function fair_fight_as_p1() => never(!is_in_game() && !is_loading_results_screen())
    && once(
        just_entered_game()
            && !is_loading_from_save()
            && p1_money() <= p2_money()
            && p1_place_units_at_start_addr() <= p2_place_units_at_start_addr()
    )

function fair_fight_as_p2() => never(!is_in_game() && !is_loading_results_screen())
    && once(
        just_entered_game()
            && !is_loading_from_save()
            && p2_money() <= p1_money()
            && p2_place_units_at_start_addr() <= p1_place_units_at_start_addr()
    )

MAP_TO_LEADERBOARD_IDS = {
    MAP_NOHMA      : [92493, 92494],
    MAP_HUMA       : [92495, 92496],
    MAP_VERSAI     : [92497, 92498],
    MAP_KENGOLA    : [92499, 92500],
    MAP_JINARL_1   : [92501, 92502],
    MAP_JINARL_2   : [92503, 92504],
    MAP_LAYSARK_1  : [92505, 92506],
    MAP_LAYSARK_2  : [92507, 92508],
    MAP_ELGUALA_1  : [92509, 92510],
    MAP_ELGUALA_2  : [92511, 92512],
    MAP_JAROA_1    : [92513, 92514],
    MAP_JAROA_2    : [92515, 92516],
    MAP_JAROA_3    : [92517, 92518],
    MAP_GALANDIA   : [92519, 92520],
    MAP_ELLITA_1   : [92521, 92522],
    MAP_ELLITA_2   : [92523, 92524],
    MAP_NICKEEYU_1 : [92525, 92526],
    MAP_NICKEEYU_2 : [92527, 92528],
    MAP_NOBBORN_1  : [92529, 92530],
    MAP_NOBBORN_2  : [92531, 92532],
    MAP_BELOSE_1   : [92533, 92534],
    MAP_BELOSE_2   : [92535, 92536],
    MAP_BELOSE_3   : [92537, 92538],
    MAP_NOBBORN_S  : [92539, 92540],
    MAP_ELLITA_S   : [92541, 92542],
    MAP_ELGUALA_S  : [92543, 92544],
    MAP_BELOSE_S   : [92545, 92546],
    MAP_NICKEEYU_S : [92547, 92548],
    MAP_LAYSARK_S  : [92549, 92550],
    MAP_JAROA_S    : [92551, 92552],
    MAP_JINARL_S   : [92553, 92554]
}

// [Character name, conditions, index for ID array items (0 for Faliall, 1 for Stefan)]
leaderboard_setups = [
    ["Faliall", !is_p1_ai() && is_p2_ai() && winning_character() == CHARACTER_FALIALL && fair_fight_as_p1(), 0],
    ["Stefan", is_p1_ai() && !is_p2_ai() && winning_character() == CHARACTER_STEFAN && fair_fight_as_p2(), 1]
]

for map in MAP_TO_NAME {
    map_name = MAP_TO_NAME[map]
    for setup in leaderboard_setups {
        character_name = setup[0]
        submit_condition = setup[1] && just_entered_results_screen() && current_map() == map
        leaderboard(
            title = format("{0} - {1} - Quickest Victory", character_name, map_name),
            description = format("Beat {0} as {1} in a fair fight without quickloading in the fewest number of turns", map_name, character_name),
            id = MAP_TO_LEADERBOARD_IDS[map][setup[2]],
            start = submit_condition,
            cancel = always_false(),
            submit = submit_condition,
            value = turn_number_normalized(),
            format = "VALUE",
            lower_is_better = true
        )
    }
}


// == MAP ACHIEVEMENTS ==

MAP_TO_ACHIEVEMENT_IDS = {
    MAP_NOHMA      : [411053, 411054],
    MAP_HUMA       : [411055, 411056],
    MAP_VERSAI     : [411057, 411058],
    MAP_KENGOLA    : [411059, 411060],
    MAP_JINARL_1   : [411061, 411062],
    MAP_JINARL_2   : [411063, 411064],
    MAP_LAYSARK_1  : [411065, 411066],
    MAP_LAYSARK_2  : [411067, 411068],
    MAP_ELGUALA_1  : [411069, 411070],
    MAP_ELGUALA_2  : [411071, 411072],
    MAP_JAROA_1    : [411073, 411074],
    MAP_JAROA_2    : [411075, 411076],
    MAP_JAROA_3    : [411077, 411078],
    MAP_GALANDIA   : [411079, 411080],
    MAP_ELLITA_1   : [411081, 411082],
    MAP_ELLITA_2   : [411083, 411084],
    MAP_NICKEEYU_1 : [411085, 411086],
    MAP_NICKEEYU_2 : [411087, 411088],
    MAP_NOBBORN_1  : [411089, 411090],
    MAP_NOBBORN_2  : [411091, 411092],
    MAP_BELOSE_1   : [411093, 411094],
    MAP_BELOSE_2   : [411095, 411096],
    MAP_BELOSE_3   : [411097, 411098],
    MAP_NOBBORN_S  : [411099, 411100],
    MAP_ELLITA_S   : [411101, 411102],
    MAP_ELGUALA_S  : [411103, 411104],
    MAP_BELOSE_S   : [411105, 411106],
    MAP_NICKEEYU_S : [411107, 411108],
    MAP_LAYSARK_S  : [411109, 411110],
    MAP_JAROA_S    : [411111, 411112],
    MAP_JINARL_S   : [411113, 411114]
}

for map in MAP_TO_NAME {
    map_name = MAP_TO_NAME[map]
    for setup in leaderboard_setups {
        character_name = setup[0]
        submit_condition = setup[1] && just_entered_results_screen() && current_map() == map
        achievement(
            title = format("Victory at {0} ({1})", map_name, character_name),
            description = format("Beat {0} as {1} in a fair fight (start with equal or less money and don't start with your units placed and your opponent's not placed) without quickloading", map_name, character_name),
            points = 10,
            id = MAP_TO_LEADERBOARD_IDS[map][setup[2]],
            trigger = submit_condition
        )
    }
}


// == SCENARIO MODE ACHIEVEMENTS ==

function is_in_scenario_mode() => byte(0x0af4) == 0x01
function scenario_mode_character() => byte(0x0af5)

function cutscene_index_addr() => word(0x0265)

function win_at_end_of_faliall_campaign() => is_in_scenario_mode()
    && cutscene_index_addr() == 0xbfce
    && prev(cutscene_index_addr()) != 0xbfce
    && scenario_mode_character() == CHARACTER_FALIALL

achievement(
    title = "The Dawn of a New Era of Peace",
    description = "Conquer the Vasteel system as Faliall and defeat Stefan",
    points = 10,
    id = 411115,
    trigger = win_at_end_of_faliall_campaign()
)

function win_at_end_of_stefan_campaign() => is_in_scenario_mode()
    && cutscene_index_addr() == 0x7d97
    && prev(cutscene_index_addr()) != 0x7d97
    && scenario_mode_character() == CHARACTER_STEFAN

achievement(
    title = "Two Sides of the Same Coin",
    description = "Conquer the Vasteel system as Stefan and defeat Faliall",
    points = 10,
    id = 411116,
    trigger = win_at_end_of_stefan_campaign()
)

function lose_at_end_of_faliall_campaign() => is_in_scenario_mode()
    && cutscene_index_addr() == 0x0796
    && prev(cutscene_index_addr()) != 0x0796 // No character assertion just to allow players to witness the cutscene after losing every encounter

achievement(
    title = "I'll See You In Hell",
    description = "Fail as Faliall to defeat Stefan after conquering the Vasteel system (or play as Stefan and beat Faliall after failing every scenario)",
    points = 1,
    id = 411121,
    trigger = lose_at_end_of_faliall_campaign()
)

function lose_at_end_of_stefan_campaign() => is_in_scenario_mode()
    && cutscene_index_addr() == 0x5ccd
    && prev(cutscene_index_addr()) != 0x5ccd // No character assertion just to allow players to witness the cutscene after losing every encounter

achievement(
    title = "Even Now We Can't Agree",
    description = "Fail as Stefan to defeat Faliall after conquering the Vasteel system (or play as Faliall and beat Stefan after failing every scenario)",
    points = 1,
    id = 411122,
    trigger = lose_at_end_of_stefan_campaign()
)

function reached_snuggle_cutscene() => is_in_scenario_mode()
    && cutscene_index_addr() == 0x83d1
    && prev(cutscene_index_addr()) != 0x83d1

achievement(
    title = "I've Totally Forgotten My Line",
    description = "Stick around after the credits",
    points = 1,
    id = 411123,
    trigger = reached_snuggle_cutscene()
)


// == MISC ACHIEVEMENTS ==

function max_money_trigger() {
    return (
        is_in_single_player_game_as_p1()
            && never(!is_in_game())
            && once(p1_money() <= 10000)
            && p1_money() >= 65000
            && prev(p1_money()) < 65000
    ) || (
        is_in_single_player_game_as_p2()
            && never(!is_in_game())
            && once(p2_money() <= 10000)
            && p2_money() >= 65000
            && prev(p2_money()) < 65000
    )
}

achievement(
    title = "Wealth For Toil",
    description = "Work your way up from 10,000 money to 60,000 within a single game",
    points = 5,
    id = 411117,
    trigger = max_money_trigger()
)

function max_units_trigger() {
    return (
        is_in_single_player_game_as_p1()
            && p1_unit_count() >= 32
            && prev(p1_unit_count()) < 32
    ) || (
        is_in_single_player_game_as_p2()
            && p2_unit_count() >= 32
            && prev(p2_unit_count()) < 32
    )
}

achievement(
    title = "A Full Chess Board",
    description = "Maximise your army strength with 32 units",
    points = 5,
    id = 411118,
    trigger = max_units_trigger()
)

function max_buildings_trigger() {
    return (
        is_in_single_player_game_as_p1()
            && p1_cities() >= 30
            && prev(p1_cities()) < 30
            && p1_factories() >= 5
            && prev(p1_factories()) < 5
    ) || (
        is_in_single_player_game_as_p2()
            && p2_cities() >= 30
            && prev(p2_cities()) < 30
            && p2_factories() >= 5
            && prev(p2_factories()) < 5
    )
}

achievement(
    title = "Advance To Mayfair",
    description = "Have 30 cities and 5 factories captured on any map",
    points = 5,
    id = 411119,
    trigger = max_buildings_trigger()
)

function is_in_combat_addr() => byte(0x0070)
function p1_in_combat_unit_type() => byte(0xb28)
function p1_in_combat_health() => byte(0xb29)
function p2_in_combat_unit_type() => byte(0xb30)
function p2_in_combat_health() => byte(0xb31)

function destroy_base_in_one_go_trigger() {
    return (
        is_in_single_player_game_as_p1()
            && once(
                is_in_combat_addr() == 0x80
                    && p2_in_combat_unit_type() == 0x80
                    && p2_in_combat_health() == 0xff
            )
            && p2_in_combat_health() == 0x00
            && never(
                is_in_combat_addr() == 0x00
            )
    ) || (
        is_in_single_player_game_as_p2()
            && once(
                is_in_combat_addr() == 0x80
                    && p1_in_combat_unit_type() == 0x88
                    && p1_in_combat_health() == 0xff
            )
            && p1_in_combat_health() == 0x00
            && never(
                is_in_combat_addr() == 0x00
            )
    )
}

achievement(
    title = "Stay On Target",
    description = "Destroy your opponent's base from full health in a single attempt",
    points = 10,
    id = 411120,
    trigger = destroy_base_in_one_go_trigger()
)