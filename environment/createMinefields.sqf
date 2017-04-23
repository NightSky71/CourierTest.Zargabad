_qty = _this select 0;

// Function to check if a minefield is too close to a building
CheckMinefieldPos = {
	_cornerPos = _this select 0;
	_fieldW = _this select 1;
	_fieldL = _this select 2;
	
	_centre = [(_cornerPos select 0) + (_fieldW / 2), (_cornerPos select 1) + (_fieldL / 2)];
	
	_nearObjs = nearestObjects [_centre, ["house"], 300];
	
	_safe = true;
	
	if ((BASEPOS distance _centre) < 300) then
	{
		_safe = false;
	}
	else
	{	
		{
			_building = _x;
			
			_bPos = position _building;
			if (
				( abs ((_bPos select 0) - (_centre select 0)) < (_fieldW / 2) ) &&
				( abs ((_bPos select 1) - (_centre select 1)) < (_fieldL / 2) )
			)
			then
			{
				_testLoc = _building buildingPos 1;
				if (_testLoc select 0 != 0 && _testLoc select 1 != 0 && _testLoc select 2 != 0) then
				{
					_safe = false;
					
					/*
					_marker = createMarker [str(_centre select 0), _centre];
					_marker setMarkerShape "RECTANGLE";
					_marker setMarkerBrush "Solid";
					_marker setMarkerColor "ColorBlue";
					_marker setMarkerSize [_fieldW / 2, _fieldL / 2];
					
					_marker = createMarker [str(_bPos select 0), _bPos];
					_marker setMarkerShape "ICON";
					_marker setMarkerType "hd_dot";
					_marker setMarkerColor "ColorBlue";
					*/

				};
			};
		}
		foreach _nearObjs;
	};
	
	_safe
};

_townPos = [4150, 3950];

for "_i" from 1 to _qty do
{
	_mPos = [0,0];
	_wid = 50 + random 200;
	_len = 300 - _wid;
	
	_findPos = true;
	_count = 0;

	while {_findPos} do
	{
		if ((_mPos select 0) == 0 && (_mPos select 1) == 0 || _count > 10) then
		{
			_count = 0;
			_mPos = [(_townPos select 0) - 1500 + random 3000, (_townPos select 1) - 1800 + random 3600];
		}
		else
		{
			_count = _count + 1;
			_mPos = [(_mPos select 0) - (_count * 100) + (_count * random 200), (_mPos select 1) - (_count * 100) + (_count * random 200)];
		};
		
		if ([_mPos , _wid, _len] call CheckMinefieldPos) then
		{
			_findPos = false;
		}
		else
		{
			_temp = _wid;
			_wid = _len;
			_len = _temp;
			
			if ([_mPos , _wid, _len] call CheckMinefieldPos) then
			{
				_findPos = false;
			};
		};
	};

	_nul = [_mPos, _wid, _len, (random 100) < 75] execVM "environment\minefield.sqf";
};