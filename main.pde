Game game;
Hero hero;
boolean game1 = true;
PVector coordBoard;
PVector sizeBoard = new PVector(900, 800);
PVector initHeroPosition;
int initHeroPositionX;
int initHeroPositionY;
PVector[] initMonstersPosition = new PVector[0];
PImage[] arraySprites;
boolean[] isMoveButtonsPressed = {false, false, false, false};
boolean isMoveButtonPressed;
int[] buttons = {'z', 'q', 's', 'd'};

void setup() {
  size(1200, 900, P2D);
  coordBoard = new PVector(0, 0);
  frameRate(60);
}

void draw() {
  
  if(game1) {
    game1 = false;  
    Content boardContent = new Content("levels/level1.txt", "data/img/tiles.png", 16, 16);
    Board board = new Board(boardContent, coordBoard, sizeBoard, boardContent._nbCellsX, boardContent._nbCellsY);
    hero = new Hero(initHeroPosition, initHeroPositionX, initHeroPositionY, board._cellSize);
    Bomb bomb = new Bomb(board);
    game = new Game(board, hero, bomb);
  }
  
  game.update();
  game.drawIt();
}

void keyPressed() {
  //Update list of keys pressed
  switch (key) {
    case 'z':
      isMoveButtonsPressed[0] = true;
      break;
    case 'q':
      isMoveButtonsPressed[1] = true;
      break;
    case 's':
      isMoveButtonsPressed[2] = true;
      break;
    case 'd':
      isMoveButtonsPressed[3] = true;
      break;
    case 'Z':
      isMoveButtonsPressed[0] = true;
      break;
    case 'Q':
      isMoveButtonsPressed[1] = true;
      break;
    case 'S':
      isMoveButtonsPressed[2] = true;
      break;
    case 'D':
      isMoveButtonsPressed[3] = true;
      break;
  }
  
  game.handleKey(key);
}

void keyReleased() {
  //Update list of keys pressed
  switch (key) {
    case 'z':
      isMoveButtonsPressed[0] = false;
      break;
    case 'q':
      isMoveButtonsPressed[1] = false;
      break;
    case 's':
      isMoveButtonsPressed[2] = false;
      break;
    case 'd':
      isMoveButtonsPressed[3] = false;
      break;
    case 'Z':
      isMoveButtonsPressed[0] = false;
      break;
    case 'Q':
      isMoveButtonsPressed[1] = false;
      break;
    case 'S':
      isMoveButtonsPressed[2] = false;
      break;
    case 'D':
      isMoveButtonsPressed[3] = false;
      break;
  }
  
  for (int numButton = 0; numButton < buttons.length; numButton++) {
    if (isMoveButtonsPressed[numButton]) {
      isMoveButtonPressed = true;
      break;
    }
    else {
      isMoveButtonPressed = false;
    }
  }
  
  if (!isMoveButtonPressed)
    hero._moveDirection = new PVector(0,0);
}

void mousePressed() {
}
