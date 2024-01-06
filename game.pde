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
    for (int k = 0; k < _monsters.length; k++) {
      _monsters[k].update();
    }
  }



  void drawIt() {
    _board.drawIt();
    _bomb.drawIt();
    _hero.drawIt();
    for (int k = 0; k < _monsters.length; k++) {
      _monsters[k].drawIt();  
    }
  }



  void handleKey(int k) {
    switch (k) {        
      case 32:
        bomb.drop(board, hero);
        break;
    }
  }
}
