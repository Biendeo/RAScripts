from PIL import Image

WORLDS = [
    "AviationHangar",
    "Greenhouse",
    "RoboticsLab",
    "ChemistryLab",
    "LabOfTheLost",
    "NuclearPowerStation",
    "SpacePort",
    "DextersHouse"
]

TOOLS = [
    "Drill",
    "Hammer",
    "Pliers",
    "Screwdriver",
    "SolderingIron",
    "Wrench"
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_deedee_icons()
    generate_machine_icons()
    generate_robot_icons()
    generate_tool_icons()
    generate_other_icons()

def generate_deedee_icons() -> None:
    for world in WORLDS:
        background_image = Image.open(f"Icons/Layers/DeeDee-{world}.png")
        for level_num in ["A", "B", "C", "D"]:
            if world == "DextersHouse" and level_num == "C":
                continue
            level_layer = Image.open(f"Icons/Layers/Letter-{level_num}.png")
            background_image.paste(level_layer, (40, 40), level_layer)
            background_image.paste(BORDER, (0, 0), BORDER)
            background_image.save(f"Icons/Output/Achievement-DeeDees-{world}-{level_num}.png")

def generate_machine_icons() -> None:
    for world in WORLDS:
        background_image = Image.open(f"Icons/Layers/Machine-{world}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-MachinesRepaired-{world}.png")

def generate_robot_icons() -> None:
    for world in WORLDS:
        if world == "DextersHouse":
            continue
        background_image = Image.open(f"Icons/Layers/Robot-{world}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-RobotsDestroyed-{world}.png")

def generate_tool_icons() -> None:
    for tool in TOOLS:
        background_image = Image.open(f"Layers/Tool-{tool}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-CollectedTool-{tool}.png")

def generate_other_icons() -> None:
    for background_file_name, output_achievement_name in [
        ("Lives", "Collected9Lives"),
        ("Tutorial", "CompletedTutorial"),
        ("Complete", "GameComplete")
    ]:
        background_image = Image.open(f"Icons/Layers/{background_file_name}.png")
        background_image.paste(BORDER, (0, 0), BORDER)
        background_image.save(f"Icons/Output/Achievement-{output_achievement_name}.png")

if __name__ == "__main__":
    main()