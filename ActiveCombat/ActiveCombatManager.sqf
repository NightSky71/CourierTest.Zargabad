/*
	ActiveCombatManager.sqf
	
	Manages the combat between the Blufor and Opfor to create a realistic environment
	The systems runs on a ticket based system where the manager tries to maintain the fight
*/

/*
	Compile Functions
*/

_spawnSquad = compile preprocessFile "ActiveCombat\spawnSquad.sqf";
_spawnVehicle = compile preprocessFile "ActiveCombat\spawnVehicle.sqf";

/*
	Blu Variables
*/
_BluTickets = 40;
_BluSpawnMarkerTotal = 6;
_BluSpawnMarkerPrefix = "Blu_";

_BluSoldiers = ["US_Soldier_MG_EP1", "US_Soldier_B_EP1", "US_Soldier_B_EP1", "US_Soldier_B_EP1", 
	"US_Soldier_Engineer_EP1", "US_Soldier_Marksman_EP1", "US_Soldier_AT_EP1", "US_Soldier_AA_EP1"];
	
_BluCrew = "US_Soldier_Crew_EP1";
_BluVehicles = ["M1A1_US_DES_EP1","M2A2_EP1","HMMWV_MK19_DES_EP1","HMMWV_Avenger_DES_EP1", "M1133_MEV_EP1"];

/* 
	Red Variables
*/
_RedTickets = 50;
_RedSpawnMarkerTotal = 6;
_RedSpawnMarkerPrefix = "Red_";

_RedSoldiers = ["TK_Soldier_MG_EP1", "TK_Soldier_B_EP1", "TK_Soldier_B_EP1", "TK_Soldier_B_EP1", 
	"TK_Soldier_Engineer_EP1", "TK_Soldier_SL_EP1", "TK_Soldier_AT_EP1", "TK_Soldier_LAT_EP1"];
	
_RedCrew = "TK_Soldier_Crew_EP1";
_RedVehicles = ["T72_TK_EP1","BMP2_TK_EP1","ZSU_TK_EP1","T55_TK_EP1", "M113_TK_EP1", "UAZ_MG_TK_EP1"];


/*
	Common Variables
*/
_InfantryRatio = 0.0;
_InfantrySquadSize = 10;


sleep 120;


while{true} do {

	// Check if blue side is below that ticket threshold
	_countWest = {(side _x) == west} count allUnits;
	
	if(_countWest < _BluTickets) then {
		_rNumber = random 1;
		
		_randomNum = (floor random _BluSpawnMarkerTotal) + 1;
		_spawnLocation = _BluSpawnMarkerPrefix + str(_randomNum);
		
		if(_rNumber < _InfantryRatio) then {
			// Spawn Squad
			[_BluSoldiers, _spawnLocation, WEST, _InfantrySquadSize] spawn _spawnSquad;
		}
		else {
			// Spawn Vehicle
			_unit = _BluVehicles select floor random count _BluVehicles;
			[_unit, _BluCrew, _spawnLocation, WEST] spawn _spawnVehicle;
		};
	};

	// Check if red side is below that ticket threshold
	_countEast = {(side _x) == east} count allUnits;
	
	if(_countEast < _RedTickets) then {
		_rNumber = random 1;
		
		_randomNum = (floor random _RedSpawnMarkerTotal) + 1;
		_spawnLocation = _RedSpawnMarkerPrefix + str(_randomNum);
		
		if(_rNumber < _InfantryRatio) then {
			// Spawn Squad
			[_RedSoldiers, _spawnLocation, EAST, _InfantrySquadSize] spawn _spawnSquad;
		}
		else {
			// Spawn Vehicle
			_unit = _RedVehicles select floor random count _RedVehicles;
			[_unit, _RedCrew, _spawnLocation, East] spawn _spawnVehicle;
		};
	};
	
	//hintSilent format["West Units: %1 \nEast Units %2", _countWest , _countEast];
	
	sleep 2;
};
