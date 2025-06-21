// Singstar Party
// #ID = 33393

// SCES_528.26 - Europe
// SCES_528.28 - France (NRJ Music Tour)
// SCES_528.29 - Germany
// SCES_528.27 - Italy
// SCES_528.30 - Spain

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

DIFFICULTY_EASY   = 0x00
DIFFICULTY_MEDIUM = 0x01
DIFFICULTY_HARD   = 0x02

DIFFICULTY_TO_NAME = {
    DIFFICULTY_EASY   : "Easy",
    DIFFICULTY_MEDIUM : "Medium",
    DIFFICULTY_HARD   : "Hard"
}

SONG_FRANCE_AMI_OH                      = 0x009138d0
SONG_FRANCE_FALLIN                      = 0x008c01d0
SONG_FRANCE_OBSESION                    = 0x00926470
SONG_FRANCE_BRIGHT_LIGHTS               = 0x00925fa0
SONG_FRANCE_NO_WOMAN_NO_CRY             = 0x008ab7b0
SONG_FRANCE_VIDEO_KILLED_THE_RADIO_STAR = 0x00854dd0
SONG_FRANCE_YEAR_3000                   = 0x008b91f0
SONG_FRANCE_GIRLS_JUST_WANNA_HAVE_FUN   = 0x008546d0
SONG_FRANCE_SURVIVOR                    = 0x008c0690
SONG_FRANCE_WHITE_FLAG                  = 0x0093ebc0
SONG_FRANCE_LAISSE_PARLER_LES_GENS      = 0x008d82c0
SONG_FRANCE_DONT_GO_BREAKING_MY_HEART   = 0x0093ee20
SONG_FRANCE_BUILD_ME_UP_BUTTERCUP       = 0x008a97a0
SONG_FRANCE_TAKE_ME_OUT                 = 0x008c0430
SONG_FRANCE_FAITH                       = 0x0094fc10
SONG_FRANCE_COSMIC_GIRL                 = 0x008b8900
SONG_FRANCE_FEMME_LIKE_U                = 0x008f0250
SONG_FRANCE_I_SHOULD_BE_SO_LUCKY        = 0x0094fe70
SONG_FRANCE_TUTTI_FRUTTI                = 0x008abbc0
SONG_FRANCE_SEVADER                     = 0x008b8b60
SONG_FRANCE_THIS_LOVE                   = 0x008b86a0
SONG_FRANCE_PARLE_MOI                   = 0x008c0b70
SONG_FRANCE_ET_CEST_PARTI               = 0x008c08f0
SONG_FRANCE_JAI_DES_CHOSES_A_TE_DIRE    = 0x00926200
SONG_FRANCE_JUST_LIKE_A_PILL            = 0x008ac090
SONG_FRANCE_EVERY_BREATH_YOU_TAKE       = 0x008b8430
SONG_FRANCE_I_GOT_YOU_BABE              = 0x008ac3e0
SONG_FRANCE_WHO_DO_YOU_THINK_YOU_ARE    = 0x008abe20
SONG_FRANCE_LORPHELIN                   = 0x00913b40
SONG_FRANCE_LE_MUR_DU_SON               = 0x0093e960


SONG_GERMANY_FALLIN                             = 0x008ba9e0
SONG_GERMANY_SOLID                              = 0x008cc640
SONG_GERMANY_VENUS                              = 0x008a4340
SONG_GERMANY_AINT_NO_SUNSHINE                   = 0x008bb380
SONG_GERMANY_NO_WOMAN_NO_CRY                    = 0x008a3650
SONG_GERMANY_VIDEO_KILLED_THE_RADIO_STAR        = 0x0084c890
SONG_GERMANY_DO_YOU_REALLY_WANT_TO_HURT_ME      = 0x008b05f0
SONG_GERMANY_GIRLS_JUST_WANNA_HAVE_FUN          = 0x008d92d0
SONG_GERMANY_JUST_A_GIGALO_I_AINT_GOT_NOBODY    = 0x008b9080
SONG_GERMANY_SURVIVOR                           = 0x008bac40
SONG_GERMANY_WHITE_FLAG                         = 0x008bb5f0
SONG_GERMANY_ES_WAR_SOMMER_DIE_WAHRE_GESCHICHTE = 0x008b9560
SONG_GERMANY_HUNGRY_LIKE_THE_WOLF               = 0x008a40d0
SONG_GERMANY_DONT_GO_BREAKING_MY_HEART          = 0x008bb850
SONG_GERMANY_WAY_DOWN                           = 0x008b9300
SONG_GERMANY_BUILD_ME_UP_BUTTERCUP              = 0x008a3230
SONG_GERMANY_FAITH                              = 0x008d8e00
SONG_GERMANY_COSMIC_GIRL                        = 0x008b0ee0
SONG_GERMANY_1000_UND_1_NACHT                   = 0x008ba770
SONG_GERMANY_I_SHOULD_BE_SO_LUCKY               = 0x008d9060
SONG_GERMANY_TUTTI_FRUTTI                       = 0x008a38b0
SONG_GERMANY_THIS_LOVE                          = 0x008b0c80
SONG_GERMANY_51ST_STATE                         = 0x008bb120
SONG_GERMANY_JUST_LIKE_A_PILL                   = 0x008b97f0
SONG_GERMANY_EVERY_BREATH_YOU_TAKE              = 0x008a3b10
SONG_GERMANY_KONIG_VON_DEUTSCHLAND              = 0x008b1140
SONG_GERMANY_I_GOT_YOU_BABE                     = 0x008a45a0
SONG_GERMANY_GOLD                               = 0x008a1220
SONG_GERMANY_WHO_DO_YOU_THINK_YOU_ARE           = 0x008a3a60
SONG_GERMANY_SKANDAL_IM_SPERRBEZIRK             = 0x008baea0

SONG_ITALY_COME_MAI                    = 0x008d2130
SONG_ITALY_DIMMI_COME                  = 0x008d2860
SONG_ITALY_FALLIN                      = 0x008b99b0
SONG_ITALY_SENZA_PIETA                 = 0x008abeb0
SONG_ITALY_AINT_NO_SUNSHINE            = 0x008d2d30
SONG_ITALY_ALTRE_FDV                   = 0x008ac6d0
SONG_ITALY_NO_WOMAN_NO_CRY             = 0x008ab830
SONG_ITALY_VIDEO_KILLED_THE_RADIO_STAR = 0x00854e50
SONG_ITALY_GIRLS_JUST_WANNA_HAVE_FUN   = 0x00854750
SONG_ITALY_UN_GIORNO_DAMORE            = 0x008d2ac0
SONG_ITALY_SURVIVOR                    = 0x008bee00
SONG_ITALY_WHITE_FLAG                  = 0x008d2fa0
SONG_ITALY_HUNGRY_LIKE_THE_WOLF        = 0x008ac460
SONG_ITALY_SI_TRATTA_DELLAMORE         = 0x008d25f0
SONG_ITALY_DONT_GO_BREAKING_MY_HEART   = 0x008d3200
SONG_ITALY_VIVERE_A_COLORI             = 0x008b8bf0
SONG_ITALY_BUILD_ME_UP_BUTTERCUP       = 0x008a9820
SONG_ITALY_TAKE_ME_OUT                 = 0x008beba0
SONG_ITALY_FAITH                       = 0x008e3ff0
SONG_ITALY_BAMBINE_CATTIVE             = 0x008d1ed0
SONG_ITALY_COSMIC_GIRL                 = 0x008b94e0
SONG_ITALY_IL_MARE_DINVERNO            = 0x008ac930
SONG_ITALY_THIS_LOVE                   = 0x008b9280
SONG_ITALY_BLU                         = 0x008bf060
SONG_ITALY_JUST_LIKE_A_PILL            = 0x008b9740
SONG_ITALY_EVERY_BREATH_YOU_TAKE       = 0x008ac110
SONG_ITALY_I_GOT_YOU_BABE              = 0x008acba0
SONG_ITALY_GENTE_COME_NOI              = 0x008d1c70
SONG_ITALY_WHO_DO_YOU_THINK_YOU_ARE    = 0x008abc40
SONG_ITALY_FASI                        = 0x008d2390

SONG_SPAIN_NO_ES_LO_MISMO              = 0x008c23c0
SONG_SPAIN_SIN_MIEDO_A_NADA            = 0x008c2fd0
SONG_SPAIN_VIDEO_KILLED_THE_RADIO_STAR = 0x00854610
SONG_SPAIN_LA_LOLA                     = 0x008bff70
SONG_SPAIN_OTRA_VEZ                    = 0x008b7a60
SONG_SPAIN_AVE_MARIA                   = 0x00853f90
SONG_SPAIN_DOS_HOMBRES_Y_UN_DESTINO    = 0x008c3970
SONG_SPAIN_EN_ALGUN_LUGAR              = 0x008c0ac0
SONG_SPAIN_DONT_GO_BREAKING_MY_HEART   = 0x008d3e10
SONG_SPAIN_RETORCIENDO_PALABRAS        = 0x008c0f80
SONG_SPAIN_BUILD_ME_UP_BUTTERCUP       = 0x008a9020
SONG_SPAIN_UNO_MAS_UNO_SON_SIETE       = 0x008b7710
SONG_SPAIN_YIN_YANG                    = 0x008c0860
SONG_SPAIN_ES_POR_TI                   = 0x008c11f0
SONG_SPAIN_TU_VOLVERAS                 = 0x008c1450
SONG_SPAIN_ROSAS                       = 0x008b7cc0
SONG_SPAIN_CAROLINA                    = 0x008c0600
SONG_SPAIN_DESESPERADA                 = 0x008bfaa0
SONG_SPAIN_AMANTE_BANDIDO              = 0x008c34b0
SONG_SPAIN_BIENVENIDOS                 = 0x008c0d20
SONG_SPAIN_LOKO                        = 0x008c2b00
SONG_SPAIN_CHICA_DE_AYER               = 0x008c3710
SONG_SPAIN_UN_BESO_Y_UNA_FLOR          = 0x008c3240
SONG_SPAIN_COMO_HEMOS_CAMBIADO         = 0x008c2880
SONG_SPAIN_JUST_LIKE_A_PILL            = 0x008b74a0
SONG_SPAIN_EVERY_BREATH_YOU_TAKE       = 0x008b7230
SONG_SPAIN_SI_ES_TAN_SOLO_AMOR         = 0x008c2d60
SONG_SPAIN_QUIERO_BESARTE              = 0x008c2620
SONG_SPAIN_CHIQUILLA                   = 0x008bfd00
SONG_SPAIN_I_GOT_YOU_BABE              = 0x008ab030

SONG_DETAILS = [
    {
        "Id": SONG_FRANCE_AMI_OH,
        "Name": "Ami Oh",
        "Artist": "African Connection",
        "Length": 9758,
        "ShortLength": 5254,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Viens Couper Décaler",
                "Id": 527258,
                "TargetScore": 6960
            },
            "Hard": {
                "Title": "Le Monde Est Ma Maison Et Le Ciel Est Mon Toit",
                "Id": 527133,
                "TargetScore": 6420
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "L'Amour Est Ma Raison Et Le Bonheur Ma Loi",
                        "Id": 527134,
                        "TotalPhraseCount": 61
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133846,
                        "Short": 133847
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133848,
                        "Short": 133849
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133850,
                        "Short": 133851
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_FALLIN,
        "Name": "Fallin'",
        "Artist": "Alicia Keys",
        "Length": 10363,
        "ShortLength": 5631,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_OBSESION,
        "Name": "Obsesion",
        "Artist": "Aventura",
        "Length": 9226,
        "ShortLength": 5435,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "El Insomnio Es Mi Castigo",
                "Id": 527259,
                "TargetScore": 7450
            },
            "Hard": {
                "Title": "Bien Vestido y En Mi Lexus",
                "Id": 527135,
                "TargetScore": 6910
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "Anthony Santos",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Voy a Hacerte Caricias Que No Se Han Inventa'o",
                        "Id": 527136,
                        "TotalPhraseCount": 51
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133852,
                        "Short": 133853
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133854,
                        "Short": 133855
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133856,
                        "Short": 133857
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Judy Santos",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Así Funciona El Corazón",
                        "Id": 527137,
                        "TotalPhraseCount": 32
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133858,
                        "Short": 133859
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133860,
                        "Short": 133861
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133862,
                        "Short": 133863
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_BRIGHT_LIGHTS,
        "Name": "Bright Lights",
        "Artist": "Billy Crawford",
        "Length": 11639,
        "ShortLength": 6505,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "The Hotel Just Sent Up the Hen",
                "Id": 527260,
                "TargetScore": 6980
            },
            "Hard": {
                "Title": "So Let's Do It to the Congo's",
                "Id": 527138,
                "TargetScore": 6440
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Oh Lord, This Girl Is So Pretty",
                        "Id": 527139,
                        "TotalPhraseCount": 118
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133864,
                        "Short": 133865
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133866,
                        "Short": 133867
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133868,
                        "Short": 133869
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_NO_WOMAN_NO_CRY,
        "Name": "No Woman No Cry",
        "Artist": "Bob Marley",
        "Length": 16037,
        "ShortLength": 8513,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_VIDEO_KILLED_THE_RADIO_STAR,
        "Name": "Video Killed The Radio Star",
        "Artist": "Buggles",
        "Length": 9897,
        "ShortLength": 5393,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Trevor Horn"
            },
            {
                "Id": 1,
                "Name": "Linda Jardim"
            }
        ]
    },
    {
        "Id": SONG_FRANCE_YEAR_3000,
        "Name": "Year 3000",
        "Artist": "Busted",
        "Length": 9893,
        "ShortLength": 4983,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_GIRLS_JUST_WANNA_HAVE_FUN,
        "Name": "Girls Just Wanna Have Fun",
        "Artist": "Cyndi Lauper",
        "Length": 13367,
        "ShortLength": 4885,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_SURVIVOR,
        "Name": "Survivor",
        "Artist": "Destiny's Child",
        "Length": 12481,
        "ShortLength": 6195,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Chanteur 1"
            },
            {
                "Id": 1,
                "Name": "Chanteur 2"
            }
        ]
    },
    {
        "Id": SONG_FRANCE_WHITE_FLAG,
        "Name": "White Flag",
        "Artist": "Dido",
        "Length": 10687,
        "ShortLength": 6169,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_LAISSE_PARLER_LES_GENS,
        "Name": "Laisse Parler Les Gens!!!",
        "Artist": "Dis L'Heure 2 Zouk",
        "Length": 10301,
        "ShortLength": 5207,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "On Dit Que Chez Toi Les Hommes Sont Tous Beaux-Parleurs",
                "Id": 527261,
                "TargetScore": 6480
            },
            "Hard": {
                "Title": "Tu Vas Te Retrouver Au Village de \"Si Je Savais\"",
                "Id": 527140,
                "TargetScore": 5940
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "Cheela",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Vis Ta Vie, Oublie-Moi",
                        "Id": 527141,
                        "TotalPhraseCount": 68
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133870,
                        "Short": 133871
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133872,
                        "Short": 133873
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133874,
                        "Short": 133875
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Jocelyne",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Va Chercher Bonheur à Gauche",
                        "Id": 527142,
                        "TotalPhraseCount": 65
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133876,
                        "Short": 133877
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133878,
                        "Short": 133879
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133880,
                        "Short": 133881
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_DONT_GO_BREAKING_MY_HEART,
        "Name": "Don't Go Breaking My Heart",
        "Artist": "Elton John & Kiki Dee",
        "Length": 12877,
        "ShortLength": 4551,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Elton John"
            },
            {
                "Id": 1,
                "Name": "Kiki Dee"
            }
        ]
    },
    {
        "Id": SONG_FRANCE_BUILD_ME_UP_BUTTERCUP,
        "Name": "Build Me Up Buttercup",
        "Artist": "The Foundations",
        "Length": 8857,
        "ShortLength": 5443,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_TAKE_ME_OUT,
        "Name": "Take Me Out",
        "Artist": "Franz Ferdinand",
        "Length": 11925,
        "ShortLength": 7707,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_FAITH,
        "Name": "Faith",
        "Artist": "George Michael",
        "Length": 10645,
        "ShortLength": 8205,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_COSMIC_GIRL,
        "Name": "Cosmic Girl",
        "Artist": "Jamiroquai",
        "Length": 11577,
        "ShortLength": 7163,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_FEMME_LIKE_U,
        "Name": "Femme Like U",
        "Artist": "K-Maro",
        "Length": 11808,
        "ShortLength": 6865,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Tu Donnes Un Son à Ma Vie",
                "Id": 527262,
                "TargetScore": 6500
            },
            "Hard": {
                "Title": "Bad Boy, Tu Sais Qu'Tu M'Plais",
                "Id": 527143,
                "TargetScore": 5960
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "K-Maro",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Deux Vies, Deux Voix Qui S'Rencontrent",
                        "Id": 527144,
                        "TotalPhraseCount": 102
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133882,
                        "Short": 133883
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133884,
                        "Short": 133885
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133886,
                        "Short": 133887
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Nancy Martinez",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Donne-Moi Ton Bon Vieux Funk",
                        "Id": 527145,
                        "TotalPhraseCount": 56
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133888,
                        "Short": 133889
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133890,
                        "Short": 133891,
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133892,
                        "Short": 133893
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_I_SHOULD_BE_SO_LUCKY,
        "Name": "I Should Be So Lucky",
        "Artist": "Kylie Minogue",
        "Length": 9793,
        "ShortLength": 5881,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_I_SHOULD_BE_SO_LUCKY,
        "Name": "Tutti Frutti",
        "Artist": "Little Richard",
        "Length": 7033,
        "ShortLength": 4097,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_SEVADER,
        "Name": "S'Evader",
        "Artist": "Lynnsha",
        "Length": 10585,
        "ShortLength": 5685,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "M'évader Est Ma Seule Envie",
                "Id": 527263,
                "TargetScore": 6490
            },
            "Hard": {
                "Title": "Pression Sur la Session",
                "Id": 527146,
                "TargetScore": 5950
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Aimer, Lover, Espérer Un Monde Meilleur",
                        "Id": 527147,
                        "TotalPhraseCount": 112
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133894,
                        "Short": 133895
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133896,
                        "Short": 133897
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133898,
                        "Short": 133899
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_THIS_LOVE,
        "Name": "This Love",
        "Artist": "Maroon5",
        "Length": 10125,
        "ShortLength": 6113,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_PARLE_MOI,
        "Name": "Parle-Moi",
        "Artist": "Nâdiya",
        "Length": 12381,
        "ShortLength": 5257,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Parle-Moi de Ce Qui Fait Ta Vie",
                "Id": 527264,
                "TargetScore": 6020
            },
            "Hard": {
                "Title": "Tout Peut Changer de Main",
                "Id": 527148,
                "TargetScore": 5480
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "Nâyida",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Ne Jamais Abandonner Ta Vie",
                        "Id": 527149,
                        "TotalPhraseCount": 54
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133900,
                        "Short": 133901
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133902,
                        "Short": 133903
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133904,
                        "Short": 133905
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Choriste",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Parle-Moi de Ton Coeur",
                        "Id": 527150,
                        "TotalPhraseCount": 48
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133906,
                        "Short": 133907
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133908,
                        "Short": 133909
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133910,
                        "Short": 133911
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_ET_CEST_PARTI,
        "Name": "Et C'est Parti...",
        "Artist": "Nâdiya feat. Smartzee",
        "Length": 11699,
        "ShortLength": 5684,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Le Stade Est Chaud",
                "Id": 527265,
                "TargetScore": 7610
            },
            "Hard": {
                "Title": "Il Lève Ses Poings Faits de Lave",
                "Id": 527151,
                "TargetScore": 7070
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Délaisse Les Coups Qui Le Blessent",
                        "Id": 527152,
                        "TotalPhraseCount": 97
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133912,
                        "Short": 133913
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133914,
                        "Short": 133915
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133916,
                        "Short": 133917
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_JAI_DES_CHOSES_A_TE_DIRE,
        "Name": "J'ai Des Choses À Te Dire",
        "Artist": "Pearl",
        "Length": 10505,
        "ShortLength": 6522,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Sur Une Messagerie Ou Avеc Des Sms",
                "Id": 527266,
                "TargetScore": 7440
            },
            "Hard": {
                "Title": "Quel Genre D'Excuse Vas-Tu Encore Me Trouver?",
                "Id": 527153,
                "TargetScore": 6900
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Ce Silence Ne Te Ressemble Pas",
                        "Id": 527154,
                        "TotalPhraseCount": 108
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133918,
                        "Short": 133919
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133920,
                        "Short": 133921
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133922,
                        "Short": 133923
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_JUST_LIKE_A_PILL,
        "Name": "Just Like A Pill",
        "Artist": "Pink",
        "Length": 11727,
        "ShortLength": 7605,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_EVERY_BREATH_YOU_TAKE,
        "Name": "Every Breath You Take",
        "Artist": "The Police",
        "Length": 11499,
        "ShortLength": 5595,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_I_GOT_YOU_BABE,
        "Name": "I Got You Babe",
        "Artist": "Sonny & Cher",
        "Length": 9479,
        "ShortLength": 4595,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Sonny"
            },
            {
                "Id": 1,
                "Name": "Cher"
            }
        ]
    },
    {
        "Id": SONG_FRANCE_WHO_DO_YOU_THINK_YOU_ARE,
        "Name": "Who Do You Think You Are",
        "Artist": "Spice Girls",
        "Length": 11096,
        "ShortLength": 6679,
        "Region": REGION_FRANCE,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_FRANCE_LORPHELIN,
        "Name": "L'Orphelin",
        "Artist": "Willy Denzey",
        "Length": 11553,
        "ShortLength": 7685,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Cet Enfant Reste Là Face Au Destin",
                "Id": 527267,
                "TargetScore": 6970
            },
            "Hard": {
                "Title": "Si ça Continue Votre Tour Viendra Peut-être",
                "Id": 527155,
                "TargetScore": 6430
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "Willy Denzey",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Croire Que Tout Ira Mieux",
                        "Id": 527156,
                        "TotalPhraseCount": 60
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133924,
                        "Short": 133925
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133926,
                        "Short": 133927
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133928,
                        "Short": 133929
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Kader Riwan",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Mata Tkelem Mat Dgoul Ana",
                        "Id": 527157,
                        "TotalPhraseCount": 48
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133930,
                        "Short": 133931
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133932,
                        "Short": 133933
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133934,
                        "Short": 133935
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_FRANCE_LE_MUR_DU_SON,
        "Name": "Le Mur Du Son",
        "Artist": "Willy Denzey",
        "Length": 9776,
        "ShortLength": 6483,
        "Region": REGION_FRANCE,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Mets-Toi en Condition",
                "Id": 527268,
                "TargetScore": 7460
            },
            "Hard": {
                "Title": "Je Me Place, Efficace, Suis Ma Direction",
                "Id": 527158,
                "TargetScore": 6920
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "En Aucun Cas Limité, Oh Oui à Jamais",
                        "Id": 527159,
                        "TotalPhraseCount": 83
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133936,
                        "Short": 133937
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133938,
                        "Short": 133939
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133940,
                        "Short": 133941
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_FALLIN,
        "Name": "Fallin'",
        "Artist": "Alicia Keys",
        "Length": 10363,
        "ShortLength": 5631,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_SOLID,
        "Name": "Solid",
        "Artist": "Ashford & Simpson",
        "Length": 12705,
        "ShortLength": 8495,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Ashford"
            },
            {
                "Id": 1,
                "Name": "Simpson"
            }
        ]
    },
    {
        "Id": SONG_GERMANY_VENUS,
        "Name": "Venus",
        "Artist": "Bananarama",
        "Length": 10840,
        "ShortLength": 4782,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Goddess On the Mountaintop",
                "Id": 527269,
                "TargetScore": 7290
            },
            "Hard": {
                "Title": "Her Weapons Were Her Crystal Eyes",
                "Id": 527160,
                "TargetScore": 6750
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Yeah, Baby, She's Got It",
                        "Id": 527161,
                        "TotalPhraseCount": 50
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133942,
                        "Short": 133943
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133944,
                        "Short": 133945
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133946,
                        "Short": 133947
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_AINT_NO_SUNSHINE,
        "Name": "Ain't No Sunshine",
        "Artist": "Bill Withers",
        "Length": 6013,
        "ShortLength": 0, // There's no short version!
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_NO_WOMAN_NO_CRY,
        "Name": "No Woman No Cry",
        "Artist": "Bob Marley",
        "Length": 16037,
        "ShortLength": 8513,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_VIDEO_KILLED_THE_RADIO_STAR,
        "Name": "Video Killed The Radio Star",
        "Artist": "Buggles",
        "Length": 9897,
        "ShortLength": 5393,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Trevor Horn"
            },
            {
                "Id": 1,
                "Name": "Linda Jardim"
            }
        ]
    },
    {
        "Id": SONG_GERMANY_DO_YOU_REALLY_WANT_TO_HURT_ME,
        "Name": "Do You Really Want To Hurt Me",
        "Artist": "Culture Club",
        "Length": 13033,
        "ShortLength": 7939,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Let Me Love and Steal",
                "Id": 527270,
                "TargetScore": 6960
            },
            "Hard": {
                "Title": "Precious Kisses, Words That Burn Me",
                "Id": 527162,
                "TargetScore": 6420
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Wrapped in Sorrow, Words Are Token",
                        "Id": 527163,
                        "TotalPhraseCount": 78
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133948,
                        "Short": 133949
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133950,
                        "Short": 133951
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133952,
                        "Short": 133953
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_GIRLS_JUST_WANNA_HAVE_FUN,
        "Name": "Girls Just Wanna Have Fun",
        "Artist": "Cyndi Lauper",
        "Length": 13367,
        "ShortLength": 4885,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_JUST_A_GIGALO_I_AINT_GOT_NOBODY,
        "Name": "Just A Gigalo - I Ain't Got Nobody",
        "Artist": "David Lee Roth",
        "Length": 13953,
        "ShortLength": 7936,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "There Will Come a Day When Youth Will Pass Away",
                "Id": 527271,
                "TargetScore": 6020
            },
            "Hard": {
                "Title": "Sad and Lonely",
                "Id": 527164,
                "TargetScore": 5480
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Life Goes on Without Me",
                        "Id": 527165,
                        "TotalPhraseCount": 88
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133954,
                        "Short": 133955
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133956,
                        "Short": 133957
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133958,
                        "Short": 133959
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_SURVIVOR,
        "Name": "Survivor",
        "Artist": "Destiny's Child",
        "Length": 12481,
        "ShortLength": 6195,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Sänger 1"
            },
            {
                "Id": 1,
                "Name": "Sänger 2"
            }
        ]
    },
    {
        "Id": SONG_GERMANY_WHITE_FLAG,
        "Name": "White Flag",
        "Artist": "Dido",
        "Length": 10687,
        "ShortLength": 6169,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_ES_WAR_SOMMER_DIE_WAHRE_GESCHICHTE,
        "Name": "Es War Sommer (Die Wahre Geschichte)",
        "Artist": "Dieter Thomas Kuhn",
        "Length": 12647,
        "ShortLength": 5555,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Die Sonne Brannte So, Als Hätte Sie's Gewusst",
                "Id": 527272,
                "TargetScore": 6490
            },
            "Hard": {
                "Title": "Komm, Bleib Bei Mir Bis Die Sonne Rot Wird",
                "Id": 527166,
                "TargetScore": 5950
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Doch Als Ein Mann Sah Ich Die Sonne Aufgehen",
                        "Id": 527167,
                        "TotalPhraseCount": 55
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133960,
                        "Short": 133961
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133962,
                        "Short": 133963
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133964,
                        "Short": 133965
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_HUNGRY_LIKE_THE_WOLF,
        "Name": "Hungry Like The Wolf",
        "Artist": "Duran Duran",
        "Length": 10685,
        "ShortLength": 6931,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_DONT_GO_BREAKING_MY_HEART,
        "Name": "Don't Go Breaking My Heart",
        "Artist": "Elton John & Kiki Dee",
        "Length": 12877,
        "ShortLength": 4551,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Elton John"
            },
            {
                "Id": 1,
                "Name": "Kiki Dee"
            }
        ]
    },
    {
        "Id": SONG_GERMANY_WAY_DOWN,
        "Name": "Way Down",
        "Artist": "Elvis Presley",
        "Length": 7743,
        "ShortLength": 4985,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_BUILD_ME_UP_BUTTERCUP,
        "Name": "Build Me Up Buttercup",
        "Artist": "The Foundations",
        "Length": 8857,
        "ShortLength": 5443,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_FAITH,
        "Name": "Faith",
        "Artist": "George Michael",
        "Length": 10645,
        "ShortLength": 8205,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_COSMIC_GIRL,
        "Name": "Cosmic Girl",
        "Artist": "Jamiroquai",
        "Length": 11577,
        "ShortLength": 7163,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_1000_UND_1_NACHT,
        "Name": "1000 Und 1 Nacht",
        "Artist": "Klaus Lage",
        "Length": 9925,
        "ShortLength": 5145,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Wir Waren Nur Freunde Und Wollten's Auch Bleiben",
                "Id": 527273,
                "TargetScore": 6970
            },
            "Hard": {
                "Title": "Wir Kennen Uns Zu Lange",
                "Id": 527168,
                "TargetScore": 6430
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Hätt Ich Nie Geahnt, du Warst Der Schlüssel Dazu",
                        "Id": 527169,
                        "TotalPhraseCount": 68
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133966,
                        "Short": 133967
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133968,
                        "Short": 133969
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133970,
                        "Short": 133971
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_I_SHOULD_BE_SO_LUCKY,
        "Name": "I Should Be So Lucky",
        "Artist": "Kylie Minogue",
        "Length": 9793,
        "ShortLength": 5881,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_TUTTI_FRUTTI,
        "Name": "Tutti Frutti",
        "Artist": "Little Richard",
        "Length": 7033,
        "ShortLength": 4097,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_THIS_LOVE,
        "Name": "This Love",
        "Artist": "Maroon5",
        "Length": 10125,
        "ShortLength": 6113,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_51ST_STATE,
        "Name": "51st State",
        "Artist": "New Model Army",
        "Length": 8061,
        "ShortLength": 4895,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "We're W-A-S-Ps",
                "Id": 527274,
                "TargetScore": 7460
            },
            "Hard": {
                "Title": "Tip Your Hat to the Yankee Conquerors",
                "Id": 527170,
                "TargetScore": 6920
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Watch Us Revel in Our Liberty",
                        "Id": 527171,
                        "TotalPhraseCount": 61
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133972,
                        "Short": 133973
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133974,
                        "Short": 133975
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133976,
                        "Short": 133977
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_JUST_LIKE_A_PILL,
        "Name": "Just Like A Pill",
        "Artist": "Pink",
        "Length": 11727,
        "ShortLength": 7605,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_EVERY_BREATH_YOU_TAKE,
        "Name": "Every Breath You Take",
        "Artist": "The Police",
        "Length": 11499,
        "ShortLength": 5595,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_KONIG_VON_DEUTSCHLAND,
        "Name": "König Von Deutschland",
        "Artist": "Rio Reiser",
        "Length": 10195,
        "ShortLength": 5561,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Sondern Kanzler, Kaiser, König Oder Königin",
                "Id": 527275,
                "TargetScore": 7610
            },
            "Hard": {
                "Title": "Ich Würd Vivaldi Hör'n, Tagein, Tagaus",
                "Id": 527172,
                "TargetScore": 7070
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Ich Wär Feiner Als Der Kinkel Und Dicker Als Der Kohl",
                        "Id": 527173,
                        "TotalPhraseCount": 85
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133978,
                        "Short": 133979
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133980,
                        "Short": 133981
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133982,
                        "Short": 133983
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_GERMANY_I_GOT_YOU_BABE,
        "Name": "I Got You Babe",
        "Artist": "Sonny & Cher",
        "Length": 9479,
        "ShortLength": 4595,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Sonny"
            },
            {
                "Id": 1,
                "Name": "Cher"
            }
        ]
    },
    {
        "Id": SONG_GERMANY_GOLD,
        "Name": "Gold",
        "Artist": "Spandau Ballet",
        "Length": 11383,
        "ShortLength": 7139,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_WHO_DO_YOU_THINK_YOU_ARE,
        "Name": "Who Do You Think You Are",
        "Artist": "Spice Girls",
        "Length": 11096,
        "ShortLength": 6679,
        "Region": REGION_GERMANY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_GERMANY_SKANDAL_IM_SPERRBEZIRK,
        "Name": "Skandal Im Sperrbezirk",
        "Artist": "Spider Murphy Gang",
        "Length": 10740,
        "ShortLength": 6733,
        "Region": REGION_GERMANY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Rosi Täglich Inseriert",
                "Id": 527276,
                "TargetScore": 7450
            },
            "Hard": {
                "Title": "Langweilen Sich Die Damen Nur",
                "Id": 527174,
                "TargetScore": 6910
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Auch Ich Hab' Ihre Nummer Schon",
                        "Id": 527175,
                        "TotalPhraseCount": 93
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133984,
                        "Short": 133985
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133986,
                        "Short": 133987
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133988,
                        "Short": 133989
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_COME_MAI,
        "Name": "Come Mai",
        "Artist": "883",
        "Length": 12878,
        "ShortLength": 6044,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Le Notti Non Finiscono All'Alba Nella Via",
                "Id": 527277,
                "TargetScore": 6970
            },
            "Hard": {
                "Title": "Notti Intere Ad Aspettarti",
                "Id": 527176,
                "TargetScore": 6430
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Una Quotidiana Guerra Con la Razionalità",
                        "Id": 527177,
                        "TotalPhraseCount": 70
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133990,
                        "Short": 133991
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133992,
                        "Short": 133993
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 133994,
                        "Short": 133995
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_DIMMI_COME,
        "Name": "Dimmi Come",
        "Artist": "Alexia",
        "Length": 10578,
        "ShortLength": 4762,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Ti Dovrei Odiare, Ma Come Potrei?",
                "Id": 527278,
                "TargetScore": 7450
            },
            "Hard": {
                "Title": "Mi Incanti e Mi Butti Giù",
                "Id": 527178,
                "TargetScore": 6910
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Senza Di Te Non C'è Più Il Sole",
                        "Id": 527179,
                        "TotalPhraseCount": 93
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 133996,
                        "Short": 133997
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 133998,
                        "Short": 133999
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134000,
                        "Short": 134001
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_FALLIN,
        "Name": "Fallin'",
        "Artist": "Alicia Keys",
        "Length": 10363,
        "ShortLength": 5631,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_SENZA_PIETA,
        "Name": "Senza Pietà",
        "Artist": "Anna Oxa",
        "Length": 13355,
        "ShortLength": 8524,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Non Mi Fermeranno Le Paludi O la Neve",
                "Id": 527279,
                "TargetScore": 7760
            },
            "Hard": {
                "Title": "Ti Stringerò, Conquisterò, Proteggerò",
                "Id": 527180,
                "TargetScore": 7220
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Quel Brivido in Più Che Sei Tu",
                        "Id": 527181,
                        "TotalPhraseCount": 69
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134002,
                        "Short": 134003
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134004,
                        "Short": 134005
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134006,
                        "Short": 134007
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_AINT_NO_SUNSHINE,
        "Name": "Ain't No Sunshine",
        "Artist": "Bill Withers",
        "Length": 6013,
        "ShortLength": 0, // There's no short version!
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_ALTRE_FDV,
        "Name": "Altre F.D.V.",
        "Artist": "Bluvertigo",
        "Length": 13245,
        "ShortLength": 5627,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Se Non Esistessero i Pesci",
                "Id": 527280,
                "TargetScore": 6180
            },
            "Hard": {
                "Title": "Che Solamente Noi Siamo Stati Generati Dal Caso",
                "Id": 527182,
                "TargetScore": 5640
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "È Praticamente Ovvio Che Esistano",
                        "Id": 527183,
                        "TotalPhraseCount": 61
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134008,
                        "Short": 134009
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134010,
                        "Short": 134011
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134012,
                        "Short": 134013
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_NO_WOMAN_NO_CRY,
        "Name": "No Woman No Cry",
        "Artist": "Bob Marley",
        "Length": 16037,
        "ShortLength": 8513,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_VIDEO_KILLED_THE_RADIO_STAR,
        "Name": "Video Killed The Radio Star",
        "Artist": "Buggles",
        "Length": 9897,
        "ShortLength": 5393,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Trevor Horn"
            },
            {
                "Id": 1,
                "Name": "Linda Jardim"
            }
        ]
    },
    {
        "Id": SONG_ITALY_GIRLS_JUST_WANNA_HAVE_FUN,
        "Name": "Girls Just Wanna Have Fun",
        "Artist": "Cyndi Lauper",
        "Length": 13367,
        "ShortLength": 4885,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_UN_GIORNO_DAMORE,
        "Name": "Un Giorno D'Amore",
        "Artist": "Daniele Stefani",
        "Length": 11273,
        "ShortLength": 5168,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Qui Nel Mondo C'è Troppo Orgoglio",
                "Id": 527281,
                "TargetScore": 7460
            },
            "Hard": {
                "Title": "Il Bianco e Nero Di Una Canzone",
                "Id": 527184,
                "TargetScore": 6920
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Non Fermarti Se Poi Io Mi Fermo",
                        "Id": 527185,
                        "TotalPhraseCount": 84
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134014,
                        "Short": 134015
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134016,
                        "Short": 134017
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134018,
                        "Short": 134019
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_SURVIVOR,
        "Name": "Survivor",
        "Artist": "Destiny's Child",
        "Length": 12481,
        "ShortLength": 6195,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Cantante 1"
            },
            {
                "Id": 1,
                "Name": "Cantante 2"
            }
        ]
    },
    {
        "Id": SONG_ITALY_WHITE_FLAG,
        "Name": "White Flag",
        "Artist": "Dido",
        "Length": 10687,
        "ShortLength": 6169,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_HUNGRY_LIKE_THE_WOLF,
        "Name": "Hungry Like The Wolf",
        "Artist": "Duran Duran",
        "Length": 10685,
        "ShortLength": 6931,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_SI_TRATTA_DELLAMORE,
        "Name": "Si Tratta Dell'Amore",
        "Artist": "Edoardo Bennato",
        "Length": 13465,
        "ShortLength": 6320,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Chissà Qual è la Chiave",
                "Id": 527282,
                "TargetScore": 7440
            },
            "Hard": {
                "Title": "Chissà Qual è L'Impulso",
                "Id": 527186,
                "TargetScore": 6900
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Tutto è Sempre Imprevedibile",
                        "Id": 527187,
                        "TotalPhraseCount": 98
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134020,
                        "Short": 134021
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134022,
                        "Short": 134023
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134024,
                        "Short": 134025
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_DONT_GO_BREAKING_MY_HEART,
        "Name": "Don't Go Breaking My Heart",
        "Artist": "Elton John & Kiki Dee",
        "Length": 12877,
        "ShortLength": 4551,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Elton John"
            },
            {
                "Id": 1,
                "Name": "Kiki Dee"
            }
        ]
    },
    {
        "Id": SONG_ITALY_VIVERE_A_COLORI,
        "Name": "Vivere A Colori",
        "Artist": "Fiorello",
        "Length": 12817,
        "ShortLength": 5799,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Se Sogni Il Vento Volerai",
                "Id": 527283,
                "TargetScore": 6490
            },
            "Hard": {
                "Title": "Tra Me e la Vita Quanto Tempo C'è",
                "Id": 527188,
                "TargetScore": 5950
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Colorare Il Mio Destino",
                        "Id": 527189,
                        "TotalPhraseCount": 79
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134026,
                        "Short": 134027
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134028,
                        "Short": 134029
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134030,
                        "Short": 134031
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_BUILD_ME_UP_BUTTERCUP,
        "Name": "Build Me Up Buttercup",
        "Artist": "The Foundations",
        "Length": 8857,
        "ShortLength": 5443,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_TAKE_ME_OUT,
        "Name": "Take Me Out",
        "Artist": "Franz Ferdinand",
        "Length": 11925,
        "ShortLength": 7707,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_FAITH,
        "Name": "Faith",
        "Artist": "George Michael",
        "Length": 10645,
        "ShortLength": 8205,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_BAMBINE_CATTIVE,
        "Name": "Bambine Cattive",
        "Artist": "Irene Grandi",
        "Length": 12292,
        "ShortLength": 5143,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "C'è Un Sole Rosso Giù Oltre Le Colline",
                "Id": 527284,
                "TargetScore": 6960
            },
            "Hard": {
                "Title": "Velocità Costante Musica e Vento",
                "Id": 527190,
                "TargetScore": 6420
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Ma Se L'Amore è Una Sorpresa C'è Una Discesa",
                        "Id": 527191,
                        "TotalPhraseCount": 72
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134032,
                        "Short": 134033
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134034,
                        "Short": 134035
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134036,
                        "Short": 134037
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_COSMIC_GIRL,
        "Name": "Cosmic Girl",
        "Artist": "Jamiroquai",
        "Length": 11577,
        "ShortLength": 7163,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_IL_MARE_DINVERNO,
        "Name": "Il Mare D'Inverno",
        "Artist": "Loredano Bertè",
        "Length": 12638,
        "ShortLength": 7533,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Una Lettera Che Il Vento Sta Portando Via",
                "Id": 527285,
                "TargetScore": 6640
            },
            "Hard": {
                "Title": "È Un Concetto Che Il Pensiero Non Considera",
                "Id": 527192,
                "TargetScore": 6100
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Mi Tuffo Perplessa in Momenti Vissuti Di Già",
                        "Id": 527193,
                        "TotalPhraseCount": 80
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134038,
                        "Short": 134039
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134040,
                        "Short": 134041
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134042,
                        "Short": 134043
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_THIS_LOVE,
        "Name": "This Love",
        "Artist": "Maroon5",
        "Length": 10125,
        "ShortLength": 6113,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_BLU,
        "Name": "Blu",
        "Artist": "Paola & Chiara",
        "Length": 11091,
        "ShortLength": 6055,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Che Atmosfera",
                "Id": 527286,
                "TargetScore": 6480
            },
            "Hard": {
                "Title": "Con la Musica Noi Stiamo Insieme",
                "Id": 527194,
                "TargetScore": 5940
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "Paola",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Muovi i Fianchi e Poi Gira in Tondo",
                        "Id": 527195,
                        "TotalPhraseCount": 60
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134044,
                        "Short": 134045
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134046,
                        "Short": 134047
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134048,
                        "Short": 134049
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Chiara",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "L'Universo Ci Gira Intorno",
                        "Id": 527196,
                        "TotalPhraseCount": 59
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134050,
                        "Short": 134051
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134052,
                        "Short": 134053
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134054,
                        "Short": 134055
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_JUST_LIKE_A_PILL,
        "Name": "Just Like A Pill",
        "Artist": "Pink",
        "Length": 11727,
        "ShortLength": 7605,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_EVERY_BREATH_YOU_TAKE,
        "Name": "Every Breath You Take",
        "Artist": "The Police",
        "Length": 11499,
        "ShortLength": 5595,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_I_GOT_YOU_BABE,
        "Name": "I Got You Babe",
        "Artist": "Sonny & Cher",
        "Length": 9479,
        "ShortLength": 4595,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Sonny"
            },
            {
                "Id": 1,
                "Name": "Cher"
            }
        ]
    },
    {
        "Id": SONG_ITALY_GENTE_COME_NOI,
        "Name": "Gente Come Noi",
        "Artist": "Spagna",
        "Length": 12346,
        "ShortLength": 6400,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Amori Unici, Ma Tanto Fragili",
                "Id": 527287,
                "TargetScore": 6500
            },
            "Hard": {
                "Title": "È Così Difficile Perdonare",
                "Id": 527197,
                "TargetScore": 5960
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Gente Come Noi Che Sogna Ancora",
                        "Id": 527198,
                        "TotalPhraseCount": 76
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134056,
                        "Short": 134057
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134058,
                        "Short": 134059
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134060,
                        "Short": 134061
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_ITALY_WHO_DO_YOU_THINK_YOU_ARE,
        "Name": "Who Do You Think You Are",
        "Artist": "Spice Girls",
        "Length": 11096,
        "ShortLength": 6679,
        "Region": REGION_ITALY,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_ITALY_FASI,
        "Name": "Fasi",
        "Artist": "Zeropositivo",
        "Length": 10646,
        "ShortLength": 4679,
        "Region": REGION_ITALY,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Lascia Che Mi Stimoli la Mente",
                "Id": 527288,
                "TargetScore": 6980
            },
            "Hard": {
                "Title": "Ad Aggrapparci Ma Ancora per Poco Noi",
                "Id": 527199,
                "TargetScore": 6440
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Vorrei Il Mare",
                        "Id": 527200,
                        "TotalPhraseCount": 41
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134062,
                        "Short": 134063
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134064,
                        "Short": 134065
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134066,
                        "Short": 134067
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_NO_ES_LO_MISMO,
        "Name": "No Es Lo Mismo",
        "Artist": "Alejandro Sanz",
        "Length": 17935,
        "ShortLength": 5644,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Eres Tanta Gente, Que Dime Con Quién Hablo Ahora",
                "Id": 527289,
                "TargetScore": 7610
            },
            "Hard": {
                "Title": "No Es Comunismo, Es Instinto",
                "Id": 527201,
                "TargetScore": 7070
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Vale, Que a Lo Mejor Me Lo Merezco",
                        "Id": 527202,
                        "TotalPhraseCount": 163
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134068,
                        "Short": 134069
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134070,
                        "Short": 134071
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134072,
                        "Short": 134073
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_SIN_MIEDO_A_NADA,
        "Name": "Sin Miedo A Nada",
        "Artist": "Alex Ubago",
        "Length": 13483,
        "ShortLength": 8033,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Me Muero Por Escucharte Decir Las Cosas Que Nunca Dirás",
                "Id": 527290,
                "TargetScore": 6960
            },
            "Hard": {
                "Title": "Voy Sintiendo El Fuego en Mi Interior",
                "Id": 527203,
                "TargetScore": 6420
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Me Muero Por Conocerte",
                        "Id": 527204,
                        "TotalPhraseCount": 80
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134074,
                        "Short": 134075
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134076,
                        "Short": 134077
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134078,
                        "Short": 134079
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_VIDEO_KILLED_THE_RADIO_STAR,
        "Name": "Video Killed The Radio Star",
        "Artist": "Buggles",
        "Length": 9897,
        "ShortLength": 5393,
        "Region": REGION_SPAIN,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Trevor Horn"
            },
            {
                "Id": 1,
                "Name": "Linda Jardim"
            }
        ]
    },
    {
        "Id": SONG_SPAIN_LA_LOLA,
        "Name": "La Lola",
        "Artist": "Café Quijano",
        "Length": 10003,
        "ShortLength": 5109,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Tenía Escondida Tremendas Armas",
                "Id": 527291,
                "TargetScore": 7600
            },
            "Hard": {
                "Title": "De Nostalgia Y de Su Locura",
                "Id": 527205,
                "TargetScore": 7060
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Tu Triste Vida Es Tu Triste Historia",
                        "Id": 527206,
                        "TotalPhraseCount": 84
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134080,
                        "Short": 134081
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134082,
                        "Short": 134083
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134084,
                        "Short": 134085
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_OTRA_VEZ,
        "Name": "Otra Vez",
        "Artist": "Coti",
        "Length": 10612,
        "ShortLength": 5037,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Tengo Una Guitarra en El Hombro",
                "Id": 527292,
                "TargetScore": 7280
            },
            "Hard": {
                "Title": "Pido Que Me Olvide Tu Olvido",
                "Id": 527207,
                "TargetScore": 6740
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Por El Bien de Los Dos",
                        "Id": 527208,
                        "TotalPhraseCount": 76
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134086,
                        "Short": 134087
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134088,
                        "Short": 134089
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134090,
                        "Short": 134091
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_AVE_MARIA,
        "Name": "Ave María",
        "Artist": "David Bisbal",
        "Length": 10615,
        "ShortLength": 6273,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "¿Cuándo Serás Mía?",
                "Id": 527293,
                "TargetScore": 7460
            },
            "Hard": {
                "Title": "Tú Eres Mi Tesoro",
                "Id": 527209,
                "TargetScore": 6920
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Enciéndeme Con Tu Fuego",
                        "Id": 527210,
                        "TotalPhraseCount": 82
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134092,
                        "Short": 134093
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134094,
                        "Short": 134095
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134096,
                        "Short": 134097
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_DOS_HOMBRES_Y_UN_DESTINO,
        "Name": "Dos Hombres Y Un Destino",
        "Artist": "David Bustamante & Alex",
        "Length": 10921,
        "ShortLength": 5671,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Por El Amor de Esa Mujer",
                "Id": 527294,
                "TargetScore": 7450
            },
            "Hard": {
                "Title": "Y Aunque Seas Mi Amigo, Lucharé",
                "Id": 527211,
                "TargetScore": 6910
            }
        },
        "Parts": [
            {
                "Id": 0,
                "Name": "David",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Es la Chispa de Mi Piel",
                        "Id": 527212,
                        "TotalPhraseCount": 44
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134098,
                        "Short": 134099
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134100,
                        "Short": 134101
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134102,
                        "Short": 134103
                    }
                }
            },
            {
                "Id": 1,
                "Name": "Alex",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Ella Es Como El Sol de Otro Amanecer",
                        "Id": 527213,
                        "TotalPhraseCount": 42
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134104,
                        "Short": 134105
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134106,
                        "Short": 134107
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134108,
                        "Short": 134109
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_EN_ALGUN_LUGAR,
        "Name": "En Algún Lugar",
        "Artist": "Duncan Dhu",
        "Length": 12235,
        "ShortLength": 5598,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Un Hogar Donde No Queme El Sol",
                "Id": 527295,
                "TargetScore": 6650
            },
            "Hard": {
                "Title": "No Hay Camino Que Llegue Hasta Aquí",
                "Id": 527214,
                "TargetScore": 6920
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Cuando Lo Triste Es Vivir",
                        "Id": 527215,
                        "TotalPhraseCount": 58
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134110,
                        "Short": 134111
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134112,
                        "Short": 134113
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134114,
                        "Short": 134115
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_DONT_GO_BREAKING_MY_HEART,
        "Name": "Don't Go Breaking My Heart",
        "Artist": "Elton John & Kiki Dee",
        "Length": 12877,
        "ShortLength": 4551,
        "Region": REGION_SPAIN,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Elton John"
            },
            {
                "Id": 1,
                "Name": "Kiki Dee"
            }
        ]
    },
    {
        "Id": SONG_SPAIN_RETORCIENDO_PALABRAS,
        "Name": "Retorciendo Palabras",
        "Artist": "Duncan Dhu",
        "Length": 11742,
        "ShortLength": 7019,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "¿De Qué Sirve Un Futuro Ideal?",
                "Id": 527296,
                "TargetScore": 7120
            },
            "Hard": {
                "Title": "Transparente Como Una Traición",
                "Id": 527216,
                "TargetScore": 6580
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Un Diseño de Algo Fugaz",
                        "Id": 527217,
                        "TotalPhraseCount": 96
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134116,
                        "Short": 134117
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134118,
                        "Short": 134119
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134120,
                        "Short": 134121
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_BUILD_ME_UP_BUTTERCUP,
        "Name": "Build Me Up Buttercup",
        "Artist": "The Foundations",
        "Length": 8857,
        "ShortLength": 5443,
        "Region": REGION_SPAIN,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_SPAIN_UNO_MAS_UNO_SON_SIETE,
        "Name": "Uno Más Uno Son Siete",
        "Artist": "Fran Perea",
        "Length": 8869,
        "ShortLength": 5913,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Mis Cuentos No Hablaban de Historias",
                "Id": 527297,
                "TargetScore": 6170
            },
            "Hard": {
                "Title": "Cual Es El Precio Exacto de la Felicidad",
                "Id": 527218,
                "TargetScore": 5630
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Hay Tostadas Para Tres",
                        "Id": 527219,
                        "TotalPhraseCount": 65
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134122,
                        "Short": 134123
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134124,
                        "Short": 134125
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134126,
                        "Short": 134127
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_YIN_YANG,
        "Name": "Yin Yang",
        "Artist": "Jarabe De Palo",
        "Length": 9607,
        "ShortLength": 5702,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Menos Es Más",
                "Id": 527298,
                "TargetScore": 6640
            },
            "Hard": {
                "Title": "Vienen Y Van",
                "Id": 527220,
                "TargetScore": 6100
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "¿Cómo Vas? ¿Cómo Lo Ves?",
                        "Id": 527221,
                        "TotalPhraseCount": 82
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134128,
                        "Short": 134129
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134130,
                        "Short": 134131
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134132,
                        "Short": 134133
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_ES_POR_TI,
        "Name": "Es Por Ti",
        "Artist": "Juanes",
        "Length": 12103,
        "ShortLength": 5976,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Me Siento Renovado",
                "Id": 527299,
                "TargetScore": 7130
            },
            "Hard": {
                "Title": "Tú Controlas Toda Mi Verdad",
                "Id": 527222,
                "TargetScore": 6590
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "He Vuelto a Hablar de Amor",
                        "Id": 527223,
                        "TotalPhraseCount": 60
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134134,
                        "Short": 134135
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134136,
                        "Short": 134137
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134138,
                        "Short": 134139
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_TU_VOLVERAS,
        "Name": "Tú Volverás",
        "Artist": "Ketama",
        "Length": 11177,
        "ShortLength": 6113,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Ya Todo Acabó",
                "Id": 527300,
                "TargetScore": 7140
            },
            "Hard": {
                "Title": "Nunca Me Olvidarán",
                "Id": 527224,
                "TargetScore": 6600
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Y Mi Corazón Soñando",
                        "Id": 527225,
                        "TotalPhraseCount": 83
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134140,
                        "Short": 134141
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134142,
                        "Short": 134143
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134144,
                        "Short": 134145
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_ROSAS,
        "Name": "Rosas",
        "Artist": "La Oreja de Van Gogh",
        "Length": 11679,
        "ShortLength": 6805,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Hoy Va a Ser El Día Menos Pensado",
                "Id": 527301,
                "TargetScore": 7290
            },
            "Hard": {
                "Title": "Quieta, Hoy Quizás Sí",
                "Id": 527226,
                "TargetScore": 6750
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Un Placer Coincidir en Esta Vida",
                        "Id": 527227,
                        "TotalPhraseCount": 93
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134146,
                        "Short": 134147
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134148,
                        "Short": 134149
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134150,
                        "Short": 134151
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_CAROLINA,
        "Name": "Carolina",
        "Artist": "M-Clan",
        "Length": 13089,
        "ShortLength": 6699,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Esa Va a Ser Mi Ruina",
                "Id": 527302,
                "TargetScore": 6180
            },
            "Hard": {
                "Title": "Del Norte de España",
                "Id": 527228,
                "TargetScore": 5640
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "El Diablo Está en Mi Vida",
                        "Id": 527229,
                        "TotalPhraseCount": 73
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134152,
                        "Short": 134153
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134154,
                        "Short": 134155
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134156,
                        "Short": 134157
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_DESESPERADA,
        "Name": "Desesperada",
        "Artist": "Marta Sànchez",
        "Length": 11165,
        "ShortLength": 5807,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Soy Una Mujer Normal",
                "Id": 527303,
                "TargetScore": 7300
            },
            "Hard": {
                "Title": "El Dolor Me Vuelve de Papel",
                "Id": 527230,
                "TargetScore": 6760
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Dejar la Oscuridad Sepultada en la Profundidad Del Mar",
                        "Id": 527231,
                        "TotalPhraseCount": 94
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134158,
                        "Short": 134159
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134160,
                        "Short": 134161
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134162,
                        "Short": 134163
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_AMANTE_BANDIDO,
        "Name": "Amante Bandido",
        "Artist": "Miguel Bosé",
        "Length": 13555,
        "ShortLength": 5919,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Yo Seré El Viento Que Va",
                "Id": 527304,
                "TargetScore": 6980
            },
            "Hard": {
                "Title": "Yo Seré Tormento Y Amor",
                "Id": 527232,
                "TargetScore": 6440
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Renunciaré a Ser Lo Que Fui",
                        "Id": 527233,
                        "TotalPhraseCount": 93
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134164,
                        "Short": 134165
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134166,
                        "Short": 134167
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134168,
                        "Short": 134169
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_BIENVENIDOS,
        "Name": "Bienvenidos",
        "Artist": "Miguel Ríos",
        "Length": 12375,
        "ShortLength": 7685,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Hijos Del Rock and Roll",
                "Id": 527305,
                "TargetScore": 6660
            },
            "Hard": {
                "Title": "Sólo Por Ti El Rock Existirá",
                "Id": 527234,
                "TargetScore": 6120
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Os Saludan Los Aliados de la Noche",
                        "Id": 527235,
                        "TotalPhraseCount": 82
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134170,
                        "Short": 134171
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134172,
                        "Short": 134173
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134174,
                        "Short": 134175
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_LOKO,
        "Name": "Loko",
        "Artist": "Mürfila",
        "Length": 12419,
        "ShortLength": 5305,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "El Mundo Va Al Reves",
                "Id": 527306,
                "TargetScore": 6490
            },
            "Hard": {
                "Title": "Vamonos de Este Caos",
                "Id": 527236,
                "TargetScore": 5950
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Vamos a Hacer Muchas Pupita",
                        "Id": 527237,
                        "TotalPhraseCount": 92
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134176,
                        "Short": 134177
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134178,
                        "Short": 134179
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134180,
                        "Short": 134181
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_CHICA_DE_AYER,
        "Name": "Chica De Ayer",
        "Artist": "Nacha Pop",
        "Length": 13719,
        "ShortLength": 5795,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Las Calles Mojadas Te Han Visto Crecer",
                "Id": 527307,
                "TargetScore": 7440
            },
            "Hard": {
                "Title": "Jugando Con Las Flores, en Mi Jardín",
                "Id": 527238,
                "TargetScore": 6900
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Tus Cabellos Dorados Parecen El Sol",
                        "Id": 527239,
                        "TotalPhraseCount": 48
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134182,
                        "Short": 134183
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134184,
                        "Short": 134185
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134186,
                        "Short": 134187
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_UN_BESO_Y_UNA_FLOR,
        "Name": "Un Beso Y Una Flor",
        "Artist": "Nino Bravo",
        "Length": 11312,
        "ShortLength": 5915,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Dejaré Mi Tierra Por Ti",
                "Id": 527308,
                "TargetScore": 6970
            },
            "Hard": {
                "Title": "Serás Como Una Luz Que Alumbre Mi Camino",
                "Id": 527240,
                "TargetScore": 6430
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Lo Que Nos Es Querido Siempre Queda Atrás",
                        "Id": 527241,
                        "TotalPhraseCount": 68
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134188,
                        "Short": 134189
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134190,
                        "Short": 134191
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134192,
                        "Short": 134193
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_COMO_HEMOS_CAMBIADO,
        "Name": "Cómos Hemos Cambiado",
        "Artist": "Presuntos Implicados",
        "Length": 12965,
        "ShortLength": 6783,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Asi Como El Viento Lo Abandona Todo Al Paso",
                "Id": 527309,
                "TargetScore": 6480
            },
            "Hard": {
                "Title": "Fu Asi Como Tu Y Yo Perdimos la Confianza",
                "Id": 527242,
                "TargetScore": 5940
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Tantos Sueos Por Cumplir, Alguno Se Ha de Vivir",
                        "Id": 527243,
                        "TotalPhraseCount": 91
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134194,
                        "Short": 134195
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134196,
                        "Short": 134197
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134198,
                        "Short": 134199
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_JUST_LIKE_A_PILL,
        "Name": "Just Like A Pill",
        "Artist": "Pink",
        "Length": 11727,
        "ShortLength": 7605,
        "Region": REGION_SPAIN,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_SPAIN_EVERY_BREATH_YOU_TAKE,
        "Name": "Every Breath You Take",
        "Artist": "The Police",
        "Length": 11499,
        "ShortLength": 5595,
        "Region": REGION_SPAIN,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 2,
                "Name": ""
            }
        ]
    },
    {
        "Id": SONG_SPAIN_SI_ES_TAN_SOLO_AMOR,
        "Name": "Si Es Tan Solo Amor",
        "Artist": "Revólver",
        "Length": 12256,
        "ShortLength": 7353,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Tú Me Diste Un Beso Sin Saber Por Qué",
                "Id": 527310,
                "TargetScore": 6500
            },
            "Hard": {
                "Title": "¿Cuántas Carreteras Yo Quemé Por Mi?",
                "Id": 527244,
                "TargetScore": 5960
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Algo Tan Hermoso No Puede Quemar",
                        "Id": 527245,
                        "TotalPhraseCount": 66
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134200,
                        "Short": 134201
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134202,
                        "Short": 134203
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134204,
                        "Short": 134205
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_QUIERO_BESARTE,
        "Name": "Quiero Besarte",
        "Artist": "Roser",
        "Length": 10369,
        "ShortLength": 5835,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Toda la Noche, Bailando Y Bailando",
                "Id": 527311,
                "TargetScore": 6020
            },
            "Hard": {
                "Title": "Tu Eres Mi Locura Eres Mi Obsesion",
                "Id": 527246,
                "TargetScore": 5480
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "No Se Lo Que Me Das, Que Ya No Puedo Mas",
                        "Id": 527247,
                        "TotalPhraseCount": 91
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134206,
                        "Short": 134207
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134208,
                        "Short": 134209
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134210,
                        "Short": 134211
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_CHIQUILLA,
        "Name": "Chiquilla",
        "Artist": "Seguridad Social",
        "Length": 8643,
        "ShortLength": 5208,
        "Region": REGION_SPAIN,
        "Exclusive": true,
        "Achievements": {
            "Easy": {
                "Title": "Yo Llevo to El Dia Sufriendo",
                "Id": 527312,
                "TargetScore": 7760
            },
            "Hard": {
                "Title": "Tengo Una Cosa Que Me Arde Dentro",
                "Id": 527248,
                "TargetScore": 7220
            }
        },
        "Parts": [
            {
                "Id": 2,
                "Name": "",
                "Achievements": {
                    "PhraseBonuses": {
                        "Title": "Sus Ojos Llevan El Fuego de Alguna Estrella",
                        "Id": 527249,
                        "TotalPhraseCount": 61
                    }
                },
                "LeaderboardIds": {
                    DIFFICULTY_EASY: {
                        "Normal": 134212,
                        "Short": 134213
                    },
                    DIFFICULTY_MEDIUM: {
                        "Normal": 134214,
                        "Short": 134215
                    },
                    DIFFICULTY_HARD: {
                        "Normal": 134216,
                        "Short": 134217
                    }
                }
            }
        ]
    },
    {
        "Id": SONG_SPAIN_I_GOT_YOU_BABE,
        "Name": "I Got You Babe",
        "Artist": "Sonny & Cher",
        "Length": 9479,
        "ShortLength": 4595,
        "Region": REGION_SPAIN,
        "Exclusive": false,
        "Parts": [
            {
                "Id": 0,
                "Name": "Sonny"
            },
            {
                "Id": 1,
                "Name": "Cher"
            }
        ]
    }
]

function format_song_length(song_length) {
    minutes = song_length / 3000
    seconds = song_length % 3000 / 50
    if (seconds < 10) {
        seconds = "0" + seconds
    }
    return minutes + ":" + seconds
}

SONG_TO_NAME = {}
SONG_TO_ARTIST_NAME = {}
SONG_TO_LENGTH = {}
SONG_TO_LENGTH_FORMATTED = {}
SONG_TO_SHORT_LENGTH = {}
SONG_TO_SHORT_LENGTH_FORMATTED = {}
PART_TO_NAME = {}
for song in SONG_DETAILS {
    id = song["Id"]
    SONG_TO_NAME[id] = song["Name"]
    SONG_TO_ARTIST_NAME[id] = song["Artist"]
    SONG_TO_LENGTH[id] = song["Length"]
    SONG_TO_LENGTH_FORMATTED[id] = format_song_length(song["Length"])
    SONG_TO_SHORT_LENGTH[id] = song["ShortLength"]
    SONG_TO_SHORT_LENGTH_FORMATTED[id] = format_song_length(song["ShortLength"])
    for part in song["Parts"] {
        if (part["Name"] == "") {
            part_format = ""
        } else {
            part_format = format("({0}) ", part["Name"])
        }
        PART_TO_NAME[id + part["Id"]] = part_format
    }
}


// == RICH PRESENCE ==

IS_IN_SOLO_MODE_ADDR = {
    REGION_FRANCE: 0x002de3e8,
    REGION_GERMANY: 0x002dc9d8,
    REGION_ITALY: 0x002de3d8,
    REGION_SPAIN: 0x002de1d8
}
IS_IN_SOLO_MODE_SOLO_VALUE = {
    REGION_FRANCE: 0x01f64b00,
    REGION_GERMANY: 0x01f62fe0,
    REGION_ITALY: 0x01f64b00,
    REGION_SPAIN: 0x01f64900
}
IS_IN_SOLO_MODE_FREESTYLE_VALUE = {
    REGION_FRANCE: 0x01f614d0,
    REGION_GERMANY: 0x01f5f9b0,
    REGION_ITALY: 0x01f614d0,
    REGION_SPAIN: 0x01f612d0
}
IS_IN_SOLO_MODE_PARTY_VALUE = {
    REGION_FRANCE: 0x01f68190,
    REGION_GERMANY: 0x01f66670,
    REGION_ITALY: 0x01f68190,
    REGION_SPAIN: 0x01f67f90
}
function is_in_solo_mode(region) => dword(IS_IN_SOLO_MODE_ADDR[region]) == IS_IN_SOLO_MODE_SOLO_VALUE[region]
function is_in_freestyle_mode(region) => dword(IS_IN_SOLO_MODE_ADDR[region]) == IS_IN_SOLO_MODE_FREESTYLE_VALUE[region]
function is_in_party_mode(region) => dword(IS_IN_SOLO_MODE_ADDR[region]) == IS_IN_SOLO_MODE_PARTY_VALUE[region]

SONG_DETAILS_POINTER_ADDR = {
    REGION_FRANCE: 0x0034e958,
    REGION_GERMANY: 0x0034ce48,
    REGION_ITALY: 0x0034e958,
    REGION_SPAIN: 0x0034e758
}

function is_in_region(region) {
    return ascii_string_equals(MASTER_DISC_NAME_ADDR[region], MASTER_DISC_EXPECTED_STRING[region], length(MASTER_DISC_EXPECTED_STRING[region]))
}

CURRENT_SONG_DETAILS_ADDR = {
    REGION_FRANCE: 0x00d255e4,
    REGION_GERMANY: 0x00cac694,
    REGION_ITALY: 0x00cb69b4,
    REGION_SPAIN: 0x00cb7884
}

function current_song_id(region) => dword(dword(CURRENT_SONG_DETAILS_ADDR[region]))
function is_song_short_version(region) => dword(dword(CURRENT_SONG_DETAILS_ADDR[region]) + 4) == 1

function song_part_id(region) => dword(dword(CURRENT_SONG_DETAILS_ADDR[region]) + 0xc)

DIFFICULTY_ADDR = {
    REGION_FRANCE: 0x00d2560c,
    REGION_GERMANY: 0x00cac6bc,
    REGION_ITALY: 0x00c3b9e8,
    REGION_SPAIN: 0x00cb78ac
} // This is behind some pointers but it's stable enough to reference directly.
function difficulty(region) => dword(DIFFICULTY_ADDR[region])

function phrase_bonus(region) => dword(dword(SONG_DETAILS_POINTER_ADDR[region]) + 0x02f8) // This is making some assumptions about the structure but it's stable enough
function total_score(region) => dword(dword(SONG_DETAILS_POINTER_ADDR[region]) + 0x02fc) // This is making some assumptions about the structure but it's stable enough

SONG_POSITION_ADDR = {
    REGION_FRANCE: 0x002de5fc,
    REGION_GERMANY: 0x002dcbdc,
    REGION_ITALY: 0x002de5ec,
    REGION_SPAIN: 0x002de3ec
}
function song_position(region) => dword(SONG_POSITION_ADDR[region])

CURRENT_DISC_NAME_ADDR = {
    REGION_FRANCE: 0x00854910,
    REGION_GERMANY: 0x008bb820,
    REGION_ITALY: 0x008546b0,
    REGION_SPAIN: 0x00853eb0
}
MASTER_DISC_NAME_ADDR = {
    REGION_FRANCE: 0x00854630,
    REGION_GERMANY: 0x008bb350,
    REGION_ITALY: 0x008546e0,
    REGION_SPAIN: 0x008541c0
}
MASTER_DISC_EXPECTED_STRING = {
    REGION_FRANCE: "52828#SingStar NRJ",
    REGION_GERMANY: "52829#SingStar Party",
    REGION_ITALY: "52827#SingStar Party",
    REGION_SPAIN: "52830#SingStar Party"
}
function is_master_disc_in_use(region) => ascii_string_equals(CURRENT_DISC_NAME_ADDR[region], MASTER_DISC_EXPECTED_STRING[region], length(MASTER_DISC_EXPECTED_STRING[region])) && ascii_string_equals(MASTER_DISC_NAME_ADDR[region], MASTER_DISC_EXPECTED_STRING[region], length(MASTER_DISC_EXPECTED_STRING[region]))

IS_IN_PASS_THE_MIC_MODE_ADDR = {
    REGION_FRANCE: 0x0033a7c8,
    REGION_GERMANY: 0x00338cc8,
    REGION_ITALY: 0x0033a7c8,
    REGION_SPAIN: 0x0033a5c8
}
function is_in_pass_the_mic_mode(region) => dword(IS_IN_PASS_THE_MIC_MODE_ADDR[region]) == 0x01

PASS_THE_MIC_SCORE_DETAILS = {
    REGION_FRANCE: 0x0033a78c,
    REGION_GERMANY: 0x00338c8c,
    REGION_ITALY: 0x0033a78c,
    REGION_SPAIN: 0x0033a58c
}
function pass_the_mic_blue_score(region) => dword(dword(PASS_THE_MIC_SCORE_DETAILS[region]) + 0x0014)
function pass_the_mic_red_score(region) => dword(dword(PASS_THE_MIC_SCORE_DETAILS[region]) + 0x01e4)

for region in REGION_TO_SHORT_NAME {
    if (region != REGION_EUROPE) {
        region_name = REGION_TO_SHORT_NAME[region]

        rich_presence_conditional_display(is_in_region(region) && !is_master_disc_in_use(region), "[" + region_name + "] Singing with a different disc")
        rich_presence_conditional_display(is_in_region(region) && is_in_pass_the_mic_mode(region),  "[" + region_name + "] Pass The Mic Mode: Blue {0} vs. Red {1}",
            rich_presence_macro("Number", pass_the_mic_blue_score(region)),
            rich_presence_macro("Number", pass_the_mic_red_score(region))
        )
        rich_presence_conditional_display(is_in_region(region) && is_in_solo_mode(region) && is_song_short_version(region) && song_position(region) > 0,  "[" + region_name + "] Solo Mode: {0} {1}(Short) by {2} - Difficulty: {3}, Score: {4}, Time: {5}/{6}",
            rich_presence_lookup("SongName", current_song_id(region), SONG_TO_NAME),
            rich_presence_lookup("PartName", current_song_id(region) + song_part_id(region), PART_TO_NAME),
            rich_presence_lookup("ArtistName", current_song_id(region), SONG_TO_ARTIST_NAME),
            rich_presence_lookup("Difficulty", difficulty(region), DIFFICULTY_TO_NAME),
            rich_presence_macro("Number", total_score(region)),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLengthShort", current_song_id(region), SONG_TO_SHORT_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(is_in_region(region) && is_in_solo_mode(region) && song_position(region) > 0,  "[" + region_name + "] Solo Mode: {0} {1}by {2} - Difficulty: {3}, Score: {4}, Time: {5}/{6}",
            rich_presence_lookup("SongName", current_song_id(region), SONG_TO_NAME),
            rich_presence_lookup("PartName", current_song_id(region) + song_part_id(region), PART_TO_NAME),
            rich_presence_lookup("ArtistName", current_song_id(region), SONG_TO_ARTIST_NAME),
            rich_presence_lookup("Difficulty", difficulty(region), DIFFICULTY_TO_NAME),
            rich_presence_macro("Number", total_score(region)),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLength", current_song_id(region), SONG_TO_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(is_in_region(region) && is_in_freestyle_mode(region) && is_song_short_version(region) && song_position(region) > 0,  "[" + region_name + "] Freestyle Mode: {0} {1}(Short) by {2} - Time: {3}/{4}",
            rich_presence_lookup("SongName", current_song_id(region), SONG_TO_NAME),
            rich_presence_lookup("PartName", current_song_id(region) + song_part_id(region), PART_TO_NAME),
            rich_presence_lookup("ArtistName", current_song_id(region), SONG_TO_ARTIST_NAME),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLengthShort", current_song_id(region), SONG_TO_SHORT_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(is_in_region(region) && is_in_freestyle_mode(region) && song_position(region) > 0,  "[" + region_name + "] Freestyle Mode: {0} {1}by {2} - Time: {3}/{4}",
            rich_presence_lookup("SongName", current_song_id(region), SONG_TO_NAME),
            rich_presence_lookup("PartName", current_song_id(region) + song_part_id(region), PART_TO_NAME),
            rich_presence_lookup("ArtistName", current_song_id(region), SONG_TO_ARTIST_NAME),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLength", current_song_id(region), SONG_TO_LENGTH_FORMATTED)
        )
        // NOTE: The P2 score hasn't been found, but it's just for rich presence and isn't relevant.
        rich_presence_conditional_display(is_in_region(region) && is_in_party_mode(region) && is_song_short_version(region) && song_position(region) > 0,  "[" + region_name + "] Party Mode: {0} {1}(Short) by {2} - Difficulty: {3}, Score: {4}, Time: {5}/{6}",
            rich_presence_lookup("SongName", current_song_id(region), SONG_TO_NAME),
            rich_presence_lookup("PartName", current_song_id(region) + song_part_id(region), PART_TO_NAME),
            rich_presence_lookup("ArtistName", current_song_id(region), SONG_TO_ARTIST_NAME),
            rich_presence_lookup("Difficulty", difficulty(region), DIFFICULTY_TO_NAME),
            rich_presence_macro("Number", total_score(region)),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLengthShort", current_song_id(region), SONG_TO_SHORT_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(is_in_region(region) && is_in_party_mode(region) && song_position(region) > 0,  "[" + region_name + "] Party Mode: {0} {1}by {2} - Difficulty: {3}, Score: {4}, Time: {5}/{6}",
            rich_presence_lookup("SongName", current_song_id(region), SONG_TO_NAME),
            rich_presence_lookup("PartName", current_song_id(region) + song_part_id(region), PART_TO_NAME),
            rich_presence_lookup("ArtistName", current_song_id(region), SONG_TO_ARTIST_NAME),
            rich_presence_lookup("Difficulty", difficulty(region), DIFFICULTY_TO_NAME),
            rich_presence_macro("Number", total_score(region)),
            rich_presence_macro("Seconds", song_position(region) / 50),
            rich_presence_lookup("SongLength", current_song_id(region), SONG_TO_LENGTH_FORMATTED)
        )
        rich_presence_conditional_display(is_in_region(region), "[" + region_name + "] Looking through menus")
    }
}
rich_presence_display("Booting up...")


// == LEADERBOARDS ==

function start_leaderboard(region, song_id, part_id, song_difficulty, is_short) {
    if (is_short == true) {
        length_condition = is_song_short_version(region)
    } else {
        length_condition = !is_song_short_version(region)
    }
    return is_master_disc_in_use(region)
        && !is_in_pass_the_mic_mode(region)
        && is_in_solo_mode(region)
        && song_position(region) == 2
        && prev(song_position(region)) == 1
        && current_song_id(region) == song_id
        && song_part_id(region) == part_id
        && difficulty(region) == song_difficulty
        && length_condition
}

function cancel_leaderboard(region) {
    return !is_in_solo_mode(region) || song_position(region) == 0
}

SONG_STATE_ADDR = {
    REGION_FRANCE: 0x0034d7ac,
    REGION_GERMANY: 0x0034bca4,
    REGION_ITALY: 0x0034d7ac,
    REGION_SPAIN: 0x0034d5ac
}
QUIT_SONG_DETECTOR_ADDR = {
    REGION_FRANCE: 0x00386464,
    REGION_GERMANY: 0x00384964,
    REGION_ITALY: 0x00386464,
    REGION_SPAIN: 0x00386264
}
QUIT_SONG_DETECTOR_VALUE = {
    REGION_FRANCE: 0x00002910,
    REGION_GERMANY: 0x000028d0,
    REGION_ITALY: 0x00002920,
    REGION_SPAIN: 0x00002920
}
function did_song_just_finish(region) => (prev(dword(SONG_STATE_ADDR[region])) == 0x01 || prev(dword(SONG_STATE_ADDR[region])) == 0x04) && dword(SONG_STATE_ADDR[region]) == 0x02 && dword(QUIT_SONG_DETECTOR_ADDR[region]) != QUIT_SONG_DETECTOR_VALUE[region]

function submit_leaderboard(region) {
    return did_song_just_finish(region)
}

function leaderboard_value(region) {
    return total_score(region)
}

for song in SONG_DETAILS {
    if (song["Exclusive"] == true) {
        song_name = song["Name"]
        song_id = song["Id"]
        song_region = song["Region"]
        region_name = REGION_TO_SHORT_NAME[song_region]
        for part in song["Parts"] {
            if (part["Name"] == "") {
                part_title_format = ""
                part_description_format = ""
            } else {
                part_title_format = format("({0}) ", part["Name"])
                part_description_format = format("as {0} ", part["Name"])
            }
            part_id = part["Id"]
            for song_difficulty in DIFFICULTY_TO_NAME {
                part_name = song["Name"]
                difficulty_name = DIFFICULTY_TO_NAME[song_difficulty]
                normal_leaderboard_id = part["LeaderboardIds"][song_difficulty]["Normal"]
                leaderboard(
                    title = format("[{0}] {1} {2}- {3} - Highest Score", region_name, song_name, part_title_format, difficulty_name),
                    description = format("Highest score for {0} {1}on {2} in Sing Solo mode", song_name, part_description_format, difficulty_name),
                    id = normal_leaderboard_id,
                    start = start_leaderboard(song_region, song_id, part_id, song_difficulty, false),
                    cancel = cancel_leaderboard(song_region),
                    submit = submit_leaderboard(song_region),
                    value = leaderboard_value(song_region),
                    format = "VALUE"
                )

                // Fun edge-case with Ain't No Sunshine
                if (song["ShortLength"] > 0) {
                    short_leaderboard_id = part["LeaderboardIds"][song_difficulty]["Short"]
                    leaderboard(
                        title = format("[{0}] {1} {2}(Short) - {3} - Highest Score", region_name, song_name, part_title_format, difficulty_name),
                        description = format("Highest score for {0} (Short) {1}on {2} in Sing Solo mode", song_name, part_description_format, difficulty_name),
                        id = short_leaderboard_id,
                        start = start_leaderboard(song_region, song_id, part_id, song_difficulty, true),
                        cancel = cancel_leaderboard(song_region),
                        submit = submit_leaderboard(song_region),
                        value = leaderboard_value(song_region),
                        format = "VALUE"
                    )
                }
            }
        }
    }
}


// == ACHIEVEMENTS ==
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

for song in SONG_DETAILS {
    if (song["Exclusive"] == true) {
        song_name = song["Name"]
        song_id = song["Id"]
        song_region = song["Region"]
        region_name = REGION_TO_SHORT_NAME[song_region]
        if (array_reduce(song["Parts"], 0, (acc, value) => acc + 1) > 1) {
            with_any_part_phrase = "with either singer part "
        } else {
            with_any_part_phrase = ""
        }
        easy_target_score = song["Achievements"]["Easy"]["TargetScore"]
        achievement(
            title = "[" + region_name + "] " + song["Achievements"]["Easy"]["Title"],
            description = format("Achieve a score of {0} or more on {1} (normal length) {2}on any difficulty in Sing Solo mode", format_int_with_commas(easy_target_score), song_name, with_any_part_phrase),
            points = 5,
            id = song["Achievements"]["Easy"]["Id"],
            trigger = (
                is_master_disc_in_use(song_region)
                    && !is_in_pass_the_mic_mode(song_region)
                    && is_in_solo_mode(song_region)
                    && !is_song_short_version(song_region)
                    && did_song_just_finish(song_region)
                    && current_song_id(song_region) == song_id
                    && total_score(song_region) >= easy_target_score
            )
        )

        hard_target_score = song["Achievements"]["Hard"]["TargetScore"]
        achievement(
            title = "[" + region_name + "] " + song["Achievements"]["Hard"]["Title"],
            description = format("Achieve a score of {0} or more on {1} (normal length) {2}on the hard difficulty in Sing Solo mode", format_int_with_commas(hard_target_score), song_name, with_any_part_phrase),
            points = 5,
            id = song["Achievements"]["Hard"]["Id"],
            trigger = (
                is_master_disc_in_use(song_region)
                    && !is_in_pass_the_mic_mode(song_region)
                    && is_in_solo_mode(song_region)
                    && !is_song_short_version(song_region)
                    && difficulty(song_region) == DIFFICULTY_HARD
                    && did_song_just_finish(song_region)
                    && current_song_id(song_region) == song_id
                    && total_score(song_region) >= hard_target_score
            )
        )

        for part in song["Parts"] {
            if (part["Name"] == "") {
                part_format = ""
            } else {
                part_format = format("as {0} ", part["Name"])
            }
            part_id = part["Id"]
            total_phrase_count = part["Achievements"]["PhraseBonuses"]["TotalPhraseCount"]
            target_phrase_count = total_phrase_count * 3 / 4

            achievement(
                title = "[" + region_name + "] " + part["Achievements"]["PhraseBonuses"]["Title"],
                description = format("Get a phrase bonus on at least {0} of the {1} phrases on {2} {3}on the hard difficulty in Sing Solo mode", target_phrase_count, total_phrase_count, song_name, part_format),
                points = 10,
                id = part["Achievements"]["PhraseBonuses"]["Id"],
                trigger = (
                    measured(
                        repeated(target_phrase_count, prev(phrase_bonus(song_region)) < phrase_bonus(song_region)),
                        is_master_disc_in_use(song_region)
                            && !is_in_pass_the_mic_mode(song_region)
                            && is_in_solo_mode(song_region)
                            && !is_song_short_version(song_region)
                            && difficulty(song_region) == DIFFICULTY_HARD
                            && current_song_id(song_region) == song_id
                            && song_part_id(song_region) == part_id
                    )
                        && never(song_position(song_region) == 0)
                        && did_song_just_finish(song_region)
                )
            )
        }
    }
}