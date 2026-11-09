"""Draw the addon's icon variants (round gold-rimmed badge) and save them for the game.

Usage:  python tools/make_icon.py          (needs Pillow)
Writes Media/icon_<variant>.tga (SIZE x SIZE, 32-bit, what WoW loads) and preview PNGs (256x256)
into Media/preview/. Media/icon.tga is the chosen variant (CHOSEN below).
"""
import math
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

ROOT = Path(__file__).resolve().parent.parent
MEDIA = ROOT / "Media"
CHOSEN = "tome"
SIZE = 40                    # in-game texture size (pixels)
S = 512                      # drawing size; scaled down for smooth edges
C = S / 2

GOLD_DARK, GOLD, GOLD_LIGHT = (122, 84, 30), (214, 168, 74), (255, 228, 150)
SKY_TOP, SKY_BOTTOM = (40, 72, 120), (12, 20, 40)


def lerp(a, b, t):
    return tuple(int(a[i] + (b[i] - a[i]) * t) for i in range(len(a)))


def disc_mask(r):
    m = Image.new("L", (S, S), 0)
    ImageDraw.Draw(m).ellipse((C - r, C - r, C + r, C + r), fill=255)
    return m


def badge():
    """Gold ring and the night-sky disc; returns (image, inner radius)."""
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    outer, inner = S * 0.48, S * 0.40
    # ring: vertical gold gradient, lit from the top
    ring = Image.new("RGBA", (S, S))
    rd = ImageDraw.Draw(ring)
    for y in range(S):
        t = y / S
        col = lerp(GOLD_LIGHT, GOLD, t * 1.6) if t < 0.5 else lerp(GOLD, GOLD_DARK, (t - 0.5) * 2)
        rd.line([(0, y), (S, y)], fill=col + (255,))
    img.paste(ring, (0, 0), disc_mask(outer))
    # thin dark lines either side of the ring
    d = ImageDraw.Draw(img)
    d.ellipse((C - outer, C - outer, C + outer, C + outer), outline=(60, 38, 12, 255), width=6)
    d.ellipse((C - inner - 6, C - inner - 6, C + inner + 6, C + inner + 6), outline=(70, 45, 15, 255), width=8)
    # sky disc: radial-ish vertical gradient
    sky = Image.new("RGBA", (S, S))
    sd = ImageDraw.Draw(sky)
    for y in range(S):
        sd.line([(0, y), (S, y)], fill=lerp(SKY_TOP, SKY_BOTTOM, y / S) + (255,))
    # a few stars
    for x, y, r in ((0.32, 0.30, 5), (0.62, 0.24, 4), (0.70, 0.36, 3), (0.42, 0.20, 3), (0.26, 0.42, 3)):
        sd.ellipse((x * S - r, y * S - r, x * S + r, y * S + r), fill=(235, 240, 255, 255))
    img.paste(sky, (0, 0), disc_mask(inner))
    return img, inner


def art_layer():
    return Image.new("RGBA", (S, S), (0, 0, 0, 0))


def mountain(layer, base_y=0.80, scale=1.0, flag=True, trail=True):
    d = ImageDraw.Draw(layer)
    def P(x, y):
        return (C + (x - 0.5) * S * scale, base_y * S + (y - base_y) * S * scale)
    # back peak
    d.polygon([P(0.48, base_y), P(0.70, 0.40), P(0.95, base_y)], fill=(44, 58, 86, 255))
    d.polygon([P(0.66, 0.46), P(0.70, 0.40), P(0.75, 0.47), P(0.71, 0.45)], fill=(205, 220, 240, 255))
    # main peak: shaded right face, lit left face
    top = P(0.42, 0.26)
    d.polygon([P(0.05, base_y), top, P(0.42, base_y)], fill=(92, 112, 146, 255))
    d.polygon([top, P(0.80, base_y), P(0.42, base_y)], fill=(58, 74, 106, 255))
    # snow cap
    d.polygon([top, P(0.33, 0.38), P(0.38, 0.35), P(0.42, 0.40), P(0.46, 0.35), P(0.52, 0.39)],
              fill=(240, 246, 255, 255))
    if trail:
        # dotted gold trail winding up to the summit: the guide's route
        pts = [P(0.24, 0.79), P(0.40, 0.72), P(0.28, 0.62), P(0.44, 0.54), P(0.36, 0.45), P(0.42, 0.30)]
        dots = []
        for (x1, y1), (x2, y2) in zip(pts, pts[1:]):
            n = max(2, int(math.hypot(x2 - x1, y2 - y1) / (S * 0.045)))
            dots += [(x1 + (x2 - x1) * i / n, y1 + (y2 - y1) * i / n) for i in range(n)]
        for i, (x, y) in enumerate(dots):
            r = S * 0.012 * scale * (1.25 if i == 0 else 1)
            d.ellipse((x - r, y - r, x + r, y + r), fill=GOLD_LIGHT + (255,))
    if flag:
        fx, fy = top
        d.line([(fx, fy), (fx, fy - S * 0.13 * scale)], fill=(60, 40, 20, 255), width=int(7 * scale))
        d.polygon([(fx + 3, fy - S * 0.13 * scale), (fx + S * 0.10 * scale, fy - S * 0.105 * scale),
                   (fx + 3, fy - S * 0.08 * scale)], fill=(200, 40, 40, 255))
    # ground
    d.rectangle((0, base_y * S, S, S), fill=(18, 26, 40, 255))


def tome(layer, cx=0.5, cy=0.60, w=0.62, star=True):
    d = ImageDraw.Draw(layer)
    x0, x1 = (cx - w / 2) * S, (cx + w / 2) * S
    y = cy * S
    h = w * 0.42 * S
    # cover (dark leather) peeking under the pages
    d.polygon([(x0 - 10, y - h * 0.40), (C, y - h * 0.25), (x1 + 10, y - h * 0.40),
               (x1 + 10, y + h * 0.58), (C, y + h * 0.72), (x0 - 10, y + h * 0.58)], fill=(110, 40, 30, 255))
    # two pages, curving up at the outer edges
    for side in (-1, 1):
        edge = x0 if side < 0 else x1
        d.polygon([(C, y - h * 0.20), (edge, y - h * 0.50), (edge, y + h * 0.46), (C, y + h * 0.60)],
                  fill=(244, 232, 200, 255))
        # text lines
        for i in range(4):
            ly = y - h * 0.22 + i * h * 0.17
            a, b = (C + side * w * S * 0.08), (edge - side * w * S * 0.06)
            d.line([(a, ly + h * 0.06 * i * 0.15), (b, ly - h * 0.05)], fill=(170, 150, 120, 255), width=6)
    d.line([(C, y - h * 0.22), (C, y + h * 0.62)], fill=GOLD_DARK + (255,), width=8)  # spine
    if star:
        sx, sy, r = C, (cy - w * 0.48) * S, S * 0.09
        pts = []
        for i in range(8):
            ang = -math.pi / 2 + i * math.pi / 4
            rr = r if i % 2 == 0 else r * 0.32
            pts.append((sx + math.cos(ang) * rr, sy + math.sin(ang) * rr))
        d.polygon(pts, fill=GOLD_LIGHT + (255,))


def compose(variant):
    img, inner = badge()
    art = art_layer()
    if variant == "mountain":
        mountain(art)
    elif variant == "tome":
        tome(art)
    elif variant == "both":
        mountain(art, base_y=0.72, flag=True, trail=False)
        tome(art, cx=0.5, cy=0.70, w=0.46, star=False)
    shadow = art.filter(ImageFilter.GaussianBlur(4))
    img.paste(Image.new("RGBA", (S, S), (0, 0, 0, 120)), (0, 0),
              Image.composite(shadow.split()[3], Image.new("L", (S, S), 0), disc_mask(inner - 2)))
    img.paste(art, (0, 0), Image.composite(art.split()[3], Image.new("L", (S, S), 0), disc_mask(inner - 2)))
    # glossy highlight on the upper ring
    gloss = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    ImageDraw.Draw(gloss).arc((S * 0.05, S * 0.05, S * 0.95, S * 0.95), 200, 340, fill=(255, 255, 230, 110), width=10)
    img.alpha_composite(gloss)
    return img


def main():
    (MEDIA / "preview").mkdir(parents=True, exist_ok=True)
    for variant in ("mountain", "tome", "both"):
        img = compose(variant)
        img.resize((SIZE, SIZE), Image.LANCZOS).save(MEDIA / f"icon_{variant}.tga")
        img.resize((256, 256), Image.LANCZOS).save(MEDIA / "preview" / f"icon_{variant}.png")
        # how it reads at minimap size
        img.resize((24, 24), Image.LANCZOS).resize((96, 96), Image.NEAREST).save(MEDIA / "preview" / f"icon_{variant}_small.png")
    compose(CHOSEN).resize((SIZE, SIZE), Image.LANCZOS).save(MEDIA / "icon.tga")
    print(f"icons -> {MEDIA.relative_to(ROOT)} (chosen: {CHOSEN})")


if __name__ == "__main__":
    main()
