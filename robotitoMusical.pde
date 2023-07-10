import ddf.minim.*; //<>//
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
PImage note;

Robotito robotito;
PGraphics back;
color cardColor, yellow, blue, green, red, white, markerColor, noteColor;
int cardSize;
boolean puttingCards, musicalMode, stopRobot;
int offsetSensing;
int strokeThickness;

Card selectedCard;
int ignoredId;
ArrayList<Card> allCards;

void setup() {
  size(800, 800);
  ellipseMode(CENTER);
  smooth();
  robotito = new Robotito(width/2, height/2);
  back = createGraphics(width, height);
  back.beginDraw();
  back.noStroke();
  back.background(255);
  back.rectMode(CENTER);
  back.imageMode(CENTER);
  back.endDraw();

  yellow = #FAF021;
  blue = #2175FA;
  red = #FA0F2B;
  green = #02E01A;
  white = #FFFFFF;
  markerColor = #000000;
  noteColor = #FFFFA50A;

  cardColor = green;
  cardSize = 100;
  puttingCards = true;
  stopRobot = false;
  offsetSensing = cardSize/2;
  ignoredId = 0;
  strokeThickness = 4;
  allCards = new ArrayList<Card>();
  initWithCards();

  // musical part
  minim = new Minim(this);
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  musicalMode = false;
  note = loadImage("notes.png");
}

void draw() {
  displayCards();
  if (!stopRobot) {
    robotito.update();
  }
  robotito.drawRobotitoAndLights();
}

void mousePressed() {
  // TODO restrict card selection to just one!
  for (Card currentCard : allCards) {
    if (currentCard.isPointInside(mouseX, mouseY)) {
      selectedCard =  currentCard;
      currentCard.setIsSelected(true);
    } else {
      currentCard.setIsSelected(false);
    }
  }
}
void mouseDragged() {
  for (Card currentCard : allCards) {
    if (currentCard.isPointInside(mouseX, mouseY) && currentCard.isSelected) {
      currentCard.updatePosition(mouseX, mouseY);
    }
  }
  //if (robotito.isPointInside(mouseX, mouseY))
  if (dist(robotito.xpos, robotito.ypos, mouseX, mouseY) < robotito.size/2)
  {
    robotito.updatePosition(mouseX, mouseY);
  }
}
void keyPressed() {
  if (key == 'p' || key == 'P') {
    puttingCards = !puttingCards;
  } else if (key == 's' || key == 'S') {
    stopRobot = !stopRobot;
  } else if (key == 'd' || key == 'D') {
    deleteSelectedCard();
  } else if (key == CODED) {
    if (keyCode == DOWN) {
      if (puttingCards) {
        addCard(mouseX, mouseY);
      }
    }
  } else {
    if (key == 'b' || key == 'B') {
      cardColor = blue; // azul
    } else if (key == 'r' || key == 'R') {
      cardColor = red; // rojo
    } else if (key == 'g' || key == 'G') {
      cardColor = green; // verde
    } else if (key == 'y' || key == 'Y') {
      cardColor = yellow; // amarillo
    } else if (key == 'n' || key == 'N'){
      cardColor = noteColor;
    }
  }
}

void addCard(int x, int y) {
  if (cardColor == noteColor) {
    allCards.add(new MusicalCard(x, y, cardSize, cardColor));
  } else {
    allCards.add(new ColorCard(x, y, cardSize, cardColor));
  }
}

void displayCards() {
  back.beginDraw();
  back.background(255);
  back.endDraw();
  for (Card currentCard : allCards) {
    currentCard.addToBackground();
  }
  image(back, 0, 0);
}

void deleteSelectedCard() {
  allCards.remove(selectedCard);
}
void initWithCards() {
  int x = 0 + cardSize/2 + 10;
  int y = height - cardSize/2 -10;
  allCards.add(new ColorCard(x, y, cardSize, green, 1));
  x = x + cardSize + 10;
  allCards.add(new ColorCard(x, y, cardSize, red, 2));
  x = x + cardSize + 10;
  allCards.add(new ColorCard(x, y, cardSize, yellow, 3));
  x = x + cardSize + 10;
  allCards.add(new ColorCard(x, y, cardSize, blue, 4));
  x = x + cardSize + 10;
  allCards.add(new MusicalCard(x, y, cardSize, noteColor, 5));
}
