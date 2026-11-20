"""Draws Stormbound's textures into Media/ (TGA, power-of-two sizes).

Run from the addon folder:  python3 tools/make_media.py
Card textures are white with alpha so the game can tint them; the emblem is drawn in colour.
"""
import math
import random
from PIL import Image, ImageDraw, ImageFilter

import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "LibBound", "tools"))
from paint import Canvas, bar, disc, grow, leaf, lick, mask, minus, poly, radial_disc, rays, ring, sparkle, union  # noqa: E402

S = 1024

OUT = "Media/"


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
    """The Stormbound emblem, painted (tools in LibBound/tools/paint.py)."""
    s = S
    cv = Canvas(s)
    radial_disc(cv, 0.40, (46, 56, 92), (8, 10, 22))
    rnd = random.Random(4)
    cl = mask(s); d = ImageDraw.Draw(cl)
    for _ in range(26):
        a, r = rnd.uniform(0, 2 * math.pi), rnd.uniform(0.08, 0.30)
        x, y, rr = 0.5 + math.cos(a) * r, 0.5 + math.sin(a) * r, rnd.uniform(0.04, 0.09)
        d.ellipse([(x - rr) * s, (y - rr) * s, (x + rr) * s, (y + rr) * s], fill=rnd.randint(60, 140))
    cl = minus(cl.filter(ImageFilter.GaussianBlur(22)), minus(mask(s), disc(s, 0.37)))
    cv.light(cl, (90, 110, 170), 0.6)
    rg = ring(s, 0.415, 0.372)
    cv.glow(rg, (100, 160, 255), 18, 0.5)
    cv.paint(rg, top=(240, 200, 140), bottom=(110, 62, 30), bevel=8, gloss=0.6)
    gems = [(math.pi * 1.75, (240, 250, 255), (130, 150, 180)), (math.pi * 0.25, (255, 150, 60), (150, 40, 10)),
            (math.pi * 0.75, (110, 190, 255), (20, 70, 170)), (math.pi * 1.25, (120, 200, 90), (30, 80, 20))]
    for a, top, bot in gems:   # air top left, fire top right, water bottom right, earth bottom left
        x, y = 0.5 + math.sin(a) * 0.393, 0.5 - math.cos(a) * 0.393
        g = disc(s, 0.042, x * s, y * s)
        cv.shadow(g, 6, 3, 5, 0.6)
        cv.paint(grow(g, 6), top=(240, 200, 140), bottom=(100, 60, 30), bevel=4, gloss=0.5)
        cv.paint(g, top=top, bottom=bot, bevel=8, gloss=0.9)
    bolt = poly(s, [(0.56, 0.02), (0.33, 0.52), (0.48, 0.50), (0.38, 0.98), (0.70, 0.40), (0.53, 0.43), (0.68, 0.02)])
    cv.glow(bolt, (90, 160, 255), 60, 1.0)
    cv.glow(bolt, (170, 210, 255), 20, 0.9)
    cv.shadow(bolt, 14, 8, 10, 0.5)
    cv.paint(bolt, top=(255, 255, 255), bottom=(150, 200, 255), bevel=14, gloss=0.5, light=0.5, dark=0.55)
    arcs = mask(s); d = ImageDraw.Draw(arcs)
    for pts in (((0.36, 0.50), (0.27, 0.46), (0.22, 0.52), (0.15, 0.48)), ((0.62, 0.42), (0.71, 0.47), (0.76, 0.42), (0.84, 0.46)),
                ((0.45, 0.70), (0.40, 0.78), (0.31, 0.80))):
        d.line([(x * s, y * s) for x, y in pts], fill=255, width=6)
    cv.light(arcs.filter(ImageFilter.GaussianBlur(5)), (120, 180, 255), 1.0)
    cv.light(arcs.filter(ImageFilter.GaussianBlur(1)), (230, 240, 255), 0.8)
    return cv.image(size)


def icon(size):
    """Square icon: the emblem on a dark storm gradient."""
    bg = Image.new("RGBA", (size, size), (0, 0, 0, 255))
    d = ImageDraw.Draw(bg)
    for y in range(size):
        t = y / size
        d.line([(0, y), (size, y)], fill=(int(18 + 22 * (1 - t)), int(20 + 26 * (1 - t)), int(36 + 50 * (1 - t)), 255))
    e = emblem(size * 2).resize((size, size), Image.LANCZOS)
    return Image.alpha_composite(bg, e)


def _finish(img, size):
    """White line art at 4x: a soft glow under it, down to size, as alpha."""
    glow = img.filter(ImageFilter.GaussianBlur(img.size[0] * 0.012))
    img = Image.composite(img, glow, img).resize((size, size), Image.LANCZOS)
    out = Image.new("RGBA", (size, size), (255, 255, 255, 0))
    out.putalpha(img)
    return out

def crest(size=256):
    """The card crest: a lightning bolt through a storm swirl."""
    s = size * 4
    c = s / 2
    img = Image.new("L", (s, s), 0)
    d = ImageDraw.Draw(img)
    w = int(s * 0.02)
    for i, r in enumerate((0.44, 0.34, 0.24)):
        start = 200 + i * 50
        d.arc([c - s * r, c - s * r, c + s * r, c + s * r], start, start + 250, fill=230 - i * 30, width=w)
    bolt = [(c + s * 0.06, s * 0.10), (c - s * 0.12, s * 0.52), (c + s * 0.02, s * 0.50), (c - s * 0.08, s * 0.90),
            (c + s * 0.16, s * 0.42), (c + s * 0.02, s * 0.44), (c + s * 0.14, s * 0.10)]
    d.polygon(bolt, fill=255)
    return _finish(img, size)


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
