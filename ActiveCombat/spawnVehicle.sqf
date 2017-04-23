// Define variables
_unit = _this select 0;
_crew = if (count _this > 1) then {_this select 1} else {"US_Soldier_Crew_EP1"};
_markerSpawn = if (count _this > 2) then {_this select 2} else {"spawn1"};
_side = if (count _this > 3) then {_this select 3} else {EAST};

_Group = CreateGroup _side;
_Vehicle = createVehicle [_unit, getMarkerPos _markerSpawn, [], 0, "NONE"];
_Driver = _Group createUnit [_crew, [0,0,1], [], 0, "CAN_COLLIDE"];
_Driver moveInDriver _Vehicle;
_Gunner = _Group createUnit [_crew, [0,0,1], [], 0, "CAN_COLLIDE"];
_Gunner moveInGunner _Vehicle;

if(_side == EAST) then {
	wp1 = _Group addWaypoint [[(((getMarkerPos _markerSpawn) select 0) + 2000),(((getMarkerPos _markerSpawn) select 1)),0], 0];
} else {
	wp1 = _Group addWaypoint [[(((getMarkerPos _markerSpawn) select 0) - 2000),(((getMarkerPos _markerSpawn) select 1)),0], 0];
};
wp1 setWaypointSpeed "NORMAL";
wp1 setWaypointType "SAD";
