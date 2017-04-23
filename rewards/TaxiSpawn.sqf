// Select Location for the vehicle
_radius = 100;
_minRadius = 25;

_state = true;
_skips = 15;
_n = 0;

_VehiclePos = position player;
while{_state} do {
	_VehiclePos = [(position player select 0) + (random (_radius*2)) - _radius, (position player select 1) + (random (_radius*2)) - _radius, position player select 2 ];
	_isFlat = position player isFlatEmpty  [-1, -1, 0.3, 5, -1] ;
	
	if((_VehiclePos distance position player > _minRadius) and (count _isFlat != 0)) then {
		_state = false;
	};
	
	_n = _n + 1;
	if(_n > _skips) then{
		hint "Taxi cannot find a suitable area to spawn, relocate and try again.";
		TAXITIMESTAMP = -600;
		_state = false;
	};
};

if(_n > _skips) then {
	// Don't continue and break (terminate) the script.
} else{
	// Create Vehicle
	_Group = CreateGroup resistance;
	_Vehicle = createVehicle ["VolhaLimo_TK_CIV_EP1", _VehiclePos , [], 0, "NONE"];
	_Driver = _Group createUnit ["TK_GUE_Soldier_3_EP1", [0,0,1], [], 0, "CAN_COLLIDE"];
	_Driver moveInDriver _Vehicle;
	wp1 = _Group addWaypoint [(position player), 0];


	// Wait until player has entered the car
	waitUntil{count (crew _Vehicle) > 1};

	wp1 = _Group addWaypoint [(markerPos "Taxi_DropOff"), 0];
	hint "Remain in Taxi";

	// Wait until player has left the car
	// Set a new random position to travel to
	waitUntil{count (crew _Vehicle) == 1};

	_radius = 500;
	_minRadius = 250;

	_state = true;
	while{_state} do {
		_VehiclePos = [(position _Vehicle select 0) + random 500 - 250, (position _Vehicle select 1) + random 100 - 50, position player select 2 ];
		if(_VehiclePos distance position player > _minRadius) then {_state = false;};
	};

	wp1 = _Group addWaypoint [(_VehiclePos), 0];

	sleep 45;

	deleteVehicle _Driver;
	deleteVehicle _Vehicle;
};





