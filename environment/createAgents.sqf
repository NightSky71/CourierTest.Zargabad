_numAgents = _this select 0;
agentsMen = [];
agentsItems = [];

if (isServer) then
{
	_agentNames = [
		"Adam",
		"Adel",
		"Adib",
		"Adil",
		"Ahmed",
		"Aissa",
		"Ali",
		"Amine",
		"Amir",
		"Anas",
		"Anise",
		"Anouar",
		"Ayoub",
		"Azziz",
		"Bachir",
		"Badr",
		"Baligh",
		"Billal",
		"Bouzid",
		"Chafik",
		"Chahid",
		"Chaker",
		"Chams",
		"Chawki",
		"Chokri",
		"Daoud",
		"Djamel",
		"Djillali",
		"Fadel",
		"Fahim",
		"Fares",
		"Farid",
		"Fathi",
		"Faudel",
		"Faouzi",
		"Ferhat",
		"Fouad",
		"Gibril",
		"Ghani",
		"Habib",
		"Hafid",
		"Hakim",
		"Halim",
		"Hamid",
		"Hani",
		"Hichem",
		"Hilal",
		"Hosni",
		"Ismail",
		"Imed",
		"Jabar",
		"Kamel",
		"Karim",
		"Khaled",
		"Khalil",
		"Larbi",
		"Lotfi",
		"Mabrouk",
		"Mahboub",
		"Mahfoud",
		"Mahmoud",
		"Malik",
		"Marwan",
		"Mehdi",
		"Mohamed",
		"Moktar",
		"Moncef",
		"Mourad",
		"Nabil",
		"Nacer",
		"Nadir",
		"Nadjib",
		"Nassim",
		"Nazim",
		"Nouh",
		"Omar",
		"Othmane",
		"Usama",
		"Rabah",
		"Rachid",
		"Rafik",
		"Rahal",
		"Ramzi",
		"Raouf",
		"Rayan",
		"Redouane",
		"Riad",
		"Rochdi",
		"Sabri",
		"Salah",
		"Salim",
		"Sami",
		"Sedik",
		"Sofiane",
		"Tahar",
		"Taimim",
		"Tarek",
		"Tayeb",
		"Tawfik",
		"Wallid",
		"Wassim",
		"Yacoub",
		"Yazid",
		"Youcef",
		"Younes",
		"Zahid",
		"Zakaria",
		"Zaki",
		"Ziad",
		"Zoheir"
	];


	_building = 0;
	_distance = 0;
	_numPos = 0;

	_remainingSpecials = globalSpecialList;

	for "_i" from 0 to _numAgents - 1 do
	{
		_r = floor random count _remainingSpecials;
		
		agentsItems set [_i, [_remainingSpecials select _r]];
		_remainingSpecials = _remainingSpecials - [_remainingSpecials select _r];
	};

	{
		_r = floor random _numAgents;
		
		agentsItems set [_r, (agentsItems select _r) + [_x]];
	}
	forEach _remainingSpecials;

	for "_i" from 0 to _numAgents - 1 do
	{
		_distance = 0;
		
		while {_distance < 1000} do
		{
		//pick a random building to go to
			_buildingInfo = globalBuildingList select floor random count globalBuildingList;
			_building = _buildingInfo select 0;
			_distance = _buildingInfo select 1;
			_numPos = _buildingInfo select 2;
		};

		//pick a random waypoint in our building
		_location = _building buildingPos floor random _numPos;

		_man = leader ([[0,0], civilian, ["RU_Doctor"]] call BIS_fnc_spawnGroup);
		_man setPos _location;
		_name = _agentNames select floor random count _agentNames;
		
		_manMarker = createMarker [str(random 10), _location];
		_manMarker setMarkerShape "ICON";
		_manMarker setMarkerType "hd_dot";
		_manMarker setMarkerText _name;
		
		agentsMen set [_i, [_man, _name]];
	};
	
	sleep 1;
	
	publicVariable "agentsMen";
	publicVariable "agentsItems";
}
else
{
	sleep 3;
};

for "_i" from 0 to _numAgents - 1 do
{
	_man = (agentsMen select _i) select 0;
	_name = (agentsMen select _i) select 1;
	_noteString = "";
	
	{
		_itemName = _x select 1;
		
		_man addAction [format ["Purchase %1", _itemName], "environment\purchaseItem.sqf", _x];
		if (_noteString != "") then {_noteString = _noteString + "<br/>";};
		_noteString = _noteString +  _itemName;
	}
	forEach (agentsItems select _i);
	
	player createDiaryRecord ["Diary", [_name, _noteString]];
};
