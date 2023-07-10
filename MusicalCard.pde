class MusicalCard extends ColorCard {
  MusicalCard(int x, int y, int cSize, color cColor) {
    super(x, y, cSize, cColor);
  }
  MusicalCard(int x, int y, int cSize, color cColor, int fixedId) {
    super(x, y, cSize, cColor, fixedId);
  }

  void addToBackground() {
    back.beginDraw();
    back.fill(cardColor);
    if (isSelected) {
      back.stroke(markerColor);
      back.strokeWeight(strokeThickness);
    } else {
      back.noStroke();
    }
    back.rect(xpos, ypos, cardSize, cardSize);
    back.image(note, xpos, ypos, cardSize, cardSize);
    back.endDraw();
  }
}
