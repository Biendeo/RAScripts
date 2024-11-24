from dataclasses import dataclass

@dataclass
class Difficulty:
    name: str
    size: int

@dataclass
class Color:
    name: str
    constant: str

DIFFICULTIES = [
    Difficulty("Beginner", 3),
    Difficulty("Junior", 4),
    Difficulty("Senior", 5),
    Difficulty("Professional", 6)
]

COLORS = [
    Color("Blue", "COLOR_BLUE"),
    Color("Red", "COLOR_RED"),
    Color("Green", "COLOR_GREEN"),
]

for difficulty in DIFFICULTIES:
    i = 0
    print("rich_presence_conditional_display(")
    print(f"    game_state() == GAME_STATE_IN_GAME && puzzle_width() == {difficulty.size},")
    print(f'    "Sliding on {difficulty.name} difficulty - Correct Tiles: ', end="")
    for color in COLORS:
        print(f"{color.name} ", end="")
        for row in range(difficulty.size):
            for col in range(difficulty.size):
                print(f"{{{i}}}", end="")
                i += 1
            if row < difficulty.size - 1:
                print("/", end="")
            
        if color.name != "Green":
            print(", ", end="")
    print('",')
    for color in COLORS:
        for row in range(difficulty.size):
            for col in reversed(range(difficulty.size)):
                print(f'    rich_presence_lookup("CorrectTile", is_tile_correct_int({color.constant}, {row * difficulty.size + col}), CORRECT_TILE_RP_CHAR, ".")', end="")
                if color.name != "Green" or row != difficulty.size - 1 or col != 0:
                    print(",")
                else:
                    print()
    print(")")