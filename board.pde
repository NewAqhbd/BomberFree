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

  Board(PVector drawPosition, PVector drawSize, int nbCellsX, int nbCellsY) {
    _drawPosition = drawPosition;
    _drawSize = drawSize;
    _nbCellsX = nbCellsX;
    _nbCellsY = nbCellsY;
    _cellSize = int(min(drawSize.x, drawSize.y) / max(nbCellsX, nbCellsY));
    
    _cells = new TypeCell[nbCellsY][nbCellsX];
    String[] lines = loadStrings("levels/level1.txt");
    for (int nbLine = 1; nbLine < lines.length; nbLine++) { //Lines //<>//
      for (int nbCell = 0; nbCell < lines[nbLine].length(); nbCell++) { //Characters
        println(lines[nbLine].length());
        switch(lines[nbLine].charAt(nbCell)) {
          case 'x':
            _cells[nbLine-1][nbCell] = TypeCell.WALL;
            println("WALL");
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
            initHeroPosition = new PVector(nbCell * _cellSize + _cellSize/2, nbLine * _cellSize + _cellSize/2);
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
          default:
            _sprite = _sprites.get(48, 96, 16, 16);
            image(_sprite, _drawPosition.x + j*_cellSize, _drawPosition.y + i*_cellSize, _cellSize, _cellSize);
            break;
        }
        
      }
    }
  }
  
  
}
