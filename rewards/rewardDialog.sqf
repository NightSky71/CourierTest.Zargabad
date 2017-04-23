
// Create and display menu
REWARD_IDD_Dialog = 389;

REWARD_IDC_VehicleDescription = 1001;
REWARD_IDC_Picture = 1002;
REWARD_IDC_Credits = 1003;

REWARD_IDC_VehicleList = 901;

REWARD_IDC_ReRollDescription = 1101;
REWARD_IDC_ReRollButton = 1102;

REWARD_IDC_TaxiDescription = 1103;
REWARD_IDC_TaxiButton = 1104;
//-----------------------------------------------------------------------------
// Control functions
//-----------------------------------------------------------------------------

REWARD_FillComboList = 
{
	_idc2 = _this select 0;
	_DualList = _this select 1;

	_control = ((uiNamespace getVariable 'REWARD_display') displayCtrl _idc2);
	
	lbClear _idc2;
	{
	   _Item = _x select 0;
	   _Data = _x select 2;
	   _index = lbAdd [_idc2, _Item];
	   lbSetData [_idc2, _index, _Data];
	} forEach _DualList;

	lbSetCurSel [_idc2, 0];
};

//-----------------------------------------------------------------------------
// Button and List functions
//-----------------------------------------------------------------------------

REWARD_changeVehicleDescription =
{
	_selection = _this select 0; 
	_selectedIndex = _selection select 1; 
	_selectedVehicle = globalVehicleList select _selectedIndex;
	
	_displayString = format["%1\n\nCost: %2\nCargo Size: %3\nMax Speed: %4 km/h",
						_selectedVehicle select 0,
						_selectedVehicle select 2, 
						_selectedVehicle select 3,
						_selectedVehicle select 4
	];
	
	ctrlSetText [REWARD_IDC_VehicleDescription, _displayString];
	ctrlSetText [REWARD_IDC_Picture, (_selectedVehicle select 5)];
};

REWARD_BuyButton = 
{
	_selectedIndex = lbCurSel REWARD_IDC_VehicleList;
	_selectedVehicleCost = (globalVehicleList select _selectedIndex) select 2;
	
	// There needs to be an extra check to make sure the player is within 100m of the base
	_distance = player distance getMarkerPos "Base";
	if( _distance < 100) then {
		if(CREDITS >= _selectedVehicleCost) then {
			NEWVEHICLE = _selectedIndex;
			BUYBUTTONPRESSED = true;
		} else {
			hint format["You cannot afford a %1", (globalVehicleList select _selectedIndex) select 0];
		};
	} else {
		hint "Player is too far from the base";
	};
	
};

REWARD_ExitButton = 
{
	closeDialog 0;
};

REWARD_ReRollButton = 
{
	if(time > REROLLTASKSTIMESTAMP + REROLLTASKSCOOLDOWN) then {
		REROLLTASKS = true;
		REROLLTASKSTIMESTAMP = time;
		hint "Current Tasks Have Been Rerolled";
	}
};

REWARD_TaxiButton = 
{
	if(time > TAXITIMESTAMP + TAXICOOLDOWN) then {
		[] execVM "rewards\TaxiSpawn.sqf";
		TAXITIMESTAMP = time;
		hint "A Taxi has been hailed";
	}
};

//-----------------------------------------------------------------------------
// Init
//-----------------------------------------------------------------------------
disableSerialization;

_ok = createDialog "REWARD_Dialog";
if !(_ok) exitWith { hint "createDialog failed" };

uiNamespace setVariable ["REWARD_display", findDisplay REWARD_IDD_Dialog];

[REWARD_IDC_VehicleList, globalVehicleList] call REWARD_FillComboList;

while{true} do {
	// Current Credits
	_msg = format["Credits: %1", CREDITS];
	ctrlSetText [REWARD_IDC_Credits, _msg];
	
	// ReRollTasks Button
	if(time > REROLLTASKSTIMESTAMP + REROLLTASKSCOOLDOWN) then {
		ctrlSetText [REWARD_IDC_ReRollButton, "READY"];
	} else {
		_msg = format["%1", floor (REROLLTASKSTIMESTAMP + REROLLTASKSCOOLDOWN - time)];
		ctrlSetText [REWARD_IDC_ReRollButton, _msg];
	};
	
	// Hail Taxi Button
	if(time > TAXITIMESTAMP + TAXICOOLDOWN) then {
		ctrlSetText [REWARD_IDC_TaxiButton, "READY"];
	} else {
		_msg = format["%1", floor (TAXITIMESTAMP + TAXICOOLDOWN - time)];
		ctrlSetText [REWARD_IDC_TaxiButton, _msg];
	};
	
	sleep 0.2;
};

// user selects choice, check whether the user has enough money (SCORE-SPENT > COST)

// spawn unit

// increase spent variable