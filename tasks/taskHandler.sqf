//make sure we only have one instance of the handler
if (!isNil{HANDLER}) exitWith {};
HANDLER = 0;

_unit = _this select 0;

_missionList = [[],[],[],[]];
waitUntil {!isNil{fnc_newMission}};

for "_i" from 0 to 3 do
{
	_missionData = [_unit, _i] call fnc_newMission;
	_missionList set [_i, _missionData];
};

while {true} do
{
	if (REROLLTASKS) then
	{
		for "_i" from 0 to 3 do
		{
			_missionData = _missionList select _i;
			_crate = _missionData select 3;
			_task = _missionData select 4;
			
			deleteVehicle _crate;
			_task setTaskState "Failed";
			
			_missionData = [_unit, _i] call fnc_newMission;
			_missionList set [_i, _missionData];
		};
		
		REROLLTASKS = false;
	};
	
	for "_i" from 0 to 3 do
	{
		_missionData = _missionList select _i;
		
		_missionWepList = _missionData select 0;
		_missionMagList = _missionData select 1;
		_distance = _missionData select 2;
		_crate = _missionData select 3;
		_task = _missionData select 4;
		_tskReward = _missionData select 5;
		
		_taskDone = true;
		
		_wepCargo = getWeaponCargo _crate;
		{
			_wepName = _x select 2;
			_wepQty = _x select 1;
			
			_j = (_wepCargo select 0) find _wepName;
			if (_j >= 0) then
			{
				if (_wepQty > (_wepCargo select 1) select _j) then
				{
					_taskDone = false;
					
					_wepCargoQtys = (_wepCargo select 1);
					_newVal = (_wepCargoQtys select _j) - _wepQty;
					_wepCargoQtys set [_j, _newVal];
					_wepCargo set [1, _wepCargoQtys];
				};
			}
			else
			{
				_taskDone = false;
			};
		}
		forEach _missionWepList;
		
		_magCargo = getMagazineCargo _crate;
		if (_taskDone) then
		{
			{
				_magName = _x select 2;
				_magQty = _x select 1;
				
				_j = (_magCargo select 0) find _magName;
				if (_j >= 0) then
				{
					if (_magQty > (_magCargo select 1) select _j) then
					{
						_taskDone = false;
					}
					else
					{
						_magCargoQtys = (_magCargo select 1);
						_newVal = (_magCargoQtys select _j) - _magQty;
						_magCargoQtys set [_j, _newVal];
						_magCargo set [1, _magCargoQtys];
					};
				}
				else
				{
					_taskDone = false;
				};
			}
			forEach _missionMagList;
		};
		
		if (_taskDone) then
		{
			_task setTaskState "Succeeded";
			CREDITS = CREDITS + _tskReward;
			hint format ["Task completed for $%1\nTotal Credits: $%2", _tskReward, CREDITS];
			
			clearWeaponCargo _crate;
			clearMagazineCargo _crate;
			
			for "_j" from 0 to (count (_wepCargo select 0))-1 do
			{
				_wepName = (_wepCargo select 0) select _j;
				_wepQty = (_wepCargo select 1) select _j;
				
				if (_wepQty > 0) then
				{
					_crate addWeaponCargo [_wepName, _wepQty];
				};
			};
			
			for "_j" from 0 to (count (_magCargo select 0))-1 do
			{
				_magName = (_magCargo select 0) select _j;
				_magQty = (_magCargo select 1) select _j;
				
				if (_magQty > 0) then
				{
					_crate addMagazineCargo [_magName, _magQty];
				};
			};
			
			
			_missionData = [_unit, _i] call fnc_newMission;
			_missionList set [_i, _missionData];
			
			sleep 60;
			deleteVehicle _crate;
		};
		
		sleep 1;
	};
};