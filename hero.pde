class Hero { //<>//
  // position on screen
  PVector _position;
  int _borderUp, _borderDown, _borderLeft, _borderRight;
  int _speed;
  // position on board
  int _cellX, _cellY, leftCellX, rightCellX, footsCellY, headCellY;
  // display size
  float _size;
  // if hero was hit by a bomb
  boolean _wasHit;
  float _verticalOffset;
  PImage _sprites;
  PImage _heroSprite;
  boolean _up, _down, _left, _right = false;
  
  
  //Bombs
  ArrayList<Bomb> _arrayBombs;
  int _explosionRadius;
  int _nbBombMax;


  Hero() {
    _wasHit = false;
  }
  
  
  
  Hero(PVector position, int cellX, int cellY, float size) {
    _position = position;
    _borderUp = int(_position.y - board._cellSize * 8);
    _borderDown = int(_position.y + board._cellSize * 8);
    _borderLeft = int(_position.x - board._cellSize * 8);
    _borderRight = int(_position.x + board._cellSize * 8);
    _speed = 6;
    _cellX = cellX;
    _cellY = cellY;
    _size = size/16;
    _wasHit = false;
    _verticalOffset = 4 * _size;
    _sprites = loadImage("data/img/characters.png");
    _heroSprite = _sprites.get(16, 0, 16, 24);
    _explosionRadius = 1;
    _nbBombMax = 2;
    _arrayBombs = new ArrayList<Bomb>();
  }
  


  //Changes of PV, Bonus, wasHit, initPosition ...
  void update(Board board) {

  }
  
  
  
  void move(Board board, PVector direction) {
    boolean canMove = false;
    boolean bombInTargetCell = false;

    int nextPosX = int(_position.x + direction.x * _speed);
    int nextPosY = int(_position.y + direction.y * _speed);
    
    int nextBorderUp = int(nextPosY - board._cellSize / 2);
    int nextBorderDown = int(nextPosY + board._cellSize / 2);
    int nextBorderLeft = int(nextPosX - board._cellSize / 2);
    int nextBorderRight = int(nextPosX + board._cellSize / 2);
    
    int nextCellX = _cellX;
    int nextCellY = _cellY;

    
    //Change of cell for bomb (based on center hero)
    if (nextPosX > _cellX * board._cellSize + board._cellSize) {
      nextCellX = _cellX + 1;
    }
    else if (nextPosX < _cellX * board._cellSize) {
      nextCellX = _cellX - 1;
    }
    else if (nextPosY > _cellY * board._cellSize + board._cellSize) {
      nextCellY = _cellY + 1;
    }
    else if (nextPosY < _cellY * board._cellSize) {
      nextCellY = _cellY - 1;
    }
    
    if (
       direction.x == 1 
    && (board._cells[_cellY][nextBorderRight / board._cellSize] == TypeCell.EMPTY || board._cells[_cellY][nextBorderRight / board._cellSize] == TypeCell.EXIT_DOOR)
    && _position.y == board.getCellCenter(_cellX, _cellY).y //Change Right
    
    || direction.x == -1 
    && (board._cells[_cellY][nextBorderLeft / board._cellSize] == TypeCell.EMPTY || board._cells[_cellY][nextBorderLeft / board._cellSize] == TypeCell.EXIT_DOOR) 
    && _position.y == board.getCellCenter(_cellX, _cellY).y //Change Left
    
    || direction.y == 1 
    && (board._cells[nextBorderDown / board._cellSize][_cellX] == TypeCell.EMPTY || board._cells[nextBorderDown / board._cellSize][_cellX] == TypeCell.EXIT_DOOR)
    && _position.x == board.getCellCenter(_cellX, _cellY).x  //Change Down
    
    || direction.y == -1 
    && (board._cells[nextBorderUp / board._cellSize][_cellX] == TypeCell.EMPTY || board._cells[nextBorderUp / board._cellSize][_cellX] == TypeCell.EXIT_DOOR)
    && _position.x == board.getCellCenter(_cellX, _cellY).x   //Change Up
    ) 
    { 
      canMove = true;
    } 
    
    
    //Recenter the hero position if its next position go on a wall because of his too high speed
    else if 
    (
       direction.x == 1 
    && (board._cells[_cellY][nextBorderRight / board._cellSize] != TypeCell.EMPTY || board._cells[_cellY][nextBorderRight / board._cellSize] != TypeCell.EXIT_DOOR)
    && _position.y == board.getCellCenter(_cellX, _cellY).y
    )
      _position.x = int(board.getCellCenter(_cellX, _cellY).x);
      
    else if (
       direction.x == -1 
    && (board._cells[_cellY][nextBorderLeft / board._cellSize] != TypeCell.EMPTY || board._cells[_cellY][nextBorderLeft / board._cellSize] != TypeCell.EXIT_DOOR)
    && _position.y == board.getCellCenter(_cellX, _cellY).y
    )
      _position.x = int(board.getCellCenter(_cellX, _cellY).x);
      
    else if (
       direction.y == 1 
    && (board._cells[nextBorderDown / board._cellSize][_cellX] != TypeCell.EMPTY || board._cells[nextBorderDown / board._cellSize][_cellX] != TypeCell.EXIT_DOOR)
    && _position.x == board.getCellCenter(_cellX, _cellY).x
    )  
      _position.y = int(board.getCellCenter(_cellX, _cellY).y);
      
    else if (
       direction.y == -1 
    && (board._cells[nextBorderUp / board._cellSize][_cellX] != TypeCell.EMPTY || board._cells[nextBorderUp / board._cellSize][_cellX] != TypeCell.EXIT_DOOR)
    && _position.x == board.getCellCenter(_cellX, _cellY).x
    )
      _position.y = int(board.getCellCenter(_cellX, _cellY).y);
   
   
    //Check if a bomb is placed on the cell we want to reach with the hero
    for (int i = 0; i < _arrayBombs.size(); i++) {
      Bomb bomb = _arrayBombs.get(i);
      if (bomb._cellX == nextCellX && bomb._cellY == nextCellY) {
        bombInTargetCell = true;
        break;
      }
    }
    
    
    //Move towards a walkable cell
    if (!bombInTargetCell && canMove ) {
      _cellX = nextCellX;
      _cellY = nextCellY;
      _position.x = nextPosX;
      _position.y = nextPosY;
    } 
    
    
    //Move towards a not walkable cell
    else {

      //Move horizontally
      if (    
         direction.x != 0
      && _position.y != board.getCellCenter(_cellX, _cellY).y
      )
      {
        
        //Above the center of the actual cell
        if (
           board._cells[footsCellY - 1][_cellX + int(direction.x)] == TypeCell.EMPTY 
        || board._cells[footsCellY - 1][_cellX + int(direction.x)] == TypeCell.EXIT_DOOR
        ) 
        {

          if (_position.y - _speed > board.getCellCenter(_cellX, headCellY).y)
            _position.y -= _speed;
          else
            _position.y = board.getCellCenter(_cellX, _cellY).y;
          if (_position.y < _cellY * board._cellSize) {
            _cellY -= 1;
          }
          
        }
        
        
        //Below the center of the actual cell
        else if (
           board._cells[headCellY + 1][_cellX + int(direction.x)] == TypeCell.EMPTY  
        || board._cells[headCellY + 1][_cellX + int(direction.x)] == TypeCell.EXIT_DOOR  
        )
        {

          if (_position.y + _speed < board.getCellCenter(_cellX, footsCellY).y)
            _position.y += _speed;
          else
            _position.y = board.getCellCenter(_cellX, _cellY).y;
          if (_position.y > _cellY * board._cellSize + board._cellSize) {
            _cellY += 1;
          }
        }
      
      }
      
      
      //Move vertically
      else if (
         direction.y != 0
      && _position.x != board.getCellCenter(_cellX, _cellY).x
      ) 
      {
        
        //To the left of the center of the actual cell 
        if (
           board._cells[_cellY + int(direction.y)][rightCellX - 1] == TypeCell.EMPTY
        || board._cells[_cellY + int(direction.y)][rightCellX - 1] == TypeCell.EXIT_DOOR
        ) 
        {
          if (_position.x - _speed > board.getCellCenter(leftCellX, _cellY).x)
            _position.x -= _speed;
          else
            _position.x = board.getCellCenter(_cellX, _cellY).x;
          if (_position.x < _cellX * board._cellSize) {
            _cellX -= 1;
          }
          
        }
        
        
        //To the right of the center of the actual cell
        else if (
           board._cells[_cellY + int(direction.y)][leftCellX + 1] == TypeCell.EMPTY  
        || board._cells[_cellY + int(direction.y)][leftCellX + 1] == TypeCell.EXIT_DOOR  
        )
        {
          if (_position.x + _speed > board.getCellCenter(leftCellX, _cellY).x)
            _position.x += _speed;
          else
            _position.x = board.getCellCenter(_cellX, _cellY).x;
          if (_position.x > _cellX * board._cellSize + board._cellSize) {
            _cellX += 1;
          }
          
        }
      }
    }
    
      _borderUp = int(_position.y - board._cellSize / 2);
      _borderDown = int(_position.y + board._cellSize / 2);
      _borderLeft = int(_position.x - board._cellSize / 2);
      _borderRight = int(_position.x + board._cellSize / 2);
      
      //Cell position of the hero's borders
      headCellY = _borderUp / board._cellSize;
      footsCellY = _borderDown / board._cellSize;
      leftCellX = _borderLeft / board._cellSize;      
      rightCellX = _borderRight / board._cellSize;
  }
  






  void drawIt() {
    imageMode(CENTER);
    image(_heroSprite, _position.x, _position.y - _verticalOffset, 16 * _size, 24 * _size);
    imageMode(CORNER);
  }
}
