import sys
import binascii

with open("Savestates/eeMemory.bin", "rb") as f:
    memory = bytearray(f.read())

# Sanity check that this is correct
AVAILABLE_FUNDS_NODE = 0x008ef260
available_funds = int.from_bytes(memory[(AVAILABLE_FUNDS_NODE + 0x8):(AVAILABLE_FUNDS_NODE + 0xc)], byteorder="little")
if available_funds != 2000008920:
    print("Available funds did not match! Aborting!")
    sys.exit(1)

print("Exploring tail end")

current_node = AVAILABLE_FUNDS_NODE
while current_node != 0:
    whatever_is_before = memory[(current_node + 0x0):(current_node + 0x8)]
    value = int.from_bytes(memory[(current_node + 0x8):(current_node + 0xc)], byteorder="little")
    next_node = int.from_bytes(memory[(current_node + 0xc):(current_node + 0x10)], byteorder="little")
    print(f"{hex(current_node)}[{hex(current_node)} before={binascii.hexlify(whatever_is_before)} v={value}] --> {hex(next_node)}")
    current_node = next_node

print()

print("Exploring head")

def find_all_addresses(a: bytearray, x: int) -> list[int]:
    r = []
    result = 0
    offset = 0
    while result >= 0:
        result = a.find(x.to_bytes(4, byteorder="little"), offset)
        if result >= 0:
            r.append(result - 0xc)
        offset += result + 4
        
    return r

current_node = AVAILABLE_FUNDS_NODE
stack = [current_node]
while len(stack) > 0:
    current_node = stack.pop()
    stack.extend(find_all_addresses(memory, current_node))
    whatever_is_before = memory[(current_node + 0x0):(current_node + 0x8)]
    value = int.from_bytes(memory[(current_node + 0x8):(current_node + 0xc)], byteorder="little")
    next_node = int.from_bytes(memory[(current_node + 0xc):(current_node + 0x10)], byteorder="little")
    print(f"{hex(current_node)}[{hex(current_node)} before={binascii.hexlify(whatever_is_before)} v={value}] --> {hex(next_node)}")