//[] execVM "buildList.sqf";

_wepnamelist = [];
_weaponsList = [];

_cfgweapons = configFile >> "cfgWeapons";
for "_i" from 0 to (count _cfgweapons)-1 do
{
	_weapon = _cfgweapons select _i;
	if (isClass _weapon) then
	{
		_wCName = configName(_weapon);
		_wDName = getText(configFile >> "cfgWeapons" >> _wCName >> "displayName");
		_wModel = getText(configFile >> "cfgWeapons" >> _wCName >> "model");
		_wType = getNumber(configFile >> "cfgWeapons" >> _wCName >> "type");
		_wscope = getNumber(configFile >> "cfgWeapons" >> _wCName >> "scope");
		_wPic =  getText(configFile >> "cfgWeapons" >> _wCName >> "picture");
		_wDesc = getText(configFile >> "cfgWeapons" >> _wCName >> "Library" >> "libTextDesc");	

		_isFake = false;
		_wHits=0;
		_mags=[];
		_muzzles = getArray(configfile >> "cfgWeapons" >> _wCName >> "muzzles");
		if ((_muzzles select 0)=="this") then
		{
			_muzzles=[_wCName];
			_mags = getArray(configfile >> "cfgWeapons" >> _wCName >> "magazines");
		}
		else
		{
			{
				_muzzle=_x;
				_mags = getArray(configfile >> "cfgWeapons" >> _wCName >> _muzzle >> "magazines");
			}
			forEach _muzzles;
		};
		
		{
			_ammo = getText(configfile >> "cfgMagazines" >> _x >> "ammo");
			_hit = getNumber(configfile >> "cfgAmmo" >> _ammo >> "hit");
			_wHits = _wHits + _hit;
		}
		forEach _mags;

		if ((_wCName!="") && (_wDName!="") && (_wModel!="") && (_wPic!="")) then
		{
			if !(_wDName in _wepnamelist) then
			{
				_weaponsList = _weaponsList + [[_wCName,_wDName,_wPic,_wDesc]];
				_wepnamelist = _wepnamelist + [_wDName];
			};
		};
	};
};

_magnamelist = [];
_magazinesList = [];

_cfgmagazines = configFile >> "cfgmagazines";

for "_i" from 0 to (count _cfgmagazines)-1 do
{
	_magazine = _cfgmagazines select _i;
	if (isClass _magazine) then
	{
		_mCName = configName(_magazine);
		_mDName = getText(configFile >> "cfgmagazines" >> _mCName >> "displayName");
		_mModel = getText(configFile >> "cfgmagazines" >> _mCName >> "model");
		_mType = getNumber(configFile >> "cfgmagazines" >> _mCName >> "type");
		_mscope = getNumber(configFile >> "cfgmagazines" >> _mCName >> "scope");
		_mPic =  getText(configFile >> "cfgmagazines" >> _mCName >> "picture");
		_mDesc = getText(configFile >> "cfgmagazines" >> _mCName >> "Library" >> "libTextDesc");	

		if ((_mCName!="") && (_mDName!="") && (_mModel!="")) then
		{
			if !(_mDName in _magnamelist) then
			{
				_magazinesList = _magazinesList + [[_mCName,_mDName,_mPic,_mDesc]];
				_magnamelist = _magnamelist + [_mDName];
			};
		};
	};
};


diag_log format ["### <COURIER MISSION> ###"];

diag_log format ["### <wep>"];
for "_i" from 0 to (count _weaponsList)-1 do
{
	_weapon = _weaponsList select _i;
	_name = _wepnamelist select _i;
	diag_log format ["%1, %2", _weapon select 0, _name];
};
diag_log format ["### </wep>"];

diag_log format ["### <mag>"];
for "_i" from 0 to (count _magazinesList)-1 do
{
	_magazine = _magazinesList select _i;
	_name = _magnamelist select _i;
	diag_log format ["%1, %2", _magazine select 0, _name];
};
diag_log format ["### </mag>"];

diag_log format ["### </COURIER MISSION> ###"];

hint "Finished building list.";