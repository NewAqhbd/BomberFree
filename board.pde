enum TypeCell
{
  EMPTY, WALL, DESTRUCTIBLE_WALL, EXIT_DOOR
}

class Board
{
  TypeCell _cells[][];
  PImage _sprite;      
  PImage _sprites;
  PVector _drawPosition;
  PVector _drawSize;
  int _nbCellsX;
  int _nbCellsY;
  int _cellSize; // cells should be square
  //Sprites
  PImage _spriteEmpty;
  PImage _spriteWall;
  PImage _spriteBorderWallLeft;
  PImage _spriteBorderWallRight;
  PImage _spriteBorderWallTop;
  PImage _spriteBorderWallBottom;
  PImage _spriteDestructibleWall;
  PImage _spriteExitDoor;
  

  Board(PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX; //<>//
    _nbCellsY = nbCellsY;
    _cellSize = int(min(drawSize.x, drawSize.y) / max(nbCellsX, nbCellsY));  
    _sprites = loadImage("data/img/tiles.png");   
    
    //Initialzing _cells
    _cells = new TypeCell[nbCellsY][nbCellsX];
    String[] lines = loadStrings("levels/level1.txt");
    for (int nbLine = 1; nbLine < lines.length; nbLine++) { //Lines
      for (int nbCell = 0; nbCell < lines[nbLine].length(); nbCell++) { //Characters
        switch(lines[nbLine].charAt(nbCell)) {
          case 'x':
            _cells[nbLine-1][nbCell] = TypeCell.WALL;
            break;
          case 'v':
            _cells[nbLine-1][nbCell] = TypeCell.EMPTY;
            break;
          case 'o':
            _cells[nbLine-1][nbCell] = TypeCell.DESTRUCTIBLE_WALL;
            break;
          case 'S':
            _cells[nbLine-1][nbCell] = TypeCell.EXIT_DOOR;
            break;
          case 'B':
            _cells[nbLine-1][nbCell] = TypeCell.EMPTY;
            initHeroPosition = getCellCenter(nbCell, nbLine-1);
            initHeroPositionX = nbLine-1;
            initHeroPositionY = nbCell;
            break;
          case 'M':
            _cells[nbLine-1][nbCell] = TypeCell.EMPTY;
            initMonstersPosition = (PVector[]) append(initMonstersPosition, new PVector(nbLine - 1, nbCell));
            break;
          default:
            _cells[nbLine-1][nbCell] = TypeCell.EMPTY;
            break;
        }
      }
    }   
    
    //Initializing sprites
    _spriteEmpty = _sprites.get(48, 96, 16, 16);
    _spriteBorderWallLeft = _sprites.get(16, 80, 16, 16);
    _spriteBorderWallRight = _sprites.get(16, 80, 16, 16);
    _spriteBorderWallTop = _sprites.get(48, 64, 16, 16);
    _spriteBorderWallBottom = _sprites.get(48, 64, 16, 16);
    _spriteWall = _sprites.get(32, 80, 16, 16);
    _spriteDestructibleWall = _sprites.get(64, 64, 16, 16);
    _spriteExitDoor = _sprites.get(144, 48, 16, 16);
  }
  


  //Get the position on the screen
  PVector getCellCenter(int i, int j) {
    return new PVector(i * _cellSize + _cellSize/2, j * _cellSize + _cellSize/2);
  }
  
  

  void drawIt() {
    for (int i = 0; i < _cells.length; i++) {
      for (int j = 0; j < _cells[i].length; j++) {        
        switch (_cells[i][j]) {
          case EMPTY:
            image(_spriteEmpty, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case WALL:
            if (j == 0)
              image(_spriteBorderWallLeft, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (j == _cells[i].length-1)
              image(_spriteBorderWallRight, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (i == 0)
              image(_spriteBorderWallTop, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else if (i == _cells.length-1)
              image(_spriteBorderWallBottom, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            else
              image(_spriteWall, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case DESTRUCTIBLE_WALL:
            image(_spriteDestructibleWall, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          case EXIT_DOOR:
            image(_spriteExitDoor, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
          default:
            image(_spriteEmpty, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
        }
      }
    }
  }

  
}
