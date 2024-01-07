class Monster {
  PVector _position;
  int _borderUp, _borderDown, _borderLeft, _borderRight;
  PVector _moveDirection;
  int _speed;
  int _cellX, _cellY;
  PImage _sprites;
  PImage _monsterSprite;
  float _verticalOffset;
  Board _board;
  PVector[] directions = 
  {
    new PVector(1, 0),
    new PVector(0, 1),
    new PVector(-1, 0),
    new PVector(0, -1)
  };
  

  Monster(PVector position, int cellX, int cellY, Board board) {
    _position = position;
    _borderUp = int(_position.y - board._cellSize / 2);
    _borderDown = int(_position.y + board._cellSize / 2);
    _borderLeft = int(_position.x - board._cellSize / 2);
    _borderRight = int(_position.x + board._cellSize / 2);
    _moveDirection = new PVector(0, 0);
    _speed = 2;
    _cellX = cellX;
    _cellY = cellY;
    _verticalOffset = board._cellSize / 4;
    _sprites = loadImage("data/img/characters.png"); 
    _monsterSprite = _sprites.get(0, 72, 16, 24);
    _board = board;
  } 


  //method to avoid walls
  boolean collision(PVector position) {
    float adjustedX = position.x + _board._cellSize / 2 * _moveDirection.x;
    float adjustedY = position.y + _board._cellSize / 2 * _moveDirection.y;
    int cellX = int(adjustedX / _board._cellSize);
    int cellY = int(adjustedY / _board._cellSize);

    return _board._cells[cellY][cellX] == TypeCell.WALL 
    || _board._cells[cellY][cellX] == TypeCell.DESTRUCTIBLE_WALL 
    || _board._cells[cellY][cellX] == TypeCell.EXIT_DOOR 
    || _board.isBombInTargetCell(cellX, cellY);

  }


  void update() {
    if (_moveDirection.x == 0 && _moveDirection.y == 0) {
       _moveDirection = directions[int(random(4))];  
    }
    
    PVector nextPosition = new PVector(_position.x + _moveDirection.x * _speed, _position.y + _moveDirection.y * _speed);  
    
    if (collision(nextPosition)) {
      _moveDirection = directions[int(random(4))];
    }
    else {
      _position = nextPosition;
      
      _cellX = int(_position.x / board._cellSize);
      _cellY = int(_position.y / board._cellSize);
      
      _borderUp = int(_position.y - board._cellSize / 2);
      _borderDown = int(_position.y + board._cellSize / 2);
      _borderLeft = int(_position.x - board._cellSize / 2);
      _borderRight = int(_position.x + board._cellSize / 2);
    }
  }


  void drawIt() {
    imageMode(CENTER);
    image(_monsterSprite, _position.x, _position.y - _verticalOffset, board._cellSize, board._cellSize * 1.5);
    imageMode(CORNER);
  }
}
