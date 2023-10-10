class Robotito { //<>//
  int ypos, xpos, speed, size, directionX, directionY, ledSize, activeDirection, arrowSize, arrowShift;
  color colorRobotito, lastColor;
  float ledDistance;
  boolean isSelected;
  Robotito (int x, int y) {
    xpos = x;
    ypos = y;
    speed = 1;
    size = 100;
    ledSize= 5;
    arrowSize = 14;
    arrowShift = 9;
    ledDistance = size*0.52/2-ledSize/2;
    directionX = directionY = activeDirection = 0;
    colorRobotito = #FCB603;
    lastColor = white;
    isSelected = false;
  }
  void update() {
    xpos += speed*directionX;
    ypos += speed*directionY;
    if ((ypos > height) || (ypos < 0)) {
      directionY = 0;
    }
    if ((xpos > width) || (xpos < 0)) {
      directionX = 0;
    }
    // calculate offset necesary to change direction in the middle of the card depending direction
    int offsetX = directionX*offsetSensing*-1;
    int offsetY = directionY*offsetSensing*-1;

    for (ColorCard currentCard : allCards) {
      if (currentCard.isPointInside(xpos+offsetX, ypos+offsetY)) {
        if (currentCard.id != ignoredId && !isSelected) {
          processColorAndId(currentCard.cardColor, currentCard.id);
        }
      }
    }
  }
  void drawRobotitoAndLights() {
    drawRobotito();
    //circle(xpos+offsetX, ypos+offsetY, 10); // debugging sensing position
    pushMatrix();
    translate(xpos, ypos);
    //draw4lights();
    drawArrows();
    drawDirectionLights();
    if (musicalMode) {
      drawMusicalModeLights();
    }
    popMatrix();
  }

  void updatePositionDragged(int x, int y) {
    directionX = 0;
    directionY = 0;
    activeDirection = 0;
    xpos = x;
    ypos = y;
    ignoredId = -1;
  }
  void drawRobotito() {
    fill(colorRobotito);
    stroke(strokeColor);
    strokeWeight(1);
    circle(xpos, ypos, size);
    fill(255);
    noStroke();
    circle(xpos, ypos, size*0.62);
    fill(200);
    circle(xpos, ypos, size*0.52);
    fill(255);
    circle(xpos, ypos, size*0.42);
  }
  void draw4lights() {
    // 4 lights
    // green light
    pushMatrix();
    translate(0, -ledDistance);
    fill(green);
    stroke(strokeColor);
    circle(0, 0, ledSize);
    popMatrix();
    // red light
    pushMatrix();
    rotate(radians(180));
    translate(0, -ledDistance);
    fill(red);
    circle(0, 0, ledSize);
    popMatrix();
    //yellow
    pushMatrix();
    rotate(radians(270));
    translate(0, -ledDistance);
    fill(yellow);
    circle(0, 0, ledSize);
    popMatrix();
    //blue
    pushMatrix();
    rotate(radians(90));
    translate(0, -ledDistance);
    fill(blue);
    circle(0, 0, ledSize);
    popMatrix();
  }

  void drawArrows() {
    pushMatrix();
    translate(0, -ledDistance - arrowShift);
    fill(green);
    drawArrow(arrowSize);
    popMatrix();
    // red light
    pushMatrix();
    rotate(radians(180));
    translate(0, -ledDistance - arrowShift);
    fill(red);
    drawArrow(arrowSize);
    popMatrix();
    //yellow
    pushMatrix();
    rotate(radians(270));
    translate(0, -ledDistance - arrowShift);
    fill(yellow);
    drawArrow(arrowSize);
    popMatrix();
    //blue
    pushMatrix();
    rotate(radians(90));
    translate(0, -ledDistance - arrowShift);
    fill(blue);
    drawArrow(arrowSize);
    popMatrix();
  }
  void drawArrow(int aSize) {
    int triangleSize = 8;
    triangle(0, -aSize, triangleSize/2, -aSize+triangleSize, -triangleSize/2, -aSize+triangleSize);
    // CENTER MODE!!
    rect(0, 0-(aSize-triangleSize)/2, triangleSize/2, (aSize-triangleSize));
  }


  void drawDirectionLights() {
    switch(activeDirection) {
    case 1: // green
      drawArc(0, green);
      break;
    case 2: // blue
      drawArc(90, blue);
      break;
    case 3: // red
      drawArc(180, red);
      break;
    case 4: // yellow
      drawArc(270, yellow);
      break;
    }
  }

  void drawArc(int rotation, color ledArcColor) {
    pushMatrix();
    rotate(radians(rotation));
    translate(0, -ledDistance);
    fill(ledArcColor);
    stroke(strokeColor);
    circle(0, 0, ledSize);
    popMatrix();
    pushMatrix();
    rotate(radians(rotation) + radians(360/24));
    translate(0, -ledDistance);
    fill(ledArcColor);
    stroke(strokeColor);
    circle(0, 0, ledSize);
    popMatrix();
    pushMatrix();
    rotate(radians(rotation)+radians(360/24)*2);
    translate(0, -ledDistance);
    fill(ledArcColor);
    circle(0, 0, ledSize);
    popMatrix();
    // left
    pushMatrix();
    rotate(radians(rotation)-radians(360/24));
    translate(0, -ledDistance);
    fill(ledArcColor);
    circle(0, 0, ledSize);
    popMatrix();
    pushMatrix();
    rotate(radians(rotation)-radians(360/24)*2);
    translate(0, -ledDistance);
    fill(ledArcColor);
    circle(0, 0, ledSize);
    popMatrix();
    if (musicalMode) {
      pushMatrix();
      rotate(radians(rotation)+radians(360/24)*3);
      translate(0, -ledDistance);
      fill(noteColor);
      circle(0, 0, ledSize);
      popMatrix();
      pushMatrix();
      rotate(radians(rotation)-radians(360/24)*3);
      translate(0, -ledDistance);
      fill(noteColor);
      circle(0, 0, ledSize);
      popMatrix();
    }
  }
  void drawMusicalModeLights() {
    if (activeDirection == 0) {
      stroke(strokeColor);
      for (int i = 0; i<24; i++) {
        pushMatrix();
        rotate(radians(360/24)*i);
        translate(0, -ledDistance);
        fill(noteColor);
        circle(0, 0, ledSize);
        popMatrix();
      }
    } else {
      switch(activeDirection) {
      case 1: // green
        drawMusicalIndicators(0);
        break;
      case 2: // blue
        drawMusicalIndicators(90);
        break;
      case 3: // red
        drawMusicalIndicators(180);
        break;
      case 4: // yellow
        drawMusicalIndicators(270);
        break;
      }
    }
  }

  void drawMusicalIndicators(int rotation) {
    pushMatrix();
    rotate(radians(rotation)+ radians(360/24)*3);
    translate(0, -ledDistance);
    fill(noteColor);
    circle(0, 0, ledSize);
    popMatrix();
    pushMatrix();
    rotate(radians(rotation)+ radians(360/24)*-3);
    translate(0, -ledDistance);
    fill(noteColor);
    circle(0, 0, ledSize);
    popMatrix();
  }

  void processColorAndId(color currentColor, int id) {
    if (currentColor == green || currentColor == yellow || currentColor == red || currentColor == blue || currentColor == noteColor) {
      if (currentColor == noteColor) {
        musicalMode = !musicalMode;
        if (musicalMode) {
          out.playNote(0, 0.1, 200);
          out.playNote(0.1, 0.1, 300);
          out.playNote(0.2, 0.1, 500);
          out.playNote(0.3, 0.1, 800);
        } else {
          out.playNote(0, 0.1, 800);
          out.playNote(0.1, 0.1, 500);
          out.playNote(0.2, 0.1, 300);
          out.playNote(0.3, 0.1, 200);
        }
      } else {
        if (musicalMode) {
          playNoteFromColor(currentColor);
        }
        if (currentColor == green) {
          directionY = -1;
          directionX = 0;
          activeDirection = 1;
        } else if (currentColor == blue) {
          directionY = 0;
          directionX = 1;
          activeDirection = 2;
        } else if (currentColor == red) {
          directionY = 1;
          directionX = 0;
          activeDirection = 3;
        } else if (currentColor == yellow) {
          directionY = 0;
          directionX = -1;
          activeDirection = 4;
        }
      }
      ignoredId = id;
    }
  }

  void playNoteFromColor(int colorNow) {
    switch(colorNow) {
    case -16588774: // green
      //out.playNote(0, 0.5, 300);
      out.playNote(0, 0.15, "E4");
      out.playNote(0.2, 0.15, "D4");
      out.playNote(0.4, 0.15, "C4");
      out.playNote(0.6, 0.15, "D4");
      break;
      //case -1:
      //  toReturn = "white";
      //  break;
    case -331743: // yellow
      out.playNote(0, 0.15, "E4");
      out.playNote(0.2, 0.15, "G4");
      out.playNote(0.4, 0.3, "G4");
      break;
    case -389333: // red
      out.playNote(0, 0.15, "D4");
      out.playNote(0.2, 0.15, "D4");
      out.playNote(0.4, 0.3, "D4");

      break;
    case -14584326: // blue
      out.playNote(0, 0.15, "E4");
      out.playNote(0.2, 0.15, "E4");
      out.playNote(0.4, 0.3, "E4");
      break;
      //case -16777216:
      //  toReturn = "marker";
      //  break;
    }
  }
  void setIsSelected(boolean is) {
    isSelected = is;
  }
}
