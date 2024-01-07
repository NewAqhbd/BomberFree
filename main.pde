Game game;
Hero hero;
Monster[] _monsters;
Board board;
Content boardContent;
Bomb bomb;
boolean game1 = true;
PVector coordBoard;
PVector sizeBoard = new PVector(900, 800);
PVector initHeroPosition;
int initHeroPositionX;
int initHeroPositionY;
PVector[] initMonstersPosition = new PVector[0];
PImage[] arrayTileSprites;
PImage[] arrayCharSprites;

void setup() {
  size(1200, 900);
  coordBoard = new PVector(0, 0);
  frameRate(60);
}

void draw() {
  //Initialize game
  if (game1) {
    game1 = false;
    boardContent = new Content("levels/level1.txt", "data/img/tiles.png", "data/img/characters.png", 16, 16, 16, 24);
    board = new Board(boardContent, coordBoard, sizeBoard, boardContent._nbCellsX, boardContent._nbCellsY);
    hero = new Hero(initHeroPosition);
    bomb = new Bomb(board);
    game = new Game(board, hero, bomb);
  }
  
  if (hero._life == 0)
    exit();


  if (hero._up) {//MoveUp
    hero.move(board, new PVector(0, -1));
  } else if (hero._down) { //MoveDown
    hero.move(board, new PVector(0, 1));
  } else if (hero._right) { //MoveRight
    hero.move(board, new PVector(1, 0));
  } else if (hero._left) { //MoveLeft
    hero.move(board, new PVector(-1, 0));
  }

  game.update();
  game.drawIt();

}

void keyPressed() {
  game.handleKey(key);
  if (key == 'z' || key == 'Z')
    hero._up = true;
  if (key == 's' || key == 'S')
    hero._down = true;
  if (key == 'q' || key == 'Q')
    hero._left = true;
  if (key == 'd' || key == 'D')
    hero._right = true; 
}

void keyReleased() {
  //hero._isMovePossible = false;
  if (key == 'z' || key == 'Z')
    hero._up = false;
  if (key == 's' || key == 'S')
    hero._down = false;
  if (key == 'q' || key == 'Q')
    hero._left = false;
  if (key == 'd' || key == 'D')
    hero._right = false;
}


void mousePressed() {
}
