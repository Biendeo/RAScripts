from PIL import Image
from dataclasses import dataclass

SONGS = [
    "AmiOh",
    "Obsesion",
    "BrightLights",
    "LaisseParlerLesGens",
    "FemmeLikeU",
    "Sevader",
    "ParleMoi",
    "EtCestParti",
    "JaiDesChosesATeDire",
    "Lorphelin",
    "LeMurDuSon",
    "Venus",
    "DoYouReallyWantToHurtMe",
    "JustAGigaloIAintGotNobody",
    "EsWarSommerDieWahreGeschichte",
    "1000Und1Nacht",
    "51stState",
    "KonigVonDeutschland",
    "SkandalImSperrbezirk",
    "ComeMai",
    "DimmiCome",
    "SenzaPieta",
    "AltreFDV",
    "UnGiornoDamore",
    "SiTrattaDellAmore",
    "VivereAColori",
    "BambineCattive",
    "IlMareDinverno",
    "Blu",
    "GenteComeNoi",
    "Fasi",
    "NoEsLoMismo",
    "SinMiedoANada",
    "LaLola",
    "OtraVez",
    "AveMaria",
    "DosHombresYUnDestino",
    "EnAlgunLugar",
    "RetorciendoPalabras",
    "UnoMasUnoSonSiete",
    "YinYang",
    "EsPorTi",
    "TuVolveras",
    "Rosas",
    "Carolina",
    "Desesperada",
    "AmanteBandido",
    "Bienvenidos",
    "Loko",
    "ChicaDeAyer",
    "UnBesoYUnaFlor",
    "ComoHemosCambiado",
    "SiEsTanSoloAmor",
    "QuieroBesarte",
    "Chiquilla"
]

TWO_PART_SONGS = [
    "Obsesion",
    "LaisseParlerLesGens",
    "FemmeLikeU",
    "ParleMoi",
    "Lorphelin",
    "Blu",
    "DosHombresYUnDestino"
]

@dataclass
class AchievementDetails:
    name: str
    border_color: str

BORDER_COLORS = {
    "blue": [0.000, 0.722, 0.937, 1.000],
    "red": [0.918, 0.078, 0.176, 1.000],
    "orange": [1.000, 0.545, 0.000, 1.000],
    "green": [0.012, 0.793, 0.000, 1.000]
}

SONG_ACHIEVEMENTS = [
    AchievementDetails("Easy", "blue"),
    AchievementDetails("Hard", "red"),
    AchievementDetails("FC", "orange")
]

BORDER = Image.open("Icons/Layers/Border.png")

def main() -> None:
    generate_song_achievements()

def get_border(color: str) -> Image:
    r, g, b, a = BORDER.split()
    colors = BORDER_COLORS[color]
    return Image.merge("RGBA", (
        r.point(lambda z: z * colors[0]),
        g.point(lambda z: z * colors[1]),
        b.point(lambda z: z * colors[2]),
        a.point(lambda z: z * colors[3])
    ))

def generate_song_achievements() -> None:
    for i, details in enumerate(SONG_ACHIEVEMENTS):
        r, g, b, a = BORDER.split()
        colored_border = get_border(details.border_color)
        for song in SONGS:
            if details.name == "FC" and song in TWO_PART_SONGS:
                background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 1}.png")
                background_image.paste(colored_border, (0, 0), colored_border)
                background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}-1.png")
                background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 2}.png")
                background_image.paste(colored_border, (0, 0), colored_border)
                background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}-2.png")
            else:
                background_image = Image.open(f"Icons/Layers/Song-{song}-{i + 1}.png")
                background_image.paste(colored_border, (0, 0), colored_border)
                background_image.save(f"Icons/Output/Achievement-Song-{song}-{details.name}.png")

if __name__ == "__main__":
    main()