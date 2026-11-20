"""Draws Stormbound's textures into Media/ (TGA, power-of-two sizes).

Run from the addon folder:  python3 tools/make_media.py
Card textures are white with alpha so the game can tint them; the emblem comes from the painted art.
"""
import random
from PIL import Image, ImageChops, ImageDraw, ImageFilter


OUT = "Media/"
ART = "Stormbound.png"  # painted by Marius; the logo, icon and crest are made from it


def cloud(size=128, seed=11):
    """Storm clouds: soft overlapping blobs, tileable, white on alpha."""
    rnd = random.Random(seed)
    img = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(img)
    for _ in range(60):
        x, y = rnd.randrange(size), rnd.randrange(size)
        r = rnd.randint(8, 26)
        v = rnd.randint(30, 90)
        for dx in (-size, 0, size):
            for dy in (-size, 0, size):
                d.ellipse([x + dx - r, y + dy - r * 0.7, x + dx + r, y + dy + r * 0.7], fill=v)
    img = img.filter(ImageFilter.GaussianBlur(6))
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def fork(size=32, seed=3):
    """A small lightning fork running out of the top-left corner."""
    rnd = random.Random(seed)
    s = size * 4
    img = Image.new("L", (s, s), 0)
    d = ImageDraw.Draw(img)
    x, y = s * 0.04, s * 0.04
    pts = [(x, y)]
    for _ in range(5):
        x += rnd.uniform(s * 0.10, s * 0.20)
        y += rnd.uniform(s * 0.10, s * 0.20)
        pts.append((x + rnd.uniform(-s * 0.06, s * 0.06), y))
    d.line(pts, fill=255, width=int(s * 0.05), joint="curve")
    bx, by = pts[2]
    d.line([(bx, by), (bx + s * 0.25, by - s * 0.02), (bx + s * 0.38, by + s * 0.06)], fill=200, width=int(s * 0.03))
    glow = img.filter(ImageFilter.GaussianBlur(s * 0.04))
    img = Image.composite(img, glow, img)
    img = img.resize((size, size), Image.LANCZOS)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


def rim(size=64, width=5):
    """A soft glow along the edge of a square, for the pulsing rim (stretched over the card)."""
    img = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(img)
    for i in range(width * 2):
        v = int(255 * (1 - i / (width * 2)) ** 2)
        d.rectangle([i, i, size - 1 - i, size - 1 - i], outline=v)
    img = img.filter(ImageFilter.GaussianBlur(1.2))
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out


ELEMENT_COLOURS = [(158, 118, 66), (255, 115, 40), (64, 153, 255), (200, 220, 255)]  # earth fire water air


def emblem(size=256):
    """The emblem, from the painted art in Stormbound.png (also the CurseForge project picture)."""
    return Image.open(ART).convert("RGBA").resize((size, size), Image.LANCZOS)


def crest(size=256):
    """The card crest: the same art as a white shape for the game to tint, its light parts
    brighter, so the faint motif behind the cards matches the icon."""
    art = emblem(size)
    lum = art.convert("L").point([int(70 + v * 185 / 255) for v in range(256)])
    alpha = ImageChops.multiply(art.getchannel("A"), lum)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(alpha)
    return out

def icon(size):
    """Square icon: the emblem on a dark storm gradient."""
    bg = Image.new("RGBA", (size, size), (0, 0, 0, 255))
    d = ImageDraw.Draw(bg)
    for y in range(size):
        t = y / size
        d.line([(0, y), (size, y)], fill=(int(18 + 22 * (1 - t)), int(20 + 26 * (1 - t)), int(36 + 50 * (1 - t)), 255))
    e = emblem(size * 2).resize((size, size), Image.LANCZOS)
    return Image.alpha_composite(bg, e)


def save(img, name):
    img.save(OUT + name + ".tga")
    print("wrote", OUT + name + ".tga", img.size)


if __name__ == "__main__":
    save(cloud(), "Cloud")
    save(fork(), "Fork")
    save(crest(), "Crest")
    save(rim(), "Rim")
    save(emblem(256), "Logo256")
    save(emblem(64), "Logo64")
    save(icon(64), "Icon64")
    save(icon(128), "Icon128")
