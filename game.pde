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
        hero.move(board, new PVector(0, -1));
        break;
      case 'q':
        hero.move(board, new PVector(-1, 0));
        break;
      case 's':
        hero.move(board, new PVector(0, 1));
        break;
      case 'd':
        hero.move(board, new PVector(1, 0));
        break;       
      case 'Z':
        hero.move(board, new PVector(0, -1));
        break;
      case 'Q':
        hero.move(board, new PVector(-1, 0));
        break;
      case 'S':
        hero.move(board, new PVector(0, 1));
        break;
      case 'D':
        hero.move(board, new PVector(1, 0));
        break;
        
      case 32:
        bomb.drop(board, hero);
        break;
    }
  }
}
