class Content {
  PImage _imageSprites;
  int _spriteSizeX;
  int _spriteSizeY;   
  String[] lines;
  int _nbCellsX; //Second line chosen arbitrarily because same nbCell for each line.
  int _nbCellsY;
  TypeCell[][] _cells;
  
  Content(String levelPath, String spritesPath, int spriteSizeX, int spriteSizeY) {
    _imageSprites = loadImage(spritesPath);
    _spriteSizeX = spriteSizeX;
    _spriteSizeY = spriteSizeY;   
    String[] lines = loadStrings(levelPath);
    _nbCellsX = lines[1].length(); //Second line chosen arbitrarily beacause same nbCell for each line.
    _nbCellsY = lines.length - 1;
    _cells = new TypeCell[_nbCellsY][_nbCellsX];   
    
     
    for (int nbLine = 1; nbLine <= _nbCellsY; nbLine++) { //Lines
      for (int nbCell = 0; nbCell < _nbCellsX; nbCell++) { //Characters
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

    arraySprites = new PImage[0];
    for (int y = 0; y < _imageSprites.height; y += _spriteSizeY) {
      for (int x = 0; x < _imageSprites.width; x += _spriteSizeX) {
        arraySprites = (PImage[]) append(arraySprites, _imageSprites.get(x, y, _spriteSizeX, _spriteSizeY)); 
      }
    }   
  }
}
