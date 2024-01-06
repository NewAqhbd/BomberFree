enum TypeCell
{
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR
}

class Board
{
  TypeCell _cells[][];
  PVector _drawPosition;
  PVector _drawSize;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square
  int _lastUpdateTime = 0;
  int _spriteTime = 1000; 
  boolean _togglSprite = true;
  int _currentTime;
  int _elapsedTime;
  
  Board(Content content, PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    _cellSize = int(min(drawSize.x, drawSize.y) / max(nbCellsX, nbCellsY));  
    println("cellsize : " + _cellSize);
    _cells = content._cells;
    initHeroPosition = getCellCenter(initHeroPositionX, initHeroPositionY);
    createMonsters(content);
  }
  
  void createMonsters(Content content) {
    _monsters = new Monster[content._monstersPositions.length];
    for (int i = 0; i < content._monstersPositions.length; i++) {
      PVector monsterPosition = content._monstersPositions[i];
      int cellX = (int) monsterPosition.x;
      int cellY = (int) monsterPosition.y;
      PVector position = getCellCenter(cellX, cellY);
      //create a new monster instance and associate it with the board instance
      _monsters[i] = new Monster(position, cellX, cellY, this);
    }
  }

  //Get the position on the screen
  PVector getCellCenter(int i, int j) {
    return new PVector(_drawPosition.x + (i * _cellSize + _cellSize/2) , _drawPosition.y + (j * _cellSize + _cellSize/2));
  }
  
  
  boolean isBombInTargetCell(int nextCellX, int nextCellY) {
    //Check if a bomb is placed on the cell we want to reach with the hero
    for (int i = 0; i < hero._arrayBombs.size(); i++) {
      Bomb bomb = hero._arrayBombs.get(i);
      if (bomb._cellX == nextCellX && bomb._cellY == nextCellY) {
        return true;
      }
    } 
    return false; 
  }



  void drawIt() {
    for (int i = 0; i < _cells.length; i++) {
      for (int j = 0; j < _cells[i].length; j++) {
        
        switch (_cells[i][j]) {
          case EMPTY:
            image(arrayTileSprites[63], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case WALL:
            if (j == 0)
              image(arrayTileSprites[51], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (j == _cells[i].length-1)
              image(arrayTileSprites[51], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (i == 0)
              image(arrayTileSprites[43], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (i == _cells.length-1)
              image(arrayTileSprites[43], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else
              image(arrayTileSprites[52], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case DESTRUCTIBLE_WALL:
            image(arrayTileSprites[44], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case EXIT_DOOR:
            if (_togglSprite)
              image(arrayTileSprites[38], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else
              image(arrayTileSprites[39], _drawPosition.x + j * _cellSize, _drawPosition.y + i * _cellSize, _cellSize, _cellSize);
            update();
            break;
          default:
            image(arrayTileSprites[63], _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
        }
        
      }
    }
  } 

  void update() {
    _currentTime = millis();
    _elapsedTime = _currentTime - _lastUpdateTime;
    if (_elapsedTime > _spriteTime) {
      _togglSprite = !_togglSprite;
      _lastUpdateTime = _currentTime;
    }
  }
}
