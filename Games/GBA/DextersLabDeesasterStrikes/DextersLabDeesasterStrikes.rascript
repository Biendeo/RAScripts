// Dexter's Laboratory: Deesaster Strikes
// #ID = 6193
// md5: 5e42d25ee9c5c16a7169f1c5a35b9451

// == CODE NOTES ==

// $007C30: Cheat Code Input (2 bytes)
//          Pausing resets value to 0x0000
//          Pressing L << 1 and | 0x0001
//          Pressing R << 1
function cheat_code_input() => word(0x007C30)

// $038CFC: Demo Mode (2 bytes)
//          0x00 - Not in demo
//          0x02 - In demo
function demo_mode() => word(0x038CFC)

// $038CFE: Demo Progress (2 bytes)
//          Counts up one every frame while in the demo
//          Both demos last until 0x0960
function demo_progress() => word(0x038CFE)

// $03A55C: Input (2 bytes)
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
function input() => word(0x03A55C)

// $03A566: Control Status (2 bytes)
//          A value that seems to indicate when on these specific levels
//          0x00 - Main menu
//          0x01 - Hub map screen
//          0x03 - Chemistry Lab C/D, Dexter's House C
//          0x04 - In Hub, Tutorial, Aviation Hangar A/C/D, Robotics Lab A/B, Chemistry Lab C, Space Port B
//          0x05 - Most other levels
//          0x07 - Chemistry Lab B, Space Port D
//          0xFF - While loading a level
function control_status() => word(0x03A566)

// $03A568: Mini-map X position (4 bytes)
//          Left of the level is 0
function mini_map_x_position() => dword(0x03A568)

// $03A56C: Mini-map Y position (4 bytes)
//          Top of the level is 0
function mini_map_y_position() => dword(0x03A56C)

// $03A570: Time in current level (4 bytes)
//          Counts up 1 per frame
function time_in_current_level() => dword(0x03A570)

// $03A578: Controlling Actor (1 byte)
//          0x60 - Controlling UFO in Aviation Hangar B
//          0xb0 - Controlling Dexter
function controlling_actor() => byte(0x03A578)

// $03A584: Current save name (8 bytes)
//          ASCII characters, blanks are spaces (0x20)
function current_save_name() => byte(0x03A584)

// $03A590: Total time (4 bytes)
//          Counts up 1 per frame
function total_time() => dword(0x03A590)

// Dee Dees Collected
// There are 16 bytes counting all 124 Dee Dees in the game
// All of the Dee Dees in a single level are all exactly 4 bytes apart (occupying the same bit in the corresponding bytes)

// $03A594: Dee Dees Collected 1 (1 byte)
//          0 - Aviation Hangar A (bottom left of map) / Tutorial
//          1 - Aviation Hangar B (top of map)
//          2 - Aviation Hangar C (bottom right of map)
//          3 - Aviation Hangar D (bottom right of map)
//          4 - Space Port A (centre of map)
//          5 - Space Port B (left of map)
//          6 - Space Port C (top left of map)
//          7 - Space Port D (top of map)
DEE_DEES_COLLECTED_ADDRESS = 0x03A594
function dee_dees_collected_1() => byte(DEE_DEES_COLLECTED_ADDRESS)

// $03A595: Dee Dees Collected 2 (1 byte)
//          0 - Greenhouse A (top right of map)
//          1 - Greenhouse B (top of map)
//          2 - Greenhouse C (top of map)
//          3 - Greenhouse D (right of maze part)
//          4 - Robotics Lab A (top right of map)
//          5 - Robotics Lab B (left of map)
//          6 - Robotics Lab C (centre of map)
//          7 - Robotics Lab D (top of map)
function dee_dees_collected_2() => byte(0x03A595)

// $03A596: Dee Dees Collected 3 (1 byte)
//          0 - Chemistry Lab A (bottom left of map)
//          1 - Chemistry Lab B (bottom right of map)
//          2 - Chemistry Lab C (top of map)
//          3 - Chemistry Lab D (top left of map)
//          4 - Lab of the Lost A (top of map)
//          5 - Lab of the Lost B (centre of map)
//          6 - Lab of the Lost C (bottom of map)
//          7 - Lab of the Lost D (top of map)
function dee_dees_collected_3() => byte(0x03A596)

// $03A597: Dee Dees Collected 4 (1 byte)
//          0 - Nuclear Power Station A (centre of map)
//          1 - Nuclear Power Station B (bottom right of map)
//          2 - Nuclear Power Station C (top left of map)
//          3 - Nuclear Power Station D (bottom left of map)
//          4 - Dexter's House A (top left of map)
//          5 - Dexter's House B (bottom left of map)
//          7 - Dexter's House D (2nd top right of map)
function dee_dees_collected_4() => byte(0x03A597)

// $03A598: Dee Dees Collected 5 (1 byte)
//          0 - Aviation Hangar A (2nd top right of map)
//          1 - Aviation Hangar B (close to tube)
//          2 - Aviation Hangar C (next to rocket)
//          3 - Aviation Hangar D (close to tube)
//          4 - Space Port A (bottom right of map)
//          5 - Space Port B (right of map)
//          6 - Space Port C (right of map)
//          7 - Space Port D (top right of map)
function dee_dees_collected_5() => byte(0x03A598)

// $03A599: Dee Dees Collected 6 (1 byte)
//          0 - Greenhouse A (left side of map)
//          1 - Greenhouse B (top left side of map)
//          2 - Greenhouse C (middle of map)
//          3 - Greenhouse D (top of maze)
//          4 - Robotics Lab A (right of map)
//          5 - Robotics Lab B (right of map)
//          6 - Robotics Lab C (top of map)
//          7 - Robotics Lab D (bottom right of map)
function dee_dees_collected_6() => byte(0x03A599)

// $03A59A: Dee Dees Collected 7 (1 byte)
//          0 - Chemistry Lab A (right of map)
//          1 - Chemistry Lab B (bottom left of map)
//          2 - Chemistry Lab C (bottom of map)
//          3 - Chemistry Lab D (top of map)
//          4 - Lab of the Lost A (upper middle of map)
//          5 - Lab of the Lost B (right of map)
//          6 - Lab of the Lost C (centre of map)
//          7 - Lab of the Lost D (left of map)
function dee_dees_collected_7() => byte(0x03A59A)

// $03A59B: Dee Dees Collected 8 (1 byte)
//          0 - Nuclear Power Station A (bottom of map)
//          1 - Nuclear Power Station B (bottom left of map)
//          2 - Nuclear Power Station C (centre of map)
//          3 - Nuclear Power Station D (bottom right of map)
//          4 - Dexter's House A (top of map)
//          5 - Dexter's House B (bottom right of map)
//          7 - Dexter's House D (2nd top right of map)
function dee_dees_collected_8() => byte(0x03A59B)

// $03A59C: Dee Dees Collected 9 (1 byte)
//          0 - Aviation Hangar A (1st top right of map)
//          1 - Aviation Hangar B (bottom of map)
//          2 - Aviation Hangar C (top left of map)
//          3 - Aviation Hangar D (top right of map)
//          4 - Space Port A (top of map)
//          5 - Space Port B (bottom right of map)
//          6 - Space Port C (bottom right of map)
//          7 - Space Port D (right of map)
function dee_dees_collected_9() => byte(0x03A59C)

// $03A59D: Dee Dees Collected 10 (1 byte)
//          0 - Greenhouse A (right of map)
//          1 - Greenhouse B (bottom of map)
//          2 - Greenhouse C (bottom of map)
//          3 - Greenhouse D (top of map)
//          4 - Robotics Lab A (bottom right of map)
//          5 - Robotics Lab B (top of map)
//          6 - Robotics Lab C (right of map)
//          7 - Robotics Lab D (centre of map)
function dee_dees_collected_10() => byte(0x03A59D)

// $03A59E: Dee Dees Collected 11 (1 byte)
//          0 - Chemistry Lab A (bottom right of map)
//          1 - Chemistry Lab B (centre of map)
//          2 - Chemistry Lab C (bottom left of map)
//          3 - Chemistry Lab D (top right of map)
//          4 - Lab of the Lost A (lower middle of map)
//          5 - Lab of the Lost B (top of map)
//          6 - Lab of the Lost C (close to pipe)
//          7 - Lab of the Lost D (right of map)
function dee_dees_collected_11() => byte(0x03A59E)

// $03A59F: Dee Dees Collected 12 (1 byte)
//          0 - Nuclear Power Station A (right of map)
//          1 - Nuclear Power Station B (top of map)
//          2 - Nuclear Power Station C (top right of map)
//          3 - Nuclear Power Station D (right of map)
//          4 - Dexter's House A (bottom of map)
//          5 - Dexter's House B (left of map)
//          7 - Dexter's House D (left of map)
function dee_dees_collected_12() => byte(0x03A59F)

// $03A5A0: Dee Dees Collected 13 (1 byte)
//          0 - Aviation Hangar A (top centre of map)
//          1 - Aviation Hangar B (at end of map)
//          2 - Aviation Hangar C (top-ish of map)
//          3 - Aviation Hangar D (left of map)
//          4 - Space Port A (top left of map)
//          5 - Space Port B (bottom left of map)
//          6 - Space Port C (left of map)
//          7 - Space Port D (left of map)
function dee_dees_collected_13() => byte(0x03A5A0)

// $03A5A1: Dee Dees Collected 14 (1 byte)
//          0 - Greenhouse A (bottom right-ish of map)
//          1 - Greenhouse B (right of map)
//          2 - Greenhouse C (top left of map)
//          3 - Greenhouse D (left of maze part)
//          4 - Robotics Lab A (left of map)
//          5 - Robotics Lab B (centre of map)
//          6 - Robotics Lab C (bottom right of map)
//          7 - Robotics Lab D (bottom left of map)
function dee_dees_collected_14() => byte(0x03A5A1)

// $03A5A2: Dee Dees Collected 15 (1 byte)
//          0 - Chemistry Lab A (top of map)
//          1 - Chemistry Lab B (top of map)
//          2 - Chemistry Lab C (bottom right of map)
//          3 - Chemistry Lab D (left of map)
//          4 - Lab of the Lost A (bottom left of map)
//          5 - Lab of the Lost B (left of map)
//          6 - Lab of the Lost C (top of map)
//          7 - Lab of the Lost D (bottom of map)
function dee_dees_collected_15() => byte(0x03A5A2)

// $03A5A3: Dee Dees Collected 16 (1 byte)
//          0 - Nuclear Power Station A (top of map)
//          1 - Nuclear Power Station B (top left of map)
//          2 - Nuclear Power Station C (right of map)
//          3 - Nuclear Power Station D (top right of map)
//          4 - Dexter's House A (right of map)
//          5 - Dexter's House B (top right of map)
//          7 - Dexter's House D (top of map)
function dee_dees_collected_16() => byte(0x03A5A3)

// $03A610: Total Dee Dees Collected (2 bytes)
//          This is a cached value of all the Dee Dees collected.
//          Calculated on game load, and then used for menus and the world barrier checks.
function total_dee_dees_collected() => word(0x03A610)

// Machines Repaired
// There are 8 bytes counting all 43 machines in the game
// Both of the machines in a single level are exactly 4 bytes apart (occupying the same bit in the corresponding bytes)

// $03A5A4: Machines Repaired 1 (1 byte)
//          0 - Aviation Hangar A (top of map) / Tutorial
//          1 - Aviation Hangar B (top left of map)
//          2 - Aviation Hanger C (right of map)
//          3 - Aviation Hangar D (right of the two bottom right of the map)
//          4 - Space Port A (left of map)
//          5 - Space Port B (bottom left of map)
//          6 - Space Port C (top left of map)
//          7 - Space Port D (top of map)
MACHINES_REPAIRED_ADDRESS = 0x03A5A4
function machines_repaired_1() => byte(MACHINES_REPAIRED_ADDRESS)

// $03A5A5: Machines Repaired 2 (1 byte)
//          0 - Greenhouse A (bottom right of map)
//          1 - Greenhouse B (top of map)
//          2 - Greenhouse C (top of map)
//          3 - Greenhouse D (bottom left of map)
//          4 - Robotics Lab A (centre of map)
//          5 - Robotics Lab B (right of map)
//          6 - Robotics Lab C (right of map)
//          7 - Robotics Lab D (bottom left of map)
function machines_repaired_2() => byte(0x03A5A5)

// $03A5A6: Machines Repaired 3 (1 byte)
//          0 - Chemistry Lab A (bottom right of map)
//          1 - Chemistry Lab B (left of map)
//          3 - Chemistry Lab D (top of map)
//          4 - Lab of the Lost A (left of map)
//          5 - Lab of the Lost B (centre of map)
//          6 - Lab of the Lost C (bottom right of map)
//          7 - Lab of the Lost D (top of map)
function machines_repaired_3() => byte(0x03A5A6)

// $03A5A7: Machines Repaired 4 (1 byte)
//          0 - Nuclear Power Station A (right of map)
//          1 - Nuclear Power Station B (top of map)
//          3 - Nuclear Power Station D (top of map)
//          4 - Dexter's House A (bottom left of map)
//          5 - Dexter's House B (bottom of map)
function machines_repaired_4() => byte(0x03A5A7)

// $03A5A8: Machines Repaired 5 (1 byte)
//          1 - Aviation Hangar B (bottom right of map)
//          3 - Aviation Hangar D (left of the two bottom right of map)
//          5 - Space Port B (bottom right of map)
//          6 - Space Port C (bottom of map)
//          7 - Space Port D (left of map)
function machines_repaired_5() => byte(0x03A5A8)

// $03A5A9: Machines Repaired 6 (1 byte)
//          1 - Greenhouse B (right of map)
//          3 - Greenhouse D (top right of map)
//          7 - Robotics Lab D (bottom right of map)
function machines_repaired_6() => byte(0x03A5A9)

// $03A5AA: Machines Repaired 7 (1 byte)
//          4 - Lab of the Lost A (top left of map)
//          5 - Lab of the Lost B (close to pipe)
//          6 - Lab of the Lost C (left of map)
//          7 - Lab of the Lost D (bottom left of map)
function machines_repaired_7() => byte(0x03A5AA)

// $03A5AB: Machines Repaired 8 (1 byte)
//          0 - Nuclear Power Station A (bottom left of map)
//          1 - Nuclear Power Station B (bottom left of map)
//          3 - Nuclear Power Station D (left of map)
function machines_repaired_8() => byte(0x03A5AB)

// $03A5B4: Levels Unlocked (4 bytes)
//           0- 3 - Aviation Hangar
//           4- 7 - Space Port
//           8-11 - Green House
//          12-15 - Robotics Lab
//          16-19 - Chemistry Lab
//          20-23 - Lab of the Lost
//          24-27 - Nuclear Power Station
//          28-31 - Dexter's House
function levels_unlocked() => dword(0x03A5B4)

// $03A5B8: Tools Collected (2 bytes)
//          3 - Wrench
//          4 - Screwdriver
//          5 - Pliers (including tutorial)
//          6 - Soldering Iron
//          7 - Hammer
//          8 - Drill
TOOLS_COLLECTED_ADDRESS = 0x03A5B8
function tools_collected() => word(TOOLS_COLLECTED_ADDRESS)

// $03A5BC: Lives (2 bytes)
function lives() => word(0x03A5BC)

// $03A5BE: Health (2 bytes)
//          0x80 is max health, 0 is death
function health() => word(0x03A5BE)

// $03A5C0: Language (4 bytes)
//          0x00 - English
//          0x01 - French
//          0x02 - German
//          0x03 - Italian
//          0x04 - Spanish
function language() => dword(0x03A5C0)

// $03A5C4: Brightness (4 bytes)
//          0x00 to 0x08 normally
function brightness() => dword(0x03A5C4)

// $03A5CC: Button Config (4 bytes)
//          0x00 to 0x05 normally
function button_config() => dword(0x03A5CC)

// $03A5D0: Music On (4 bytes)
//          0x00 for off
//          0x01 for on
function music_on() => dword(0x03A5D0)

// $03A5D4: Sound FX On (4 bytes)
//          0x00 for off
//          0x01 for on
function sound_fx_on() => dword(0x03A5D4)

// $03A5D8: Starting Lives (4 bytes)
function starting_lives() => dword(0x03A5D8)

// $03A5DC: Inventory (52 bytes)
//          Array of 2-byte values of the inventory (last 2-byte value MUST be 0x0000)
//          0x0001 - Fist
//          0x0002 - Grabber Arm
//          0x0003 - Wrench
//          0x0004 - Screwdriver
//          0x0005 - Pliers
//          0x0006 - Soldering Iron
//          0x0007 - Hammer
//          0x0008 - Drill
//          0x0009 - Zap-a-tron
//          0x000b - Splurgerator
//          0x000c - Green ID
//          0x000d - Blue ID
//          0x000e - Red ID
//          0x000f - Yellow ID
//          0x0010 - Orange ID
//          0x0012 - Green Key
//          0x0013 - Orange Key
//          0x0014 - Yellow Key
//          0x0015 - Fuse
//          0x0016 - Red Gem
//          0x0017 - Green Gem
//          0x0018 - Blue Gem
//          0x0019 - Yellow Gem
function inventory() => byte(0x03A5DC)

// $03A614: Cheats Applied (4 bytes)
//          6 - Low Gravity (LLRR RRRR LLRR LLLR)
//          7 - Reversed Controls (LRRR RRRL RLLR RLLL)
//          8 - Stronger Enemies (LLRR RRLR RRLL LLLL)
//          9 - Faster Enemies (LRRR RRLL LLRR RRLL)
//          10 - Slippery Floor (LLRR RLRR RLLR RLLR)
//          11 - Faster Dexter (LRRR RLRL RRLL RLRR)
//          12 - Stronger Dexter (LLRR RLLR LLRR LRLR)
//          13 - Less Damage Taken (LRRR RLLL RLLL LLLR)
//          14 - Weaker Enemies (LLRR LRRL LLLR RLLL)
//          15 - Slow Enemies (LRRR LRLR LLRL LLLL)
//          16 - Extra Life (LLRR LRLL LRLL RRLL)
//          17 - Double Ammo (LRRR LLRR LLLL RLLR)
//          18 - Dexter-roo (LLRR LLRL RRRR LLLR)
function cheats_applied() => dword(0x03A614)

// $03A618: Cheat Expriy Time (4 bytes)
//          Starts at 1800 when a cheat is applied (except extra lives and double ammo).
//          Drops by 1 every in-game frame (30 seconds total), and disables cheats when 0.
function cheat_expiry_time() => dword(0x03A618)

// $03A640: ? Some Specific Repair Flag (1 byte)
//          Set to 0x02 when you repair one of the Greenhouse B machines?
function some_specific_repair_flag() => byte(0x03A640)

// $03A69C: Ammo (4 bytes)
function ammo() => dword(0x03A69C)

// $03A6A4: Level (2 bytes)
//          0x00 - Hub
//          0x01 - Aviation Hangar A
//          0x05 - Space Port A
//          0x09 - Greenhouse A
//          0x0d - Robotics Lab A
//          0x11 - Chemistry Lab A
//          0x15 - Lab of the Lost A
//          0x19 - Nuclear Power Station A
//          0x1d - Dexter's House A
//          0x21 - Tutorial
function level() => word(0x03A6A4)

// $03A6A6: Spawn Point Index (2 bytes)
//          Indicates which spawn point you'll start the level from
//          Most levels start at 0x00, navigating backward through a door will start at 0x01.
//          The hub has many more spawn points. Interestingly leaving the Nuclear Power Station spawns at 0x07 which is in front of Dexter's House.
//          Set to 0xff for the final cutscene.
function spawn_point_index() => word(0x03A6A6)

// $03A6AA: Cutscene (2 bytes)
//          0x00 - No cutscene
//          0x01 - Game over? Triggers on title screen
//          0x02 - Exit game? Triggers on title screen
//          0x04 - End cutscene
function cutscene() => word(0x03A6AA)

// $03A6AE: Hub Selected Warp (2 bytes)
//          Value is `x * 0x64 + y` where x is a level number and y is the spawn point number (can't normally have y greater than 0)
//          0x0000 - Hub
//          0x0064 - Aviation Hangar
//          ...
//          0x0ce4 - Tutorial
//          0xffff - Teleporter is off
function hub_selected_warp() => word(0x03A6AE)

// $03A6B8: Projectile Type (2 bytes)
//          0 to 3 are valid values
function projectile_type() => word(0x03A6B8)

// $03A6BA: Holding Dee Dee (1 byte)
//          0x00 means not holding, 0x01 means holding
function holding_dee_dee() => byte(0x03A6BA)

// $03A6C0: Currently selected item (4 bytes)
//          This is an index of the Inventory array at 0x03a5dc, when 0 and L is pressed, finds the last index (searching for a 0x0000)
function currently_selected_item() => dword(0x03A6C0)

// $03A6C4: X position (4 bytes)
//          Left of the level is 0
function x_position() => dword(0x03A6C4)

// $03A6C8: Y position (4 bytes)
//          Top of the level is 0
function y_position() => dword(0x03A6C8)

// $03A6D0: Warping? (8 bytes)
//          Not sure what this is, but it's 0xFFFF when you're warping
function warping() => dword(0x03A6D0)

// $03A6DC: Last Teleporter Location (4 bytes)
//          Seems to be set whenever you step on a teleporter
function last_teleporter_location() => dword(0x03A6DC)

// $03A6E0: X position (4 bytes)
//          ? Mirror of 0x3a6c4?
function x_position() => dword(0x03A6E0)

// $03A6E4: Y position (4 bytes)
//          ? Mirror of 0x3a6c8
function y_position() => dword(0x03A6E4)

// $03A704: Time since last movement (4 bytes)
function time_since_last_movement() => dword(0x03A704)

// $03A708: Segments fixing machine (4 bytes)
//          Machine is fixed when this reaches 9
function segments_fixing_machine() => dword(0x03A708)

// $03A774: Frames left of inventory change animation (4 bytes)
function frames_left_of_inventory_change_animation() => dword(0x03A774)

// $03A794: Save 1 name (8 bytes)
//          ASCII characters, blanks are spaces (0x20)
function save_1_name() => byte(0x03A794)

// $03A7AC: Save 2 name (8 bytes)
//          ASCII characters, blanks are spaces (0x20)
function save_2_name() => byte(0x03A7AC)

// $03A7C4: Save 3 name (8 bytes)
//          ASCII characters, blanks are spaces (0x20)
function save_3_name() => byte(0x03A7C4)

// $03A7F8: Total Dee Dees (4 byte)
//          Referred to when figuring out your percentage
function total_dee_dees() => dword(0x03A7F8)

// $03A7FC: Total machines to repair (4 bytes)
function total_machines_to_repair() => dword(0x03A7FC)

// $03A808: Health Bar Presentation (4 bytes)
//          Starts at 128, dead at 0
function health_bar_presentation() => dword(0x03A808)

// $03A84C: Last seen mini-map X position (4 bytes)
//          Set to 0x03a568 whenever the mini-map is closed
function last_seen_mini_map_x_position() => dword(0x03A84C)

// $03A850: Last seen mini-map Y position (4 bytes)
//          Set to 0x03a56c whenever the mini-map is closed
function last_seen_mini_map_y_position() => dword(0x03A850)

// $03A9CC: X position (4 bytes)
function x_position() => dword(0x03A9CC)

// $03A9D0: Y position (4 bytes)
function y_position() => dword(0x03A9D0)

// $03A9D4: Z position (4 bytes)
//          Anything less than zero is a death state
function z_position() => dword(0x03A9D4)

// $03A9DC: X velocity (4 bytes)
//          Positive is right, negative is left
function x_velocity() => dword(0x03A9DC)

// $03A9E0: Y velocity (4 bytes)
//          Positive is down, negative is up
function y_velocity() => dword(0x03A9E0)

// $03A9E4: Z velocity (jump) (4 bytes)
//          Positive is upward, negative is downward
function z_velocity_jump() => dword(0x03A9E4)

// $03AA2A: Cycles of current animation remaining (2 byte)
function cycles_of_current_animation_remaining() => word(0x03AA2A)

// $03AFE6: In-gameplay flag? (2 bytes)
//          0x03 - In most levels
//          0x04 - Some levels like Aviation Hangar A and Nuclear Power Station A
//          0x05 - Main menu
function in_gameplay_flag() => word(0x03AFE6)

// $03B1FC: Enemy Health (2 bytes)
//          Enemy is defeated when this becomes zero or less.
//          All entities are defined by a 0xD8 sized struct, and an array of them starts here.
//          Not all entities exist on each level, and not all entities are enemies that can be defeated.
//          The array of entities might be about 128 entities in size?
//          Some other fields that might exist are:
//            - Position on screen
//            - Movement behaviour
//            - Enemy type
//            - Item drop
//            - Damage glow frames
function enemy_health() => word(0x03B1FC)

// == CONSTANTS ==

CONTROL_STATUS_MAIN_MENU       = 0x0000
CONTROL_STATUS_HUB_MAP         = 0x0001
CONTROL_STATUS_LOADING         = 0x00FF

TOOL_WRENCH         = 0x03
TOOL_SCREWDRIVER    = 0x04
TOOL_PLIERS         = 0x05
TOOL_SOLDERING_IRON = 0x06
TOOL_HAMMER         = 0x07
TOOL_DRILL          = 0x08

TOOL_TO_NAME = {
    TOOL_WRENCH:         "Wrench",
    TOOL_SCREWDRIVER:    "Screwdriver",
    TOOL_PLIERS:         "Pliers",
    TOOL_SOLDERING_IRON: "Soldering Iron",
    TOOL_HAMMER:         "Hammer",
    TOOL_DRILL:          "Drill",
}

LEVEL_HUB                     = 0x00
LEVEL_AVIATION_HANGAR_A       = 0x01
LEVEL_AVIATION_HANGAR_B       = 0x02
LEVEL_AVIATION_HANGAR_C       = 0x03
LEVEL_AVIATION_HANGAR_D       = 0x04
LEVEL_GREENHOUSE_A            = 0x09
LEVEL_GREENHOUSE_B            = 0x0A
LEVEL_GREENHOUSE_C            = 0x0B
LEVEL_GREENHOUSE_D            = 0x0C
LEVEL_ROBOTICS_LAB_A          = 0x0D
LEVEL_ROBOTICS_LAB_B          = 0x0E
LEVEL_ROBOTICS_LAB_C          = 0x0F
LEVEL_ROBOTICS_LAB_D          = 0x10
LEVEL_CHEMISTRY_LAB_A         = 0x11
LEVEL_CHEMISTRY_LAB_B         = 0x12
LEVEL_CHEMISTRY_LAB_C         = 0x13
LEVEL_CHEMISTRY_LAB_D         = 0x14
LEVEL_LAB_OF_THE_LOST_A       = 0x15
LEVEL_LAB_OF_THE_LOST_B       = 0x16
LEVEL_LAB_OF_THE_LOST_C       = 0x17
LEVEL_LAB_OF_THE_LOST_D       = 0x18
LEVEL_NUCLEAR_POWER_STATION_A = 0x19
LEVEL_NUCLEAR_POWER_STATION_B = 0x1A
LEVEL_NUCLEAR_POWER_STATION_C = 0x1B
LEVEL_NUCLEAR_POWER_STATION_D = 0x1C
LEVEL_SPACE_PORT_A            = 0x05
LEVEL_SPACE_PORT_B            = 0x06
LEVEL_SPACE_PORT_C            = 0x07
LEVEL_SPACE_PORT_D            = 0x08
LEVEL_DEXTERS_HOUSE_A         = 0x1D
LEVEL_DEXTERS_HOUSE_B         = 0x1E
LEVEL_DEXTERS_HOUSE_C         = 0x1F
LEVEL_DEXTERS_HOUSE_D         = 0x20
LEVEL_TUTORIAL                = 0x21

LEVEL_TO_NAME = {
    LEVEL_HUB:                     "Hub",
    LEVEL_AVIATION_HANGAR_A:       "Aviation Hangar A",
    LEVEL_AVIATION_HANGAR_B:       "Aviation Hangar B",
    LEVEL_AVIATION_HANGAR_C:       "Aviation Hangar C",
    LEVEL_AVIATION_HANGAR_D:       "Aviation Hangar D",
    LEVEL_GREENHOUSE_A:            "Greenhouse A",
    LEVEL_GREENHOUSE_B:            "Greenhouse B",
    LEVEL_GREENHOUSE_C:            "Greenhouse C",
    LEVEL_GREENHOUSE_D:            "Greenhouse D",
    LEVEL_ROBOTICS_LAB_A:          "Robotics Lab A",
    LEVEL_ROBOTICS_LAB_B:          "Robotics Lab B",
    LEVEL_ROBOTICS_LAB_C:          "Robotics Lab C",
    LEVEL_ROBOTICS_LAB_D:          "Robotics Lab D",
    LEVEL_CHEMISTRY_LAB_A:         "Chemistry Lab A",
    LEVEL_CHEMISTRY_LAB_B:         "Chemistry Lab B",
    LEVEL_CHEMISTRY_LAB_C:         "Chemistry Lab C",
    LEVEL_CHEMISTRY_LAB_D:         "Chemistry Lab D",
    LEVEL_LAB_OF_THE_LOST_A:       "Lab of the Lost A",
    LEVEL_LAB_OF_THE_LOST_B:       "Lab of the Lost B",
    LEVEL_LAB_OF_THE_LOST_C:       "Lab of the Lost C",
    LEVEL_LAB_OF_THE_LOST_D:       "Lab of the Lost D",
    LEVEL_NUCLEAR_POWER_STATION_A: "Nuclear Power Station A",
    LEVEL_NUCLEAR_POWER_STATION_B: "Nuclear Power Station B",
    LEVEL_NUCLEAR_POWER_STATION_C: "Nuclear Power Station C",
    LEVEL_NUCLEAR_POWER_STATION_D: "Nuclear Power Station D",
    LEVEL_SPACE_PORT_A:            "Space Port A",
    LEVEL_SPACE_PORT_B:            "Space Port B",
    LEVEL_SPACE_PORT_C:            "Space Port C",
    LEVEL_SPACE_PORT_D:            "Space Port D",
    LEVEL_DEXTERS_HOUSE_A:         "Dexter's House A",
    LEVEL_DEXTERS_HOUSE_B:         "Dexter's House B",
    LEVEL_DEXTERS_HOUSE_C:         "Dexter's House C",
    LEVEL_DEXTERS_HOUSE_D:         "Dexter's House D",
    LEVEL_TUTORIAL:                "Tutorial",
}

// The constants in this enum are arbitrary and don't correspond to anything in-game.
WORLD_AVIATION_HANGAR       = 0x00
WORLD_GREENHOUSE            = 0x01
WORLD_ROBOTICS_LAB          = 0x02
WORLD_CHEMISTRY_LAB         = 0x03
WORLD_LAB_OF_THE_LOST       = 0x04
WORLD_NUCLEAR_POWER_STATION = 0x05
WORLD_SPACE_PORT            = 0x06
WORLD_DEXTERS_HOUSE         = 0x07

WORLD_TO_NAME = {
    WORLD_AVIATION_HANGAR:       "Aviation Hangar",
    WORLD_GREENHOUSE:            "Greenhouse",
    WORLD_ROBOTICS_LAB:          "Robotics Lab",
    WORLD_CHEMISTRY_LAB:         "Chemistry Lab",
    WORLD_LAB_OF_THE_LOST:       "Lab of the Lost",
    WORLD_NUCLEAR_POWER_STATION: "Nuclear Power Station",
    WORLD_SPACE_PORT:            "Space Port",
    WORLD_DEXTERS_HOUSE:         "Dexter's House"
}

WORLD_TO_FIRST_LEVEL = {
    WORLD_AVIATION_HANGAR:       LEVEL_AVIATION_HANGAR_A,
    WORLD_GREENHOUSE:            LEVEL_GREENHOUSE_A,
    WORLD_ROBOTICS_LAB:          LEVEL_ROBOTICS_LAB_A,
    WORLD_CHEMISTRY_LAB:         LEVEL_CHEMISTRY_LAB_A,
    WORLD_LAB_OF_THE_LOST:       LEVEL_LAB_OF_THE_LOST_A,
    WORLD_NUCLEAR_POWER_STATION: LEVEL_NUCLEAR_POWER_STATION_A,
    WORLD_SPACE_PORT:            LEVEL_SPACE_PORT_A,
    WORLD_DEXTERS_HOUSE:         LEVEL_DEXTERS_HOUSE_A
}

CUTSCENE_NONE      = 0x00
CUTSCENE_EXIT_GAME = 0x01
CUTSCENE_GAME_OVER = 0x02
CUTSCENE_WIN_GAME  = 0x04

CHEATS_OFF = 0x00

IS_WARPING = 0xFFFFFFFF

// == FUNCTIONS ==

// Given a level number and a Dee Dee number (0 to 3), returns a bool whether that Dee Dee is collected
function get_dee_dee_bit(level, dee_dee_num) {
    // The tutorial level uses the same bits as Aviation Hanagar A
    if (level == LEVEL_TUTORIAL)
        level = LEVEL_AVIATION_HANGAR_A
    level_offset = 4 * dee_dee_num
    return bit(level - 1, DEE_DEES_COLLECTED_ADDRESS + level_offset)
}

function get_tool_bit(tool) {
    return bit(tool, TOOLS_COLLECTED_ADDRESS)
}

// Given a level number and a machine number (0 or 1), returns a bool whether that machine is repaired
function get_machine_bit(level, machine_num) {
    // The tutorial level uses the same bits as Aviation Hanagar A
    if (level == LEVEL_TUTORIAL)
        level = LEVEL_AVIATION_HANGAR_A
    level_offset = 4 * machine_num
    return bit(level - 1, MACHINES_REPAIRED_ADDRESS + level_offset)
}

function machines_repaired_count() {
    count = 0
    for offset in range(0, 7) {
        count = count + bitcount(MACHINES_REPAIRED_ADDRESS + offset)
    }
    return count
}

// == ACHIEVEMENTS ==

function are_cheats_off() {
    return cheats_applied() == CHEATS_OFF
}

// Cheats only last temporarily, but this checks that they haven't been used since the title screen
function have_cheats_always_been_off() {
    return disable_when(!are_cheats_off(), control_status() == CONTROL_STATUS_MAIN_MENU)
}

function is_demo_mode_off() {
    return demo_mode() == 0
}

function is_tool_currently_acquired(tool) {
    return get_tool_bit(tool) == 1
}

function is_dee_dee_collected(level, dee_dee_num) {
    return get_dee_dee_bit(level, dee_dee_num) == 1
}

function is_machine_repaired(level, machine_num) {
    return get_machine_bit(level, machine_num) == 1
}

function is_warping() {
    return warping() == IS_WARPING
}

function is_tutorial_fully_complete() {
    return have_cheats_always_been_off() &&
        is_demo_mode_off() &&
        level() == LEVEL_TUTORIAL &&
        is_tool_currently_acquired(TOOL_PLIERS) &&
        is_dee_dee_collected(LEVEL_TUTORIAL, 0) &&
        is_machine_repaired(LEVEL_TUTORIAL, 0) &&
        is_warping()
}

achievement(
    title = "Elementary", points = 1, id = 369934,
    description = "Exit the Tutorial with the Dee Dee rescued and the machine repaired",
    trigger = is_tutorial_fully_complete()
)

function did_lives_just_hit_nine() {
    return have_cheats_always_been_off() &&
        is_demo_mode_off() &&
        level() != LEVEL_HUB &&
        lives() == 9 &&
        prev(lives()) == 8
}

achievement(
    title = "The 27th Most Popular Cat Name", points = 2, id = 369984,
    description = "Max out the lives counter with 9 lives",
    trigger = did_lives_just_hit_nine()
)

function is_game_completed() {
    return have_cheats_always_been_off() &&
        is_demo_mode_off() &&
        cutscene() == CUTSCENE_WIN_GAME
}

achievement(
    title = "Deesaster Averted", points = 10, id = 369944,
    description = "Finish the game by interacting with the machine in the hub once everything has been done",
    trigger = is_game_completed()
)

leaderboard(
    title = "Game Completion Time",
    description = "Fastest time to beat the game",
    start  = total_time() > 0 && level() == LEVEL_HUB && have_cheats_always_been_off(),
    cancel = (cutscene() == CUTSCENE_EXIT_GAME || cutscene() == CUTSCENE_GAME_OVER || !are_cheats_off()),
    submit = cutscene() == CUTSCENE_WIN_GAME,
    value = measured(total_time()),
    format = "FRAMES", lower_is_better = true
)

rich_presence_conditional_display(control_status() == CONTROL_STATUS_MAIN_MENU, "Dexter in Main Menu")
rich_presence_conditional_display(!is_demo_mode_off(), "Dexter in Demo")
rich_presence_display("Dexter in {0} 🧑‍🔬: {1} 💖: {2}% 👩: {3} 🖥️: {4} ⏱️: {5} ",
    rich_presence_lookup("Level", level(), LEVEL_TO_NAME),
    rich_presence_value("VALUE", lives()),
    rich_presence_value("VALUE", health() * 0.78125),
    rich_presence_value("VALUE", total_dee_dees_collected()),
    rich_presence_value("VALUE", machines_repaired_count()),
    rich_presence_value("TIME", total_time(), format = "FRAMES")
)

// === TOOLS ===

function is_tool_acquired_in_level(tool_num, level_num) {
    return have_cheats_always_been_off() &&
        is_demo_mode_off() &&
        level() == level_num &&
        prev(bit(tool_num, TOOLS_COLLECTED_ADDRESS)) == 0 &&
        bit(tool_num, TOOLS_COLLECTED_ADDRESS) == 1
}

// [0] Achievement Name
// [1] Achievement ID
// [2] Level the tool is in
TOOL_ACHIEVEMENT_DETAILS = {
    TOOL_WRENCH:         ["Hand Provided Torque Spanner", 369938, LEVEL_GREENHOUSE_B],
    TOOL_HAMMER:         ["Stone Age Shaper", 369939, LEVEL_ROBOTICS_LAB_D],
    TOOL_SOLDERING_IRON: ["200 Degree Glue Stick", 369940, LEVEL_LAB_OF_THE_LOST_A],
    TOOL_DRILL:          ["Ubiquitous Hole Puncher", 369941, LEVEL_SPACE_PORT_A],
    TOOL_PLIERS:         ["Bronze Age Bolt Cutter", 369942, LEVEL_CHEMISTRY_LAB_A],
    TOOL_SCREWDRIVER:    ["Patented in 1932", 369943, LEVEL_AVIATION_HANGAR_D]
}

for tool_num in TOOL_ACHIEVEMENT_DETAILS {
    tool_name = TOOL_TO_NAME[tool_num]
    achievement_name = TOOL_ACHIEVEMENT_DETAILS[tool_num][0]
    achievement_id = TOOL_ACHIEVEMENT_DETAILS[tool_num][1]
    level_num = TOOL_ACHIEVEMENT_DETAILS[tool_num][2]
    level_name = LEVEL_TO_NAME[level_num]
    achievement(
        title = achievement_name, points = 1, id = achievement_id,
        description = "Find the " + tool_name + " in " + level_name,
        trigger = is_tool_acquired_in_level(tool_num, level_num)
    )
}

// === DEE DEES ===

function is_level_dee_dees_collected(level_num) {
    dee_dee_changed_this_frame = false
    dee_dees_collected = 0
    for i in range(0, 3) {
        prev_get_dee_dee_bit = prev(get_dee_dee_bit(level_num, i))
        current_get_dee_dee_bit = get_dee_dee_bit(level_num, i)
        dee_dee_changed_this_frame = dee_dee_changed_this_frame || (prev_get_dee_dee_bit == 0 && current_get_dee_dee_bit == 1)
        dee_dees_collected = dee_dees_collected + current_get_dee_dee_bit
    }
    is_in_level = (level() == level_num)
    return have_cheats_always_been_off() &&
        is_demo_mode_off() &&
        dee_dee_changed_this_frame &&
        measured(dee_dees_collected == 4, when = is_in_level)
}

// [0] Achievement Name
// [1] Achievement ID
DEE_DEE_ACHIEVEMENT_DETAILS = {
    LEVEL_AVIATION_HANGAR_A:       ["Wright of Passage", 369945],
    LEVEL_AVIATION_HANGAR_B:       ["Curtiss Call", 369946],
    LEVEL_AVIATION_HANGAR_C:       ["Friends and Dufaux", 369947],
    LEVEL_AVIATION_HANGAR_D:       ["Whittle by Whittle", 369948],
    LEVEL_GREENHOUSE_A:            ["Arber Day", 369950],
    LEVEL_GREENHOUSE_B:            ["Deposit to the Banks", 369951],
    LEVEL_GREENHOUSE_C:            ["Cultivating With Carver", 369952],
    LEVEL_GREENHOUSE_D:            ["Front of the Linneaus", 369953],
    LEVEL_ROBOTICS_LAB_A:          ["Berners-Lee and the World Wide Web", 369955],
    LEVEL_ROBOTICS_LAB_B:          ["Hopper to It", 369956],
    LEVEL_ROBOTICS_LAB_C:          ["Dijkstra's Algorithm", 369957],
    LEVEL_ROBOTICS_LAB_D:          ["Lovelace, Death and Robots", 369958],
    LEVEL_CHEMISTRY_LAB_A:         ["Gibbs and Take", 369960],
    LEVEL_CHEMISTRY_LAB_B:         ["Don't Mean To Bragg", 369961],
    LEVEL_CHEMISTRY_LAB_C:         ["Periodic Reminder of Mendeleev", 369962],
    LEVEL_CHEMISTRY_LAB_D:         ["Awarded the Nobel Prize", 369963],
    LEVEL_LAB_OF_THE_LOST_A:       ["Swearing a Hippocratic Oath", 369965],
    LEVEL_LAB_OF_THE_LOST_B:       ["Euclidean Design", 369966],
    LEVEL_LAB_OF_THE_LOST_C:       ["As Real as Eudoxus", 369967],
    LEVEL_LAB_OF_THE_LOST_D:       ["Pythagoras' Theorem", 369968],
    LEVEL_NUCLEAR_POWER_STATION_A: ["Volta's Current Findings", 369970],
    LEVEL_NUCLEAR_POWER_STATION_B: ["Alternating With Tesla", 369971],
    LEVEL_NUCLEAR_POWER_STATION_C: ["Calling In to Eccles", 369972],
    LEVEL_NUCLEAR_POWER_STATION_D: ["Performing at Your Maxwell", 369973],
    LEVEL_SPACE_PORT_A:            ["Korolev Off", 369976],
    LEVEL_SPACE_PORT_B:            ["Getting With Goddard", 369977],
    LEVEL_SPACE_PORT_C:            ["Propulsing With Cayley", 369978],
    LEVEL_SPACE_PORT_D:            ["Played a Frick", 369979],
    LEVEL_DEXTERS_HOUSE_A:         ["Leaving Brunel's Tunnels", 369980],
    LEVEL_DEXTERS_HOUSE_B:         ["Bradfield and Bridges", 369981],
    LEVEL_DEXTERS_HOUSE_D:         ["Telford Like It Is", 369982]
}

for level_num in DEE_DEE_ACHIEVEMENT_DETAILS {
    level_name = LEVEL_TO_NAME[level_num]
    achievement_name = DEE_DEE_ACHIEVEMENT_DETAILS[level_num][0]
    achievement_id = DEE_DEE_ACHIEVEMENT_DETAILS[level_num][1]
    achievement(
        title = achievement_name, points = 5, id = achievement_id,
        description = "Collect all 4 Dee Dees in " + level_name,
        trigger = is_level_dee_dees_collected(level_num)
    )
}

// === MACHINES ===

function is_level_machines_repaired(world_num, machines_in_levels) {
    first_level_num = WORLD_TO_FIRST_LEVEL[world_num]
    last_level_num = first_level_num + 3
    machines_changed_this_frame = false
    machines_repaired = 0
    total_machines = 0
    for i in range(0, 3) {
        if (machines_in_levels[i] > 0) {
            for machine_num in range(0, machines_in_levels[i] - 1) {
                prev_machine_bit = prev(get_machine_bit(first_level_num + i, machine_num))
                current_machine_bit = get_machine_bit(first_level_num + i, machine_num)
                machines_changed_this_frame = machines_changed_this_frame || (prev_machine_bit == 0 && current_machine_bit == 1)
                machines_repaired = machines_repaired + current_machine_bit
                total_machines = total_machines + 1
            }
        }
    }
    is_in_world = (level() >= first_level_num && level() <= last_level_num)
    return have_cheats_always_been_off() &&
        is_demo_mode_off() &&
        machines_changed_this_frame &&
        measured(machines_repaired == total_machines, when = is_in_world)
}

// [0] Achievement Name
// [1] Achievement ID
// [2] List of machines per level in world
MACHINE_ACHIEVEMENT_DETAILS = {
    WORLD_AVIATION_HANGAR:       ["The Montgolfier Brothers Weren't Full of Hot Air", 369949, [1, 2, 1, 2]],
    WORLD_GREENHOUSE:            ["Mendel as Anything", 369954, [1, 2, 1, 2]],
    WORLD_ROBOTICS_LAB:          ["Checked In Babbage", 369959, [1, 1, 1, 2]],
    WORLD_CHEMISTRY_LAB:         ["Faraday to Celebrate", 369964, [1, 1, 0, 1]],
    WORLD_LAB_OF_THE_LOST:       ["Archimedes Found It Easy as Pi", 369969, [2, 2, 2, 2]],
    WORLD_NUCLEAR_POWER_STATION: ["Fleming's Right Hand Rule",  369974, [2, 2, 0, 2]],
    WORLD_SPACE_PORT:            ["Strong Like Armstrong", 369975, [1, 2, 2, 2]],
    WORLD_DEXTERS_HOUSE:         ["Eiffel Won't Fall", 369983, [1, 1, 0, 0]]
}

// Sums all the integers in an array
function sum_array(a) {
    total = 0
    for x in a {
        total = total + x
    }
    return total
}

for world_num in MACHINE_ACHIEVEMENT_DETAILS {
    achievement_name = MACHINE_ACHIEVEMENT_DETAILS[world_num][0]
    achievement_id = MACHINE_ACHIEVEMENT_DETAILS[world_num][1]
    machines_in_world = MACHINE_ACHIEVEMENT_DETAILS[world_num][2]
    world_name = WORLD_TO_NAME[world_num]
    achievement(
        title = achievement_name, points = 5, id = achievement_id,
        description = "Repair all " + sum_array(machines_in_world) + " machines in " + world_name,
        trigger = is_level_machines_repaired(world_num, machines_in_world)
    )
}

// === ROBOT SWEEP ===

// This mapping is of every enemy's health address I could find while within that level.
// There may be a better way of finding these but some levels have out of bounds enemies that you cannot defeat, as well as non-defeatable entities.
ROBOT_ADDRESSES_IN_LEVEL = {
    LEVEL_AVIATION_HANGAR_A:       [0x03D20C, 0x03DF8C, 0x03CDD4, 0x03CB4C, 0x03DEB4, 0x03CC24],
    LEVEL_AVIATION_HANGAR_B:       [0x03C714, 0x03C7EC, 0x03C8C4, 0x03E13C, 0x03C63C, 0x03C99C, 0x03CA74, 0x03DB54],
    LEVEL_AVIATION_HANGAR_C:       [0x03EEBC, 0x03CB4C, 0x03CC24, 0x03CEAC, 0x03CF84, 0x03E574, 0x03CCFC, 0x03BF7C, 0x03CDD4],
    LEVEL_AVIATION_HANGAR_D:       [0x03DF8C, 0x03DEB4, 0x03D8CC, 0x03D7F4, 0x03D9A4, 0x03DA7C, 0x03DC2C, 0x03DDDC, 0x03D71C, 0x03D644, 0x03DD04],
    LEVEL_GREENHOUSE_A:            [0x03FDEC, 0x03D71C, 0x03D7F4, 0x03D8CC, 0x03D9A4, 0x03DC2C, 0x03DB54, 0x03DA7C, 0x03DDDC, 0x03DEB4],
    LEVEL_GREENHOUSE_B:            [0x03F654, 0x03E3C4, 0x03C3B4, 0x03C2DC, 0x03C12C, 0x03C054, 0x03BF7C, 0x03C204],
    LEVEL_GREENHOUSE_C:            [0x03D56C, 0x03DB54, 0x03DC2C, 0x03DA7C, 0x03D9A4, 0x03D7F4, 0x03D71C, 0x03D644, 0x03DEB4, 0x03DDDC, 0x03DD04],
    LEVEL_GREENHOUSE_D:            [0x0408E4, 0x04080C, 0x040A94, 0x0409BC, 0x040ECC, 0x040B6C, 0x040DF4, 0x040C44, 0x040734, 0x040D1C],
    LEVEL_ROBOTICS_LAB_A:          [0x03D134, 0x03D56C, 0x03D71C, 0x03D644, 0x03D494],
    LEVEL_ROBOTICS_LAB_B:          [0x03DDDC, 0x03D2E4, 0x03DA7C, 0x03DD04, 0x03E2EC, 0x03DC2C, 0x03DF8C, 0x03EA84, 0x03E8D4],
    LEVEL_ROBOTICS_LAB_C:          [0x03C204, 0x03C3B4, 0x03C48C, 0x03C564],
    LEVEL_ROBOTICS_LAB_D:          [0x03EF94, 0x03D7F4, 0x03EA84, 0x03EB5C, 0x03D20C, 0x03EEBC],
    LEVEL_CHEMISTRY_LAB_A:         [0x03D71C, 0x03CEAC, 0x03DA7C, 0x03D9A4, 0x03D56C, 0x03D644, 0x03DD04, 0x03DC2C, 0x03DDDC, 0x03DF8C, 0x03DEB4, 0x03DB54, 0x03E064, 0x03CF84],
    LEVEL_CHEMISTRY_LAB_B:         [0x03E13C, 0x03C8C4, 0x03DDDC, 0x03DEB4, 0x03D9A4, 0x03DA7C, 0x03DD04, 0x03DB54, 0x03DC2C, 0x03DF8C],
    LEVEL_CHEMISTRY_LAB_C:         [0x03E8D4, 0x03F144, 0x03E724, 0x03E7FC, 0x03ED0C, 0x03EDE4, 0x03B1FC, 0x03E9AC, 0x03EF94, 0x03F06C],
    LEVEL_CHEMISTRY_LAB_D:         [0x03D20C, 0x03D2E4, 0x03D3BC, 0x03D494, 0x03D56C, 0x03DC2C, 0x03DB54, 0x03D71C, 0x03D134, 0x03D7F4, 0x03DA7C, 0x03B484, 0x03B3AC, 0x03B2D4, 0x03B2D4],
    LEVEL_LAB_OF_THE_LOST_A:       [0x03CB4C, 0x03CC24, 0x03CDD4, 0x03C99C, 0x03CCFC, 0x03CA74, 0x03C7EC, 0x03C8C4, 0x03C714],
    LEVEL_LAB_OF_THE_LOST_B:       [0x03E49C, 0x03E3C4, 0x03E064, 0x03DF8C, 0x03E13C, 0x03E214, 0x03E2EC, 0x03DEB4, 0x03DDDC, 0x03F21C],
    LEVEL_LAB_OF_THE_LOST_C:       [0x03EF94, 0x03EDE4, 0x03EEBC, 0x03F06C, 0x03EC34, 0x03F57C, 0x03ED0C],
    LEVEL_LAB_OF_THE_LOST_D:       [0x03E13C, 0x03E214, 0x03DF8C, 0x03DDDC, 0x03DD04, 0x03E49C, 0x03E574, 0x03D9A4, 0x03E64C, 0x03DC2C, 0x03DB54, 0x03E724, 0x03DA7C, 0x03E3C4, 0x03E2EC, 0x03DEB4],
    LEVEL_NUCLEAR_POWER_STATION_A: [0x03CEAC, 0x03DDDC, 0x03D05C, 0x03D3BC, 0x03D494, 0x03CF84, 0x03DD04, 0x03D644, 0x03D56C, 0x03D134, 0x03DEB4],
    LEVEL_NUCLEAR_POWER_STATION_B: [0x040584, 0x0404AC, 0x0409BC, 0x0414B4, 0x0403D4, 0x04107C, 0x040FA4, 0x040ECC, 0x040DF4, 0x040D1C, 0x0413DC, 0x041304],
    LEVEL_NUCLEAR_POWER_STATION_C: [0x03E2EC, 0x03E3C4, 0x03E574, 0x03E13C, 0x03E64C, 0x03E49C, 0x03E9AC, 0x03E8D4, 0x03E7FC, 0x03E724, 0x03E214],
    LEVEL_NUCLEAR_POWER_STATION_D: [0x03E724, 0x03ED0C, 0x03EC34, 0x03EB5C, 0x03E7FC, 0x03E8D4, 0x03EA84, 0x03E64C, 0x03DB54, 0x03E574, 0x03E9AC],
    LEVEL_SPACE_PORT_A:            [0x03D134, 0x03D71C, 0x03E3C4, 0x03DA7C, 0x03DB54, 0x03DF8C, 0x03DEB4, 0x03E064, 0x03E13C, 0x03E2EC, 0x03E214],
    LEVEL_SPACE_PORT_B:            [0x03DA7C, 0x03DC2C, 0x03E214, 0x03DB54, 0x03DD04, 0x03DDDC, 0x03DEB4, 0x03DF8C],
    LEVEL_SPACE_PORT_C:            [0x03CA74, 0x03C99C, 0x03C8C4, 0x03CCFC, 0x03D9A4, 0x03CDD4, 0x03CC24, 0x03CB4C, 0x03CEAC],
    LEVEL_SPACE_PORT_D:            [0x03CEAC, 0x03CF84, 0x03D05C, 0x03E214, 0x03D20C, 0x03D134, 0x03D2E4]
}

function are_robots_defeated(world_num) {
    first_level_num = WORLD_TO_FIRST_LEVEL[world_num]
    last_level_num = first_level_num + 3
    total_robots = 0
    conditions = []
    for i in range(0, 3) {
        for data in ROBOT_ADDRESSES_IN_LEVEL[first_level_num + i] {
            prev_robot_health = prev(word(data))
            current_robot_health = word(data)
            array_push(conditions, once(
                level() == first_level_num + i &&
                prev(level()) == first_level_num + i &&
                current_robot_health != prev_robot_health &&
                (current_robot_health == 0 || current_robot_health > 0xF0FF) // Picking some arbitrary value to detect an underflow and not just the initial level health
            ))
            total_robots = total_robots + 1
        }
    }
    is_in_world = (level() >= first_level_num && level() <= last_level_num)
    return measured(
        tally(total_robots, conditions),
        when = (once(prev(level()) == LEVEL_HUB && level() == first_level_num))
    ) &&
        never(!is_in_world) &&
        never(lives() < prev(lives())) &&
        have_cheats_always_been_off() &&
        never(!is_demo_mode_off())
}

// [0] Achievement Name
// [1] Achievement ID
ROBOT_ACHIEVEMENT_DETAILS = {
    WORLD_AVIATION_HANGAR:       ["Yeager for More", 371654],
    WORLD_GREENHOUSE:            ["Darwin's Law", 371655],
    WORLD_ROBOTICS_LAB:          ["The Turing Test", 371656],
    WORLD_CHEMISTRY_LAB:         ["Lavoisier in Equilibrium", 371657],
    WORLD_LAB_OF_THE_LOST:       ["Plot a Course With Ptolomy", 371658],
    WORLD_NUCLEAR_POWER_STATION: ["Ohm Seeks No Resistance", 371659],
    WORLD_SPACE_PORT:            ["Brains and von Braun", 371660],
}

// Returns a string of how many robots are in the four levels of a given world (e.g. "(5, 4, 8, 10)")
function robots_per_level_presentation(world_num) {
    first_level_num = WORLD_TO_FIRST_LEVEL[world_num]
    robots_per_level_str = "("
    for i in range(0, 3) {
        robots_per_level_str = robots_per_level_str + length(ROBOT_ADDRESSES_IN_LEVEL[first_level_num + i])
        if (i != 3) robots_per_level_str = robots_per_level_str + ", "
    }
    robots_per_level_str = robots_per_level_str + ")"
    return robots_per_level_str
}

for world_num in ROBOT_ACHIEVEMENT_DETAILS {
    achievement_name = ROBOT_ACHIEVEMENT_DETAILS[world_num][0]
    achievement_id = ROBOT_ACHIEVEMENT_DETAILS[world_num][1]
    first_level_num = WORLD_TO_FIRST_LEVEL[world_num]
    robots_per_level_str = robots_per_level_presentation(world_num)
    world_name = WORLD_TO_NAME[world_num]
    achievement(
        title = achievement_name, points = 10, id = achievement_id,
        description = "Defeat every enemy in one trip to the " + world_name + " without losing a life " + robots_per_level_str,
        trigger = are_robots_defeated(world_num)
    )
}
