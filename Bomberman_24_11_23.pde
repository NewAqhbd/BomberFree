Game game;
boolean game1 = true;
PVector coordBoard;
PVector sizeBoard = new PVector(400, 300);
PVector initHeroPosition = new PVector(75, 125);

void setup() {
  size(800, 800, P2D);
  coordBoard = new PVector(0, 0);
  frameRate(60);
}

void draw() {
  
  if(game1) {
    game1 = false;
    Board board = new Board(coordBoard, sizeBoard, 6, 5);
    Hero hero = new Hero(initHeroPosition, 1, 2, board._cellSize);
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
