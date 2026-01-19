from constants import get_all_songs

songs = get_all_songs()

print(r"[32-bit BE] Song ID")
print(r"Every song including DLC songs has a unique value here:")
for song in sorted(songs, key=lambda song: song.Id):
    print(f"{song.Id:#010x} - {song.Title}")