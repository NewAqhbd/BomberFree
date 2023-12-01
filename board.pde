enum TypeCell
{
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR
}

class Board
{
  TypeCell _cells[][];
  PImage[] _arraySprites;
  PVector _drawPosition;
  PVector _drawSize;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square
  int _spriteSizeX;
  int _spriteSizeY;

  
  PImage empty;
  

  Board(Content content, PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX; //<>//
    _nbCellsY = nbCellsY;
    _cellSize = int(min(drawSize.x, drawSize.y) / max(nbCellsX, nbCellsY));  
    _cells = content._cells;
    initHeroPosition = getCellCenter(initHeroPositionX, initHeroPositionY);
    _arraySprites = content._arraySprites;
  } //<>//
  


  //Get the position on the screen
  PVector getCellCenter(int i, int j) {
    return new PVector(_drawPosition.x + (i * _cellSize + _cellSize/2) , _drawPosition.y + (j * _cellSize + _cellSize/2));
  }
  
  

  void drawIt() { //<>//
    for (int i = 0; i < _cells.length; i++) {
      for (int j = 0; j < _cells[i].length; j++) {
        
        switch (_cells[i][j]) {
          case EMPTY:
            image(_arraySprites[63], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case WALL:
            if (j == 0)
              image(_arraySprites[51], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (j == _cells[i].length-1)
              image(_arraySprites[51], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (i == 0)
              image(_arraySprites[43], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (i == _cells.length-1)
              image(_arraySprites[43], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else
              image(_arraySprites[52], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case DESTRUCTIBLE_WALL:
            image(_arraySprites[44], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case EXIT_DOOR:
            image(_arraySprites[39], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          default:
            image(_arraySprites[63], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
        }
        
      }
    }
  } 
}
