// Manages the upgrade, destruction and location of the player's vehicle

// Reward Dialog
_actionID = -1;
_actionPresent = false;

// Identify the player's unit's name
_playerUnit = units group player;
_markerSpawn = "VehicleSpawn" + str(_playerUnit select 0);

// Player's current vehicle (int)
CURRENTVEHICLE = 0;

// Spawn Default Vehicle
_Vehicle = createVehicle [((globalVehicleList select CURRENTVEHICLE) select 1), getMarkerPos _markerSpawn, [], 0, "NONE"];

// currentCargo
_currentWeapons = getWeaponCargo _Vehicle;
_currentAmmo = getMagazineCargo _Vehicle;
_currentWeaponsCount = 0;
_currentAmmoCount = 0;
_currentWeaponsTotal = 0;
_currentAmmoTotal = 0;

_massWeapons = 0;
_massAmmo = 0;
_maxWeight = (globalVehicleList select CURRENTVEHICLE) select 3;

_locked = false;



Func_CargoWeight = {
	_diff = _this select 0;
	_list = _this select 1;
	
	_count = count (_diff select 0);
	_bool = [];
	
	_return = 0;
	
	// Create a boolean array for checking off compared items
	for [{_i=0}, {_i < _count}, {_i = _i + 1}] do {_bool = _bool + [true];};
	
	// Compare with _list
	{
		for [{_i=0}, {_i < _count}, {_i = _i + 1}] do
		{
			// Check if the new weapon has not found it's global counterpart
			if (_bool select _i) then {
				// Compare the class name of the new weapon to that of the global list
				if (((_diff select 0) select _i) == (_x select 0)) then {
					// Add weapon mass to the return argument
					_return = _return + (_x select 2)*((_diff select 1) select _i); 
				};
			};
		};
	} foreach _list;
	
	_return

};

while {true} do {
	// Check if the action has been added to the player
	if(alive player && !_actionPresent) then {
		_actionPresent = true;
		_actionId = player addAction ["Reward Menu", "rewards\rewardDialog.sqf","", 0, false, true];
	} else {
		if(!alive player && _actionPresent) then {
			_actionPresent = false;
			player removeAction _ActionId;
		}
	};

	// Check if vehicle has been destroyed
	if(!alive _Vehicle) then {
		hint format["Your %1 has been destroyed", ((globalVehicleList select CURRENTVEHICLE) select 0)];
		CURRENTVEHICLE = 0;
		_Vehicle = createVehicle [((globalVehicleList select CURRENTVEHICLE) select 1), getMarkerPos _markerSpawn, [], 0, "NONE"];
		_maxWeight = (globalVehicleList select CURRENTVEHICLE) select 3;
		clearWeaponCargo _Vehicle;
		clearMagazineCargo _Vehicle;
		_Vehicle setVehicleVarName ("Vehicle" + str(_playerUnit select 0));
	};
	
	// Check if vehicle has been upgraded
	if(BUYBUTTONPRESSED) then {
		
		// Obtain selected vehicle's cost
		_newVehicleCost = (globalVehicleList select NEWVEHICLE) select 2;
		_oldVehicleCost = (globalVehicleList select CURRENTVEHICLE) select 2;
		
		if(CURRENTVEHICLE != NEWVEHICLE) then {
			
			// Subtract credits
			CREDITS = CREDITS - _newVehicleCost + _oldVehicleCost * 0.5;
			
			// Report remaining Credits
			hint format["Credits Remaining: %1", CREDITS];
			
		} else {
			
			// Subtract credits
			_cost = 0;
			
			if(CURRENTVEHICLE != 0) then {
				_cost = _cost + floor (_newVehicleCost * ( getDammage _Vehicle) + 100);
			};
			
			CREDITS = CREDITS - _cost;
			
		
			// Report remaining Credits
			hint format["Vehicle Repaired and Respawned\nCost: %1\nCredits Remaining: %2", _cost, CREDITS];
		};
		
		// Change the vehicle
		CURRENTVEHICLE = NEWVEHICLE;
		deleteVehicle _Vehicle;
		_Vehicle = createVehicle [((globalVehicleList select CURRENTVEHICLE) select 1), getMarkerPos _markerSpawn, [], 0, "NONE"];
		_maxWeight = (globalVehicleList select CURRENTVEHICLE) select 3;
		clearWeaponCargo _Vehicle;
		clearMagazineCargo _Vehicle;
		_Vehicle setVehicleVarName ("Vehicle" + str(_playerUnit select 0));
		
		// Reset buy button
		BUYBUTTONPRESSED = false;
	};
	
	// Check if player is in the right vehicle
	if(vehicle player != player) then {
		// Check if the vehicle is the player's
		if(driver _Vehicle != player) then {
			if(driver vehicle player == player) then {
				player action ["Eject",vehicle player];
			};
			if(gunner vehicle player == player) then {
				player action ["Eject",vehicle player];
			};
			if(commander vehicle player == player) then {
				player action ["Eject",vehicle player];
			};
		};
	};
	
	// --------------------------------------------------------------------------
	//	Check vehicle cargo contents
	// --------------------------------------------------------------------------
	_newWeapons = getWeaponCargo _Vehicle;
	_newAmmo = getMagazineCargo _Vehicle;
	
	_newWeaponsCount = count (_currentWeapons select 0);
	_newAmmoCount = count (_currentAmmo select 0);
	
	_newWeaponsTotal = 0; {_newWeaponsTotal = _newWeaponsTotal + _x;} foreach (_newWeapons select 1);
	_newAmmoTotal = 0;  {_newAmmoTotal = _newAmmoTotal + _x;} foreach (_newAmmo select 1);
	
	if( _currentWeaponsCount != _newWeaponsCount || _newWeaponsTotal != _currentWeaponsTotal) then {
	
		_currentWeapons = _newWeapons;
		_currentWeaponsCount = _newWeaponsCount;
		_currentWeaponsTotal = _newWeaponsTotal;
		_massWeapons = 0;
		_rhsWeight = [_currentWeapons,globalWeaponsList] call Func_CargoWeight; _massWeapons = _massWeapons + _rhsWeight;
		_rhsWeight = [_currentWeapons,globalLaunchersList] call Func_CargoWeight; _massWeapons = _massWeapons + _rhsWeight;
		_rhsWeight = [_currentWeapons,globalPistolsList] call Func_CargoWeight; _massWeapons = _massWeapons + _rhsWeight;
	};
	if( _currentAmmoCount != _newAmmoCount || _newAmmoTotal != _currentAmmoTotal) then {
		_currentAmmo = _newAmmo;
		_currentAmmoCount = _newAmmoCount;
		_currentAmmoTotal = _newAmmoTotal;
		_massAmmo = 0;
		_rhsWeight = [_currentAmmo,globalMagazinesList] call Func_CargoWeight; _massAmmo = _massAmmo + _rhsWeight;
		_rhsWeight = [_currentAmmo,globalLauncherMagsList] call Func_CargoWeight; _massAmmo = _massAmmo + _rhsWeight;
		_rhsWeight = [_currentAmmo,globalPistolMagsList] call Func_CargoWeight; _massAmmo = _massAmmo + _rhsWeight;
		_rhsWeight = [_currentAmmo,globalSpecialList] call Func_CargoWeight; _massAmmo = _massAmmo + _rhsWeight;
	};
	
	
	// Check that the new exceeds the vehicles limit
	if((_massAmmo + _massWeapons) > _maxWeight) then {
		hintSilent "Vehicle is overloaded!";
		_Vehicle setVehicleLock "LOCKED";
		_locked = true;
	} else {
		if(_locked) then {
			_Vehicle setVehicleLock "UNLOCKED";
		};
	};
	
	sleep 0.5;
};