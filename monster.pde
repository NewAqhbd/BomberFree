class Monster {
  PVector _position;
  PVector _moveDirection;
  int _cellX, _cellY;
  float _size;
  PImage _sprites;
  PImage _monsterSprite;
  float _verticalOffset;
  Board _board;

  Monster(PVector position, int cellX, int cellY, float size, Board board) {
    _position = position;
    _moveDirection = new PVector(0, 0);
    _cellX = cellX;
    _cellY = cellY;
    _size = size / 16;
    _verticalOffset = 4 * _size;
    _sprites = loadImage("data/img/characters.png"); 
    _monsterSprite = _sprites.get(0, 72, 16, 24);
    _board = board;
  } 


  void move() {
    if (_moveDirection.x == 0 && _moveDirection.y == 0) {
      _moveDirection = new PVector(1, 0);
    }
    PVector nextPosition = PVector.add(_position, _moveDirection);

    if (collision(nextPosition)) {
      ArrayList<PVector> directions = new ArrayList<PVector>();
      directions.add(new PVector(1, 0));
      directions.add(new PVector(0, 1));
      directions.add(new PVector(-1, 0));
      directions.add(new PVector(0, -1));
      if (directions.size() > 0) {
        int randomIndex = int(random(directions.size()));
        _moveDirection = directions.get(randomIndex);
      }
    }
    update();
  }

//method to avoid walls
  boolean collision(PVector position) {
    float adjustedX = position.x + _board._cellSize / 2 * _moveDirection.x;
    float adjustedY = position.y + _board._cellSize / 2 * _moveDirection.y;
    int cellX = int(adjustedX / _board._cellSize);
    int cellY = int(adjustedY / _board._cellSize);

    if (cellX >= 0 && cellX < _board._nbCellsX && cellY >= 0 && cellY < _board._nbCellsY) {
      return _board._cells[cellY][cellX] == TypeCell.WALL || 
      _board._cells[cellY][cellX] == TypeCell.DESTRUCTIBLE_WALL ||
      _board._cells[cellY][cellX] == TypeCell.EXIT_DOOR ;
    }
    return false;
  }


  void update() {
    _position.add(_moveDirection);
  }


  void drawIt() {
    imageMode(CENTER);
    image(_monsterSprite, _position.x, _position.y - _verticalOffset, 16 * _size, 24 * _size);
    imageMode(CORNER);
  }
}
