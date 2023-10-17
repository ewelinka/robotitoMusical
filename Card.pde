class Card {

  int xpos;
  int ypos;
  int cSize;
  int id;
  boolean isConditional; // color or conditional?
  boolean isSelected;

  Card(int x, int y, int mySize) {
    xpos = x;
    ypos = y;
    cSize = mySize;
    isSelected = false;
    id = millis();
  }

  Card(int x, int y, int mySize, int fixedId) {
    this(x, y, mySize);
    id = fixedId;
  }

  void updatePosition(int x, int y) {
    xpos = x;
    ypos = y;
    //checkCardPosition();//too many cards, does not work well
  }

  void addToBackground() {
  }

  boolean isPointInside(int x, int y) {
    return x >= xpos-cSize/2 && x <= xpos+cSize/2 && y >= ypos-cSize/2 && y <= ypos+cSize/2;
  }
  void setIsSelected(boolean is) {
    isSelected = is;
  }
  void checkCardPosition() {
    if ((ypos+cSize/2) > height) { // over bottom line
      ypos = height-cSize/2-1;
    } else if ((ypos-cSize/2) < 0) { //above top line
      ypos = cSize/2+1;
    }
    if ((xpos+cSize/2) > maxPixelMat) { // over bottom line
      xpos = maxPixelMat - cSize/2 - 1;
    } else if ((xpos-cSize/2) < 0) { //above top line
      xpos = cSize/2 + 1;
    }
  }
}
