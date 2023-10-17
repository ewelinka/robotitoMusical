class ImageCard extends ColorCard {
  PImage img;
  ImageCard(int x, int y, int cSize, color cColor, PImage pic) {
    super(x, y, cSize, cColor);
    img = pic;
  }
  ImageCard(int x, int y, int cSize, color cColor, PImage pic, int fixedId) {
    super(x, y, cSize, cColor, fixedId);
    img = pic;
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
    image(img, xpos, ypos, cardSize, cardSize);
  }
}
