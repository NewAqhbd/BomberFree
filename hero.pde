class Hero {
  // position on screen
  PVector _position;
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;
  // if hero was hit by a bomb
  boolean _wasHit;
  float _verticalOffset;
  PImage _sprites;
  PImage _heroSprite;


  Hero() {
    _wasHit = false;
  }
  
  
  
  Hero(PVector position, int cellX, int cellY, float size) {
    _position = position;
    _cellX = cellX;
    _cellY = cellY;
    _size = size/16;
    _wasHit = false;
    _verticalOffset = 4 * _size;
    _sprites = loadImage("data/img/characters.png");
    _heroSprite = _sprites.get(16, 0, 16, 24);
  }



  void move(Board board, PVector direction) {
    if (
          board._cells[int(_cellY + direction.y)][int(_cellX + direction.x)] == TypeCell.EMPTY
       || board._cells[int(_cellY + direction.y)][int(_cellX + direction.x)] == TypeCell.EXIT_DOOR     
       ) {
      _cellX += direction.x;
      _cellY += direction.y;
      _position = board.getCellCenter(_cellX, _cellY);
    }
  }
  


  //Changes of PV, Bonus, wasHit, initPosition ...
  void update(Board board) {
    
  }



  void drawIt() {
    imageMode(CENTER);
    image(_heroSprite, _position.x, _position.y - _verticalOffset, 16 * _size, 24 * _size);
    imageMode(CORNER);
  }
}
