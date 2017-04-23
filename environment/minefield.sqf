_pos = _this select 0;
_width = _this select 1;
_depth = _this select 2;
_real = _this select 3;

if (_width < 0) then
{
	_width = -_width;
	_pos set [0, (_pos select 0) - _width];
};
if (_depth < 0) then
{
	_depth = -_depth;
	_pos set [1, (_pos select 1) - _depth];
};

_fuzzX = 10 + random 50;
_fuzzY = 70 - _fuzzX;

_mPos = [
	(_pos select 0) + (_width / 2) + _fuzzX - (2 * random _fuzzX),
	(_pos select 1) + (_depth / 2) + _fuzzY - (2 * random _fuzzY) + (MINEDIST / 2)
];
_mSize = [
	(_width / 2) + _fuzzX,
	(_depth / 2) + _fuzzY + (MINEDIST / 2)
];

_marker = createMarker [str(random 10), _mPos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerBrush "Solid";
_marker setMarkerColor "ColorRed";
_marker setMarkerSize _mSize;

if (_real) then
{
	_x = random MINEDIST;
	_y = 0;

	while {_y < _depth} do
	{
		_minePos = [
			(_pos select 0) + _x,
			(_pos select 1) + _y + random MINEDIST
		];
		
		_mine = [_minePos] execVM "environment\createMine.sqf";
		
		/*
		_mineMarker = createMarker [str(random 10), _minePos];
		_mineMarker setMarkerShape "ICON";
		_mineMarker setMarkerType "hd_dot";
		/*
		_mineMarker setMarkerColor "ColorRed";
		*/
		
		_x = _x + MINEDIST + random MINEDIST;
		
		if (_x > _width) then
		{
			_x = random MINEDIST;
			_y = _y + MINEDIST;
		};
	};
};