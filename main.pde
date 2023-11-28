Game game;
boolean game1 = true;
PVector coordBoard;
PVector sizeBoard = new PVector(900, 800);
PVector initHeroPosition;
int initHeroPositionX;
int initHeroPositionY;
PVector[] initMonstersPosition = new PVector[0];

void setup() {
  size(900, 900, P2D);
  coordBoard = new PVector(0, 0);
  frameRate(40);
}

void draw() { //<>//
  
  if(game1) {
    game1 = false;
    String[] lines = loadStrings("levels/level1.txt");
    int nbCellsY = lines.length - 1;
    int nbCellsX = lines[1].length(); //Second line chosen arbitrarily beacause same nbCell for each line.
    
    Board board = new Board(coordBoard, sizeBoard, nbCellsX, nbCellsY);
    Hero hero = new Hero(initHeroPosition, initHeroPositionX, initHeroPositionY, board._cellSize);
    game = new Game(board, hero);
  }
  
  game.update();
  game.drawIt();
}

void keyPressed() {
  game.handleKey(key);
}

void mousePressed() {
}
