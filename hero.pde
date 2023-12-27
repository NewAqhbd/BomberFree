class Hero {
  // position on screen
  PVector _position;
  PVector _moveDirection;
  float _timeStartMoving;
  boolean _isStartingMoving;
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;
  // if hero was hit by a bomb
  boolean _wasHit;
  float _verticalOffset;
  PImage _sprites;
  PImage _heroSprite;
  
  
  //Bombs
  ArrayList<Bomb> _arrayBombs;
  int _explosionRadius;
  int _nbBombMax;


  Hero() {
    _wasHit = false;
  }
  
  
  
  Hero(PVector position, int cellX, int cellY, float size) {
    _position = position;
    _moveDirection = new PVector(0,0);
    _cellX = cellX;
    _cellY = cellY;
    _size = size/16;
    _wasHit = false;
    _verticalOffset = 4 * _size;
    _sprites = loadImage("data/img/characters.png");
    _heroSprite = _sprites.get(16, 0, 16, 24);
    _explosionRadius = 1;
    _nbBombMax = 1;
    _arrayBombs = new ArrayList<Bomb>();
  }
  


  //Changes of PV, Bonus, wasHit, initPosition ...
  void update(Board board) {
    if (millis() - _timeStartMoving > 200 || _isStartingMoving) {
    int nextDirectionX = int(_cellX + _moveDirection.x);
    int nextDirectionY = int(_cellY + _moveDirection.y);
    boolean bombInTargetCell = false;

    for (int i = 0; i < _arrayBombs.size(); i++) {
        Bomb bomb = _arrayBombs.get(i);
        if (bomb._cellX == nextDirectionX && bomb._cellY == nextDirectionY) {
            bombInTargetCell = true;
            break;
        }
    }
    if (!bombInTargetCell &&
          board._cells[nextDirectionY][nextDirectionX] == TypeCell.EMPTY
       || board._cells[nextDirectionY][nextDirectionX] == TypeCell.EXIT_DOOR     
       ) {
      _cellX += _moveDirection.x;
      _cellY += _moveDirection.y;
      _position = board.getCellCenter(_cellX, _cellY);
    }  
      _timeStartMoving = millis();
      _isStartingMoving = false;
    }
  }



  void drawIt() {
    imageMode(CENTER);
    image(_heroSprite, _position.x, _position.y - _verticalOffset, 16 * _size, 24 * _size);
    imageMode(CORNER);
  }
}
