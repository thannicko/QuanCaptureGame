class_name BoardStateMachine extends StateMachine

@export var board: Board

enum PutRocksDirection { Left, Right }

var selected_square: Square
var first_dropoff_square: Square
var put_direction: PutRocksDirection

const NumberOfStartingRocks : int = 5
