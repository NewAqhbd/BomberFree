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
        _hero._moveDirection = new PVector(0, -1);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[0] = true;
        break;
      case 'q':
        _hero._moveDirection = new PVector(-1, 0);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[1] = true;
        break;
      case 's':
        _hero._moveDirection = new PVector(0, 1);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[2] = true;
        break;
      case 'd':
        _hero._moveDirection = new PVector(1, 0);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[3] = true;
        break;       
      case 'Z':
        _hero._moveDirection = new PVector(0, -1);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[0] = true;
        break;
      case 'Q':
        _hero._moveDirection = new PVector(-1, 0);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[1] = true;
        break;
      case 'S':
        _hero._moveDirection = new PVector(0, 1);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[2] = true;
        break;
      case 'D':
        _hero._moveDirection = new PVector(1, 0);
        _hero._timeStartMoving = millis();
        _hero._isStartingMoving = true;
        isMoveButtonsPressed[3] = true;
        break;
        
      case 32:
        _bomb.drop(_board, _hero);
    }
  }
}
