from PIL import Image

SINGLE_LAYER_ACHIEVEMENTS = [
    "Key-Emerald",
    "Item-WinnowingHalls-PlatinumHelm",
    "Special-WinnowingHalls-RingBell",
    "Key-Silver",
    "Enter-SevenPortals",
    "Switch-GuardianOfIce-Sword",
    "Switch-GuardianOfFire-OneThird",
    "Item-GuardianOfFire-FlameMask",
    "Switch-GuardianOfSteel-OneThird",
    "Item-GuardianOfIce-Torch",
    "Key-Fire",
    "Key-Steel",
    "Item-GuardianOfFire-ChaosDevice",
    "Switch-GuardianOfFire-Stairs",
    "Switch-SevenPortals-EastRoom",
    "Switch-GuardianOfSteel-Stairs",
    "Switch-SevenPortals-WestRoom",
    "Switch-SevenPortals-ThreeBulls",
    "Item-SevenPortals-WingsOfWrath",
    "Item-GuardianOfSteel-MysticUrn",
    "Switch-GuardianOfSteel-SecretLevel",
    "Switch-GuardianOfFire-SecretLevel",
    "Enter-BrightCrucible",
    "Item-BrightCrucible-HeartOfDsparil",
    "Item-BrightCrucible-Use-HeartOfDsparil",
    "Item-BrightCrucible-IconOfTheDefender",
    "HubExit-1",
    "Item-ShadowWood-MysticUrn",
    "Enter-CavesOfCirce",
    "Item-CavesOfCirce-ChaosDevice",
    "Item-CavesOfCirce-PlatinumHelm",
    "Key-Cave",
    "Enter-Wastelands",
    "Key-Horn",
    "Switch-Wastelands-CenterOneSixth",
    "Enter-Darkmere",
    "Switch-Darkmere-Bungalow",
    "Switch-Darkmere-Well",
    "Key-Castle",
    "Key-Swamp",
    "Switch-Darkmere-NorthernOneSixth",
    "Switch-Darkmere-SouthernOneSixth",
    "Switch-Wastelands-EttinKills",
    "Item-Wastelands-Porkalator",
    "Item-Wastelands-BootsOfSpeed",
    "Switch-Wastelands-CastleOneSixth",
    "Switch-CavesOfCirce-SouthEasternOneSixth",
    "Switch-CavesOfCirce-SouthWesternOneSixth",
    "Enter-SacredGrove",
    "Switch-SacredGrove-Secret",
    "Enter-Hypostyle",
    "HubExit-2",
    "Switch-HeresiarchsSeminary-BullSwitches",
    "Item-HeresiarchsSeminary-IconOfTheDefender",
    "Item-HeresiarchsSeminary-FalconShield",
    "Item-OrchardOfLamentations-Porkalator",
    "Item-OrchardOfLamentations-AmuletOfWarding",
    "Item-OrchardOfLamentations-SapphirePlanet",
    "Item-OrchardOfLamentations-EmeraldPlanet",
    "Item-SilentRefactory-BanishmentDevice",
    "Item-SilentRefactory-SapphirePlanet",
    "Item-SilentRefactory-RubyPlanet",
    "Item-SilentRefactory-Porkalator",
    "Item-SilentRefactory-EmeraldPlanet",
    "Switch-HeresiarchsSeminary-Planets",
    "Item-HeresiarchsSeminary-BootsOfSpeed",
    "Switch-WolfChapel-SouthernOneNinth",
    "Item-DragonChapel-MysticUrn",
    "Switch-DragonChapel-WesternOneNinth",
    "Switch-DragonChapel-EasternOneNinth",
    "Switch-GriffinChapel-CenterOneNinth",
    "Item-GriffinChapel-ChaosDevice",
    "Switch-GriffinChapel-SouthernOneNinth",
    "Item-GriffinChapel-Porkalator",
    "Item-GriffinChapel-FalconShield",
    "Switch-GriffinChapel-NorthernOneNinth",
    "Switch-WolfChapel-WesternOneNinth",
    "Item-WolfChapel-IconOfTheDefender",
    "Switch-WolfChapel-NorthernOneNinth",
    "Item-WolfChapel-KraterOfMight",
    "Switch-DragonChapel-NorthernOneNinth",
    "Enter-DeathwindChapel",
    "Item-DeathwindChapel-PlatinumHelm",
    "Item-DeathwindChapel-KraterOfMight",
    "HubExit-3",
    "Item-CastleOfGrief-KraterOfMight",
    "Item-CastleOfGrief-AmuletOfWarding",
    "Switch-CastleOfGrief-MoonSwitches",
    "Switch-CastleOfGrief-SkullSwitches",
    "Switch-CastleOfGrief-Gears",
    "Item-ForsakenOutpost-PlatinumHelm",
    "Item-ForsakenOutpost-LiberOscura",
    "Key-Rusted",
    "Item-ForsakenOutpost-DaemonCodex",
    "Enter-DesolateGarden",
    "Item-DesolateGarden-KraterOfMight",
    "Enter-Gibbet",
    "Item-Gibbet-DragonskinBracers",
    "Item-Gibbet-YoricksSkull",
    "Item-Gibbet-Use-YoricksSkull",
    "Key-Dungeon",
    "Item-Gibbet-Porkalator",
    "Enter-Dungeons",
    "Switch-Dungeons-MoonSwitch",
    "Item-Dungeons-Porkalator",
    "Item-Dungeons-MeshArmor",
    "Enter-Effluvium",
    "Item-Effluvium-MysticUrn",
    "Item-Effluvium-Torch",
    "Item-Effluvium-DragonskinBracers",
    "Item-Effluvium-Porkalator",
    "Item-Effluvium-FalconShield",
    "Item-Effluvium-KraterOfMight",
    "Switch-ForsakenOutpost-LinedefTrigger",
    "Item-ForsakenOutpost-BootsOfSpeed",
    "Key-Axe",
    "HubExit-4",
    "Enter-Vivarium",
    "Item-Vivarium-Secret",
    "Item-Vivarium-DragonskinBracers",
    "Item-Vivarium-MysticUrn",
    "Item-Vivarium-Porkalator",
    "Item-ZedeksTomb-Porkalator",
    "Item-ZedeksTomb-MeshArmor",
    "Item-ZedeksTomb-GlaiveSeal",
    "Item-TraductusTomb-HolyRelic",
    "Item-TraductusTomb-FalconShield",
    "Item-TraductusTomb-IconOfTheDefender",
    "Item-MenelkirsTomb-SigilOfTheMagus",
    "HubExit-5",
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_single_layer_achievements()
    generate_hub_exit_difficulty_achievements()
    generate_weapon_achievements()
    generate_item_switch_achievements()

def generate_single_layer_achievements() -> None:
    for achievement in SINGLE_LAYER_ACHIEVEMENTS:
        ending_image = Image.open(f"Icons/Layers/Layer-{achievement}.png")
        ending_image.paste(BORDER, (0, 0), BORDER)
        ending_image.save(f"Icons/Output/Achievement-{achievement}.png")

def generate_hub_exit_difficulty_achievements() -> None:
    for achievement in [x for x in SINGLE_LAYER_ACHIEVEMENTS if "HubExit" in x]:
        ending_image = Image.open(f"Icons/Layers/Layer-{achievement}.png")
        r, g, b, a = ending_image.split()
        ending_image = Image.merge("RGBA", (
            r.point(lambda z: z * 1.8),
            g.point(lambda z: z * 0.8),
            b.point(lambda z: z * 0.8),
            a.point(lambda z: z)
        ))
        ending_image.paste(BORDER, (0, 0), BORDER)
        ending_image.save(f"Icons/Output/Achievement-{achievement}-Hard.png")

def generate_weapon_achievements() -> None:
    generate_second_weapon_achievement()
    generate_third_weapon_achievement()
    generate_fourth_weapon_achievement()
    generate_fourth_weapon_part_one_achievement()
    generate_fourth_weapon_part_two_achievement()
    generate_fourth_weapon_part_three_achievement()

def generate_second_weapon_achievement() -> None:
    ending_image = Image.open(f"Icons/Layers/Layer-Automap.png")
    fighter_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Fighter-2.png")
    ending_image.paste(fighter_weapon, (0, 4), fighter_weapon)
    cleric_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Cleric-2.png")
    ending_image.paste(cleric_weapon, (17, 4), cleric_weapon)
    mage_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Mage-2.png")
    ending_image.paste(mage_weapon, (34, 16), mage_weapon)
    ending_image.paste(BORDER, (0, 0), BORDER)
    ending_image.save(f"Icons/Output/Achievement-Weapon-2.png")

def generate_third_weapon_achievement() -> None:
    ending_image = Image.open(f"Icons/Layers/Layer-Automap.png")
    fighter_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Fighter-3.png")
    ending_image.paste(fighter_weapon, (1, 6), fighter_weapon)
    cleric_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Cleric-3.png")
    ending_image.paste(cleric_weapon, (17, 0), cleric_weapon)
    mage_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Mage-3.png")
    ending_image.paste(mage_weapon, (36, 14), mage_weapon)
    ending_image.paste(BORDER, (0, 0), BORDER)
    ending_image.save(f"Icons/Output/Achievement-Weapon-3.png")

def generate_fourth_weapon_achievement() -> None:
    ending_image = Image.open(f"Icons/Layers/Layer-Automap.png")
    fighter_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Fighter-4.png")
    ending_image.paste(fighter_weapon, (1, 1), fighter_weapon)
    cleric_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Cleric-4.png")
    ending_image.paste(cleric_weapon, (17, 3), cleric_weapon)
    mage_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Mage-4.png")
    ending_image.paste(mage_weapon, (49, 1), mage_weapon)
    ending_image.paste(BORDER, (0, 0), BORDER)
    ending_image.save(f"Icons/Output/Achievement-Weapon-4.png")

def generate_fourth_weapon_part_one_achievement() -> None:
    ending_image = Image.open(f"Icons/Layers/Layer-Automap.png")
    fighter_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Fighter-Piece-1.png")
    ending_image.paste(fighter_weapon, (4, 19), fighter_weapon)
    cleric_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Cleric-Piece-1.png")
    ending_image.paste(cleric_weapon, (23, 18), cleric_weapon)
    mage_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Mage-Piece-1.png")
    ending_image.paste(mage_weapon, (52, 16), mage_weapon)
    ending_image.paste(BORDER, (0, 0), BORDER)
    ending_image.save(f"Icons/Output/Achievement-Weapon-Piece-1.png")

def generate_fourth_weapon_part_two_achievement() -> None:
    ending_image = Image.open(f"Icons/Layers/Layer-Automap.png")
    fighter_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Fighter-Piece-2.png")
    ending_image.paste(fighter_weapon, (1, 21), fighter_weapon)
    cleric_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Cleric-Piece-2.png")
    ending_image.paste(cleric_weapon, (22, 19), cleric_weapon)
    mage_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Mage-Piece-2.png")
    ending_image.paste(mage_weapon, (52, 16), mage_weapon)
    ending_image.paste(BORDER, (0, 0), BORDER)
    ending_image.save(f"Icons/Output/Achievement-Weapon-Piece-2.png")

def generate_fourth_weapon_part_three_achievement() -> None:
    ending_image = Image.open(f"Icons/Layers/Layer-Automap.png")
    fighter_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Fighter-Piece-3.png")
    ending_image.paste(fighter_weapon, (4, 7), fighter_weapon)
    cleric_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Cleric-Piece-3.png")
    ending_image.paste(cleric_weapon, (20, 19), cleric_weapon)
    mage_weapon = Image.open(f"Icons/Layers/Layer-Weapon-Mage-Piece-3.png")
    ending_image.paste(mage_weapon, (49, 22), mage_weapon)
    ending_image.paste(BORDER, (0, 0), BORDER)
    ending_image.save(f"Icons/Output/Achievement-Weapon-Piece-3.png")

def generate_item_switch_achievements() -> None:
    for number in ["06", "40"]:
        ending_image = Image.open(f"Icons/Layers/Layer-Switch-DarkCrucible-ItemSwitch.png")
        ending_image.paste(BORDER, (0, 0), BORDER)
        number_image = Image.open(f"Icons/Layers/Layer-{number}.png")
        ending_image.paste(number_image, (23, 2), number_image)
        ending_image.save(f"Icons/Output/Achievement-Switch-DarkCrucible-{number}.png")


if __name__ == "__main__":
    main()