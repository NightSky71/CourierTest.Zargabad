_unit = _this select 0;
_difficulty = _this select 1;

//fucntion to round to the nearest 10 cents
rwdFloor = {
	_value = _this;
	_value = _value * 10;
	_value = floor _value;
	_value = _value / 10;
	_value
};

//declare our task variables
_title = "";
_desc = "";
_missionWepList = [];
_missionMagList = [];
_location = [];
_distance = 10000;
_building = 0;
_numPos = 0;
_reward = 0;
_weight = 0;

switch (_difficulty) do
{
	case 0:
	{
		_title = "Basic Supplies";
		_wepList = [];
		_magList = [];
		
		//get a random list of weapons
		_r = random 100;
		if (_r < 50) then
		{
			_wepList = globalWeaponsList;
		}
		else
		{
			if (_r < 75) then
			{
				_wepList = globalPistolsList;
			}
			else
			{
				_wepList = globalLaunchersList;
			};
		};
		
		//get a random weapon from our list
		_weapon = _wepList select floor random count _wepList;
		_reward = _reward + 1 + ((_weapon select 2) / 5);
		_weight = _weight + (_weapon select 2);
		
		_missionWepList = [[_weapon select 1, 1, _weapon select 0]];
		
		//get a random list of magazines
		_r = random 100;
		_q = 3 + floor random 5;
		if (_r < 60) then
		{
			_magList = globalMagazinesList;
			_reward = _reward + _q;
		}
		else
		{
			if (_r < 80) then
			{
				_magList = globalPistolMagsList;
				_reward = _reward + (_q * 0.75);
			}
			else
			{
				_magList = globalLauncherMagsList;
				_reward = _reward + (_q * 1.25);
			};
		};
		
		//get a random magazine from our list
		_mag = _magList select floor random count _magList;
		_qty = round(_q / (_mag select 2));
		_weight = _weight + ((_mag select 2) * _qty);
		
		_missionMagList = [[_mag select 1, _qty, _mag select 0]];
		
		while {_distance > 1000} do
		{
			//pick a random building to go to
			_buildingInfo = globalBuildingList select floor random count globalBuildingList;
			_building = _buildingInfo select 0;
			_distance = _buildingInfo select 1;
			_numPos = _buildingInfo select 2;
		};
		
		//pick a random waypoint in our building
		_location = _building buildingPos floor random _numPos;
	};
	
	case 1:
	{
		_title = "Terrorism Starter-Pack";
		_wepList = [];
		_magList = [];
		
		for "_i" from 0 to 1 do
		{
			_r = 10;
			//get a random list of weapons
			if (count _missionWepList > 0) then 
			{
				_r = (random 100) - (15 * ((count _missionWepList)^1.5));
			};
			
			_q = 1 + round (random 0.8);
			
			if (_r > 0) then
			{
				if (_r < 50) then
				{
					_wepList = globalWeaponsList;
				}
				else
				{
					if (_r < 75) then
					{
						_wepList = globalPistolsList;
					}
					else
					{
						_wepList = globalLaunchersList;
					};
				};
				
				//get a random weapon from our list
				_weapon = _wepList select floor random count _wepList;
				_reward = _reward + (_q * (1 + ((_weapon select 2) / 5)));
				_weight = _weight + ((_weapon select 2) * _q);
				_flag = true;
				
				//check if we already have the weapon in the list
				for "_j" from 0 to (count _missionWepList)-1 do
				{
					_wep = _missionWepList select _j;
					if (_weapon select 1 == _wep select 0) then
					{
						_qty = (_wep select 1) + _q;
						_wep set [1, _qty];
						_flag = false;
					};
				};
				
				if (_flag) then 
				{
					_missionWepList = _missionWepList + [[_weapon select 1, _q, _weapon select 0]];
				};
			};
		};
		
		for "_i" from 0 to 3 do
		{
			//get a random list of magazines
			_r = (random 100) - (10 * ((count _missionMagList)^1.5));
			_q = 4 + floor random 6;
			
			if (_r > 0) then
			{
				if (_r < 50) then
				{
					_magList = globalMagazinesList;
					_reward = _reward + _q;
				}
				else
				{
					if (_r < 75) then
					{
						_magList = globalPistolMagsList;
						_reward = _reward + (_q * 0.75);
					}
					else
					{
						_magList = globalLauncherMagsList;
						_reward = _reward + (_q * 1.25);
					};
				};
				
				//get a random magazine from our list
				_mag = _magList select floor random count _magList;
				_qty = round(_q / (_mag select 2));
				_weight = _weight + ((_mag select 2) * _qty);
				_flag = true;
				
				//check if we already have the weapon in the list
				for "_j" from 0 to (count _missionMagList)-1 do
				{
					_m = _missionMagList select _j;
					if (_mag select 1 == _m select 0) then
					{
						_qty = (_m select 1) + round(_q / (_mag select 2));
						_m set [1, _qty];
						_flag = false;
					};
				};
				
				if (_flag) then 
				{
					_missionMagList = _missionMagList + [[_mag select 1, round(_q / (_mag select 2)), _mag select 0]];
				};
			};
		};
		
		while {_distance > 1750 || _distance < 750} do
		{
			//pick a random building to go to
			_buildingInfo = globalBuildingList select floor random count globalBuildingList;
			_building = _buildingInfo select 0;
			_distance = _buildingInfo select 1;
			_numPos = _buildingInfo select 2;
		};
		
		//pick a random waypoint in our building
		_location = _building buildingPos floor random _numPos;
	};
	
	case 2:
	{
		_title = "Serious Shipment";
		_wepList = [];
		_magList = [];
		
		for "_i" from 0 to 3 do
		{
			_r = 10;
			//get a random list of weapons
			if (count _missionWepList > 0) then
			{
				_r = (random 100) - (15 * ((count _missionWepList)^1.4));
			};
			
			_q = 1 + round (random 0.8);
			_q = _q + round (random 0.8);
			
			if (_r > 0) then
			{
				if (_r < 50) then
				{
					_wepList = globalWeaponsList;
				}
				else
				{
					if (_r < 75) then
					{
						_wepList = globalPistolsList;
					}
					else
					{
						_wepList = globalLaunchersList;
					};
				};
				
				//get a random weapon from our list
				_weapon = _wepList select floor random count _wepList;
				_reward = _reward + (_q * (1 + ((_weapon select 2) / 5)));
				_weight = _weight + ((_weapon select 2) * _q);
				_flag = true;
				
				//check if we already have the weapon in the list
				for "_j" from 0 to (count _missionWepList)-1 do
				{
					_wep = _missionWepList select _j;
					if (_weapon select 1 == _wep select 0) then
					{
						_qty = (_wep select 1) + _q;
						_wep set [1, _qty];
						_flag = false;
					};
				};
				
				if (_flag) then 
				{
					_missionWepList = _missionWepList + [[_weapon select 1, _q, _weapon select 0]];
				};
			};
		};
		
		for "_i" from 0 to 5 do
		{
			//get a random list of magazines
			_r = (random 100) - (10 * ((count _missionMagList)^1.4));
			_q = 5 + floor (((random 8)^1.5) / 2.3);
			
			if (_r > 0) then
			{
				if (_r < 50) then
				{
					_magList = globalMagazinesList;
					_reward = _reward + _q;
				}
				else
				{
					if (_r < 75) then
					{
						_magList = globalPistolMagsList;
						_reward = _reward + (_q * 0.75);
					}
					else
					{
						_magList = globalLauncherMagsList;
						_reward = _reward + (_q * 1.25);
					};
				};
				
				//get a random magazine from our list
				_mag = _magList select floor random count _magList;
				_qty = round(_q / (_mag select 2));
				_weight = _weight + ((_mag select 2) * _qty);
				_flag = true;
				
				//check if we already have the weapon in the list
				for "_j" from 0 to (count _missionMagList)-1 do
				{
					_m = _missionMagList select _j;
					if (_mag select 1 == _m select 0) then
					{
						_qty = (_m select 1) + round(_q / (_mag select 2));
						_m set [1, _qty];
						_flag = false;
					};
				};
				
				if (_flag) then 
				{
					_missionMagList = _missionMagList + [[_mag select 1, round(_q / (_mag select 2)), _mag select 0]];
				};
			};
		};
		
		_distance = 0;
		while {_distance < 1250} do
		{
			//pick a random building to go to
			_buildingInfo = globalBuildingList select floor random count globalBuildingList;
			_building = _buildingInfo select 0;
			_distance = _buildingInfo select 1;
			_numPos = _buildingInfo select 2;
		};
		
		//pick a random waypoint in our building
		_location = _building buildingPos floor random _numPos;
	};
	
	case 3:
	{
		_title = "One Man Armoury";
		_wepList = [];
		_magList = [];
		
		for "_i" from 0 to 5 do
		{
			_r = 10;
			//get a random list of weapons
			if (count _missionWepList > 0) then
			{
				_r = (random 120) - (12 * ((count _missionWepList)^1.3));
			};
			
			_q = 1 + round (random 0.8);
			_q = _q + round (random 0.8);
			
			if (_r > 0) then
			{
				if (_r < 50) then
				{
					_wepList = globalWeaponsList;
				}
				else
				{
					if (_r < 75) then
					{
						_wepList = globalPistolsList;
					}
					else
					{
						_wepList = globalLaunchersList;
					};
				};
				
				//get a random weapon from our list
				_weapon = _wepList select floor random count _wepList;
				_reward = _reward + (_q * (1 + ((_weapon select 2) / 5)));
				_weight = _weight + ((_weapon select 2) * _q);
				_flag = true;
				
				//check if we already have the weapon in the list
				for "_j" from 0 to (count _missionWepList)-1 do
				{
					_wep = _missionWepList select _j;
					if (_weapon select 1 == _wep select 0) then
					{
						_qty = (_wep select 1) + _q;
						_wep set [1, _qty];
						_flag = false;
					};
				};
				
				if (_flag) then 
				{
					_missionWepList = _missionWepList + [[_weapon select 1, _q, _weapon select 0]];
				};
			};
		};
		
		for "_i" from 0 to 10 do
		{
			//get a random list of magazines
			_r = (random 120) - (7 * ((count _missionMagList)^1.2));
			_q = 5 + floor (((random 11)^1.5) / 2.3);
			
			if (_r > 0) then
			{
				if (_r < 50) then
				{
					_magList = globalMagazinesList;
					_reward = _reward + _q;
				}
				else
				{
					if (_r < 75) then
					{
						_magList = globalPistolMagsList;
						_reward = _reward + (_q * 0.75);
					}
					else
					{
						_magList = globalLauncherMagsList;
						_reward = _reward + (_q * 1.25);
					};
				};
				
				//get a random magazine from our list
				_mag = _magList select floor random count _magList;
				_qty = round(_q / (_mag select 2));
				_weight = _weight + ((_mag select 2) * _qty);
				_flag = true;
				
				//check if we already have the weapon in the list
				for "_j" from 0 to (count _missionMagList)-1 do
				{
					_m = _missionMagList select _j;
					if (_mag select 1 == _m select 0) then
					{
						_qty = (_m select 1) + round(_q / (_mag select 2));
						_m set [1, _qty];
						_flag = false;
					};
				};
				
				if (_flag) then 
				{
					_missionMagList = _missionMagList + [[_mag select 1, round(_q / (_mag select 2)), _mag select 0]];
				};
			};
		};
		
		_reward = _reward * 0.9;
		
		_distance = 0;
		while {_distance < 2250} do
		{
			//pick a random building to go to
			_buildingInfo = globalBuildingList select floor random count globalBuildingList;
			_building = _buildingInfo select 0;
			_distance = _buildingInfo select 1;
			_numPos = _buildingInfo select 2;
		};
		
		//pick a random waypoint in our building
		_location = _building buildingPos floor random _numPos;
	};
};

if (((random 100) + (10*_difficulty)) > 100) then 
{
	_special = globalSpecialList select floor random count globalSpecialList;
	_missionWepList = _missionWepList + [[_special select 1, 1, _special select 0]];
	
	_reward = _reward + 10;
	_weight = _weight + 1
};

//set the reward muliplier based on distance
_reward = (_reward * (_distance + 100) / 50) call rwdFloor;

{
	_desc = _desc + format ["%1x %2<br/>", _x select 1, _x select 0];
}
forEach _missionWepList;

{
	_desc = _desc + format ["%1x %2<br/>", _x select 1, _x select 0];
}
forEach _missionMagList;

_desc = _desc + "<br/>";
_desc = _desc + format ["Distance: %1m<br/>", round _distance];

_endStr = "0";
if(floor _reward == _reward) then
{
	_endStr = ".00";
};
_desc = _desc + format ["Reward: $%1%2<br/>", _reward, _endStr];

_desc = _desc + format ["Cargo Size: %1<br/>", _weight];

_task = _unit createSimpleTask ["taskName1"];
_task setSimpleTaskDescription [_desc, _title, ""];
_task setSimpleTaskDestination _location;

//create the target ammo box
_box = "LocalBasicAmmunitionBox" createVehicle [0,0];
_box setPos _location;
clearWeaponCargo _box;
clearMagazineCargo _box;

[_missionWepList, _missionMagList, _distance, _box, _task, _reward]

/*
globalWeaponsList
globalMagazinesList
globalSpecialList
globalLaunchersList
globalLauncherMagsList
globalPistolsList
globalPistolMagsList
*/