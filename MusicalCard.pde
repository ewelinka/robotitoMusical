class MusicalCard extends ColorCard {
  MusicalCard(int x, int y, int cSize, color cColor) {
    super(x, y, cSize, cColor);
  }
  MusicalCard(int x, int y, int cSize, color cColor, int fixedId) {
    super(x, y, cSize, cColor, fixedId);
  }

  void addToBackground() {
    fill(cardColor);
    if (isSelected) {
      stroke(markerColor);
      strokeWeight(strokeThickness);
    } else {
      noStroke();
    }
    rect(xpos, ypos, cardSize, cardSize);
    image(note, xpos, ypos, cardSize, cardSize);
  }
}
