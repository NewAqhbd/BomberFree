class Bomb {
  float _timeToExplode;
  float _timeBombPlanted;
  boolean _toExplode;
  int _cellX, _cellY;
  PVector _position;
  int _explosionRadius;
  PImage _sprite;
  int _spriteSize;
  ArrayList<PVector> _arrayPosBombs;
  int _currentSpriteIndex;



  Bomb(Board board) {
    _toExplode = false;
    _timeToExplode = 3000;
    _sprite = arraySprites[35];
    _spriteSize = board._cellSize;
    _position = initHeroPosition;
    _arrayPosBombs = new ArrayList<PVector>();
  }
  
  
  
  Bomb(int explosionRadius, PVector position, int cellX, int cellY, float timeBombPlanted) {
    _explosionRadius = explosionRadius;
    _position = position;
    _cellX = cellX;
    _cellY = cellY;
    _timeBombPlanted = timeBombPlanted;
  }
  
  
  
  void drop(Board board, Hero hero) {
    _cellX = hero._cellX;
    _cellY = hero._cellY;
    _position = board.getCellCenter(_cellX,_cellY);
    if (hero._arrayBombs.size() < hero._nbBombMax) {
      _timeBombPlanted = millis();
      _currentSpriteIndex = 35;
      _sprite = arraySprites[_currentSpriteIndex];
      hero._arrayBombs.add(new Bomb(hero._explosionRadius, _position, _cellX, _cellY, _timeBombPlanted));
      _arrayPosBombs.add(_position);
    }     
  }
  
  

  //Update the state of each hero's bombs and their surrounding area
  void update(Board board, Hero hero) { //<>//
    for (int nbBomb = 0; nbBomb < hero._arrayBombs.size(); nbBomb++) { //<>//
      Bomb bombDropped = hero._arrayBombs.get(nbBomb);
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
          for (int bombToCheck = 0; bombToCheck < hero._arrayBombs.size(); bombToCheck++) {
            if (hero._arrayBombs.get(bombToCheck)._cellX == bombDropped._cellX && hero._arrayBombs.get(bombToCheck)._cellY == posY)
              hero._arrayBombs.get(bombToCheck)._toExplode = true;
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
          for (int bombToCheck = 0; bombToCheck < hero._arrayBombs.size(); bombToCheck++) {
            if (hero._arrayBombs.get(bombToCheck)._cellX == bombDropped._cellX && hero._arrayBombs.get(bombToCheck)._cellY == posY)
              hero._arrayBombs.get(bombToCheck)._toExplode = true;
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
          for (int bombToCheck = 0; bombToCheck < hero._arrayBombs.size(); bombToCheck++) {
            if (hero._arrayBombs.get(bombToCheck)._cellY == bombDropped._cellY && hero._arrayBombs.get(bombToCheck)._cellX == posX)
              hero._arrayBombs.get(bombToCheck)._toExplode = true;
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
          for (int bombToCheck = 0; bombToCheck < hero._arrayBombs.size(); bombToCheck++) {
            if (hero._arrayBombs.get(bombToCheck)._cellY == bombDropped._cellY && hero._arrayBombs.get(bombToCheck)._cellX == posX)
              hero._arrayBombs.get(bombToCheck)._toExplode = true;
          }
          if (board._cells[bombDropped._cellY][posX] == TypeCell.DESTRUCTIBLE_WALL) {
            board._cells[bombDropped._cellY][posX] = TypeCell.EMPTY;
            break;
          }
        }

        hero._arrayBombs.remove(nbBomb);
        _arrayPosBombs.remove(nbBomb);
      }
    }
    //change the image of the bomb every 1 second
    if (millis() - _timeBombPlanted >= 1000 && !_toExplode) {
        _currentSpriteIndex++;
        if (_currentSpriteIndex > 37) {
            _currentSpriteIndex = 35;
        }
      _sprite = arraySprites[_currentSpriteIndex];
      _timeBombPlanted = millis();
    }
  }
 
 
  
  void drawIt() {
    if (_arrayPosBombs.size() > 0) {
      for (int nbBomb = 0; nbBomb < _arrayPosBombs.size(); nbBomb++) {
        imageMode(CENTER);
        image(_sprite, _arrayPosBombs.get(nbBomb).x, _arrayPosBombs.get(nbBomb).y, _spriteSize, _spriteSize);
        imageMode(CORNER);
      }
    }
    
  }
}
