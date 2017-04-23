//[obj AmmoBox, num BoxType] execVM "supplyBox.sqf";
_box = _this select 0;
_type = _this select 1;

_box addEventHandler ["HandleDamage", {false}];

_wepcount = 10;
_magcount = 30;
_specialcount = 5;

//wait for the mission init to finish
waitUntil {!isNil{globalPistolMagsList}};

while {true} do
{
	clearweaponcargo _box;
	clearmagazinecargo _box;

	//type 0 = all, type x = specific
	if (_type == 1 || _type == 0) then
	{
		for "_i" from 0 to (count globalWeaponsList)-1 do
		{
			_weapon = globalWeaponsList select _i;
			_box addweaponcargo [_weapon select 0, _wepcount];
		};
	};

	if (_type == 2 || _type == 0) then
	{
		for "_i" from 0 to (count globalMagazinesList)-1 do
		{
			_magazine = globalMagazinesList select _i;
			_box addmagazinecargo [_magazine select 0, _magcount];
		};
	};

	if (_type == 3 || _type == 0) then
	{
		for "_i" from 0 to (count globalSpecialList)-1 do
		{
			_weapon = globalSpecialList select _i;
			_box addweaponcargo [_weapon select 0, _specialcount];
		};
	};

	if (_type == 4 || _type == 0) then
	{
		for "_i" from 0 to (count globalLaunchersList)-1 do
		{
			_weapon = globalLaunchersList select _i;
			_box addweaponcargo [_weapon select 0, _wepcount];
		};
	};

	if (_type == 5 || _type == 0) then
	{
		for "_i" from 0 to (count globalPistolsList)-1 do
		{
			_weapon = globalPistolsList select _i;
			_box addweaponcargo [_weapon select 0, _wepcount];
		};
	};

	if (_type == 6 || _type == 0) then
	{
		for "_i" from 0 to (count globalPistolMagsList)-1 do
		{
			_magazine = globalPistolMagsList select _i;
			_box addmagazinecargo [_magazine select 0, _magcount];
		};
	};

	if (_type == 7 || _type == 0) then
	{
		for "_i" from 0 to (count globalLauncherMagsList)-1 do
		{
			_magazine = globalLauncherMagsList select _i;
			_box addmagazinecargo [_magazine select 0, _magcount];
		};
	};
	
	sleep 600;
};