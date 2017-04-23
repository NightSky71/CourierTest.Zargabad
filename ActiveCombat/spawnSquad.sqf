// Define variables
_members  = _this select 0;
_markerSpawn = if (count _this > 1) then {_this select 1} else {"blu_1"};
_side = if (count _this > 2) then {_this select 2} else {EAST};
_squadSize = if (count _this > 3) then {_this select 3} else {10};

_memberArray = [];


for "_i" from 1 to _squadSize do {
	_memberArray = _memberArray + [(_members select floor random count _members)];
};


_Group = CreateGroup _side;
_Group = [getMarkerPos _markerSpawn, _side, _memberArray] call BIS_fnc_spawnGroup;


if(_side == EAST) then {
	wp1 = _Group addWaypoint [[(((getMarkerPos _markerSpawn) select 0) + 2000),(((getMarkerPos _markerSpawn) select 1)),0], 0];
	wp1 setWaypointSpeed "NORMAL";
	wp1 setWaypointType "SAD";

} else {
	wp1 = _Group addWaypoint [[(((getMarkerPos _markerSpawn) select 0) - 2000),(((getMarkerPos _markerSpawn) select 1)),0], 0];
	wp1 setWaypointSpeed "NORMAL";
	wp1 setWaypointType "SAD";

};
