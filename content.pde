class Content {
  PImage _imageTileSprites;
  PImage _imageCharSprites;
  int _spriteTileSizeX;
  int _spriteTileSizeY;   
  int _spriteCharSizeX;
  int _spriteCharSizeY;   
  String[] lines;
  int _nbCellsX; //Second line chosen arbitrarily because same nbCell for each line.
  int _nbCellsY;
  TypeCell[][] _cells;
  PVector[] _monstersPositions = new PVector[0];


  Content(String levelPath, String tileSpritesPath, String characterSpritesPath, int spriteTileSizeX, int spriteTileSizeY, int spriteCharSizeX, int spriteCharSizeY) {
    _imageTileSprites = loadImage(tileSpritesPath);
    _imageCharSprites = loadImage(characterSpritesPath);
    _spriteTileSizeX = spriteTileSizeX;
    _spriteTileSizeY = spriteTileSizeY;  
    _spriteCharSizeX = spriteCharSizeX;
    _spriteCharSizeY = spriteCharSizeY;  
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
            _monstersPositions = (PVector[]) append(_monstersPositions, new PVector(nbCell, nbLine - 1));
            break;
          default:
            _cells[nbLine-1][nbCell] = TypeCell.EMPTY;
            break;
        }
      }
    }

    arrayTileSprites = new PImage[0];
    for (int y = 0; y < _imageTileSprites.height; y += _spriteTileSizeY) {
      for (int x = 0; x < _imageTileSprites.width; x += _spriteTileSizeX) {
        arrayTileSprites = (PImage[]) append(arrayTileSprites, _imageTileSprites.get(x, y, _spriteTileSizeX, _spriteTileSizeY)); 
      }
    }
    
    
    arrayCharSprites = new PImage[0];
    for (int y = 0; y < _imageCharSprites.height; y += _spriteCharSizeY) {
      for (int x = 0; x < _imageCharSprites.width; x += _spriteCharSizeX) {
        arrayCharSprites = (PImage[]) append(arrayCharSprites, _imageCharSprites.get(x, y, _spriteCharSizeX, _spriteCharSizeY)); 
      }
    }  
  }
}
