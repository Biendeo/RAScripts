// Singstar
// #ID = 29042

// SCES_522.68 - Europe
// SCES_525.64 - France
// SCES_525.65 - Germany
// SCES_525.66 - Italy
// SCES_522.99 - Spain

// Internal region constants for this script
REGION_EUROPE  = 1
REGION_FRANCE  = 2
REGION_GERMANY = 3
REGION_ITALY   = 4
REGION_SPAIN   = 5

REGION_TO_SHORT_NAME = {
    REGION_EUROPE  : "EUR",
    REGION_FRANCE  : "FRA",
    REGION_GERMANY : "GER",
    REGION_ITALY   : "ITA",
    REGION_SPAIN   : "SPA"
}

SONG_DETAILS_ARRAY_FRANCE_ADDR  = 0x00885f90
SONG_DETAILS_ARRAY_GERMANY_ADDR = 0x00893a80
SONG_DETAILS_ARRAY_ITALY_ADDR   = 0x0089a0e0
SONG_DETAILS_ARRAY_SPAIN_ADDR   = 0x00875d10
function is_in_region(region) {
    if (region == REGION_FRANCE) {
        return dword(SONG_DETAILS_ARRAY_FRANCE_ADDR) == SONG_FRANCE_WORLD_OF_OUR_OWN
            && dword(SONG_DETAILS_ARRAY_FRANCE_ADDR + (29 * 4)) == SONG_FRANCE_VOTRE_IMAGE
    } else if (region == REGION_GERMANY) {
        return dword(SONG_DETAILS_ARRAY_GERMANY_ADDR) == SONG_GERMANY_MURDER_ON_THE_DANCEFLOOR
            && dword(SONG_DETAILS_ARRAY_GERMANY_ADDR + (29 * 4)) == SONG_GERMANY_BILDER_VON_DIR
    } else if (region == REGION_ITALY) {
        return dword(SONG_DETAILS_ARRAY_ITALY_ADDR) == SONG_ITALY_WORLD_OF_OUR_OWN
            && dword(SONG_DETAILS_ARRAY_ITALY_ADDR + (29 * 4)) == SONG_ITALY_IN_UN_ISTANTE
    } else if (region == REGION_SPAIN) {
        return dword(SONG_DETAILS_ARRAY_SPAIN_ADDR) == SONG_SPAIN_I_BELIEVE_IN_A_THING_CALLED_LOVE
            && dword(SONG_DETAILS_ARRAY_SPAIN_ADDR + (29 * 4)) == SONG_SPAIN_SUPERSTAR
    }
}

LOADED_SONG_DETAILS_ADDR = {
    REGION_EUROPE  : 0x005af244,
    REGION_FRANCE  : 0x005b8d04,
    REGION_GERMANY : 0x005b8e44,
    REGION_ITALY   : 0x005b7984,
    REGION_SPAIN   : 0x005b85c4
}
function loaded_song_details(region) => dword(LOADED_SONG_DETAILS_ADDR[region])

IS_IN_STAR_MAKER_MODE_ADDR = {
    REGION_EUROPE  : 0x002f3888,
    REGION_FRANCE  : 0x002f7288,
    REGION_GERMANY : 0x002f7188,
    REGION_ITALY   : 0x002f5f08,
    REGION_SPAIN   : 0x002f6b88
}
function is_in_star_maker_mode(region) => dword(IS_IN_STAR_MAKER_MODE_ADDR[region]) == 0x01
function is_in_sing_mode_song(region) => !is_in_star_maker_mode(region)

function loaded_song_id_sing_mode(region) => dword(loaded_song_details(region) + 0x84)

function is_sing_mode_short_song_enabled(region) => dword(loaded_song_details(region) + 0x88) == 0x01

FIRST_SONG_SCORE_DETAILS_ADDR = {
    REGION_EUROPE  : 0x0029f290,
    REGION_FRANCE  : 0x002a27e0,
    REGION_GERMANY : 0x002a26e0,
    REGION_ITALY   : 0x002a14f8,
    REGION_SPAIN   : 0x002a20e8
}

function first_song_score_details(region) => dword(FIRST_SONG_SCORE_DETAILS_ADDR[region])
function phrase_bonus(region) => dword(dword(first_song_score_details(region) + 0xcc) + 0x38)
function total_score(region) => dword(dword(first_song_score_details(region) + 0xcc) + 0x3c)
function sing_mode_difficulty(region) => dword(loaded_song_details(region) + 0xbc)

IS_MIC_ON_ADDR = {
    REGION_EUROPE  : 0x00330848,
    REGION_FRANCE  : 0x00334288,
    REGION_GERMANY : 0x00339a9c,
    REGION_ITALY   : 0x0033881c,
    REGION_SPAIN   : 0x00339454
}
function is_mic_on(region) => dword(IS_MIC_ON_ADDR[region]) == 0x01

IS_GAME_PAUSED_ADDR = {
    REGION_EUROPE  : 0x0029f4a0,
    REGION_FRANCE  : 0x002a29f0,
    REGION_GERMANY : 0x002a28f0,
    REGION_ITALY   : 0x002a1708,
    REGION_SPAIN   : 0x002a22f8
}
function is_game_paused(region) => dword(IS_GAME_PAUSED_ADDR[region]) == 0x01

SCORE_SCREEN_DETECTOR_ADDR = {
    REGION_EUROPE  : 0x0036a3d0,
    REGION_FRANCE  : 0x0036de90,
    REGION_GERMANY : 0x0036dfd0,
    REGION_ITALY   : 0x0036cb10,
    REGION_SPAIN   : 0x0036d750
}
SCORE_SCREEN_DETECTOR_IN_SONG = 0x50000000
SCORE_SCREEN_DETECTOR_IN_SONG_FIRST_FRAME = 0x3a800000
SCORE_SCREEN_DETECTOR_END_SONG = 0x3f4ac000
function score_screen_detector(region) => dword(SCORE_SCREEN_DETECTOR_ADDR[region])

function did_song_just_finish(region) {
    return prev(score_screen_detector(region)) == SCORE_SCREEN_DETECTOR_IN_SONG && score_screen_detector(region) == SCORE_SCREEN_DETECTOR_END_SONG
}

function is_in_song(region) {
    return (
        score_screen_detector(region) == SCORE_SCREEN_DETECTOR_IN_SONG
            || score_screen_detector(region) == SCORE_SCREEN_DETECTOR_IN_SONG_FIRST_FRAME
    ) && (
        is_mic_on(region)
            || is_game_paused(region)
    )
}

SONG_POSITION_ADDR = {
    REGION_EUROPE  : 0x00331c40,
    REGION_FRANCE  : 0x00335670,
    REGION_GERMANY : 0x00335570,
    REGION_ITALY   : 0x003342f0,
    REGION_SPAIN   : 0x00334f70
}
function song_position(region) => dword(SONG_POSITION_ADDR[region])

function is_in_specific_song_and_difficulty_short(region, song_id, difficulty_id) {
    return (
        is_in_sing_mode_song(region)
        && loaded_song_id_sing_mode(region) == song_id
        && sing_mode_difficulty(region) == difficulty_id
        && is_sing_mode_short_song_enabled(region)
    )
}

function is_in_specific_song_and_difficulty_long(region, song_id, difficulty_id) {
    return (
        is_in_sing_mode_song(region)
        && loaded_song_id_sing_mode(region) == song_id
        && sing_mode_difficulty(region) == difficulty_id
        && !is_sing_mode_short_song_enabled(region)
    )
}

function start_leaderboard(region, song_id, song_difficulty, is_short) {
    if (is_short == true) {
        song_condition = is_in_specific_song_and_difficulty_short(region, song_id, song_difficulty)
    } else {
        song_condition = is_in_specific_song_and_difficulty_long(region, song_id, song_difficulty)
    }
    return (
        score_screen_detector(region) == SCORE_SCREEN_DETECTOR_IN_SONG
            || score_screen_detector(region) == SCORE_SCREEN_DETECTOR_IN_SONG_FIRST_FRAME
    )
        && is_in_region(region)
        && is_mic_on(region)
        && song_position(region) == 2 // Si C'est Bone Comme Ça's needs this wait for some reason.
        && prev(song_position(region)) == 1
        && song_condition
}

function submit_leaderboard(region) {
    return did_song_just_finish(region)
}

function is_in_song_frame_0(region) {
    return !is_in_song(region)
        && song_position(region) == 0
}

function is_in_end_song_loading(region) {
    return score_screen_detector(region) == SCORE_SCREEN_DETECTOR_IN_SONG
        && song_position(region) > 1000 // Some songs stop the mic+video before it's actually finished
}

function is_in_end_song_results(region) {
    return score_screen_detector(region) == SCORE_SCREEN_DETECTOR_END_SONG
}

function cancel_leaderboard(region) {
    return !is_in_song(region)
        && !is_in_end_song_loading(region)
        && !is_in_end_song_results(region)
        || is_in_song_frame_0(region)
}

function leaderboard_value(region) {
    return total_score(region)
}

DIFFICULTY_EASY   = 0x00
DIFFICULTY_NORMAL = 0x01
DIFFICULTY_HARD   = 0x02

DIFFICULTY_TO_NAME = {
    DIFFICULTY_EASY   : "Easy",
    DIFFICULTY_NORMAL : "Normal",
    DIFFICULTY_HARD   : "Hard"
}

SONG_FRANCE_WORLD_OF_OUR_OWN                 = 0x008023d0
SONG_FRANCE_MURDER_ON_THE_DANCEFLOOR         = 0x00801920
SONG_FRANCE_THANK_YOU                        = 0x008041c0
SONG_FRANCE_GET_THE_PARTY_STARTED            = 0x00804e50
SONG_FRANCE_SCANDALOUS                       = 0x00805280
SONG_FRANCE_LIKE_A_VIRGIN                    = 0x008012e0
SONG_FRANCE_NEVER_GONNA_GIVE_YOU_UP          = 0x008014f0
SONG_FRANCE_OH_PRETTY_WOMAN                  = 0x00801710
SONG_FRANCE_GROOVE_IS_IN_THE_HEART           = 0x00641520
SONG_FRANCE_JUST_A_LITTLE                    = 0x00801fb0
SONG_FRANCE_TAKE_ON_ME                       = 0x008021c0
SONG_FRANCE_KUNG_FU_FIGHTING                 = 0x008025f0
SONG_FRANCE_SUSPICIOUS_MINDS                 = 0x00802810
SONG_FRANCE_HEART_OF_GLASS                   = 0x00802a30
SONG_FRANCE_CARELESS_WHISPER                 = 0x00802c40
SONG_FRANCE_YMCA                             = 0x00801b50
SONG_FRANCE_COMPLICATED                      = 0x00801d60
SONG_FRANCE_LIVIN_LA_VIDA_LOCA               = 0x00803b70
SONG_FRANCE_DONT_STOP_MOVIN                  = 0x00803d90
SONG_FRANCE_SUPERSTAR                        = 0x00803fb0
SONG_FRANCE_I_BELIEVE_IN_A_THING_CALLED_LOVE = 0x008043d0
SONG_FRANCE_ONE_LOVE                         = 0x00804600
SONG_FRANCE_ETERNAL_FLAME                    = 0x00804a30
SONG_FRANCE_ENSEMBLE                         = 0x00804c40
SONG_FRANCE_HEY_OH                           = 0x00805490
SONG_FRANCE_TU_SERAS                         = 0x00802e60
SONG_FRANCE_SI_CEST_BON_COMME_CA             = 0x00804810
SONG_FRANCE_MAGDALENA                        = 0x00803070
SONG_FRANCE_CEST_QUAND_LE_BONHEUR            = 0x007ff170
SONG_FRANCE_VOTRE_IMAGE                      = 0x00805070

SONG_GERMANY_MURDER_ON_THE_DANCEFLOOR        = 0x00801a20
SONG_GERMANY_THANK_YOU                       = 0x00802fa0
SONG_GERMANY_GET_THE_PARTY_STARTED           = 0x008037f0
SONG_GERMANY_ACE_OF_SPADES                   = 0x007ffc20
SONG_GERMANY_DOWNTOWN                        = 0x008024a0
SONG_GERMANY_LIKE_A_VIRGIN                   = 0x008004e0
SONG_GERMANY_NEVER_GONNA_GIVE_YOU_UP         = 0x008006f0
SONG_GERMANY_OH_PRETTY_WOMAN                 = 0x00800910
SONG_GERMANY_TAKE_ON_ME                      = 0x006416e0
SONG_GERMANY_KUNG_FU_FIGHTING                = 0x008011b0
SONG_GERMANY_SUSPICIOUS_MINDS                = 0x008013d0
SONG_GERMANY_CARELESS_WHISPER                = 0x008015f0
SONG_GERMANY_ROUND_ROUND                     = 0x00801810
SONG_GERMANY_SIE_IST_WEG                     = 0x00801c50
SONG_GERMANY_YMCA                            = 0x00801e70
SONG_GERMANY_COMPLICATED                     = 0x00800b20
SONG_GERMANY_LIVIN_LA_VIDA_LOCA              = 0x00800d30
SONG_GERMANY_DONT_STOP_MOVIN                 = 0x00800f50
SONG_GERMANY_SUPERSTAR                       = 0x00802d90
SONG_GERMANY_DEEPER_UNDERGROUND              = 0x008031b0
SONG_GERMANY_ONE_LOVE                        = 0x008033d0
SONG_GERMANY_ETERNAL_FLAME                   = 0x008035e0
SONG_GERMANY_MAJOR_TOM                       = 0x00803a10
SONG_GERMANY_ROCK_ME_AMADEUS                 = 0x00803c20
SONG_GERMANY_5_DAYS                          = 0x007ffe30
SONG_GERMANY_DO_YOU                          = 0x00800040
SONG_GERMANY_STEH_AUF_WENN_DU_AM_BODEN_BIST  = 0x00800250
SONG_GERMANY_SOMEDAY                         = 0x00882750
SONG_GERMANY_THREE_LIONS                     = 0x00802080
SONG_GERMANY_BILDER_VON_DIR                  = 0x00802290

SONG_ITALY_WORLD_OF_OUR_OWN                  = 0x00800010
SONG_ITALY_MURDER_ON_THE_DANCEFLOOR          = 0x007ff560
SONG_ITALY_THANK_YOU                         = 0x00802010
SONG_ITALY_GET_THE_PARTY_STARTED             = 0x00889430
SONG_ITALY_SCANDALOUS                        = 0x00800a90
SONG_ITALY_ACE_OF_SPADES                     = 0x00800ca0
SONG_ITALY_LIKE_A_VIRGIN                     = 0x007fed10
SONG_ITALY_NEVER_GONNA_GIVE_YOU_UP           = 0x007fef20
SONG_ITALY_OH_PRETTY_WOMAN                   = 0x007ff140
SONG_ITALY_GROOVE_IS_IN_THE_HEART            = 0x006401a0
SONG_ITALY_JUST_A_LITTLE                     = 0x007ff9e0
SONG_ITALY_EGOISTA                           = 0x007ffbf0
SONG_ITALY_TAKE_ON_ME                        = 0x007ffe00
SONG_ITALY_SUSPICIOUS_MINDS                  = 0x00800230
SONG_ITALY_HEART_OF_GLASS                    = 0x00800450
SONG_ITALY_CARELESS_WHISPER                  = 0x00800660
SONG_ITALY_ROUND_ROUND                       = 0x007ff350
SONG_ITALY_YMCA                              = 0x007ff790
SONG_ITALY_CRASHED_THE_WEDDING               = 0x00801590
SONG_ITALY_COMPLICATED                       = 0x008017b0
SONG_ITALY_LIVIN_LA_VIDA_LOCA                = 0x008019c0
SONG_ITALY_DONT_STOP_MOVIN                   = 0x00801be0
SONG_ITALY_SUPERSTAR                         = 0x00801e00
SONG_ITALY_NUOVA_OSSESSIONE                  = 0x00802220
SONG_ITALY_I_BELIEVE_IN_A_THING_CALLED_LOVE  = 0x00888de0
SONG_ITALY_ONE_LOVE                          = 0x00889010
SONG_ITALY_ETERNAL_FLAME                     = 0x00889220
SONG_ITALY_SALIRO                            = 0x00889650
SONG_ITALY_VAMOS_A_BAILAR                    = 0x00889870
SONG_ITALY_IN_UN_ISTANTE                     = 0x00800880

SONG_SPAIN_I_BELIEVE_IN_A_THING_CALLED_LOVE  = 0x00802700
SONG_SPAIN_DIME                              = 0x008006c0
SONG_SPAIN_DOWN                              = 0x00801e20
SONG_SPAIN_TAKE_ON_ME                        = 0x008002a0
SONG_SPAIN_NOCHE_EN_VELA                     = 0x00801c10
SONG_SPAIN_OH_PRETTY_WOMAN                   = 0x00800090
SONG_SPAIN_BYE_BYE                           = 0x008008d0
SONG_SPAIN_20_DE_ENERO                       = 0x007ff2b0
SONG_SPAIN_CARELESS_WHISPER                  = 0x00800d70
SONG_SPAIN_COMPLICATED                       = 0x008015d0
SONG_SPAIN_CRASHED_THE_WEDDING               = 0x008013b0
SONG_SPAIN_LIKE_A_VIRGIN                     = 0x007ffe80
SONG_SPAIN_HOY                               = 0x008037c0
SONG_SPAIN_SIN_DOCUMENTOS                    = 0x007ff4d0
SONG_SPAIN_PUEDES_CONTAR_CONMIGO             = 0x00800b40
SONG_SPAIN_ROUND_ROUND                       = 0x00800f90
SONG_SPAIN_EN_EL_2000                        = 0x007ff6e0
SONG_SPAIN_THANK_YOU                         = 0x008004b0
SONG_SPAIN_LIVIN_LA_VIDA_LOCA                = 0x008019f0
SONG_SPAIN_SOLO_SE_VIVE_UNA_VEZ              = 0x00802f70
SONG_SPAIN_SUSPICIOUS_MINDS                  = 0x00640e60
SONG_SPAIN_MI_GATO                           = 0x008035b0
SONG_SPAIN_GIRLS_AND_BOYS                    = 0x00802930
SONG_SPAIN_A_DIOS_LE_PIDO                    = 0x00803190
SONG_SPAIN_YMCA                              = 0x008011a0
SONG_SPAIN_GET_THE_PARTY_STARTED             = 0x00802d50
SONG_SPAIN_LO_NOTO                           = 0x007ff900
SONG_SPAIN_ETERNAL_FLAME                     = 0x00802b40
SONG_SPAIN_NO_TE_ESCAPARAS                   = 0x008033a0
SONG_SPAIN_SUPERSTAR                         = 0x008017e0


SONG_TO_NAME = {
    SONG_FRANCE_WORLD_OF_OUR_OWN                 : "World Of Our Own",
    SONG_FRANCE_MURDER_ON_THE_DANCEFLOOR         : "Murder On The Dancefloor",
    SONG_FRANCE_THANK_YOU                        : "Thank You",
    SONG_FRANCE_GET_THE_PARTY_STARTED            : "Get The Party Started",
    SONG_FRANCE_SCANDALOUS                       : "Scandalous",
    SONG_FRANCE_LIKE_A_VIRGIN                    : "Like A Virgin",
    SONG_FRANCE_NEVER_GONNA_GIVE_YOU_UP          : "Never Gonna Give You Up",
    SONG_FRANCE_OH_PRETTY_WOMAN                  : "Oh Pretty Woman",
    SONG_FRANCE_GROOVE_IS_IN_THE_HEART           : "Groove Is In The Heart",
    SONG_FRANCE_JUST_A_LITTLE                    : "Just A Little",
    SONG_FRANCE_TAKE_ON_ME                       : "Take On Me",
    SONG_FRANCE_KUNG_FU_FIGHTING                 : "Kung Fu Fighting",
    SONG_FRANCE_SUSPICIOUS_MINDS                 : "Suspicious Minds",
    SONG_FRANCE_HEART_OF_GLASS                   : "Heart Of Glass",
    SONG_FRANCE_CARELESS_WHISPER                 : "Careless Whisper",
    SONG_FRANCE_YMCA                             : "Y.M.C.A.",
    SONG_FRANCE_COMPLICATED                      : "Complicated",
    SONG_FRANCE_LIVIN_LA_VIDA_LOCA               : "Livin' La Vida Loca",
    SONG_FRANCE_DONT_STOP_MOVIN                  : "Don't Stop Movin'",
    SONG_FRANCE_SUPERSTAR                        : "Superstar",
    SONG_FRANCE_I_BELIEVE_IN_A_THING_CALLED_LOVE : "I Believe In A Thing Called Love",
    SONG_FRANCE_ONE_LOVE                         : "One Love",
    SONG_FRANCE_ETERNAL_FLAME                    : "Eternal Flame",
    SONG_FRANCE_ENSEMBLE                         : "Ensemble",
    SONG_FRANCE_HEY_OH                           : "Hey Oh",
    SONG_FRANCE_TU_SERAS                         : "Tu Seras",
    SONG_FRANCE_SI_CEST_BON_COMME_CA             : "Si C'est Bon Comme Ça",
    SONG_FRANCE_MAGDALENA                        : "Magdalena",
    SONG_FRANCE_CEST_QUAND_LE_BONHEUR            : "C'est Quand Le Bonheur",
    SONG_FRANCE_VOTRE_IMAGE                      : "Votre Image",

    SONG_GERMANY_MURDER_ON_THE_DANCEFLOOR        : "Murder On The Dancefloor",
    SONG_GERMANY_THANK_YOU                       : "Thank You",
    SONG_GERMANY_GET_THE_PARTY_STARTED           : "Get The Party Started",
    SONG_GERMANY_ACE_OF_SPADES                   : "Ace Of Spades",
    SONG_GERMANY_DOWNTOWN                        : "Downtown",
    SONG_GERMANY_LIKE_A_VIRGIN                   : "Like A Virgin",
    SONG_GERMANY_NEVER_GONNA_GIVE_YOU_UP         : "Never Gonna Give You Up",
    SONG_GERMANY_OH_PRETTY_WOMAN                 : "Oh Pretty Woman",
    SONG_GERMANY_TAKE_ON_ME                      : "Take On Me",
    SONG_GERMANY_KUNG_FU_FIGHTING                : "Kung Fu Fighting",
    SONG_GERMANY_SUSPICIOUS_MINDS                : "Suspicious Minds",
    SONG_GERMANY_CARELESS_WHISPER                : "Careless Whisper",
    SONG_GERMANY_ROUND_ROUND                     : "Round Round",
    SONG_GERMANY_SIE_IST_WEG                     : "Sie Ist Weg",
    SONG_GERMANY_YMCA                            : "Y.M.C.A.",
    SONG_GERMANY_COMPLICATED                     : "Complicated",
    SONG_GERMANY_LIVIN_LA_VIDA_LOCA              : "Livin' La Vida Loca",
    SONG_GERMANY_DONT_STOP_MOVIN                 : "Don't Stop Movin'",
    SONG_GERMANY_SUPERSTAR                       : "Superstar",
    SONG_GERMANY_DEEPER_UNDERGROUND              : "Deeper Underground",
    SONG_GERMANY_ONE_LOVE                        : "One Love",
    SONG_GERMANY_ETERNAL_FLAME                   : "Eternal Flame",
    SONG_GERMANY_MAJOR_TOM                       : "Major Tom",
    SONG_GERMANY_ROCK_ME_AMADEUS                 : "Rock Me Amadeus",
    SONG_GERMANY_5_DAYS                          : "5 Days",
    SONG_GERMANY_DO_YOU                          : "Do You",
    SONG_GERMANY_STEH_AUF_WENN_DU_AM_BODEN_BIST  : "Steh Auf, Wenn Du Am Boden Bist",
    SONG_GERMANY_SOMEDAY               
              : "Someday",
    SONG_GERMANY_THREE_LIONS                     : "Three Lions",
    SONG_GERMANY_BILDER_VON_DIR                  : "Bilder Von Dir",

    SONG_ITALY_WORLD_OF_OUR_OWN                  : "World Of Our Own",
    SONG_ITALY_MURDER_ON_THE_DANCEFLOOR          : "Murder On The Dancefloor",
    SONG_ITALY_THANK_YOU                         : "Thank You",
    SONG_ITALY_GET_THE_PARTY_STARTED             : "Get The Party Started",
    SONG_ITALY_SCANDALOUS                        : "Scandalous",
    SONG_ITALY_ACE_OF_SPADES                     : "Ace Of Spades",
    SONG_ITALY_LIKE_A_VIRGIN                     : "Like A Virgin",
    SONG_ITALY_NEVER_GONNA_GIVE_YOU_UP           : "Never Gonna Give You Up",
    SONG_ITALY_OH_PRETTY_WOMAN                   : "Oh Pretty Woman",
    SONG_ITALY_GROOVE_IS_IN_THE_HEART            : "Groove Is In The Heart",
    SONG_ITALY_JUST_A_LITTLE                     : "Just A Little",
    SONG_ITALY_EGOISTA                           : "Egoista",
    SONG_ITALY_TAKE_ON_ME                        : "Take On Me",
    SONG_ITALY_SUSPICIOUS_MINDS                  : "Suspicious Minds",
    SONG_ITALY_HEART_OF_GLASS                    : "Heart Of Glass",
    SONG_ITALY_CARELESS_WHISPER                  : "Careless Whisper",
    SONG_ITALY_ROUND_ROUND                       : "Round Round",
    SONG_ITALY_YMCA                              : "Y.M.C.A.",
    SONG_ITALY_CRASHED_THE_WEDDING               : "Crashed The Wedding",
    SONG_ITALY_COMPLICATED                       : "Complicated",
    SONG_ITALY_LIVIN_LA_VIDA_LOCA                : "Livin' La Vida Loca",
    SONG_ITALY_DONT_STOP_MOVIN                   : "Don't Stop Movin'",
    SONG_ITALY_SUPERSTAR                         : "Superstar",
    SONG_ITALY_NUOVA_OSSESSIONE                  : "Nuova Ossessione",
    SONG_ITALY_I_BELIEVE_IN_A_THING_CALLED_LOVE  : "I Believe In A Thing Called Love",
    SONG_ITALY_ONE_LOVE                          : "One Love",
    SONG_ITALY_ETERNAL_FLAME                     : "Eternal Flame",
    SONG_ITALY_SALIRO                            : "Salirò",
    SONG_ITALY_VAMOS_A_BAILAR                    : "Vamos A Bailar",
    SONG_ITALY_IN_UN_ISTANTE                     : "In Un Istante",

    SONG_SPAIN_I_BELIEVE_IN_A_THING_CALLED_LOVE  : "I Believe In A Thing Called Love",
    SONG_SPAIN_DIME                              : "Dime",
    SONG_SPAIN_DOWN                              : "Down",
    SONG_SPAIN_TAKE_ON_ME                        : "Take On Me",
    SONG_SPAIN_NOCHE_EN_VELA                     : "Noche En Vela",
    SONG_SPAIN_OH_PRETTY_WOMAN                   : "Oh Pretty Woman",
    SONG_SPAIN_BYE_BYE                           : "Bye Bye",
    SONG_SPAIN_20_DE_ENERO                       : "20 De Enero",
    SONG_SPAIN_CARELESS_WHISPER                  : "Careless Whisper",
    SONG_SPAIN_COMPLICATED                       : "Complicated",
    SONG_SPAIN_CRASHED_THE_WEDDING               : "Crashed The Wedding",
    SONG_SPAIN_LIKE_A_VIRGIN                     : "Like A Virgin",
    SONG_SPAIN_HOY                               : "Hoy",
    SONG_SPAIN_SIN_DOCUMENTOS                    : "Sin Documentos",
    SONG_SPAIN_PUEDES_CONTAR_CONMIGO             : "Puedes Contar Conmigo",
    SONG_SPAIN_ROUND_ROUND                       : "Round Round",
    SONG_SPAIN_EN_EL_2000                        : "En El 2000",
    SONG_SPAIN_THANK_YOU                         : "Thank You",
    SONG_SPAIN_LIVIN_LA_VIDA_LOCA                : "Livin' La Vida Loca",
    SONG_SPAIN_SOLO_SE_VIVE_UNA_VEZ              : "Sólo Se Vive Una Vez",
    SONG_SPAIN_SUSPICIOUS_MINDS                  : "Suspicious Minds",
    SONG_SPAIN_MI_GATO                           : "Mi Gato",
    SONG_SPAIN_GIRLS_AND_BOYS                    : "Girls & Boys",
    SONG_SPAIN_A_DIOS_LE_PIDO                    : "A Dios Le Pido",
    SONG_SPAIN_YMCA                              : "Y.M.C.A.",
    SONG_SPAIN_GET_THE_PARTY_STARTED             : "Get The Party Started",
    SONG_SPAIN_LO_NOTO                           : "Lo Noto",
    SONG_SPAIN_ETERNAL_FLAME                     : "Eternal Flame",
    SONG_SPAIN_NO_TE_ESCAPARAS                   : "No Te Escaparás",
    SONG_SPAIN_SUPERSTAR                         : "Superstar"
}

SONG_TO_ARTIST_NAME = {
    SONG_FRANCE_WORLD_OF_OUR_OWN                 : "Westlife",
    SONG_FRANCE_MURDER_ON_THE_DANCEFLOOR         : "Sophie Ellis Bextor",
    SONG_FRANCE_THANK_YOU                        : "Dido",
    SONG_FRANCE_GET_THE_PARTY_STARTED            : "Pink",
    SONG_FRANCE_SCANDALOUS                       : "Mis-Teeq",
    SONG_FRANCE_LIKE_A_VIRGIN                    : "Madonna",
    SONG_FRANCE_NEVER_GONNA_GIVE_YOU_UP          : "Rick Astley",
    SONG_FRANCE_OH_PRETTY_WOMAN                  : "Roy Orbison",
    SONG_FRANCE_GROOVE_IS_IN_THE_HEART           : "Deee-Lite",
    SONG_FRANCE_JUST_A_LITTLE                    : "Liberty X",
    SONG_FRANCE_TAKE_ON_ME                       : "A-ha",
    SONG_FRANCE_KUNG_FU_FIGHTING                 : "Carl Douglas",
    SONG_FRANCE_SUSPICIOUS_MINDS                 : "Elvis Presley",
    SONG_FRANCE_HEART_OF_GLASS                   : "Blondie",
    SONG_FRANCE_CARELESS_WHISPER                 : "George Michael",
    SONG_FRANCE_YMCA                             : "Village People",
    SONG_FRANCE_COMPLICATED                      : "Avril Lavigne",
    SONG_FRANCE_LIVIN_LA_VIDA_LOCA               : "Ricky Martin",
    SONG_FRANCE_DONT_STOP_MOVIN                  : "S Club",
    SONG_FRANCE_SUPERSTAR                        : "Jamelia",
    SONG_FRANCE_I_BELIEVE_IN_A_THING_CALLED_LOVE : "The Darkness",
    SONG_FRANCE_ONE_LOVE                         : "Blue",
    SONG_FRANCE_ETERNAL_FLAME                    : "Atomic Kitten",
    SONG_FRANCE_ENSEMBLE                         : "Sinclair",
    SONG_FRANCE_HEY_OH                           : "Tragedie",
    SONG_FRANCE_TU_SERAS                         : "Emma Daumas",
    SONG_FRANCE_SI_CEST_BON_COMME_CA             : "Sinclair",
    SONG_FRANCE_MAGDALENA                        : "Jessica Marquez",
    SONG_FRANCE_CEST_QUAND_LE_BONHEUR            : "Cali",
    SONG_FRANCE_VOTRE_IMAGE                      : "Sinclair",

    SONG_GERMANY_MURDER_ON_THE_DANCEFLOOR        : "Sophie Ellis Bextor",
    SONG_GERMANY_THANK_YOU                       : "Dido",
    SONG_GERMANY_GET_THE_PARTY_STARTED           : "Pink",
    SONG_GERMANY_ACE_OF_SPADES                   : "Motörhead",
    SONG_GERMANY_DOWNTOWN                        : "Petula Clark",
    SONG_GERMANY_LIKE_A_VIRGIN                   : "Madonna",
    SONG_GERMANY_NEVER_GONNA_GIVE_YOU_UP         : "Rick Astley",
    SONG_GERMANY_OH_PRETTY_WOMAN                 : "Roy Orbison",
    SONG_GERMANY_TAKE_ON_ME                      : "A-ha",
    SONG_GERMANY_KUNG_FU_FIGHTING                : "Carl Douglas",
    SONG_GERMANY_SUSPICIOUS_MINDS                : "Elvis Presley",
    SONG_GERMANY_CARELESS_WHISPER                : "George Michael",
    SONG_GERMANY_ROUND_ROUND                     : "Sugababes",
    SONG_GERMANY_SIE_IST_WEG                     : "Fantastischen Vier",
    SONG_GERMANY_YMCA                            : "Village People",
    SONG_GERMANY_COMPLICATED                     : "Avril Lavigne",
    SONG_GERMANY_LIVIN_LA_VIDA_LOCA              : "Ricky Martin",
    SONG_GERMANY_DONT_STOP_MOVIN                 : "S Club",
    SONG_GERMANY_SUPERSTAR                       : "Jamelia",
    SONG_GERMANY_DEEPER_UNDERGROUND              : "Jamiroquai",
    SONG_GERMANY_ONE_LOVE                        : "Blue",
    SONG_GERMANY_ETERNAL_FLAME                   : "Atomic Kitten",
    SONG_GERMANY_MAJOR_TOM                       : "Peter Schilling",
    SONG_GERMANY_ROCK_ME_AMADEUS                 : "Falco",
    SONG_GERMANY_5_DAYS                          : "Patrick Nuo",
    SONG_GERMANY_DO_YOU                          : "Bro'sis",
    SONG_GERMANY_STEH_AUF_WENN_DU_AM_BODEN_BIST  : "Die Toten Hosen",
    SONG_GERMANY_SOMEDAY                         : "No Angels",
    SONG_GERMANY_THREE_LIONS                     : "Lightning Seeds",
    SONG_GERMANY_BILDER_VON_DIR                  : "Laith Al-Deem",

    SONG_ITALY_WORLD_OF_OUR_OWN                  : "Westlife",
    SONG_ITALY_MURDER_ON_THE_DANCEFLOOR          : "Sophie Ellis Bextor",
    SONG_ITALY_THANK_YOU                         : "Dido",
    SONG_ITALY_GET_THE_PARTY_STARTED             : "Pink",
    SONG_ITALY_SCANDALOUS                        : "Mis-Teeq",
    SONG_ITALY_ACE_OF_SPADES                     : "Motörhead",
    SONG_ITALY_LIKE_A_VIRGIN                     : "Madonna",
    SONG_ITALY_NEVER_GONNA_GIVE_YOU_UP           : "Never Gonna Give You Up",
    SONG_ITALY_OH_PRETTY_WOMAN                   : "Roy Orbison",
    SONG_ITALY_GROOVE_IS_IN_THE_HEART            : "Deee-Lite",
    SONG_ITALY_JUST_A_LITTLE                     : "Liberty X",
    SONG_ITALY_EGOISTA                           : "Alexia",
    SONG_ITALY_TAKE_ON_ME                        : "A-ha",
    SONG_ITALY_SUSPICIOUS_MINDS                  : "Elvis Presley",
    SONG_ITALY_HEART_OF_GLASS                    : "Blondie",
    SONG_ITALY_CARELESS_WHISPER                  : "George Michael",
    SONG_ITALY_ROUND_ROUND                       : "Sugababes",
    SONG_ITALY_YMCA                              : "Village People",
    SONG_ITALY_CRASHED_THE_WEDDING               : "Busted",
    SONG_ITALY_COMPLICATED                       : "Avril Lavigne",
    SONG_ITALY_LIVIN_LA_VIDA_LOCA                : "Ricky Martin",
    SONG_ITALY_DONT_STOP_MOVIN                   : "S Club",
    SONG_ITALY_SUPERSTAR                         : "Jamelia",
    SONG_ITALY_NUOVA_OSSESSIONE                  : "Subsonica",
    SONG_ITALY_I_BELIEVE_IN_A_THING_CALLED_LOVE  : "The Darkness",
    SONG_ITALY_ONE_LOVE                          : "Blue",
    SONG_ITALY_ETERNAL_FLAME                     : "Atomic Kitten",
    SONG_ITALY_SALIRO                            : "Daniele Silvestri",
    SONG_ITALY_VAMOS_A_BAILAR                    : "Paola & Chiara",
    SONG_ITALY_IN_UN_ISTANTE                     : "La Differenza",

    SONG_SPAIN_I_BELIEVE_IN_A_THING_CALLED_LOVE  : "The Darkness",
    SONG_SPAIN_DIME                              : "Beth",
    SONG_SPAIN_DOWN                              : "Junior",
    SONG_SPAIN_TAKE_ON_ME                        : "A-ha",
    SONG_SPAIN_NOCHE_EN_VELA                     : "Guaraná",
    SONG_SPAIN_OH_PRETTY_WOMAN                   : "Roy Orbison",
    SONG_SPAIN_BYE_BYE                           : "David Civera",
    SONG_SPAIN_20_DE_ENERO                       : "La Oreja de Van Gogh",
    SONG_SPAIN_CARELESS_WHISPER                  : "George Michael",
    SONG_SPAIN_COMPLICATED                       : "Avril Lavigne",
    SONG_SPAIN_CRASHED_THE_WEDDING               : "Busted",
    SONG_SPAIN_LIKE_A_VIRGIN                     : "Madonna",
    SONG_SPAIN_HOY                               : "Gloria Estefan",
    SONG_SPAIN_SIN_DOCUMENTOS                    : "Los Rodríguez",
    SONG_SPAIN_PUEDES_CONTAR_CONMIGO             : "La Oreja de Van Gogh",
    SONG_SPAIN_ROUND_ROUND                       : "Sugababes",
    SONG_SPAIN_EN_EL_2000                        : "Natalia Lafourcade",
    SONG_SPAIN_THANK_YOU                         : "Dido",
    SONG_SPAIN_LIVIN_LA_VIDA_LOCA                : "Ricky Martin",
    SONG_SPAIN_SOLO_SE_VIVE_UNA_VEZ              : "Azúcar Moreno",
    SONG_SPAIN_SUSPICIOUS_MINDS                  : "Elvis Presley",
    SONG_SPAIN_MI_GATO                           : "Rosario",
    SONG_SPAIN_GIRLS_AND_BOYS                    : "Good Charlotte",
    SONG_SPAIN_A_DIOS_LE_PIDO                    : "Juanes",
    SONG_SPAIN_YMCA                              : "Village People",
    SONG_SPAIN_GET_THE_PARTY_STARTED             : "Pink",
    SONG_SPAIN_LO_NOTO                           : "Hombres G",
    SONG_SPAIN_ETERNAL_FLAME                     : "Atomic Kitten",
    SONG_SPAIN_NO_TE_ESCAPARAS                   : "Hombres G",
    SONG_SPAIN_SUPERSTAR                         : "Jamelia"
}

SONG_TO_LENGTH = {
    SONG_FRANCE_WORLD_OF_OUR_OWN                 : 0x2849,
    SONG_FRANCE_MURDER_ON_THE_DANCEFLOOR         : 0x2c53,
    SONG_FRANCE_THANK_YOU                        : 0x2583,
    SONG_FRANCE_GET_THE_PARTY_STARTED            : 0x2533,
    SONG_FRANCE_SCANDALOUS                       : 0x31ab,
    SONG_FRANCE_LIKE_A_VIRGIN                    : 0x2bef,
    SONG_FRANCE_NEVER_GONNA_GIVE_YOU_UP          : 0x284d,
    SONG_FRANCE_OH_PRETTY_WOMAN                  : 0x22f9,
    SONG_FRANCE_GROOVE_IS_IN_THE_HEART           : 0x3891,
    SONG_FRANCE_JUST_A_LITTLE                    : 0x2da7,
    SONG_FRANCE_TAKE_ON_ME                       : 0x2b13,
    SONG_FRANCE_KUNG_FU_FIGHTING                 : 0x23eb,
    SONG_FRANCE_SUSPICIOUS_MINDS                 : 0x2bdd,
    SONG_FRANCE_HEART_OF_GLASS                   : 0x2b67,
    SONG_FRANCE_CARELESS_WHISPER                 : 0x36f7,
    SONG_FRANCE_YMCA                             : 0x2721,
    SONG_FRANCE_COMPLICATED                      : 0x30ab,
    SONG_FRANCE_LIVIN_LA_VIDA_LOCA               : 0x2bbf,
    SONG_FRANCE_DONT_STOP_MOVIN                  : 0x2ce1,
    SONG_FRANCE_SUPERSTAR                        : 0x2929,
    SONG_FRANCE_I_BELIEVE_IN_A_THING_CALLED_LOVE : 0x2c73,
    SONG_FRANCE_ONE_LOVE                         : 0x2809,
    SONG_FRANCE_ETERNAL_FLAME                    : 0x2413,
    SONG_FRANCE_ENSEMBLE                         : 0x240f,
    SONG_FRANCE_HEY_OH                           : 0x2877,
    SONG_FRANCE_TU_SERAS                         : 0x2d55,
    SONG_FRANCE_SI_CEST_BON_COMME_CA             : 0x2bcd,
    SONG_FRANCE_MAGDALENA                        : 0x2cb1,
    SONG_FRANCE_CEST_QUAND_LE_BONHEUR            : 0x2bf5,
    SONG_FRANCE_VOTRE_IMAGE                      : 0x2a7d,

    SONG_GERMANY_MURDER_ON_THE_DANCEFLOOR        : 0x2c53,
    SONG_GERMANY_THANK_YOU                       : 0x2583,
    SONG_GERMANY_GET_THE_PARTY_STARTED           : 0x2533,
    SONG_GERMANY_ACE_OF_SPADES                   : 0x1fb3,
    SONG_GERMANY_DOWNTOWN                        : 0x241b,
    SONG_GERMANY_LIKE_A_VIRGIN                   : 0x2bef,
    SONG_GERMANY_NEVER_GONNA_GIVE_YOU_UP         : 0x284d,
    SONG_GERMANY_OH_PRETTY_WOMAN                 : 0x22f9,
    SONG_GERMANY_TAKE_ON_ME                      : 0x2b13,
    SONG_GERMANY_KUNG_FU_FIGHTING                : 0x23eb,
    SONG_GERMANY_SUSPICIOUS_MINDS                : 0x2bdd,
    SONG_GERMANY_CARELESS_WHISPER                : 0x36f7,
    SONG_GERMANY_ROUND_ROUND                     : 0x2d93,
    SONG_GERMANY_SIE_IST_WEG                     : 0x2e01,
    SONG_GERMANY_YMCA                            : 0x2721,
    SONG_GERMANY_COMPLICATED                     : 0x30ab,
    SONG_GERMANY_LIVIN_LA_VIDA_LOCA              : 0x2bbf,
    SONG_GERMANY_DONT_STOP_MOVIN                 : 0x2ce1,
    SONG_GERMANY_SUPERSTAR                       : 0x2929,
    SONG_GERMANY_DEEPER_UNDERGROUND              : 0x32e3,
    SONG_GERMANY_ONE_LOVE                        : 0x2809,
    SONG_GERMANY_ETERNAL_FLAME                   : 0x2413,
    SONG_GERMANY_MAJOR_TOM                       : 0x36ed,
    SONG_GERMANY_ROCK_ME_AMADEUS                 : 0x25cb,
    SONG_GERMANY_5_DAYS                          : 0x2759,
    SONG_GERMANY_DO_YOU                          : 0x2519,
    SONG_GERMANY_STEH_AUF_WENN_DU_AM_BODEN_BIST  : 0x2dc7,
    SONG_GERMANY_SOMEDAY                         : 0x26eb,
    SONG_GERMANY_THREE_LIONS                     : 0x2be1,
    SONG_GERMANY_BILDER_VON_DIR                  : 0x3123,

    SONG_ITALY_WORLD_OF_OUR_OWN                  : 0x2849,
    SONG_ITALY_MURDER_ON_THE_DANCEFLOOR          : 0x2c53,
    SONG_ITALY_THANK_YOU                         : 0x2583,
    SONG_ITALY_GET_THE_PARTY_STARTED             : 0x2533,
    SONG_ITALY_SCANDALOUS                        : 0x31ab,
    SONG_ITALY_ACE_OF_SPADES                     : 0x1fb3,
    SONG_ITALY_LIKE_A_VIRGIN                     : 0x2bef,
    SONG_ITALY_NEVER_GONNA_GIVE_YOU_UP           : 0x284d,
    SONG_ITALY_OH_PRETTY_WOMAN                   : 0x22f9,
    SONG_ITALY_GROOVE_IS_IN_THE_HEART            : 0x3891,
    SONG_ITALY_JUST_A_LITTLE                     : 0x2da7,
    SONG_ITALY_EGOISTA                           : 0x2985,
    SONG_ITALY_TAKE_ON_ME                        : 0x2b13,
    SONG_ITALY_SUSPICIOUS_MINDS                  : 0x2bdd,
    SONG_ITALY_HEART_OF_GLASS                    : 0x2b67,
    SONG_ITALY_CARELESS_WHISPER                  : 0x36f7,
    SONG_ITALY_ROUND_ROUND                       : 0x2d93,
    SONG_ITALY_YMCA                              : 0x2721,
    SONG_ITALY_CRASHED_THE_WEDDING               : 0x235b,
    SONG_ITALY_COMPLICATED                       : 0x30ab,
    SONG_ITALY_LIVIN_LA_VIDA_LOCA                : 0x2bbf,
    SONG_ITALY_DONT_STOP_MOVIN                   : 0x2ce1,
    SONG_ITALY_SUPERSTAR                         : 0x2929,
    SONG_ITALY_NUOVA_OSSESSIONE                  : 0x2efd,
    SONG_ITALY_I_BELIEVE_IN_A_THING_CALLED_LOVE  : 0x2c73,
    SONG_ITALY_ONE_LOVE                          : 0x2809,
    SONG_ITALY_ETERNAL_FLAME                     : 0x2413,
    SONG_ITALY_SALIRO                            : 0x2deb,
    SONG_ITALY_VAMOS_A_BAILAR                    : 0x2ded,
    SONG_ITALY_IN_UN_ISTANTE                     : 0x2fab,

    SONG_SPAIN_I_BELIEVE_IN_A_THING_CALLED_LOVE  : 0x2c73,
    SONG_SPAIN_DIME                              : 0x230d,
    SONG_SPAIN_DOWN                              : 0x2d9b,
    SONG_SPAIN_TAKE_ON_ME                        : 0x2b13,
    SONG_SPAIN_NOCHE_EN_VELA                     : 0x2b89,
    SONG_SPAIN_OH_PRETTY_WOMAN                   : 0x22f9,
    SONG_SPAIN_BYE_BYE                           : 0x2bd5,
    SONG_SPAIN_20_DE_ENERO                       : 0x2b53,
    SONG_SPAIN_CARELESS_WHISPER                  : 0x36f7,
    SONG_SPAIN_COMPLICATED                       : 0x30ab,
    SONG_SPAIN_CRASHED_THE_WEDDING               : 0x235b,
    SONG_SPAIN_LIKE_A_VIRGIN                     : 0x2bef,
    SONG_SPAIN_HOY                               : 0x27b5,
    SONG_SPAIN_SIN_DOCUMENTOS                    : 0x2fa7,
    SONG_SPAIN_PUEDES_CONTAR_CONMIGO             : 0x2e3d,
    SONG_SPAIN_ROUND_ROUND                       : 0x2d93,
    SONG_SPAIN_EN_EL_2000                        : 0x2a0b,
    SONG_SPAIN_THANK_YOU                         : 0x2583,
    SONG_SPAIN_LIVIN_LA_VIDA_LOCA                : 0x2b11,
    SONG_SPAIN_SOLO_SE_VIVE_UNA_VEZ              : 0x28d7,
    SONG_SPAIN_SUSPICIOUS_MINDS                  : 0x2bdd,
    SONG_SPAIN_MI_GATO                           : 0x25c3,
    SONG_SPAIN_GIRLS_AND_BOYS                    : 0x2425,
    SONG_SPAIN_A_DIOS_LE_PIDO                    : 0x27b1,
    SONG_SPAIN_YMCA                              : 0x2721,
    SONG_SPAIN_GET_THE_PARTY_STARTED             : 0x2533,
    SONG_SPAIN_LO_NOTO                           : 0x2dab,
    SONG_SPAIN_ETERNAL_FLAME                     : 0x2413,
    SONG_SPAIN_NO_TE_ESCAPARAS                   : 0x24bf,
    SONG_SPAIN_SUPERSTAR                         : 0x2929
}

function format_song_length(song_length) {
    minutes = song_length / 3000
    seconds = song_length % 3000 / 50
    if (seconds < 10) {
        seconds = "0" + seconds
    }
    return minutes + ":" + seconds
}

SONG_TO_LENGTH_FORMATTED = {}
for song in SONG_TO_LENGTH {
    SONG_TO_LENGTH_FORMATTED[song] = format_song_length(SONG_TO_LENGTH[song])
}

SONG_TO_SHORT_LENGTH = {
    SONG_FRANCE_WORLD_OF_OUR_OWN                 : 0x179b,
    SONG_FRANCE_MURDER_ON_THE_DANCEFLOOR         : 0x1aff,
    SONG_FRANCE_THANK_YOU                        : 0x1361,
    SONG_FRANCE_GET_THE_PARTY_STARTED            : 0x138b,
    SONG_FRANCE_SCANDALOUS                       : 0x1535,
    SONG_FRANCE_LIKE_A_VIRGIN                    : 0x1b81,
    SONG_FRANCE_NEVER_GONNA_GIVE_YOU_UP          : 0x179d,
    SONG_FRANCE_OH_PRETTY_WOMAN                  : 0x1a5f,
    SONG_FRANCE_GROOVE_IS_IN_THE_HEART           : 0x182b,
    SONG_FRANCE_JUST_A_LITTLE                    : 0x1cdf,
    SONG_FRANCE_TAKE_ON_ME                       : 0x16c1,
    SONG_FRANCE_KUNG_FU_FIGHTING                 : 0x174d,
    SONG_FRANCE_SUSPICIOUS_MINDS                 : 0x152f,
    SONG_FRANCE_HEART_OF_GLASS                   : 0x16df,
    SONG_FRANCE_CARELESS_WHISPER                 : 0x1c19,
    SONG_FRANCE_YMCA                             : 0x1b55,
    SONG_FRANCE_COMPLICATED                      : 0x1f7f,
    SONG_FRANCE_LIVIN_LA_VIDA_LOCA               : 0x1069,
    SONG_FRANCE_DONT_STOP_MOVIN                  : 0x10ff,
    SONG_FRANCE_SUPERSTAR                        : 0x180f,
    SONG_FRANCE_I_BELIEVE_IN_A_THING_CALLED_LOVE : 0x18a1,
    SONG_FRANCE_ONE_LOVE                         : 0x1bbb,
    SONG_FRANCE_ETERNAL_FLAME                    : 0x16b5,
    SONG_FRANCE_ENSEMBLE                         : 0x1081,
    SONG_FRANCE_HEY_OH                           : 0x142d,
    SONG_FRANCE_TU_SERAS                         : 0x128f,
    SONG_FRANCE_SI_CEST_BON_COMME_CA             : 0x193b,
    SONG_FRANCE_MAGDALENA                        : 0x13af,
    SONG_FRANCE_CEST_QUAND_LE_BONHEUR            : 0x11c1,
    SONG_FRANCE_VOTRE_IMAGE                      : 0x1cb9,

    SONG_GERMANY_MURDER_ON_THE_DANCEFLOOR        : 0x1aff,
    SONG_GERMANY_THANK_YOU                       : 0x1361,
    SONG_GERMANY_GET_THE_PARTY_STARTED           : 0x138b,
    SONG_GERMANY_ACE_OF_SPADES                   : 0x1235,
    SONG_GERMANY_DOWNTOWN                        : 0x16a7,
    SONG_GERMANY_LIKE_A_VIRGIN                   : 0x1b81,
    SONG_GERMANY_NEVER_GONNA_GIVE_YOU_UP         : 0x179d,
    SONG_GERMANY_OH_PRETTY_WOMAN                 : 0x1a5f,
    SONG_GERMANY_TAKE_ON_ME                      : 0x16c1,
    SONG_GERMANY_KUNG_FU_FIGHTING                : 0x174d,
    SONG_GERMANY_SUSPICIOUS_MINDS                : 0x152f,
    SONG_GERMANY_CARELESS_WHISPER                : 0x1c19,
    SONG_GERMANY_ROUND_ROUND                     : 0x1de7,
    SONG_GERMANY_SIE_IST_WEG                     : 0x1ad9,
    SONG_GERMANY_YMCA                            : 0x1b55,
    SONG_GERMANY_COMPLICATED                     : 0x1f7f,
    SONG_GERMANY_LIVIN_LA_VIDA_LOCA              : 0x1069,
    SONG_GERMANY_DONT_STOP_MOVIN                 : 0x10ff,
    SONG_GERMANY_SUPERSTAR                       : 0x180f,
    SONG_GERMANY_DEEPER_UNDERGROUND              : 0x169f,
    SONG_GERMANY_ONE_LOVE                        : 0x1bbb,
    SONG_GERMANY_ETERNAL_FLAME                   : 0x16b5,
    SONG_GERMANY_MAJOR_TOM                       : 0x1211,
    SONG_GERMANY_ROCK_ME_AMADEUS                 : 0x1651,
    SONG_GERMANY_5_DAYS                          : 0x13d3,
    SONG_GERMANY_DO_YOU                          : 0x1a81,
    SONG_GERMANY_STEH_AUF_WENN_DU_AM_BODEN_BIST  : 0x123f,
    SONG_GERMANY_SOMEDAY                         : 0x1c23,
    SONG_GERMANY_THREE_LIONS                     : 0x1a1b,
    SONG_GERMANY_BILDER_VON_DIR                  : 0x1b03,

    SONG_ITALY_WORLD_OF_OUR_OWN                  : 0x179b,
    SONG_ITALY_MURDER_ON_THE_DANCEFLOOR          : 0x1aff,
    SONG_ITALY_THANK_YOU                         : 0x1361,
    SONG_ITALY_GET_THE_PARTY_STARTED             : 0x138b,
    SONG_ITALY_SCANDALOUS                        : 0x1535,
    SONG_ITALY_ACE_OF_SPADES                     : 0x1235,
    SONG_ITALY_LIKE_A_VIRGIN                     : 0x1b81,
    SONG_ITALY_NEVER_GONNA_GIVE_YOU_UP           : 0x179d,
    SONG_ITALY_OH_PRETTY_WOMAN                   : 0x1a5f,
    SONG_ITALY_GROOVE_IS_IN_THE_HEART            : 0x182b,
    SONG_ITALY_JUST_A_LITTLE                     : 0x1cdf,
    SONG_ITALY_EGOISTA                           : 0x15bb,
    SONG_ITALY_TAKE_ON_ME                        : 0x16c1,
    SONG_ITALY_SUSPICIOUS_MINDS                  : 0x152f,
    SONG_ITALY_HEART_OF_GLASS                    : 0x16df,
    SONG_ITALY_CARELESS_WHISPER                  : 0x1c19,
    SONG_ITALY_ROUND_ROUND                       : 0x1de7,
    SONG_ITALY_YMCA                              : 0x1b55,
    SONG_ITALY_CRASHED_THE_WEDDING               : 0x188b,
    SONG_ITALY_COMPLICATED                       : 0x1f7f,
    SONG_ITALY_LIVIN_LA_VIDA_LOCA                : 0x1069,
    SONG_ITALY_DONT_STOP_MOVIN                   : 0x10ff,
    SONG_ITALY_SUPERSTAR                         : 0x180f,
    SONG_ITALY_NUOVA_OSSESSIONE                  : 0x11c3,
    SONG_ITALY_I_BELIEVE_IN_A_THING_CALLED_LOVE  : 0x18a1,
    SONG_ITALY_ONE_LOVE                          : 0x1bbb,
    SONG_ITALY_ETERNAL_FLAME                     : 0x16b5,
    SONG_ITALY_SALIRO                            : 0x1c2d,
    SONG_ITALY_VAMOS_A_BAILAR                    : 0x103f,
    SONG_ITALY_IN_UN_ISTANTE                     : 0x136d,

    SONG_SPAIN_I_BELIEVE_IN_A_THING_CALLED_LOVE  : 0x18a1,
    SONG_SPAIN_DIME                              : 0x1af1,
    SONG_SPAIN_DOWN                              : 0x1de7,
    SONG_SPAIN_TAKE_ON_ME                        : 0x16c1,
    SONG_SPAIN_NOCHE_EN_VELA                     : 0x1895,
    SONG_SPAIN_OH_PRETTY_WOMAN                   : 0x1a5f,
    SONG_SPAIN_BYE_BYE                           : 0x1de5,
    SONG_SPAIN_20_DE_ENERO                       : 0x145f,
    SONG_SPAIN_CARELESS_WHISPER                  : 0x1c19,
    SONG_SPAIN_COMPLICATED                       : 0x1f7f,
    SONG_SPAIN_CRASHED_THE_WEDDING               : 0x188b,
    SONG_SPAIN_LIKE_A_VIRGIN                     : 0x1b81,
    SONG_SPAIN_HOY                               : 0x1297,
    SONG_SPAIN_SIN_DOCUMENTOS                    : 0x1677,
    SONG_SPAIN_PUEDES_CONTAR_CONMIGO             : 0x1167,
    SONG_SPAIN_ROUND_ROUND                       : 0x1de7,
    SONG_SPAIN_EN_EL_2000                        : 0x186f,
    SONG_SPAIN_THANK_YOU                         : 0x1361,
    SONG_SPAIN_LIVIN_LA_VIDA_LOCA                : 0x101f,
    SONG_SPAIN_SOLO_SE_VIVE_UNA_VEZ              : 0x18c5,
    SONG_SPAIN_SUSPICIOUS_MINDS                  : 0x152f,
    SONG_SPAIN_MI_GATO                           : 0x1a27,
    SONG_SPAIN_GIRLS_AND_BOYS                    : 0x125d,
    SONG_SPAIN_A_DIOS_LE_PIDO                    : 0x157b,
    SONG_SPAIN_YMCA                              : 0x1b55,
    SONG_SPAIN_GET_THE_PARTY_STARTED             : 0x138b,
    SONG_SPAIN_LO_NOTO                           : 0x1541,
    SONG_SPAIN_ETERNAL_FLAME                     : 0x16b5,
    SONG_SPAIN_NO_TE_ESCAPARAS                   : 0x1661,
    SONG_SPAIN_SUPERSTAR                         : 0x180f
}

SONG_TO_SHORT_LENGTH_FORMATTED = {}
for song in SONG_TO_SHORT_LENGTH {
    SONG_TO_SHORT_LENGTH_FORMATTED[song] = format_song_length(SONG_TO_SHORT_LENGTH[song])
}

ACHIEVEMENT_INFO = {
    SONG_FRANCE_ENSEMBLE: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 8160,
        "EasyAchievementName": "Chacun Son Pain",
        "EasyAchievementId": 465077,
        "HardScoreRecord": 7440,
        "HardAchievementName": "Il Faut Qu'on S'y Mette Ensemble",
        "HardAchievementId": 465078,
        "PhraseCount": 48,
        "PhraseCountAchievementName": "L'Argent Fait Vivre Mais Ne Fait Pas L'Bonheur",
        "PhraseCountAchievementId": 465079,
        "NormalLengthLeaderboardIds": [117989, 117991, 117993],
        "ShortLengthLeaderboardIds": [117990, 117992, 117994],
    },
    SONG_FRANCE_HEY_OH: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 7980,
        "EasyAchievementName": "Est-ce Que Tu M'Entends",
        "EasyAchievementId": 465083,
        "HardScoreRecord": 7260,
        "HardAchievementName": "Juste Un Signe Suffira",
        "HardAchievementId": 465084,
        "PhraseCount": 79,
        "PhraseCountAchievementName": "Et Celui Qui S'Acharnera",
        "PhraseCountAchievementId": 465085,
        "NormalLengthLeaderboardIds": [118001, 118003, 118005],
        "ShortLengthLeaderboardIds": [118002, 118004, 118006],
    },
    SONG_FRANCE_TU_SERAS: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 8640,
        "EasyAchievementName": "La Première Chance Qu'on A",
        "EasyAchievementId": 465068,
        "HardScoreRecord": 7920,
        "HardAchievementName": "L'Amour à Tous Les Temps",
        "HardAchievementId": 465069,
        "PhraseCount": 73,
        "PhraseCountAchievementName": "On a Bien Inscrit Dans Ton CœUr D'Oiseau",
        "PhraseCountAchievementId": 465070,
        "NormalLengthLeaderboardIds": [117971, 117973, 117975],
        "ShortLengthLeaderboardIds": [117972, 117974, 117976],
    },
    SONG_FRANCE_SI_CEST_BON_COMME_CA: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 7590,
        "EasyAchievementName": "Quand Tout Se Mélange",
        "EasyAchievementId": 465074,
        "HardScoreRecord": 6870,
        "HardAchievementName": "Mais en Dépensent Pourtant",
        "HardAchievementId": 465075,
        "PhraseCount": 50,
        "PhraseCountAchievementName": "Il Aime Se Débrouiller",
        "PhraseCountAchievementId": 465076,
        "NormalLengthLeaderboardIds": [117983, 117985, 117987],
        "ShortLengthLeaderboardIds": [117984, 117986, 117988],
    },
    SONG_FRANCE_MAGDALENA: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 8550,
        "EasyAchievementName": "Dans Sa Robe de Soie Tu la Reverras",
        "EasyAchievementId": 465071,
        "HardScoreRecord": 7830,
        "HardAchievementName": "Elle Ne Les Oubliera Pas",
        "HardAchievementId": 465072,
        "PhraseCount": 48,
        "PhraseCountAchievementName": "Le Coeur à Fleur de Peau Tu T'es Dis Pourquoi Pas?",
        "PhraseCountAchievementId": 465073,
        "NormalLengthLeaderboardIds": [117977, 117979, 117981],
        "ShortLengthLeaderboardIds": [117978, 117980, 117982],
    },
    SONG_FRANCE_CEST_QUAND_LE_BONHEUR: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 8460,
        "EasyAchievementName": "Espérant Le Oui",
        "EasyAchievementId": 465065,
        "HardScoreRecord": 7740,
        "HardAchievementName": "Peut-être Demain la Petite Fleur Qui Va Naître",
        "HardAchievementId": 465066,
        "PhraseCount": 66,
        "PhraseCountAchievementName": "Je Viens de Conquérir Son Coeur Mais C'est Louche",
        "PhraseCountAchievementId": 465067,
        "NormalLengthLeaderboardIds": [117965, 117967, 117969],
        "ShortLengthLeaderboardIds": [117966, 117968, 117970],
    },
    SONG_FRANCE_VOTRE_IMAGE: {
        "Region": REGION_FRANCE,
        "EasyScoreRecord": 8070,
        "EasyAchievementName": "Je Vous Avoue Rein Ne Sert de Mentir",
        "EasyAchievementId": 465080,
        "HardScoreRecord": 7350,
        "HardAchievementName": "Parfois Je Sens Monter Assez de Courage",
        "HardAchievementId": 465081,
        "PhraseCount": 82,
        "PhraseCountAchievementName": "Ce S'Rait Si Beau",
        "PhraseCountAchievementId": 465082,
        "NormalLengthLeaderboardIds": [117995, 117997, 117999],
        "ShortLengthLeaderboardIds": [117996, 117998, 118000],
    },
    SONG_GERMANY_SIE_IST_WEG: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 7750,
        "EasyAchievementName": "Drum Lass Das Gejammer Sein, Denn So Ist Es",
        "EasyAchievementId": 465095,
        "HardScoreRecord": 7030,
        "HardAchievementName": "Das Ist Krass, Dass Ich Dachte, Ich Verpass' Was",
        "HardAchievementId": 465096,
        "PhraseCount": 115,
        "PhraseCountAchievementName": "Wir Waren Beide Verdammt Cool",
        "PhraseCountAchievementId": 465097,
        "NormalLengthLeaderboardIds": [118025, 118027, 118029],
        "ShortLengthLeaderboardIds": [118026, 118028, 118030],
    },
    SONG_GERMANY_DEEPER_UNDERGROUND: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 8710,
        "EasyAchievementName": "I Get Nervous in the New York City Streets",
        "EasyAchievementId": 465104,
        "HardScoreRecord": 7990,
        "HardAchievementName": "I Know I'm Better off Standing in the Shadows",
        "HardAchievementId": 465105,
        "PhraseCount": 58,
        "PhraseCountAchievementName": "Take a Pleasure in Destruction of the Very Thing",
        "PhraseCountAchievementId": 465106,
        "NormalLengthLeaderboardIds": [118043, 118045, 118047],
        "ShortLengthLeaderboardIds": [118044, 118046, 118048],
    },
    SONG_GERMANY_MAJOR_TOM: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 7590,
        "EasyAchievementName": "Gründlich Durchgecheckt Steht Sie Da",
        "EasyAchievementId": 465107,
        "HardScoreRecord": 6870,
        "HardAchievementName": "Jeder Weiß Genau, Was von Ihm Abhängt",
        "HardAchievementId": 465108,
        "PhraseCount": 75,
        "PhraseCountAchievementName": "Mich Führt Hier Ein Licht Durch Das All",
        "PhraseCountAchievementId": 465109,
        "NormalLengthLeaderboardIds": [118049, 118051, 118053],
        "ShortLengthLeaderboardIds": [118050, 118052, 118054],
    },
    SONG_GERMANY_ROCK_ME_AMADEUS: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 7500,
        "EasyAchievementName": "Er War Ein Punker Und Er Lebte in Der Großen Stadt",
        "EasyAchievementId": 465110,
        "HardScoreRecord": 6780,
        "HardAchievementName": "Er War So Exaltiert, Because Er Hatte Flair",
        "HardAchievementId": 465111,
        "PhraseCount": 64,
        "PhraseCountAchievementName": "Woher Die Schulden Kamen, War Wohl Jedermann Bekannt",
        "PhraseCountAchievementId": 465112,
        "NormalLengthLeaderboardIds": [118055, 118057, 118059],
        "ShortLengthLeaderboardIds": [118056, 118058, 118060],
    },
    SONG_GERMANY_5_DAYS: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 8160,
        "EasyAchievementName": "It Was a Little Bit of Magic",
        "EasyAchievementId": 465086,
        "HardScoreRecord": 7440,
        "HardAchievementName": "She Took Me to Another Side",
        "HardAchievementId": 465087,
        "PhraseCount": 84,
        "PhraseCountAchievementName": "Where She Touched My Soul When I Touched Her Lips",
        "PhraseCountAchievementId": 465088,
        "NormalLengthLeaderboardIds": [118007, 118009, 118011],
        "ShortLengthLeaderboardIds": [118008, 118010, 118012],
    },
    SONG_GERMANY_DO_YOU: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 8070,
        "EasyAchievementName": "I'm the One to Decide If What I Do Is Cool",
        "EasyAchievementId": 465089,
        "HardScoreRecord": 7350,
        "HardAchievementName": "If I Don't Like Something, I'll Be Quick to Let You Know",
        "HardAchievementId": 465090,
        "PhraseCount": 91,
        "PhraseCountAchievementName": "If I See Something That I Like, I Go and Grab It",
        "PhraseCountAchievementId": 465091,
        "NormalLengthLeaderboardIds": [118013, 118015, 118017],
        "ShortLengthLeaderboardIds": [118014, 118016, 118018],
    },
    SONG_GERMANY_STEH_AUF_WENN_DU_AM_BODEN_BIST: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 7980,
        "EasyAchievementName": "Schmeiß Jetzt Nicht Alles Hin",
        "EasyAchievementId": 465092,
        "HardScoreRecord": 7260,
        "HardAchievementName": "Halt Dein Gesicht Einfach Gegen Den Wind",
        "HardAchievementId": 465093,
        "PhraseCount": 51,
        "PhraseCountAchievementName": "Du Brauchst Hier Keinem Irgendeinen Beweis Zu Bringen",
        "PhraseCountAchievementId": 465094,
        "NormalLengthLeaderboardIds": [118019, 118021, 118023],
        "ShortLengthLeaderboardIds": [118020, 118022, 118024],
    },
    SONG_GERMANY_SOMEDAY: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 8640,
        "EasyAchievementName": "I'm Not the One Who Walks Away That Easily",
        "EasyAchievementId": 465113,
        "HardScoreRecord": 7920,
        "HardAchievementName": "There Could Be a Miracle",
        "HardAchievementId": 465114,
        "PhraseCount": 66,
        "PhraseCountAchievementName": "I Truely Think That Love Is Blind",
        "PhraseCountAchievementId": 465115,
        "NormalLengthLeaderboardIds": [118061, 118063, 118065],
        "ShortLengthLeaderboardIds": [118062, 118064, 118066],
    },
    SONG_GERMANY_THREE_LIONS: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 8550,
        "EasyAchievementName": "It's Coming Home",
        "EasyAchievementId": 465098,
        "HardScoreRecord": 7830,
        "HardAchievementName": "I Know They Can Play, 'Cause I Remember",
        "HardAchievementId": 465099,
        "PhraseCount": 53,
        "PhraseCountAchievementName": "So Many Jokes, So Many Sneers",
        "PhraseCountAchievementId": 465100,
        "NormalLengthLeaderboardIds": [118031, 118033, 118035],
        "ShortLengthLeaderboardIds": [118032, 118034, 118036],
    },
    SONG_GERMANY_BILDER_VON_DIR: {
        "Region": REGION_GERMANY,
        "EasyScoreRecord": 8460,
        "EasyAchievementName": "Meine Worte Hüllt in Schweigen",
        "EasyAchievementId": 465101,
        "HardScoreRecord": 7740,
        "HardAchievementName": "Worte Sind Wie Pulver",
        "HardAchievementId": 465102,
        "PhraseCount": 59,
        "PhraseCountAchievementName": "Die Luft Ist Voll von Dir",
        "PhraseCountAchievementId": 465103,
        "NormalLengthLeaderboardIds": [118037, 118039, 118041],
        "ShortLengthLeaderboardIds": [118038, 118040, 118042],
    },
    SONG_ITALY_EGOISTA: {
        "Region": REGION_ITALY,
        "EasyScoreRecord": 7180,
        "EasyAchievementName": "Avessi Un Male Che Ti Toglie Il Fiato",
        "EasyAchievementId": 465116,
        "HardScoreRecord": 6460,
        "HardAchievementName": "Io Resto Vigile Poi Tanto Il Resto Vien Da Sé",
        "HardAchievementId": 465117,
        "PhraseCount": 68,
        "PhraseCountAchievementName": "Tu Non Puoi Pretendere Di Avere Tutto Quanto per Te",
        "PhraseCountAchievementId": 465118,
        "NormalLengthLeaderboardIds": [118067, 118069, 118071],
        "ShortLengthLeaderboardIds": [118068, 118070, 118072],
    },
    SONG_ITALY_NUOVA_OSSESSIONE: {
        "Region": REGION_ITALY,
        "EasyScoreRecord": 7500,
        "EasyAchievementName": "Ti Cerco in Tutti I Canali",
        "EasyAchievementId": 465122,
        "HardScoreRecord": 6780,
        "HardAchievementName": "Ormai Mi Pulsi Dentro",
        "HardAchievementId": 465123,
        "PhraseCount": 98,
        "PhraseCountAchievementName": "La Macchia Sporca, la Mia Distrazione",
        "PhraseCountAchievementId": 465124,
        "NormalLengthLeaderboardIds": [118079, 118081, 118083],
        "ShortLengthLeaderboardIds": [118080, 118082, 118084],
    },
    SONG_ITALY_SALIRO: {
        "Region": REGION_ITALY,
        "EasyScoreRecord": 8640,
        "EasyAchievementName": "Fra Le Rose Di Questo Giardino",
        "EasyAchievementId": 465125,
        "HardScoreRecord": 7920,
        "HardAchievementName": "Scotto Come Il Tagliolino Al Pesto Che Ho Mangiato",
        "HardAchievementId": 465126,
        "PhraseCount": 85,
        "PhraseCountAchievementName": "Amore in Fondo Non C'è Niente Da Rifare",
        "PhraseCountAchievementId": 465127,
        "NormalLengthLeaderboardIds": [118085, 118087, 118089],
        "ShortLengthLeaderboardIds": [118086, 118088, 118090],
    },
    SONG_ITALY_VAMOS_A_BAILAR: {
        "Region": REGION_ITALY,
        "EasyScoreRecord": 8550,
        "EasyAchievementName": "Eri Un'Ombra Su Di Me",
        "EasyAchievementId": 465128,
        "HardScoreRecord": 7830,
        "HardAchievementName": "Non Ho Più Niente Da Perdere, Solo Te",
        "HardAchievementId": 465129,
        "PhraseCount": 63,
        "PhraseCountAchievementName": "È Una Luce Che Mi Dà Libertà",
        "PhraseCountAchievementId": 465130,
        "NormalLengthLeaderboardIds": [118091, 118093, 118095],
        "ShortLengthLeaderboardIds": [118092, 118094, 118096],
    },
    SONG_ITALY_IN_UN_ISTANTE: {
        "Region": REGION_ITALY,
        "EasyScoreRecord": 8460,
        "EasyAchievementName": "Ti Senti Diversa Da Come Facevi Tu",
        "EasyAchievementId": 465119,
        "HardScoreRecord": 7740,
        "HardAchievementName": "Che Strano Il Rapporto Che Adesso C'è",
        "HardAchievementId": 465120,
        "PhraseCount": 84,
        "PhraseCountAchievementName": "Ma Lo Sento Che Fanno Del Male, Del Male Così",
        "PhraseCountAchievementId": 465121,
        "NormalLengthLeaderboardIds": [118073, 118075, 118077],
        "ShortLengthLeaderboardIds": [118074, 118076, 118078],
    },
    SONG_SPAIN_DIME: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7750,
        "EasyAchievementName": "Todo Vuelve a Ser Como Era Entonces",
        "EasyAchievementId": 465143,
        "HardScoreRecord": 7030,
        "HardAchievementName": "Por Mis Recuerdos Yo Vuelvo y No Pierdo la Fe",
        "HardAchievementId": 465144,
        "PhraseCount": 50,
        "PhraseCountAchievementName": "Vamos a Olvidar El Ayer y a Comenzar Otra Vez",
        "PhraseCountAchievementId": 465145,
        "NormalLengthLeaderboardIds": [118121, 118123, 118125],
        "ShortLengthLeaderboardIds": [118122, 118124, 118126],
    },
    SONG_SPAIN_DOWN: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8460,
        "EasyAchievementName": "Dentro de Mi Cabeza Vive Un Humano Tarao",
        "EasyAchievementId": 465158,
        "HardScoreRecord": 7740,
        "HardAchievementName": "Niña, Tu Moving Down No Se Puede Aguantar",
        "HardAchievementId": 465159,
        "PhraseCount": 46,
        "PhraseCountAchievementName": "Down, Do-Down, Do-Down, Down",
        "PhraseCountAchievementId": 465160,
        "NormalLengthLeaderboardIds": [118151, 118153, 118155],
        "ShortLengthLeaderboardIds": [118152, 118154, 118156],
    },
    SONG_SPAIN_NOCHE_EN_VELA: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8550,
        "EasyAchievementName": "Cuánto Tiempo He de Esperar Para Tenerte Bajo la Luna",
        "EasyAchievementId": 465155,
        "HardScoreRecord": 7830,
        "HardAchievementName": "No Quedan Luces en El Puerto",
        "HardAchievementId": 465156,
        "PhraseCount": 84,
        "PhraseCountAchievementName": "La Distancia Es El Olvido",
        "PhraseCountAchievementId": 465157,
        "NormalLengthLeaderboardIds": [118145, 118147, 118149],
        "ShortLengthLeaderboardIds": [118146, 118148, 118150],
    },
    SONG_SPAIN_BYE_BYE: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7660,
        "EasyAchievementName": "Preciso de Un O'Do Que Me Ayude a Olvidar",
        "EasyAchievementId": 465146,
        "HardScoreRecord": 6940,
        "HardAchievementName": "Se Apoderó de Mis Secretos y Me Hizo Enloquecer",
        "HardAchievementId": 465147,
        "PhraseCount": 54,
        "PhraseCountAchievementName": "Me Dejó Más Solo Que Un Desierto",
        "PhraseCountAchievementId": 465148,
        "NormalLengthLeaderboardIds": [118127, 118129, 118131],
        "ShortLengthLeaderboardIds": [118128, 118130, 118132],
    },
    SONG_SPAIN_20_DE_ENERO: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7500,
        "EasyAchievementName": "Dibujé Tu Sonrisa Junto a la Mía",
        "EasyAchievementId": 465131,
        "HardScoreRecord": 6780,
        "HardAchievementName": "Me Pregunté Que Sería Sin Ti El Resto de Mi Vida",
        "HardAchievementId": 465132,
        "PhraseCount": 54,
        "PhraseCountAchievementName": "Era Un Poema de Amor Para Viajar",
        "PhraseCountAchievementId": 465133,
        "NormalLengthLeaderboardIds": [118097, 118099, 118101],
        "ShortLengthLeaderboardIds": [118098, 118100, 118102],
    },
    SONG_SPAIN_HOY: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7590,
        "EasyAchievementName": "Tengo Una Fe Que Madura",
        "EasyAchievementId": 465173,
        "HardScoreRecord": 6870,
        "HardAchievementName": "Mis Ganas de Revivir",
        "HardAchievementId": 465174,
        "PhraseCount": 56,
        "PhraseCountAchievementName": "Tengo Una Playa y Un Pueblo Que Me Acompañan de Noche",
        "PhraseCountAchievementId": 465175,
        "NormalLengthLeaderboardIds": [118181, 118183, 118185],
        "ShortLengthLeaderboardIds": [118182, 118184, 118186],
    },
    SONG_SPAIN_SIN_DOCUMENTOS: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8160,
        "EasyAchievementName": "No Tengo Más Intenciones Que Seguir",
        "EasyAchievementId": 465134,
        "HardScoreRecord": 7440,
        "HardAchievementName": "Quiero Saber Que la Vida Contigo No Va a Terminar",
        "HardAchievementId": 465135,
        "PhraseCount": 67,
        "PhraseCountAchievementName": "Porque Sí, Porque Sí, Porque Sí",
        "PhraseCountAchievementId": 465136,
        "NormalLengthLeaderboardIds": [118103, 118105, 118107],
        "ShortLengthLeaderboardIds": [118104, 118106, 118108],
    },
    SONG_SPAIN_PUEDES_CONTAR_CONMIGO: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8480,
        "EasyAchievementName": "Un Café Con Sal, Ganas de Llorar",
        "EasyAchievementId": 465149,
        "HardScoreRecord": 7760,
        "HardAchievementName": "Nunca Hubo Maldad, Solo Ingenuidad",
        "HardAchievementId": 465150,
        "PhraseCount": 68,
        "PhraseCountAchievementName": "La Vida Pasaba y Yo Sentía Que Me Iba a Morir de Amor",
        "PhraseCountAchievementId": 465151,
        "NormalLengthLeaderboardIds": [118133, 118135, 118137],
        "ShortLengthLeaderboardIds": [118134, 118136, 118138],
    },
    SONG_SPAIN_EN_EL_2000: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8070,
        "EasyAchievementName": "Ni Un Tonto Loco Que Sea Baboso",
        "EasyAchievementId": 465137,
        "HardScoreRecord": 7350,
        "HardAchievementName": "Si Ven a Ricky Martin en Revistas Lo Recortan",
        "HardAchievementId": 465138,
        "PhraseCount": 72,
        "PhraseCountAchievementName": "No Tengo Un Hombre Ni a Gael García",
        "PhraseCountAchievementId": 465139,
        "NormalLengthLeaderboardIds": [118109, 118111, 118113],
        "ShortLengthLeaderboardIds": [118110, 118112, 118114],
    },
    SONG_SPAIN_LIVIN_LA_VIDA_LOCA: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8640,
        "EasyAchievementName": "La Reina de la Noche",
        "EasyAchievementId": 465152,
        "HardScoreRecord": 7920,
        "HardAchievementName": "Es El Beso de Calor",
        "HardAchievementId": 465153,
        "PhraseCount": 61,
        "PhraseCountAchievementName": "Tú Te Dejas Arrastrar",
        "PhraseCountAchievementId": 465154,
        "NormalLengthLeaderboardIds": [118139, 118141, 118143],
        "ShortLengthLeaderboardIds": [118140, 118142, 118144],
    },
    SONG_SPAIN_SOLO_SE_VIVE_UNA_VEZ: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8800,
        "EasyAchievementName": "Siente Unas Cosquillitas Por Los Pies",
        "EasyAchievementId": 465161,
        "HardScoreRecord": 8080,
        "HardAchievementName": "Suelta El Pelo a la Pasión",
        "HardAchievementId": 465162,
        "PhraseCount": 69,
        "PhraseCountAchievementName": "No Te Dejes Convencer",
        "PhraseCountAchievementId": 465163,
        "NormalLengthLeaderboardIds": [118157, 118159, 118161],
        "ShortLengthLeaderboardIds": [118158, 118160, 118162],
    },
    SONG_SPAIN_MI_GATO: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7680,
        "EasyAchievementName": "Gritan Mi Nombre",
        "EasyAchievementId": 465170,
        "HardScoreRecord": 6960,
        "HardAchievementName": "La Diferencia Entre El Bien Y El Mal",
        "HardAchievementId": 465171,
        "PhraseCount": 45,
        "PhraseCountAchievementName": "Ay Ay Ay Ay Ay Ay Ay Ay Ay Ay Ay",
        "PhraseCountAchievementId": 465172,
        "NormalLengthLeaderboardIds": [118175, 118177, 118179],
        "ShortLengthLeaderboardIds": [118176, 118178, 118180],
    },
    SONG_SPAIN_A_DIOS_LE_PIDO: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 8710,
        "EasyAchievementName": "Que Mis Ojos Se Despierten Con la Luz de Tu Mirada",
        "EasyAchievementId": 465164,
        "HardScoreRecord": 7990,
        "HardAchievementName": "Que Si Me Muero Sea de Amor",
        "HardAchievementId": 465165,
        "PhraseCount": 62,
        "PhraseCountAchievementName": "Que Mi Alma No Descanse Cuando de Amarte Se Trate",
        "PhraseCountAchievementId": 465166,
        "NormalLengthLeaderboardIds": [118163, 118165, 118167],
        "ShortLengthLeaderboardIds": [118164, 118166, 118168],
    },
    SONG_SPAIN_LO_NOTO: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7980,
        "EasyAchievementName": "Me Está Matando Poco a Poco",
        "EasyAchievementId": 465140,
        "HardScoreRecord": 7260,
        "HardAchievementName": "Puedo Ser Un Cabrón Pero No Un Tonto",
        "HardAchievementId": 465141,
        "PhraseCount": 47,
        "PhraseCountAchievementName": "Ya Se Va Acabando El Aire Entre Nosotros",
        "PhraseCountAchievementId": 465142,
        "NormalLengthLeaderboardIds": [118115, 118117, 118119],
        "ShortLengthLeaderboardIds": [118116, 118118, 118120],
    },
    SONG_SPAIN_NO_TE_ESCAPARAS: {
        "Region": REGION_SPAIN,
        "EasyScoreRecord": 7020,
        "EasyAchievementName": "Estoy Muy Alto de Moral",
        "EasyAchievementId": 465167,
        "HardScoreRecord": 6300,
        "HardAchievementName": "Estoy Mejor Que Bien",
        "HardAchievementId": 465168,
        "PhraseCount": 41,
        "PhraseCountAchievementName": "Te Vas a Sorprender",
        "PhraseCountAchievementId": 465169,
        "NormalLengthLeaderboardIds": [118169, 118171, 118173],
        "ShortLengthLeaderboardIds": [118170, 118172, 118174],
    }
}

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

for song_id in ACHIEVEMENT_INFO {
    region = ACHIEVEMENT_INFO[song_id]["Region"]
    region_name = REGION_TO_SHORT_NAME[region]
    song_name = SONG_TO_NAME[song_id]

    easy_score = ACHIEVEMENT_INFO[song_id]["EasyScoreRecord"]
    achievement(
        title = format("[{0}] {1}", region_name, ACHIEVEMENT_INFO[song_id]["EasyAchievementName"]),
        points = 5,
        id = ACHIEVEMENT_INFO[song_id]["EasyAchievementId"],
        description = format("Achieve a score of {0} or more on {1} (normal length) on any difficulty in Sing Mode", format_int_with_commas(easy_score), song_name),
        trigger = (
            is_in_region(region)
            && is_in_sing_mode_song(region)
            && loaded_song_id_sing_mode(region) == song_id
            && !is_sing_mode_short_song_enabled(region)
            && total_score(region) >= easy_score
            && did_song_just_finish(region)
        )
    )

    hard_score = ACHIEVEMENT_INFO[song_id]["HardScoreRecord"]
    achievement(
        title = format("[{0}] {1}", region_name, ACHIEVEMENT_INFO[song_id]["HardAchievementName"]),
        points = 5,
        id = ACHIEVEMENT_INFO[song_id]["HardAchievementId"],
        description = format("Achieve a score of {0} or more on {1} (normal length) on the hard difficulty in Sing Mode", format_int_with_commas(hard_score), song_name),
        trigger = (
            is_in_region(region)
            && is_in_sing_mode_song(region)
            && loaded_song_id_sing_mode(region) == song_id
            && sing_mode_difficulty(region) == DIFFICULTY_HARD
            && !is_sing_mode_short_song_enabled(region)
            && total_score(region) >= easy_score
            && did_song_just_finish(region)
        )
    )

    phrase_count = ACHIEVEMENT_INFO[song_id]["PhraseCount"]
    target_phrase_count = phrase_count * 3 / 4

    achievement(
        title = format("[{0}] {1}", region_name, ACHIEVEMENT_INFO[song_id]["PhraseCountAchievementName"]),
        points = 10,
        id = ACHIEVEMENT_INFO[song_id]["PhraseCountAchievementId"],
        description = format("Get a phrase bonus on at least {0} of the {1} phrases on {2} on the hard difficulty in Sing Mode", target_phrase_count, phrase_count, song_name),
        trigger = (
            is_in_region(region)
            && measured(
                repeated(target_phrase_count, prev(phrase_bonus(region)) < phrase_bonus(region)),
                is_in_sing_mode_song(region)
                    && loaded_song_id_sing_mode(region) == song_id
                    && sing_mode_difficulty(region) == DIFFICULTY_HARD
                    && !is_sing_mode_short_song_enabled(region)
            ) && never(
                song_position(region) == 0
            ) && song_position(region) == SONG_TO_LENGTH[song_id] // I can't MeasureIf during the loading and end results so instead we'll try to activate this on the last frame in-song.
        )
    )

    for song_difficulty in DIFFICULTY_TO_NAME {
        difficulty_name = DIFFICULTY_TO_NAME[song_difficulty]
        normal_leaderboard_id = ACHIEVEMENT_INFO[song_id]["NormalLengthLeaderboardIds"][song_difficulty]
        leaderboard(
            title = format("[{0}] {1} - {2} - Highest Score", region_name, song_name, difficulty_name),
            description = format("Highest score for {0} on {1} in Sing Mode", song_name, difficulty_name),
            id = normal_leaderboard_id,
            start = start_leaderboard(region, song_id, song_difficulty, false),
            cancel = cancel_leaderboard(region),
            submit = submit_leaderboard(region),
            value = leaderboard_value(region),
            format = "VALUE"
        )
        short_leaderboard_id = ACHIEVEMENT_INFO[song_id]["ShortLengthLeaderboardIds"][song_difficulty]
        leaderboard(
            title = format("[{0}] {1} (Short) - {2} - Highest Score", region_name, song_name, difficulty_name),
            description = format("Highest score for {0} (Short) on {1} in Sing Mode", song_name, difficulty_name),
            id = short_leaderboard_id,
            start = start_leaderboard(region, song_id, song_difficulty, true),
            cancel = cancel_leaderboard(region),
            submit = submit_leaderboard(region),
            value = leaderboard_value(region),
            format = "VALUE"
        )
    }
}

for region in REGION_TO_SHORT_NAME {
    if (region != REGION_EUROPE) {
        region_name = REGION_TO_SHORT_NAME[region]
        rich_presence_conditional_display(
            is_in_region(region) && is_in_star_maker_mode(region),
            "[" + region_name + "] In Star Maker mode"
        )
        rich_presence_conditional_display(
            is_in_region(region) && is_mic_on(region) && is_in_sing_mode_song(region) && is_sing_mode_short_song_enabled(region) && song_position(region) > 0,
            "[" + region_name + "] Singing {0} (Short) by {1} - Difficulty: {2}, Score: {3}, Time: {4}/{5}",
            rich_presence_lookup("SongName", loaded_song_id_sing_mode(region), SONG_TO_NAME),
            rich_presence_lookup("ArtistName", loaded_song_id_sing_mode(region), SONG_TO_ARTIST_NAME),
            rich_presence_lookup("Difficulty", sing_mode_difficulty(region), DIFFICULTY_TO_NAME),
            rich_presence_macro("Number", total_score(region)),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLengthShort", loaded_song_id_sing_mode(region), SONG_TO_SHORT_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(
            is_in_region(region) && is_mic_on(region) && is_in_sing_mode_song(region) && song_position(region) > 0,
            "[" + region_name + "] Singing {0} by {1} - Difficulty: {2}, Score: {3}, Time: {4}/{5}",
            rich_presence_lookup("SongName", loaded_song_id_sing_mode(region), SONG_TO_NAME),
            rich_presence_lookup("ArtistName", loaded_song_id_sing_mode(region), SONG_TO_ARTIST_NAME),
            rich_presence_lookup("Difficulty", sing_mode_difficulty(region), DIFFICULTY_TO_NAME),
            rich_presence_macro("Number", total_score(region)),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLength", loaded_song_id_sing_mode(region), SONG_TO_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(
            is_in_region(region),
            "[" + region_name + "] Looking through menus"
        )
    }
}

rich_presence_display("Playing a non-English version of Singstar")
