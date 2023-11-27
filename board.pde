enum TypeCell
{
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR
}

class Board
{
  TypeCell _cells[][] = {
                          {TypeCell.WALL,TypeCell.WALL,TypeCell.WALL,TypeCell.WALL,TypeCell.WALL,TypeCell.WALL},
                          {TypeCell.WALL,TypeCell.DESTRUCTIBLE_WALL,TypeCell.EMPTY,TypeCell.EMPTY,TypeCell.EMPTY, TypeCell.WALL},
                          {TypeCell.EMPTY,TypeCell.EMPTY,TypeCell.DESTRUCTIBLE_WALL,TypeCell.EXIT_DOOR,TypeCell.EMPTY, TypeCell.WALL},
                          {TypeCell.DESTRUCTIBLE_WALL,TypeCell.DESTRUCTIBLE_WALL,TypeCell.DESTRUCTIBLE_WALL,TypeCell.EMPTY,TypeCell.EMPTY, TypeCell.WALL},
                          {TypeCell.WALL,TypeCell.WALL,TypeCell.WALL,TypeCell.WALL,TypeCell.WALL,TypeCell.WALL},
                        };
  PImage _sprite;      
  PImage _sprites;
  PVector _drawPosition;
  PVector _drawSize;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square

  Board(PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    _cellSize = int(min(drawSize.x, drawSize.y) / max(nbCellsX, nbCellsY));
  }

  //Get the position on the screen
  PVector getCellCenter(int i, int j) {
    return new PVector(i * _cellSize + _cellSize/2, j * _cellSize + _cellSize/2);
  }

  void drawIt() {
    _sprites = loadImage("data/img/tiles.png");
    for (int i = 0; i < _cells.length; i++) {
      for (int j = 0; j < _cells[i].length; j++) {
        
        switch (_cells[i][j]) {
          case EMPTY:
            _sprite = _sprites.get(48, 96, 16, 16);
            image(_sprite, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case WALL:
            _sprite = _sprites.get(16, 80, 16, 16);
            image(_sprite, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case DESTRUCTIBLE_WALL:
            _sprite = _sprites.get(32, 80, 16, 16);
            image(_sprite, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case EXIT_DOOR:
            _sprite = _sprites.get(144, 48, 16, 16);
            image(_sprite, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
        }
        
      }
    }
  }
  
  
}
