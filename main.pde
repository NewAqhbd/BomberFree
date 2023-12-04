Game game;
boolean game1 = true;
PVector coordBoard;
PVector sizeBoard = new PVector(900, 800);
PVector initHeroPosition;
int initHeroPositionX;
int initHeroPositionY;
PVector[] initMonstersPosition = new PVector[0];
PImage[] arraySprites;

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
    Hero hero = new Hero(initHeroPosition, initHeroPositionX, initHeroPositionY, board._cellSize);
    Bomb bomb = new Bomb(board);
    game = new Game(board, hero, bomb);
  }
  
  game.update();
  game.drawIt();
}

void keyPressed() {
  game.handleKey(key);
}

void mousePressed() {
}
