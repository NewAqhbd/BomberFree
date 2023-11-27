class Hero {
  // position on screen
  PVector _position;
  // position on board
  int _cellX, _cellY;
  // display size
  float _size;
  // if hero was hit by a bomb
  boolean _wasHit;

  Hero() {
    _wasHit = false;
  }
  
  Hero(PVector position, int cellX, int cellY, float size) {
    _position = position;
    _cellX = cellX;
    _cellY = cellY;
    _size = size/16;
  }

  void move(Board board, PVector direction) {
    _cellX += direction.x;
    _cellY += direction.y;
    _position.set(_position.x + direction.x * board._cellSize, _position.y + direction.y * board._cellSize);
    println("X : " + _cellX);
    println("Y : " + _cellY);
  }

  void update(Board board) {
    //Changes of PV, Bonus, wasHit ...
  }

  void drawIt() {
    PImage sprites = loadImage("data/img/characters.png");
    PImage sprite = sprites.get(17, 0, 15, 24);
    float verticalOffset = 4 * _size;
    imageMode(CENTER);
    image(sprite, _position.x, _position.y - verticalOffset, 16 * _size, 24 * _size);
    imageMode(CORNER);
  }
}