with open("Savestates/eeMemory_in.bin", "rb") as f:
    memory = bytearray(f.read())

with open("Savestates/eeMemory.bin", "wb") as f:

    LEADERBOARDS_START_ADDRESS = 0x01b2d820
    LEADERBOARDS_END_ADDRESS = LEADERBOARDS_START_ADDRESS + (2250 * 0x38)

    f.write(memory[0:LEADERBOARDS_START_ADDRESS])

    for i in range(0, 2250):
        f.write(bytearray("1 - " + str(i).zfill(4) + "\0\0\0\0", "ascii"))
        f.write(bytearray("2 - " + str(i).zfill(4) + "\0\0\0\0", "ascii"))
        f.write(bytearray("3 - " + str(i).zfill(4) + "\0\0\0\0", "ascii"))
        f.write((i + 30000).to_bytes(3, "little"))
        f.write((i + 20000).to_bytes(3, "little"))
        f.write((i + 10000).to_bytes(3, "little"))
        f.write(bytearray(3))
        f.write(b"\x00")
        f.write(b"\xa0")
        l = i + 100000
        f.write(l.to_bytes(3, "little"))
        f.write(bytearray([0, 2, 0]))

    f.write(memory[LEADERBOARDS_END_ADDRESS:])
