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
    //if (millis() - _timeStartMoving > 200 || _isStartingMoving) {
    //int nextDirectionX = int(_cellX + _moveDirection.x);
    //int nextDirectionY = int(_cellY + _moveDirection.y);
    //if (
    //      board._cells[nextDirectionY][nextDirectionX] == TypeCell.EMPTY
    //   || board._cells[nextDirectionY][nextDirectionX] == TypeCell.EXIT_DOOR     
    //   ) {
    //  _cellX += _moveDirection.x;
    //  _cellY += _moveDirection.y;
    //  _position = board.getCellCenter(_cellX, _cellY);
    //}  
    //  _timeStartMoving = millis();
    //  _isStartingMoving = false;
    //}
  }
  
  
  void move(Board board, PVector direction) {
      if (
          board._cells[int(_cellY + direction.y)][int(_cellX + direction.x)] == TypeCell.EMPTY
       || board._cells[int(_cellY + direction.y)][int(_cellX + direction.x)] == TypeCell.EXIT_DOOR     
       ) 
       {
        _position.x += direction.x * 4;
        _position.y += direction.y * 4;
        println("BorderRight = " + int(_position.x + (_size*8)));
        println("BorderLeft = " + int(_position.x - (_size*8)));
        if(_position.x + (_size*8) > _cellX * board._cellSize) {
          _cellX += 1;
        }
        if(_position.x - (_size*8) < _cellX * board._cellSize) {
          _cellX -= 1;
        }
        if(_position.y + (_size*8) > _cellY * board._cellSize) {
          _cellY += 1;
        }
        if(_position.y - (_size*8) < _cellY * board._cellSize) {
          _cellY -= 1;
        }
      }
    }





  void drawIt() {
    imageMode(CENTER);
    image(_heroSprite, _position.x, _position.y - _verticalOffset, 16 * _size, 24 * _size);
    imageMode(CORNER);
  }
}
