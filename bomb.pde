class Bomb {
  float _timeToExplode;
  float _timeBombPlanted;
  boolean _toExplode;
  int _cellX, _cellY;
  PVector _position;
  int _explosionRadius;
  int _nbBombMax;
  PImage _sprite;
  int _spriteSize;
  ArrayList<Bomb> _arrayBombs;


  Bomb(Board board) {
    _nbBombMax = 2;
    _explosionRadius = 2;
    _toExplode = false;
    _timeToExplode = 2000;
    _arrayBombs = new ArrayList<Bomb>();
    _sprite = arraySprites[35];
    _spriteSize = board._cellSize;
    _position = initHeroPosition;
  }
  
  
  Bomb(int explosionRadius, int nbMax, PVector position, int cellX, int cellY, float timeBombPlanted) {
    _explosionRadius = explosionRadius;
    _nbBombMax = nbMax;
    _position = position;
    _cellX = cellX;
    _cellY = cellY;
    _timeBombPlanted = timeBombPlanted;
  }
  
  void drop(Board board, Hero hero) {
    _cellX = hero._cellX;
    _cellY = hero._cellY;
    _position = board.getCellCenter(_cellX,_cellY);
    if (_arrayBombs.size() < _nbBombMax) {
      _timeBombPlanted = millis();
      _arrayBombs.add(new Bomb(_explosionRadius, _nbBombMax, _position, _cellX, _cellY, _timeBombPlanted));
    }     
  }

  void update(Board board, Hero hero) { //<>//
    for (int nbBomb = 0; nbBomb < _arrayBombs.size(); nbBomb++) {
      Bomb bombDropped = _arrayBombs.get(nbBomb);
      if(millis() - bombDropped._timeBombPlanted > _timeToExplode) {
        bombDropped._toExplode = true;
      }
      
      if (bombDropped._toExplode) {
        int posX = bombDropped._cellX;
        int posY = bombDropped._cellY;
        
        //Explosion Up
        while (posY > bombDropped._cellY - bombDropped._explosionRadius && board._cells[posY][bombDropped._cellX] != TypeCell.WALL) {
          posY--;
          //Explodes nearby bomb
          for (int bombToCheck = 0; bombToCheck < _arrayBombs.size(); bombToCheck++) {
            if (_arrayBombs.get(bombToCheck)._cellX == bombDropped._cellX && _arrayBombs.get(bombToCheck)._cellY == posY)
              _arrayBombs.get(bombToCheck)._toExplode = true;
          }
          //Explodes nearby destructible wall
          if (board._cells[posY][bombDropped._cellX] == TypeCell.DESTRUCTIBLE_WALL) {
            board._cells[posY][bombDropped._cellX] = TypeCell.EMPTY;
            break;
          }
        }
        
        //Explosion Down
        posY = bombDropped._cellY;
        while (posY < bombDropped._cellY + bombDropped._explosionRadius && board._cells[posY][bombDropped._cellX] != TypeCell.WALL) {
          posY++;
          for (int bombToCheck = 0; bombToCheck < _arrayBombs.size(); bombToCheck++) {
            if (_arrayBombs.get(bombToCheck)._cellX == bombDropped._cellX && _arrayBombs.get(bombToCheck)._cellY == posY)
              _arrayBombs.get(bombToCheck)._toExplode = true;
          }
          if (board._cells[posY][bombDropped._cellX] == TypeCell.DESTRUCTIBLE_WALL) {
            board._cells[posY][bombDropped._cellX] = TypeCell.EMPTY;
            posY = bombDropped._cellY;
            break;
          }
        }
        
       //Explosion Left
       posX = bombDropped._cellX;
        while (posX > bombDropped._cellX - bombDropped._explosionRadius && board._cells[bombDropped._cellY][posX] != TypeCell.WALL) {
          posX--;
          for (int bombToCheck = 0; bombToCheck < _arrayBombs.size(); bombToCheck++) {
            if (_arrayBombs.get(bombToCheck)._cellY == bombDropped._cellY && _arrayBombs.get(bombToCheck)._cellX == posX)
              _arrayBombs.get(bombToCheck)._toExplode = true;
          }
          if (board._cells[bombDropped._cellY][posX] == TypeCell.DESTRUCTIBLE_WALL) {
            board._cells[bombDropped._cellY][posX] = TypeCell.EMPTY;
            break;
          }
        }
        
        //Explosion Right
        posX = bombDropped._cellX;
        while (posX < bombDropped._cellX + bombDropped._explosionRadius && board._cells[bombDropped._cellY][posX] != TypeCell.WALL) {
          posX++;
          for (int bombToCheck = 0; bombToCheck < _arrayBombs.size(); bombToCheck++) {
            if (_arrayBombs.get(bombToCheck)._cellY == bombDropped._cellY && _arrayBombs.get(bombToCheck)._cellX == posX)
              _arrayBombs.get(bombToCheck)._toExplode = true;
          }
          if (board._cells[bombDropped._cellY][posX] == TypeCell.DESTRUCTIBLE_WALL) {
            board._cells[bombDropped._cellY][posX] = TypeCell.EMPTY;
            break;
          }
        }

        _arrayBombs.remove(nbBomb);
      }
    }
  }
 
  
  void drawIt() {
    if (_arrayBombs.size() > 0) {
      for (int nbBomb = 0; nbBomb < _arrayBombs.size(); nbBomb++) {
        imageMode(CENTER);
        image(_sprite, _arrayBombs.get(nbBomb)._position.x, _arrayBombs.get(nbBomb)._position.y, _spriteSize, _spriteSize);
        imageMode(CORNER);
      }
    }
    
  }
}
