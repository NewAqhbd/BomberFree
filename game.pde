class Game
{
  Board _board;
  Hero _hero;
  Bomb _bomb;
  String _levelName;


  Game() {
    _board = null;
    _hero = null;
  }
  
  
  
  Game(Board board, Hero hero, Bomb bomb) {
    _board = board;
    _hero = hero;
    _bomb = bomb;
  }



  void update() {
    _hero.update(_board);
    _bomb.update(_board, _hero);
  }



  void drawIt() {
    _board.drawIt();
    _bomb.drawIt();
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
      case 'Z':
        _hero.move(_board, new PVector(0, -1));
        break;
      case 'Q':
        _hero.move(_board, new PVector(-1, 0));
        break;
      case 'S':
        _hero.move(_board, new PVector(0, 1));
        break;
      case 'D':
        _hero.move(_board, new PVector(1, 0));
        break;
        
      case 32:
        _bomb.drop(_board, _hero);
    }
  }
}
