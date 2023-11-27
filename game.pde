class Game
{
  Board _board;
  Hero _hero;

  String _levelName;

  Game() {
    _board = null;
    _hero = null;
  }
  
  Game(Board board, Hero hero) {
    _board = board;
    _hero = hero;
  }
  
  Game(Board board) {
    _board = board;
    _hero = null;
  }

  void update() {
    _hero.update(_board);
  }

  void drawIt() {
    _board.drawIt();
    _hero.drawIt();
  }

  void handleKey(int k) {
    switch (k) {
      case 'z':
        _hero.move(_board, new PVector(0, -1));
        break;
      case 'q':
        _hero.move(_board, new PVector(-1, 0));
        break;
      case 's':
        _hero.move(_board, new PVector(0, 1));
        break;
      case 'd':
        _hero.move(_board, new PVector(1, 0));
        break;
    }
  }
}
