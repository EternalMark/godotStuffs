class_name GameConstants

#region DROPS
const ENEMY_POSX_FAR:int=9
const ENEMY_POSX_NEAR:int=7

const DROP_COINS_FAR:int=5
const DROP_COINS_NEAR:int=6
const DROP_COINS_CLOSER:int=7
#endregion

#region ENUM
const ONE:int=1
const TWO:int=2
const THREE:int=3
const FOUR:int=4
const FIFTY:int=50
const ONEHUNDRED:int=100
#endregion

#region MoverAbejas
const allowTilesInitX:int=1
const allowTilesInitY:int=1
const allowTilesFinalX:int=5
const allowTilesFinalY:int=6
#endregion

enum GAME_STATES {
	IN_PROGRESS,
	ENDGAME
}

enum CARAMEL_TYPE {
	BEE,
	POWERUP
}
