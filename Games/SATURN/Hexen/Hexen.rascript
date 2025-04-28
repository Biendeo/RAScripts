// Hexen
// #ID = 17973
// md5: 899e743677badd953e83afb663edbca3

MAP_WINNOWING_HALL          = 1
MAP_SEVEN_PORTALS           = 2
MAP_GUARDIAN_OF_ICE         = 3
MAP_GUARDIAN_OF_FIRE        = 4
MAP_GUARDIAN_OF_STEEL       = 5
MAP_BRIGHT_CRUCIBLE         = 6
MAP_SHADOW_WOOD             = 13
MAP_DARKMERE                = 8
MAP_CAVES_OF_CIRCE          = 9
MAP_WASTELANDS              = 10
MAP_SACRED_GROVE            = 11
MAP_HYPOSTYLE               = 12
MAP_HERESIARCHS_SEMINARY    = 27
MAP_ORCHARD_OF_LAMENTATIONS = 32
MAP_SILENT_REFECTORY        = 33
MAP_WOLF_CHAPEL             = 34
MAP_DRAGON_CHAPEL           = 28
MAP_GRIFFIN_CHAPEL          = 30
MAP_DEATHWIND_CHAPEL        = 31
MAP_CASTLE_OF_GRIEF         = 22
MAP_FORSAKEN_OUTPOST        = 21
MAP_GIBBET                  = 23
MAP_EFFLUVIUM               = 24
MAP_DUNGEONS                = 25
MAP_DESOLATE_GARDEN         = 26
MAP_NECROPOLIS              = 35
MAP_ZEDEKS_TOMB             = 36
MAP_MENELKIRS_TOMB          = 37
MAP_TRADUCTUS_TOMB          = 38
MAP_VIVARIUM                = 39
MAP_DARK_CRUCIBLE           = 40

ITEM_EMPTY                = 0x00
ITEM_ICON_OF_THE_DEFENDER = 0x01
ITEM_QUARTZ_FLASK         = 0x02
ITEM_MYSTIC_URN           = 0x03
ITEM_MYSTIC_AMBIT_INCANT  = 0x04
ITEM_DARK_SERVANT         = 0x05
ITEM_TORCH                = 0x06
ITEM_PORKALATOR           = 0x07
ITEM_WINGS_OF_WRATH       = 0x08
ITEM_CHAOS_DEVICE         = 0x09
ITEM_FLECHETTE            = 0x0a
ITEM_BANISHMENT_DEVICE    = 0x0b
ITEM_BOOTS_OF_SPEED       = 0x0c
ITEM_KRATER_OF_MIGHT      = 0x0d
ITEM_DRAGONSKIN_BRACERS   = 0x0e
ITEM_DISC_OF_REPULSION    = 0x0f
ITEM_YORICKS_SKULL        = 0x10
ITEM_HEART_OF_DSPARIL     = 0x11
ITEM_RUBY_PLANET          = 0x12
ITEM_EMERALD_PLANET_1     = 0x13
ITEM_EMERALD_PLANET_2     = 0x14
ITEM_SAPPHIRE_PLANET_1    = 0x15
ITEM_SAPPHIRE_PLANET_2    = 0x16
ITEM_DAEMON_CODEX         = 0x17
ITEM_LIBER_OSCURA         = 0x18
ITEM_FLAME_MASK           = 0x19
ITEM_GLAIVE_SEAL          = 0x1a
ITEM_HOLY_RELIC           = 0x1b
ITEM_SIGIL_OF_THE_MAGUS   = 0x1c
ITEM_CLOCK_GEAR           = 0x1d

KEY_STEEL   = 0
KEY_CAVE    = 1
KEY_AXE     = 2
KEY_FIRE    = 3
KEY_EMERALD = 4
KEY_DUNGEON = 5
KEY_SILVER  = 6
KEY_RUSTED  = 7
KEY_HORN    = 8
KEY_SWAMP   = 9
KEY_CASTLE  = 10

CHEAT_MENU_ADDR = 0x19a690

function are_cheats_on() {
	// This is a boolean so we can unswizzle this
	return word(CHEAT_MENU_ADDR + 2) == 1
}

CHEATS_ADDR = 0x19afd0

function is_no_clip_on() {
	return bit(2, CHEATS_ADDR + 2) == 1
}

function is_god_mode_on() {
	return bit(1, CHEATS_ADDR + 2) == 1
}

function is_slow_mode_on() {
	return bit(2, CHEATS_ADDR + 2) == 1
}

IS_IN_DEMO_ADDR = 0x19ad30

function is_in_demo() {
	// This is a boolean so we can unswizzle this
	return word(IS_IN_DEMO_ADDR + 2) == 1
}

IS_IN_GAME_ADDR = 0x19d980
function is_in_game() {
	// This is just a boolean so we can unswizzle it
	return word(IS_IN_GAME_ADDR + 2) == 1
		&& prev(word(IS_IN_GAME_ADDR + 2)) == 1 // This is to super assert nothing happens in the first frame of gameplay
}

IS_MAP_CHANGE_HAPPENING_ADDR = 0x190318

function is_map_change_happening() {
	return prev(word(IS_MAP_CHANGE_HAPPENING_ADDR)) == 0x0601 || word(IS_MAP_CHANGE_HAPPENING_ADDR) == 0x0601
}

function is_not_loading() {
	return prev(word(IS_MAP_CHANGE_HAPPENING_ADDR)) != 0x0609 && word(IS_MAP_CHANGE_HAPPENING_ADDR) != 0x0609
}

CURRENT_MAP_ADDR = 0x19a9d0

function current_map() {
	// The last map is 40 so we can unswizzle this
	return word(CURRENT_MAP_ADDR + 2)
}

function player_is_in_map(map) {
	return !is_map_change_happening() && current_map() == map
}

function player_travelled_between_maps(prev_map, new_map) {
	return is_map_change_happening()
		&& prev(current_map()) == prev_map
		&& current_map() == new_map
}

// This is a swizzled 32-bit value, but there's only 11 keys in the game so we can look for the lower 16 bits easily
KEY_BITMASK_ADDR = 0x19af98

function did_player_pick_up_key(key) {
	condition = always_true()
	// This asserts that when a key is picked up, all other keys also weren't updated at the same time.
	// This case happens when the player dies and reloads mid-map (which isn't loading a save or transferring between maps).
	// Technically you could incorrect trigger the very first key achievement with this, but you'd had to have also picked up the key and somehow
	// left the map, so this is most likely safe.
	for i in range(0, 10) {
		if (i == key) {
			condition = condition && prev(bit(key, KEY_BITMASK_ADDR + 2)) == 0 && bit(key, KEY_BITMASK_ADDR + 2) == 1
		} else {
			condition = condition && prev(bit(i, KEY_BITMASK_ADDR + 2)) == bit(i, KEY_BITMASK_ADDR + 2)
		}
	}
	return condition
}

function ensure_keys_are_not_acquired(keys) {
	return all_of(keys, key => bit(key, KEY_BITMASK_ADDR + 2) == 0)
}

function are_player_keys_stable() {
	// On player death, the keys are reset to zero for a moment. We can ensure that if the player picked up something that's not a key then the keys would be stable.
	return prev(word(KEY_BITMASK_ADDR + 2)) == word(KEY_BITMASK_ADDR + 2)
}

INVENTORY_ADDR = 0x19ae78
INVENTORY_LENGTH_ADDR = 0x19af70

function has_player_acquired_item(item) {
	// Items only go up to value 0x1d, and the player can only hold 25 of it, so we can unswizzle these values
	return any_of(range(0, 28), i => word(INVENTORY_LENGTH_ADDR + 2) > i && word(INVENTORY_ADDR + (8 * i) + 2) == item && word(INVENTORY_ADDR + (8 * i) + 6) >= 1)
}

function did_player_pick_up_item(item) {
	return any_of(
		range(0, 28), i =>
			(
				word(INVENTORY_ADDR + (8 * i) + 2) == item
				&& prev(word(INVENTORY_ADDR + (8 * i) + 6)) + 1 == word(INVENTORY_ADDR + (8 * i) + 6)
			) || (
				prev(word(INVENTORY_ADDR + (8 * i) + 2)) != item
				&& word(INVENTORY_ADDR + (8 * i) + 2) == item
				&& word(INVENTORY_ADDR + (8 * i) + 6) == 1
			)
	) && are_player_keys_stable()
	// This stops accidental detected if you've used an item and they're reshuffling.
	// There's an odd case when a player might use an item the same frame as picking up a different item, but this is super rare.
	&& prev(word(INVENTORY_LENGTH_ADDR + 2)) <= word(INVENTORY_LENGTH_ADDR + 2)
}

function did_player_use_item(item) {
	return any_of(
		range(0, 28), i =>
			(
				word(INVENTORY_ADDR + (8) + 2) == item
				&& prev(word(INVENTORY_ADDR + (8 * i) + 6)) - 1 == word(INVENTORY_ADDR + (8 * i) + 6)
			) || (
				prev(word(INVENTORY_ADDR + (8 * i) + 2)) == item
				&& word(INVENTORY_ADDR + (8 * i) + 2) == 0
				&& prev(word(INVENTORY_ADDR + (8 * i) + 6)) == 1
				&& word(INVENTORY_ADDR + (8 * i) + 6) == 0
			)
	) && are_player_keys_stable()
}

function ensure_items_are_not_acquired(items) {
	return all_of(items, item => !has_player_acquired_item(item))
}

// These are swizzled fixed decimal values, so the higher 16-bits are actually the integer we want to look for
MESH_ARMOR_ADDR = 0x19ae68
FALCON_SHIELD_ADDR = 0x19ae6c
PLATINUM_HELMET_ADDR = 0x19ae70
AMULET_OF_WARDING_ADDR = 0x19ae74

function did_player_pick_up_mesh_armor() {
	return prev(word(MESH_ARMOR_ADDR)) < word(MESH_ARMOR_ADDR)
		&& prev(word(FALCON_SHIELD_ADDR)) == word(FALCON_SHIELD_ADDR)
		&& prev(word(PLATINUM_HELMET_ADDR)) == word(PLATINUM_HELMET_ADDR)
		&& prev(word(AMULET_OF_WARDING_ADDR)) == word(AMULET_OF_WARDING_ADDR)
		&& are_player_keys_stable()
}

function did_player_pick_up_falcon_shield() {
	return prev(word(MESH_ARMOR_ADDR)) == word(MESH_ARMOR_ADDR)
		&& prev(word(FALCON_SHIELD_ADDR)) < word(FALCON_SHIELD_ADDR)
		&& prev(word(PLATINUM_HELMET_ADDR)) == word(PLATINUM_HELMET_ADDR)
		&& prev(word(AMULET_OF_WARDING_ADDR)) == word(AMULET_OF_WARDING_ADDR)
		&& are_player_keys_stable()
}

function did_player_pick_up_platinum_helmet() {
	return prev(word(MESH_ARMOR_ADDR)) == word(MESH_ARMOR_ADDR)
		&& prev(word(FALCON_SHIELD_ADDR)) == word(FALCON_SHIELD_ADDR)
		&& prev(word(PLATINUM_HELMET_ADDR)) < word(PLATINUM_HELMET_ADDR)
		&& prev(word(AMULET_OF_WARDING_ADDR)) == word(AMULET_OF_WARDING_ADDR)
		&& are_player_keys_stable()
}

function did_player_pick_up_amulet_of_warding() {
	return prev(word(MESH_ARMOR_ADDR)) == word(MESH_ARMOR_ADDR)
		&& prev(word(FALCON_SHIELD_ADDR)) == word(FALCON_SHIELD_ADDR)
		&& prev(word(PLATINUM_HELMET_ADDR)) == word(PLATINUM_HELMET_ADDR)
		&& prev(word(AMULET_OF_WARDING_ADDR)) < word(AMULET_OF_WARDING_ADDR)
		&& are_player_keys_stable()
}

MAPVAR_ADDR = 0x19a4d4

function map_var_value(index) {
	// The highest any mapvar reaches is 40, so we can unswizzle this
	return word(MAPVAR_ADDR + (4 * index) + 2)
}

QUEUED_ACS_EXECUTE_ADDR = 0x19aa50

function did_cross_map_script_queue_up(map, script_num) {
	return any_of(
		range(0, 20), i =>
			word(QUEUED_ACS_EXECUTE_ADDR + (12 * i) + 2) == map
			&& word(QUEUED_ACS_EXECUTE_ADDR + (12 * i) + 6) == script_num
			&& (
				prev(word(QUEUED_ACS_EXECUTE_ADDR + (12 * i) + 2)) != map
				|| prev(word(QUEUED_ACS_EXECUTE_ADDR + (12 * i) + 6)) != script_num
			)
	) && are_player_keys_stable()
}

WEAPON_UNLOCKED_ADDR = 0x19afb0

function did_weapon_just_unlock(weapon_num) {
	// These are all booleans so we can unswizzle this
	return prev(word(WEAPON_UNLOCKED_ADDR + (4 * weapon_num) + 2)) == 0
		&& word(WEAPON_UNLOCKED_ADDR + (4 * weapon_num) + 2) == 1
		&& are_player_keys_stable()
}

FINAL_WEAPON_PIECE_ADDR = 0x19af9c

function did_player_pick_up_final_weapon_piece(piece_num) {
	// This bitmask only has three bits so we can unswizzle this
	return prev(bit(piece_num, FINAL_WEAPON_PIECE_ADDR + 2)) == 0
		&& bit(piece_num, FINAL_WEAPON_PIECE_ADDR + 2) == 1
		&& are_player_keys_stable()
}

DIFFICULTY_ADDR = 0x1a9a5c

function difficulty() {
	// This only goes up to 4 so we can unswizzle this
	return word(DIFFICULTY_ADDR + 2)
}

function is_player_on_hard_difficulty() {
	return difficulty() >= 3
}

FMV_ADDR = 0x19cc30

function is_player_in_fmv() {
	// This is some bitmask, and we want this specific value so this is being treated unswizzled for the moment
	return dword(FMV_ADDR) == 0x8314060e
}

IS_PAST_BIOS_ADDR = 0x19afd8

function is_player_past_bios() {
	// This is only 0 checked so swizzling isn't an issue
	return dword(IS_PAST_BIOS_ADDR) == 0
}

function protect_against_non_game() {
	return disable_when(are_cheats_on() && is_player_past_bios())
		&& disable_when(is_god_mode_on() && is_player_past_bios())
		&& disable_when(is_no_clip_on() && is_player_past_bios())
		&& disable_when(is_slow_mode_on() && is_player_past_bios())
		&& !is_in_demo()
		&& is_not_loading()
		&& is_in_game()
}

achievement(
	title = "Playing With the Doors Again",
	points = 2,
	id = 508230,
	description = "Collect the Emerald Key in the Winnowing Halls",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_SILVER])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WINNOWING_HALL)
		&& did_player_pick_up_key(KEY_EMERALD)
	)
)

achievement(
	title = "Helm's Deep",
	points = 1,
	id = 508231,
	description = "Find the hidden Platinum Helmet in the Winnowing Halls",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_SILVER])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WINNOWING_HALL)
		&& did_player_pick_up_platinum_helmet()
	)
)

achievement(
	title = "School's Out",
	points = 2,
	id = 508232,
	description = "As a Mage, ring the bell in the Winnowing Halls without acquiring the Silver key",
	type = "",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_SILVER])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WINNOWING_HALL)
		&& prev(map_var_value(4)) == 0
		&& map_var_value(4) == 1
	)
)

achievement(
	title = "Stalagmites and Stalactites Shut Me In",
	points = 2,
	id = 508233,
	description = "Collect the Silver Key in the cave in the Winnowing Halls",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_FIRE, KEY_STEEL])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WINNOWING_HALL)
		&& did_player_pick_up_key(KEY_SILVER)
	)
)

achievement(
	title = "Greetings Mortal",
	points = 3,
	id = 508234,
	description = "Leave the Winnowing Halls and arrive at the Seven Portals",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_FIRE, KEY_STEEL])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_WINNOWING_HALL, MAP_SEVEN_PORTALS)
	)
)

achievement(
	title = "A Bit More Strength",
	points = 2,
	id = 508235,
	description = "Acquire your second weapon",
	type = "",
	trigger = (
		protect_against_non_game()
		&& !is_map_change_happening()
		&& did_weapon_just_unlock(1)
	)
)

achievement(
	title = "Swords of Revealing Light",
	points = 3,
	id = 508236,
	description = "Reveal the sword exit in the Guardian of Ice, which opens two doors in the Seven Portals",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_FIRE, KEY_STEEL])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_ICE)
		&& did_cross_map_script_queue_up(MAP_SEVEN_PORTALS, 29)
	)
)

achievement(
	title = "Korax Says",
	points = 2,
	id = 508237,
	description = "Pull the ONE THIRD switch at the beginning of the Guardian of Fire",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_FIRE, KEY_STEEL])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_FIRE)
		&& did_cross_map_script_queue_up(MAP_SEVEN_PORTALS, 20)
	)
)

achievement(
	title = "The Horned Face of Janus",
	points = 3,
	id = 508238,
	description = "Collect the Flame Mask at the end of the crumbling bridge in the Guardian of Fire",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_FIRE, KEY_STEEL])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_FIRE)
		&& did_player_pick_up_item(ITEM_FLAME_MASK)
	)
)

achievement(
	title = "Arming the Nuclear Device",
	points = 4,
	id = 508239,
	description = "Pull both ONE THIRD switches on the east side of Guardian of Steel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& measured(
			map_var_value(5) == 2,
			when = player_is_in_map(MAP_GUARDIAN_OF_STEEL)
		)
		&& prev(map_var_value(5)) == 1
	)
)

achievement(
	title = "Figure Skating",
	points = 2,
	id = 508240,
	description = "Find the hidden Torch (and its accompanying Mystic Urn) in the Guardian of Ice",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_ICE)
		&& did_player_pick_up_item(ITEM_TORCH)
	)
)

achievement(
	title = "Where's the Caveman?",
	points = 3,
	id = 508241,
	description = "Collect the Fire Key after melting the ice in the Guardian of Ice",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_ICE)
		&& did_player_pick_up_key(KEY_FIRE)
	)
)

achievement(
	title = "Escape These Caves of Ice",
	points = 3,
	id = 508242,
	description = "Collect the Steel Key in the crumbling room in the Guardian of Ice",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_ICE)
		&& did_player_pick_up_key(KEY_STEEL)
	)
)

achievement(
	title = "My Get Out of Jail Free Card",
	points = 1,
	id = 508243,
	description = "Find the hidden Chaos Device in the Guardian of Fire",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_FIRE)
		&& did_player_pick_up_item(ITEM_CHAOS_DEVICE)
	)
)

achievement(
	title = "Everyone Loves Ascending Fourths",
	points = 3,
	id = 508244,
	description = "Pull the switch in south of Guardian of Fire that raises the stairs in the Seven Portals",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_FIRE)
		&& did_cross_map_script_queue_up(2, 18)
	)
)

achievement(
	title = "Opening a Window",
	points = 2,
	id = 508245,
	description = "Climb the stairs in the Seven Portals that opens up the eastern room in the Guardian of Ice",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SEVEN_PORTALS)
		&& did_cross_map_script_queue_up(MAP_GUARDIAN_OF_ICE, 22)
	)
)

achievement(
	title = "They Call Me the Stairmaster",
	points = 4,
	id = 508246,
	description = "Pull both western switches in the Guardian of Steel to raise some stairs in the Seven Portals",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& measured(
			map_var_value(6) == 2,
			when = player_is_in_map(MAP_GUARDIAN_OF_STEEL)
		)
		&& prev(map_var_value(6)) == 1
	)
)

achievement(
	title = "Letting in a Breeze",
	points = 2,
	id = 508247,
	description = "Climb the stairs in the Seven Portals that opens up the western room in the Guardian of Ice",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SEVEN_PORTALS)
		&& did_cross_map_script_queue_up(MAP_GUARDIAN_OF_ICE, 21)
	)
)

achievement(
	title = "The Bulls Are Loose",
	points = 2,
	id = 508248,
	description = "Pull all three bull switches in the Seven Portals to open up the southern doors",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& measured(
			map_var_value(2) == 3,
			when = player_is_in_map(MAP_SEVEN_PORTALS)
		)
		&& prev(map_var_value(2)) == 2
	)
)

achievement(
	title = "The Gift of Hermes",
	points = 2,
	id = 508249,
	description = "Find the hidden Wings of Wrath in the Seven Portals",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SEVEN_PORTALS)
		&& did_player_pick_up_item(ITEM_WINGS_OF_WRATH)
	)
)

achievement(
	title = "Ground to Paste",
	points = 2,
	id = 508250,
	description = "Find the hidden Mystic Urn in the Guardian of Steel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_STEEL)
		&& did_player_pick_up_item(ITEM_MYSTIC_URN)
	)
)

achievement(
	title = "Lost and Foundry",
	points = 4,
	id = 508251,
	description = "Pick up the torch from the center of the Guardian of Steel and solve half of the mystery in revealing the secret level",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_STEEL)
		&& did_cross_map_script_queue_up(MAP_SEVEN_PORTALS, 1)
	)
)

achievement(
	title = "The Volcano's Tightrope",
	points = 4,
	id = 508252,
	description = "Pull the perilous switch in the Guardian of Fire and solve half of the mystery in revealing the secret level",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GUARDIAN_OF_FIRE)
		&& did_cross_map_script_queue_up(MAP_SEVEN_PORTALS, 1)
	)
)

achievement(
	title = "A Romantic Ride Down the Nile",
	points = 3,
	id = 508253,
	description = "Discover the hidden level Bright Crucible",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_SEVEN_PORTALS, MAP_BRIGHT_CRUCIBLE)
	)
)

achievement(
	title = "Didn't We Defeat Him in the Last Game?",
	points = 2,
	id = 508254,
	description = "Find the Heart of D'Sparil in the Bright Crucible",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_BRIGHT_CRUCIBLE)
		&& did_player_pick_up_item(ITEM_HEART_OF_DSPARIL)
	)
)

achievement(
	title = "It Belongs in a Museum",
	points = 2,
	id = 508255,
	description = "Place the Heart of D'Sparil in its proper pedastal",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_BRIGHT_CRUCIBLE)
		&& did_player_use_item(ITEM_HEART_OF_DSPARIL)
	)
)

achievement(
	title = "A Treasure To Protect",
	points = 2,
	id = 508256,
	description = "Find the Icon of the Defender in the Bright Crucible and open your path to freedom",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_BRIGHT_CRUCIBLE)
		&& did_player_pick_up_item(ITEM_ICON_OF_THE_DEFENDER)
	)
)

achievement(
	title = "A Taste of Ultimate Power",
	points = 1,
	id = 508257,
	description = "Acquire your first piece of the ultimate weapon in the Seven Portals",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SEVEN_PORTALS)
		&& did_player_pick_up_final_weapon_piece(2)
	)
)

achievement(
	title = "Escape from the Portals",
	points = 5,
	id = 508258,
	description = "Leave the Seven Portals and venture towards the Shadow Wood",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SEVEN_PORTALS)
		&& is_player_in_fmv()
	)
)

achievement(
	title = "Portal Runner",
	points = 10,
	id = 508259,
	description = "Leave the Seven Portals and venture towards the Shadow Wood on the fourth or harder skill level",
	type = "",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_CASTLE, KEY_HORN, KEY_CAVE, KEY_SWAMP])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SEVEN_PORTALS)
		&& is_player_in_fmv()
		&& is_player_on_hard_difficulty()
	)
)

achievement(
	title = "Keep Your Friends Close and Your Enemies Dead",
	points = 2,
	id = 508260,
	description = "Acquire your third weapon",
	type = "",
	trigger = (
		protect_against_non_game()
		&& !is_map_change_happening()
		&& did_weapon_just_unlock(2)
	)
)

achievement(
	title = "A Jar of Rubble",
	points = 2,
	id = 508261,
	description = "Find the hidden Mystic Urn in the Shadow Wood",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SHADOW_WOOD)
		&& did_player_pick_up_item(ITEM_MYSTIC_URN)
	)
)

achievement(
	title = "We Must Go Deeper",
	points = 2,
	id = 508262,
	description = "Navigate into the Caves of Circe",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_SHADOW_WOOD, MAP_CAVES_OF_CIRCE)
	)
)

achievement(
	title = "Escape Rope",
	points = 1,
	id = 508263,
	description = "Find the hidden Chaos Device in the Caves of Circe",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_CAVES_OF_CIRCE)
		&& did_player_pick_up_item(ITEM_CHAOS_DEVICE)
	)
)

achievement(
	title = "Hard Hat",
	points = 1,
	id = 508264,
	description = "Find the hidden Platinum Helmet in the Caves of Circe",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_CAVES_OF_CIRCE)
		&& did_player_pick_up_platinum_helmet()
	)
)

achievement(
	title = "Key in a Cavestack",
	points = 3,
	id = 508265,
	description = "Find the Cave Key in the Caves of Circe",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_CAVES_OF_CIRCE)
		&& did_player_pick_up_key(KEY_CAVE)
	)
)

achievement(
	title = "The Cliffs That Surround Me",
	points = 2,
	id = 508266,
	description = "Navigate into the Wastelands",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_SHADOW_WOOD, MAP_WASTELANDS)
	)
)

achievement(
	title = "Diamond in the Rough",
	points = 3,
	id = 508267,
	description = "Find the Horn Key in the southern area of the Wastelands",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WASTELANDS)
		&& did_player_pick_up_key(KEY_HORN)
	)
)

achievement(
	title = "A Heated Engagement",
	points = 3,
	id = 508268,
	description = "Pull the ONE SIXTH switch in the fire room in the center of the Wastelands",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WASTELANDS)
		&& did_cross_map_script_queue_up(MAP_SHADOW_WOOD, 23)
	)
)

achievement(
	title = "Drowning in the Deep Mire",
	points = 2,
	id = 508269,
	description = "Navigate into Darkmere",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_SHADOW_WOOD, MAP_DARKMERE)
	)
)

achievement(
	title = "The Groundskeeper Will Permit You Entry",
	points = 2,
	id = 508270,
	description = "Pull the moon switch in the bungalow in the north-west of Darkmere",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DARKMERE)
		&& prev(map_var_value(1)) == 0
		&& map_var_value(1) == 1
	)
)

achievement(
	title = "Hell Is a Well",
	points = 2,
	id = 508271,
	description = "Pull either skull switch in the well in the castle of Darkmere",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DARKMERE)
		&& prev(map_var_value(5)) == 0
		&& map_var_value(5) == 1
	)
)

achievement(
	title = "To Venture Forth Beyond These Walls",
	points = 2,
	id = 508272,
	description = "Collect the Castle Key in the bungalow in the north-west of Darkmere",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DARKMERE)
		&& did_player_pick_up_key(KEY_CASTLE)
	)
)

achievement(
	title = "The Barriers Beyond the Slime",
	points = 2,
	id = 508273,
	description = "Collect the Swamp Key in the depths of Darkmere castle",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DARKMERE)
		&& did_player_pick_up_key(KEY_SWAMP)
	)
)

achievement(
	title = "The Mechanics Echo In These Walls",
	points = 3,
	id = 508274,
	description = "Pull the ONE SIXTH switch in the northern caves of Darkmere",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DARKMERE)
		&& did_cross_map_script_queue_up(MAP_SHADOW_WOOD, 19)
	)
)

achievement(
	title = "The Cogs Spin In the Direction of the Wind",
	points = 3,
	id = 508275,
	description = "Pull the ONE SIXTH switch in the southern cliffs of Darkmere",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DARKMERE)
		&& did_cross_map_script_queue_up(MAP_SHADOW_WOOD, 18)
	)
)

achievement(
	title = "Two Heads Aren't Better Than One",
	points = 2,
	id = 508276,
	description = "Defeat enough Ettins in the Wastelands to open the northern tunnels",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WASTELANDS)
		&& prev(map_var_value(3)) == 0
		&& map_var_value(3) == 2
	)
)

achievement(
	title = "Watch Your Step",
	points = 2,
	id = 508277,
	description = "Find the hidden Porkalator before a perilous drop in the Wastelands",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WASTELANDS)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "A Perk In Your Step",
	points = 1,
	id = 508278,
	description = "Find the hidden Boots of Speed on a ledge in the Wastelands",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WASTELANDS)
		&& did_player_pick_up_item(ITEM_BOOTS_OF_SPEED)
	)
)

achievement(
	title = "At Least It Has Three Bedrooms",
	points = 3,
	id = 508279,
	description = "Pull the ONE SIXTH switch in the swampy castle in the Wastelands",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WASTELANDS)
		&& did_cross_map_script_queue_up(MAP_SHADOW_WOOD, 22)
	)
)

achievement(
	title = "Wheelchair Access",
	points = 3,
	id = 508280,
	description = "Pull the ONE SIXTH switch in the south-eastern cavern in the Caves of Circe",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_CAVES_OF_CIRCE)
		&& did_cross_map_script_queue_up(MAP_SHADOW_WOOD, 20)
	)
)

achievement(
	title = "Discovery of an Anchialine System",
	points = 3,
	id = 508281,
	description = "Pull the ONE SIXTH switch in the south-western cavern in the Caves of Circe",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_CAVES_OF_CIRCE)
		&& did_cross_map_script_queue_up(MAP_SHADOW_WOOD, 21)
	)
)

achievement(
	title = "It's a Secret To Everyone",
	points = 3,
	id = 508282,
	description = "Navigate into the Sacred Grove",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_SHADOW_WOOD, MAP_SACRED_GROVE)
	)
)

achievement(
	title = "Challenge Accepted",
	points = 2,
	id = 508283,
	description = "Defeat the Ettins and pull the secret switch in the Sacred Grove",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SACRED_GROVE)
		&& did_cross_map_script_queue_up(MAP_FORSAKEN_OUTPOST, 9)
	)
)

achievement(
	title = "Tomb of the Ancients",
	points = 3,
	id = 508284,
	description = "Navigate into the Hypostyle",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_SHADOW_WOOD, MAP_HYPOSTYLE)
	)
)

achievement(
	title = "Soon My Weapon Shall Be Complete",
	points = 1,
	id = 508285,
	description = "Acquire your second piece of the ultimate weapon in the Hypostyle",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HYPOSTYLE)
		&& did_player_pick_up_final_weapon_piece(1)
	)
)

achievement(
	title = "A Winged Foe No More",
	points = 5,
	id = 508286,
	description = "Bring death to the Death Wyvern and leave the Hypostyle to venture towards Heresiarch's Seminary",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HYPOSTYLE)
		&& is_player_in_fmv()
	)
)

achievement(
	title = "The Beast Fell to Terra Firma",
	points = 10,
	id = 508287,
	description = "Bring death to the Death Wyvern and leave the Hypostyle to venture towards Heresiarch's Seminary on the fourth or harder skill level",
	type = "",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HYPOSTYLE)
		&& is_player_in_fmv()
		&& is_player_on_hard_difficulty()
	)
)

achievement(
	title = "The Eyes Are a Window to the Soul",
	points = 2,
	id = 508288,
	description = "Pull all six bull switches in the northern end of Heresiarch's Seminary to open the eastern doors",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& measured(
			map_var_value(4) == 6,
			when = player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		)
		&& prev(map_var_value(4)) == 5
	)
)

achievement(
	title = "A Relaxing Day at the Pool",
	points = 2,
	id = 508289,
	description = "Find the hidden Icon of the Defender in Heresiarch's Seminary",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		&& did_player_pick_up_item(ITEM_ICON_OF_THE_DEFENDER)
	)
)

achievement(
	title = "Shield Thyself",
	points = 2,
	id = 508290,
	description = "Find the hidden Falcon Shield in Heresiarch's Seminary",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		&& did_player_pick_up_falcon_shield()
	)
)

achievement(
	title = "No Better Time to Field Test",
	points = 2,
	id = 508291,
	description = "Acquire your third and final piece of the ultimate weapon in the Heresiarch's Seminary (before you acquire that piece in one of the Chapel stages)",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		&& did_player_pick_up_final_weapon_piece(0)
	)
)

achievement(
	title = "Most Enemies Will Willingly Give Their Souls",
	points = 3,
	id = 508292,
	description = "Acquire your fourth and final weapon",
	type = "",
	trigger = (
		protect_against_non_game()
		&& !is_map_change_happening()
		&& did_weapon_just_unlock(3)
	)
)

achievement(
	title = "A Taste of Pancetta",
	points = 2,
	id = 508293,
	description = "Find the hidden Porkalator in the Orchard of Lamentations",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_ORCHARD_OF_LAMENTATIONS)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "A Mysterious Ledge",
	points = 1,
	id = 508294,
	description = "Find the hidden Amulet of Warding in the Orchard of Lamentations",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_ORCHARD_OF_LAMENTATIONS)
		&& did_player_pick_up_amulet_of_warding()
	)
)

achievement(
	title = "Opening Your Third Eye",
	points = 3,
	id = 508295,
	description = "Find the Sapphire Planet in the Orchard of Lamentations",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_ORCHARD_OF_LAMENTATIONS)
		&& did_player_pick_up_item(ITEM_SAPPHIRE_PLANET_2)
	)
)

achievement(
	title = "Mercurial",
	points = 3,
	id = 508296,
	description = "Find the Emerald Planet in the Orchard of Lamentations",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_ORCHARD_OF_LAMENTATIONS)
		&& did_player_pick_up_item(ITEM_EMERALD_PLANET_2)
	)
)

achievement(
	title = "I Send You to the Shadow Realm",
	points = 2,
	id = 508297,
	description = "Find the hidden Banishment Device in the Silent Refectory",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SILENT_REFECTORY)
		&& did_player_pick_up_item(ITEM_BANISHMENT_DEVICE)
	)
)

achievement(
	title = "To Gaze Into the Future",
	points = 3,
	id = 508298,
	description = "Find the Sapphire Planet in the Silent Refectory",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SILENT_REFECTORY)
		&& did_player_pick_up_item(ITEM_SAPPHIRE_PLANET_1)
	)
)

achievement(
	title = "To Cure All Ailments",
	points = 3,
	id = 508299,
	description = "Find the Ruby Planet in the Silent Refectory",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SILENT_REFECTORY)
		&& did_player_pick_up_item(ITEM_RUBY_PLANET)
	)
)

achievement(
	title = "Gammon in the Pantry",
	points = 2,
	id = 508300,
	description = "Find the hidden Porkalator in the Silent Refectory",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SILENT_REFECTORY)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "To Protect From Magic",
	points = 3,
	id = 508301,
	description = "Find the hidden Emerald Planet in the Silent Refectory",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_SILENT_REFECTORY)
		&& did_player_pick_up_item(ITEM_EMERALD_PLANET_1)
	)
)

achievement(
	title = "When the Planets Align",
	points = 3,
	id = 508302,
	description = "Place all five missing planets into the emblem in Heresiarch's Seminary to reveal the northern portals",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& measured(
			map_var_value(3) == 5, // Watch out if this gets set to 25
			when = player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		)
		&& prev(map_var_value(3)) == 4
	)
)

achievement(
	title = "Make Haste",
	points = 1,
	id = 508303,
	description = "Find the hidden Boots of Speed in Heresiarch's Seminary",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		&& did_player_pick_up_item(ITEM_BOOTS_OF_SPEED)
	)
)

achievement(
	title = "Bark at the Moon",
	points = 2,
	id = 508304,
	description = "Pull the ONE NINTH switch in the southern part of the Wolf Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WOLF_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 34)
	)
)

achievement(
	title = "A Relic with an Unfavorable Smell",
	points = 2,
	id = 508305,
	description = "Find the hidden Mystic Urn in the Dragon Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DRAGON_CHAPEL)
		&& did_player_pick_up_item(ITEM_MYSTIC_URN)
	)
)

achievement(
	title = "The Clank of the Grinder is Deafening",
	points = 2,
	id = 508306,
	description = "Pull the ONE NINTH switch in the western part of the Dragon Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DRAGON_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 31)
	)
)

achievement(
	title = "The Dragon's Perch",
	points = 2,
	id = 508307,
	description = "Pull the ONE NINTH switch in the eastern part of the Dragon Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DRAGON_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 32)
	)
)

achievement(
	title = "A Caged Bird",
	points = 2,
	id = 508308,
	description = "Pull the ONE NINTH switch in the central part of the Griffin Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GRIFFIN_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 37)
	)
)

achievement(
	title = "Guide Me Home",
	points = 1,
	id = 508309,
	description = "Find the hidden Chaos Device in the Griffin Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GRIFFIN_CHAPEL)
		&& did_player_pick_up_item(ITEM_CHAOS_DEVICE)
	)
)

achievement(
	title = "An Altar to Flight",
	points = 2,
	id = 508310,
	description = "Stand on the ONE NINTH platform in the southern part of the Griffin Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GRIFFIN_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 39)
	)
)

achievement(
	title = "Slow Cook Chamber",
	points = 2,
	id = 508311,
	description = "Find the hidden Porkalator in the Griffin Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GRIFFIN_CHAPEL)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "Defence of the Ancients",
	points = 1,
	id = 508312,
	description = "Find the hidden Falcon Shield in the Griffin Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GRIFFIN_CHAPEL)
		&& did_player_pick_up_falcon_shield()
	)
)

achievement(
	title = "A Tight Space",
	points = 2,
	id = 508313,
	description = "Pull the ONE NINTH switch in the northern part of the Griffin Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_GRIFFIN_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 38)
	)
)

achievement(
	title = "Knock Knock",
	points = 2,
	id = 508314,
	description = "Pull the ONE NINTH switch in the western part of the Wolf Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WOLF_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 35)
	)
)

achievement(
	title = "For a Tight Scenario",
	points = 2,
	id = 508315,
	description = "Find the hidden Icon of the Defender in the Wolf Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WOLF_CHAPEL)
		&& did_player_pick_up_item(ITEM_ICON_OF_THE_DEFENDER)
	)
)

achievement(
	title = "Deliver Ascension",
	points = 2,
	id = 508316,
	description = "Stand on both ONE NINTH pedastals in the north part of the Wolf Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& measured(
			map_var_value(0) == 2,
			when = player_is_in_map(MAP_WOLF_CHAPEL)
		)
		&& prev(map_var_value(0)) == 1
	)
)

achievement(
	title = "The Blood of the Savior",
	points = 1,
	id = 508317,
	description = "Find the elevated Krater of Might in the Wolf Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_WOLF_CHAPEL)
		&& did_player_pick_up_item(ITEM_KRATER_OF_MIGHT)
	)
)

achievement(
	title = "The Early Wyrm Gets the Bird",
	points = 2,
	id = 508318,
	description = "Pull the ONE NINTH switch in the northern part of the Dragon Chapel",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DRAGON_CHAPEL)
		&& did_cross_map_script_queue_up(MAP_HERESIARCHS_SEMINARY, 33)
	)
)

achievement(
	title = "The Unholy Monument",
	points = 4,
	id = 508319,
	description = "Navigate into the Deathwind Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_travelled_between_maps(MAP_HERESIARCHS_SEMINARY, MAP_DEATHWIND_CHAPEL)
	)
)

achievement(
	title = "Protector of Intrusive Thoughts",
	points = 2,
	id = 508320,
	description = "Find the hidden Platinum Helmet in the Deathwind Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DEATHWIND_CHAPEL)
		&& did_player_pick_up_platinum_helmet()
	)
)

achievement(
	title = "The Blood of the Betrayer",
	points = 3,
	id = 508321,
	description = "Find the hidden Krater of Might in the Deathwind Chapel",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_DEATHWIND_CHAPEL)
		&& did_player_pick_up_item(ITEM_KRATER_OF_MIGHT)
	)
)

achievement(
	title = "Pray to This",
	points = 5,
	id = 508322,
	description = "Defeat the Heresiarch at its Seminary and venture towards the Castle of Grief",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		&& is_player_in_fmv()
	)
)

achievement(
	title = "Smitten",
	points = 10,
	id = 508323,
	description = "Defeat the Heresiarch at its Seminary and venture towards the Castle of Grief on the fourth or harder skill level",
	type = "",
	trigger = (
		protect_against_non_game()
		&& ensure_keys_are_not_acquired([KEY_RUSTED, KEY_DUNGEON, KEY_AXE])
		&& ensure_items_are_not_acquired([ITEM_GLAIVE_SEAL])
		&& player_is_in_map(MAP_HERESIARCHS_SEMINARY)
		&& is_player_in_fmv()
		&& is_player_on_hard_difficulty()
	)
)

achievement(
	title = "Aquifer Near the Aqueduct",
	points = 1,
	id = 508324,
	description = "Find the hidden Krater of Might in the Castle of Grief",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_CASTLE_OF_GRIEF)
		&& did_player_pick_up_item(ITEM_KRATER_OF_MIGHT)
	)
)

achievement(
	title = "A Keepsake for Thy Grief",
	points = 1,
	id = 508325,
	description = "Find the hidden Amulet of Warding in the Castle of Grief",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_CASTLE_OF_GRIEF)
		&& did_player_pick_up_amulet_of_warding()
	)
)

achievement(
	title = "Rumblings in the Clock Tower",
	points = 3,
	id = 508326,
	description = "Pull all four moon switches on the outside of the Castle of Grief to reveal a ledge in the clock tower",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& measured(
			map_var_value(9) == 4,
			when = player_is_in_map(MAP_CASTLE_OF_GRIEF)
		)
		&& prev(map_var_value(9)) == 3
	)
)

achievement(
	title = "The Basement Erupts",
	points = 3,
	id = 508327,
	description = "Pull all five skull switches in the towers of the Castle of Grief to reveal a staircase in one of the buildings",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& measured(
			map_var_value(8) == 5,
			when = player_is_in_map(MAP_CASTLE_OF_GRIEF)
		)
		&& prev(map_var_value(8)) == 4
	)
)

achievement(
	title = "The Clock Ticks Further",
	points = 4,
	id = 508328,
	description = "Place all four gears scattered around the Castle of Grief into their correct places",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& measured(
			map_var_value(2) == 4,
			when = player_is_in_map(MAP_CASTLE_OF_GRIEF)
		)
		&& prev(map_var_value(2)) == 3
	)
)

achievement(
	title = "On-site Armor Supplement",
	points = 1,
	id = 508329,
	description = "Find the hidden Platinum Helmet in the Forsaken Outpost",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_FORSAKEN_OUTPOST)
		&& did_player_pick_up_platinum_helmet()
	)
)

achievement(
	title = "Si Lego, Fatum Meum Obsignatum Erit",
	points = 2,
	id = 508330,
	description = "Find the Liber Oscura in the Forsaken Outpost",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_FORSAKEN_OUTPOST)
		&& did_player_pick_up_item(ITEM_LIBER_OSCURA)
	)
)

achievement(
	title = "It Barely Holds Together",
	points = 1,
	id = 508331,
	description = "Find the Rusted Key in the Forsaken Outpost",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_FORSAKEN_OUTPOST)
		&& did_player_pick_up_key(KEY_RUSTED)
	)
)

achievement(
	title = "Liber Debiles Magna Potestate Decipit",
	points = 3,
	id = 508332,
	description = "Find the Daemon Codex in the Forsaken Outpost",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_FORSAKEN_OUTPOST)
		&& did_player_pick_up_item(ITEM_DAEMON_CODEX)
	)
)

achievement(
	title = "Not a Soul Was Present in the Garden",
	points = 3,
	id = 508333,
	description = "Discover the secret Desolate Garden",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_travelled_between_maps(MAP_FORSAKEN_OUTPOST, MAP_DESOLATE_GARDEN)
	)
)

achievement(
	title = "A Toast to the Gala",
	points = 4,
	id = 508334,
	description = "Find the hidden Krater of Might in the Desolate Garden",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_DESOLATE_GARDEN)
		&& did_player_pick_up_item(ITEM_KRATER_OF_MIGHT)
	)
)

achievement(
	title = "The Clock Tower's Inverse",
	points = 2,
	id = 508335,
	description = "Venture into the Gibbet",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_travelled_between_maps(MAP_CASTLE_OF_GRIEF, MAP_GIBBET)
	)
)

achievement(
	title = "Watch Your Step",
	points = 1,
	id = 508336,
	description = "Find the Dragonskin Bracers in the Gibbet",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& did_player_pick_up_item(ITEM_DRAGONSKIN_BRACERS)
	)
)

achievement(
	title = "Alas Poor Yorick",
	points = 2,
	id = 508337,
	description = "Find Yorick's Skull in the Gibbet",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& did_player_pick_up_item(ITEM_YORICKS_SKULL)
	)
)

achievement(
	title = "Quit While You're A Head",
	points = 3,
	id = 508338,
	description = "Place Yorick's Skull on top of his body in the Gibbet's cathedral",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& prev(map_var_value(0)) == 0
		&& map_var_value(0) == 1
	)
)

achievement(
	title = "Under the Doormat",
	points = 3,
	id = 508339,
	description = "Find the Dungeon Key in the Effluvium",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_key(KEY_DUNGEON)
	)
)

achievement(
	title = "Some Pig",
	points = 1,
	id = 508340,
	description = "Find the caged Porkalator in the Gibbet",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "Where Some Spend Eternities",
	points = 2,
	id = 508341,
	description = "Venture into the Dungeons",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_travelled_between_maps(MAP_GIBBET, MAP_DUNGEONS)
	)
)

achievement(
	title = "Persistent Presser",
	points = 2,
	id = 508342,
	description = "Pull the moon switch next to the lava pool in the Dungeons seven times to reveal the next switch in the centre of the ring of cells",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& measured(
			map_var_value(0) == 7,
			when = player_is_in_map(MAP_DUNGEONS)
		)
		&& prev(map_var_value(0)) == 6
	)
)

achievement(
	title = "Pulled Pork",
	points = 1,
	id = 508343,
	description = "Find the caged Porkalator in the Dungeons",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_DUNGEONS)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "The Torturer's Garb",
	points = 1,
	id = 508344,
	description = "Find the hidden Mesh Armor in the Dungeons",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_DUNGEONS)
		&& did_player_pick_up_mesh_armor()
	)
)

achievement(
	title = "Where the Decomposed Corpses End Up",
	points = 3,
	id = 508345,
	description = "Find the sewer exit from the Dungeons to the Effluvium",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_travelled_between_maps(MAP_DUNGEONS, MAP_EFFLUVIUM)
	)
)

achievement(
	title = "Wading in the Decomposition",
	points = 2,
	id = 508346,
	description = "Find the hidden Mystic Urn in the Effluvium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_item(ITEM_MYSTIC_URN)
	)
)

achievement(
	title = "The Broom in the Waste Cupboard",
	points = 1,
	id = 508347,
	description = "Find the hidden Torch in the Effluvium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_item(ITEM_TORCH)
	)
)

achievement(
	title = "Accidentally Dropped Down the Drain",
	points = 2,
	id = 508348,
	description = "Find the hidden Dragonskin Bracers in the Effluvium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_item(ITEM_DRAGONSKIN_BRACERS)
	)
)

achievement(
	title = "Past its Expiry Date",
	points = 1,
	id = 508349,
	description = "Find the hidden Porkalator in the Effluvium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "A Cold Dark Fate",
	points = 1,
	id = 508350,
	description = "Find the hidden Falcon Shield in the Effluvium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_falcon_shield()
	)
)

achievement(
	title = "Drinking the Sludge",
	points = 2,
	id = 508351,
	description = "Find the hidden Krater of Might in the Effluvium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_EFFLUVIUM)
		&& did_player_pick_up_item(ITEM_KRATER_OF_MIGHT)
	)
)

achievement(
	title = "The Heavenly Rains Can Wash My Sin",
	points = 4,
	id = 508352,
	description = "Escape the Effluvium and venture back to the Forsaken Outpost, which has magically opened a door in the Gibbet",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_FORSAKEN_OUTPOST)
		&& did_cross_map_script_queue_up(MAP_GIBBET, 24)
	)
)

achievement(
	title = "A Fresh Clean Pair of Boots",
	points = 1,
	id = 508353,
	description = "Find the hidden Boots of Speed in the Forsaken Outpost",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_FORSAKEN_OUTPOST)
		&& did_player_pick_up_item(ITEM_BOOTS_OF_SPEED)
	)
)

achievement(
	title = "The Tree Feller",
	points = 3,
	id = 508354,
	description = "Find the Axe Key in the Gibbet",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& did_player_pick_up_key(KEY_AXE)
	)
)

achievement(
	title = "You Never Live Twice",
	points = 5,
	id = 508355,
	description = "Defeat the Heresiarch in the Gibbet and venture towards the Necropolis",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& is_player_in_fmv()
	)
)

achievement(
	title = "The Throne Is Not Yours",
	points = 10,
	id = 508356,
	description = "Defeat the Heresiarch in the Gibbet and venture towards the Necropolis on the fourth or harder skill level",
	type = "",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_GIBBET)
		&& is_player_in_fmv()
		&& is_player_on_hard_difficulty()
	)
)

achievement(
	title = "Treasure Outweighs Destiny",
	points = 3,
	id = 508357,
	description = "Navigate into the hidden Vivarium before entering any tombs",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_travelled_between_maps(MAP_NECROPOLIS, MAP_VIVARIUM)
	)
)

achievement(
	title = "A Nose for Treasure",
	points = 4,
	id = 508358,
	description = "Turn into a pig and find the secret treasure room in the Vivarium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_VIVARIUM)
		&& did_player_pick_up_item(ITEM_BANISHMENT_DEVICE)
	)
)

achievement(
	title = "Brace Yourself",
	points = 1,
	id = 508359,
	description = "Find the hidden Dragonskin Bracers in the Vivarium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_VIVARIUM)
		&& did_player_pick_up_item(ITEM_DRAGONSKIN_BRACERS)
	)
)

achievement(
	title = "May These Ashes Protect My Soul",
	points = 1,
	id = 508360,
	description = "Find the hidden Mystic Urn in the Vivarium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_VIVARIUM)
		&& did_player_pick_up_item(ITEM_MYSTIC_URN)
	)
)

achievement(
	title = "A Golden Statue of a Swine",
	points = 1,
	id = 508361,
	description = "Find the hidden Porkalator in the Vivarium",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_VIVARIUM)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "A Hammed Warrior of Hexen",
	points = 1,
	id = 508362,
	description = "Find the hidden Porkalator in Zedek's Tomb",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_ZEDEKS_TOMB)
		&& did_player_pick_up_item(ITEM_PORKALATOR)
	)
)

achievement(
	title = "Protector of the Dead",
	points = 1,
	id = 508363,
	description = "Find the hidden Mesh Armor in Zedek's Tomb",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_ZEDEKS_TOMB)
		&& did_player_pick_up_mesh_armor()
	)
)

achievement(
	title = "Keep Quietus and Carry On",
	points = 4,
	id = 508364,
	description = "Lay Zedek to rest and retrieve the Glaive Seal",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_ZEDEKS_TOMB)
		&& did_player_pick_up_item(ITEM_GLAIVE_SEAL)
	)
)

achievement(
	title = "The Spirits Shall Find Peace",
	points = 4,
	id = 508365,
	description = "Lay Traductus to rest and retrieve the Holy Relic",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_TRADUCTUS_TOMB)
		&& did_player_pick_up_item(ITEM_HOLY_RELIC)
	)
)

achievement(
	title = "Holy Barrier",
	points = 2,
	id = 508366,
	description = "Find the hidden Falcon Shield in Traductus' Tomb",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_TRADUCTUS_TOMB)
		&& did_player_pick_up_falcon_shield()
	)
)

achievement(
	title = "Divine Protection",
	points = 2,
	id = 508367,
	description = "Find the hidden Icon of the Defender in Traductus' Tomb",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_TRADUCTUS_TOMB)
		&& did_player_pick_up_item(ITEM_ICON_OF_THE_DEFENDER)
	)
)

achievement(
	title = "Artifact of Mysticism",
	points = 4,
	id = 508368,
	description = "Lay Menelkir to rest and retrieve the Sigil of the Magus",
	type = "progression",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_MENELKIRS_TOMB)
		&& did_player_pick_up_item(ITEM_SIGIL_OF_THE_MAGUS)
	)
)

achievement(
	title = "You've Had Enough",
	points = 1,
	id = 508369,
	description = "Receive items from the Dark Crucible's entryway six times and encounter a magical punishment",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& measured(
			map_var_value(5) == 6, // Watch out if this gets set to 0
			when = player_is_in_map(MAP_DARK_CRUCIBLE)
		)
		&& prev(map_var_value(5)) == 5
	)
)

achievement(
	title = "You've Really Had Enough",
	points = 3,
	id = 508370,
	description = "Receive items from the Dark Crucible's entryway forty times and encounter a stronger formidable punishment",
	type = "missable",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& player_is_in_map(MAP_DARK_CRUCIBLE)
		&& measured(
			map_var_value(6) == 40, // Watch out if this gets set to 0
			when = player_is_in_map(MAP_DARK_CRUCIBLE)
		)
		&& prev(map_var_value(6)) == 39
	)
)

achievement(
	title = "Checkmate",
	points = 10,
	id = 508371,
	description = "Defeat Korax in the Dark Crucible and save Hexen",
	type = "win_condition",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& current_map() == MAP_DARK_CRUCIBLE // The map actually counts as changing here.
		&& is_player_in_fmv()
	)
)

achievement(
	title = "The Chessmaster",
	points = 25,
	id = 508372,
	description = "Defeat Korax in the Dark Crucible and save Hexen on the fourth or harder skill level",
	type = "",
	trigger = (
		protect_against_non_game()
		&& ensure_items_are_not_acquired([ITEM_RUBY_PLANET])
		&& current_map() == MAP_DARK_CRUCIBLE // The map actually counts as changing here.
		&& is_player_in_fmv()
		&& is_player_on_hard_difficulty()
	)
)

MAP_TO_NAME = {
	MAP_WINNOWING_HALL          : "the Winnowing Hall",
	MAP_SEVEN_PORTALS           : "the Seven Portals",
	MAP_GUARDIAN_OF_ICE         : "the Guardian of Ice",
	MAP_GUARDIAN_OF_FIRE        : "the Guardian of Fire",
	MAP_GUARDIAN_OF_STEEL       : "the Guardian of Steel",
	MAP_BRIGHT_CRUCIBLE         : "the Bright Crucible",
	MAP_SHADOW_WOOD             : "the Shadow Wood",
	MAP_DARKMERE                : "Darkmere",
	MAP_CAVES_OF_CIRCE          : "the Caves of Circe",
	MAP_WASTELANDS              : "the Wastelands",
	MAP_SACRED_GROVE            : "the Sacred Grove",
	MAP_HYPOSTYLE               : "the Hypostyle",
	MAP_HERESIARCHS_SEMINARY    : "Heresiarch's Seminary",
	MAP_ORCHARD_OF_LAMENTATIONS : "the Orchard of Lamentations",
	MAP_SILENT_REFECTORY        : "the Silent Refectory",
	MAP_WOLF_CHAPEL             : "the Wolf Chapel",
	MAP_DRAGON_CHAPEL           : "the Dragon Chapel",
	MAP_GRIFFIN_CHAPEL          : "the Griffin Chapel",
	MAP_DEATHWIND_CHAPEL        : "the Deathwind Chapel",
	MAP_CASTLE_OF_GRIEF         : "the Castle of Grief",
	MAP_FORSAKEN_OUTPOST        : "the Forsaken Outpost",
	MAP_GIBBET                  : "the Gibbet",
	MAP_EFFLUVIUM               : "the Effluvium",
	MAP_DUNGEONS                : "the Dungeons",
	MAP_DESOLATE_GARDEN         : "the Desolate Garden",
	MAP_NECROPOLIS              : "Necropolis",
	MAP_ZEDEKS_TOMB             : "Zedek's Tomb",
	MAP_MENELKIRS_TOMB          : "Menelkir's Tomb",
	MAP_TRADUCTUS_TOMB          : "Traductus' Tomb",
	MAP_VIVARIUM                : "the Vivarium",
	MAP_DARK_CRUCIBLE           : "the Dark Crucible"
}

CLASS_FIGHTER = 0x00
CLASS_CLERIC  = 0x01
CLASS_MAGE    = 0x02

CLASS_ADDR = 0x19ae44

function class() {
	// This only goes up to 2 so we can unswizzle it
	return word(CLASS_ADDR + 2)
}

CLASS_TO_NAME = {
	CLASS_FIGHTER : "Baratus the Fighter",
	CLASS_CLERIC  : "Parias the Cleric",
	CLASS_MAGE    : "Daedolon the Mage"
}

DIFFICULTY_TO_NAME = {
	CLASS_FIGHTER * 5     : "Squire",
	CLASS_FIGHTER * 5 + 1 : "Knight",
	CLASS_FIGHTER * 5 + 2 : "Warrior",
	CLASS_FIGHTER * 5 + 3 : "Berserker",
	CLASS_FIGHTER * 5 + 4 : "Titan",
	CLASS_CLERIC  * 5      : "Altar Boy",
	CLASS_CLERIC  * 5 + 1  : "Acolyte",
	CLASS_CLERIC  * 5 + 2  : "Priest",
	CLASS_CLERIC  * 5 + 3  : "Cardinal",
	CLASS_CLERIC  * 5 + 4  : "Pope",
	CLASS_MAGE    * 5      : "Apprentice",
	CLASS_MAGE    * 5 + 1  : "Enchanter",
	CLASS_MAGE    * 5 + 2  : "Sorcerer",
	CLASS_MAGE    * 5 + 3  : "Warlock",
	CLASS_MAGE    * 5 + 4  : "Archimage"
}

HEALTH_PRESENTATION_ADDR = 0x19a57c

function health_presentation() {
	// This should max out at 100 so we can unswizzle it
	return word(HEALTH_PRESENTATION_ADDR + 2)
}

BLUE_MANA_ADDR = 0x19afc0

function blue_mana() {
	// This should max out at 100 so we can unswizzle it
	return word(BLUE_MANA_ADDR + 2)
}

GREEN_MANA_ADDR = 0x19afc4

function green_mana() {
	// This should max out at 100 so we can unswizzle it
	return word(GREEN_MANA_ADDR + 2)
}

TOTAL_TIME_ADDR = 0x19b08c

function total_time() {
	// This is swizzled and we've got to handle that
	return word(TOTAL_TIME_ADDR) * 65536 + word(TOTAL_TIME_ADDR + 2)
}

CHEAT_MENU_ACTIVE = {
	0 : "",
	1 : " [CHEATS ENABLED]"
}

CHEATS_ON = {
	0 : "",
	1 : " [Noclip]",
	2 : " [God]",
	3 : " [Noclip | God]",
	4 : " [Slow]",
	5 : " [Noclip | Slow]",
	6 : " [God | Slow]",
	7 : " [Noclip | God | Slow]"
}

rich_presence_conditional_display(
	is_in_game(),
	"{0} is in {1} on skill level {2}, 💖: {3}, 🔵: {4}, 🟢: {5}, ⏱️: {6}{7}{8}",
	rich_presence_lookup("Class", class(), CLASS_TO_NAME),
	rich_presence_lookup("CurrentMap", current_map(), MAP_TO_NAME),
	rich_presence_lookup("ClassDifficulty", class() * 5 + difficulty(), DIFFICULTY_TO_NAME),
	rich_presence_value("VALUE", health_presentation()),
	rich_presence_value("VALUE", blue_mana()),
	rich_presence_value("VALUE", green_mana()),
	rich_presence_value("TIME", total_time() * 0.0333333, format = "SECS_AS_MINS"),
	rich_presence_lookup("CheatMenuActive", word(CHEAT_MENU_ADDR + 2), CHEAT_MENU_ACTIVE),
	rich_presence_lookup("CheatCheck", word(CHEATS_ADDR + 2), CHEATS_ON)
)
rich_presence_display("Entering the realm of Hexen")