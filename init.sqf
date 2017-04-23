enableSaving [false,false];
//[] execVM "buildList.sqf";

// Rewards
// VehicleList: Name | ClassName | Cost | Cargo Size | Max Speed | Texture Address
//				0		1			2		3			4			5
globalVehicleList = [
	["Old Bike","Old_bike_TK_CIV_EP1", 0, 0, 50,"textures\bike.paa"],
	["Old Motorbike", "Old_moto_TK_Civ_EP1", 200, 10, 87,"textures\motorbike.paa"],
	["Lada", "Lada1_TK_CIV_EP1", 750, 15, 98,"textures\lada.paa"],
	["S1203 Van", "S1203_TK_CIV_EP1", 2499, 25, 93,"textures\van.paa"],
	["Toyota Hilux","hilux1_civil_3_open_EP1",3295, 30, 108,"textures\pickup.paa"],
	["Land Rover", "LandRover_CZ_EP1", 4899, 40, 115, "textures\LandRover.paa"],
	["V35","V3S_TK_EP1",6100, 75, 76,"textures\V35.paa"],
	["MTVR","MTVR_DES_EP1",9895, 95, 95, "textures\MTVR.paa"],
	["Bus","Ikarus_TK_CIV_EP1",12385 , 135, 70, "textures\Bus.paa"],
	["Lada (decorated)", "Lada2_TK_CIV_EP1", 69000, 15, 98,"textures\lada2.paa"]
];

CREDITS = 0;
CURRENTVEHICLE = 0;
NEWVEHICLE = 0;
BUYBUTTONPRESSED = false;
[] execVM "rewards\rewardManager.sqf";
[] execVM "Parameters.sqf";

//global variables for re-rolling the current tasks
REROLLTASKS = false;
REROLLTASKSCOOLDOWN = 600;
REROLLTASKSTIMESTAMP = -600;

//global variables for Hailing a Taxi
TAXICOOLDOWN = 600;
TAXITIMESTAMP = -600;


// WeaponsList: ClassName | Name | Size
globalWeaponsList = [
	["M16a4", "M16A4",6],
	["C1987_Famas_f1", "FAMAS F1",6],
	["C1987_Famas_f1_aim", "FAMAS F1 AimPoint",6],
	["C1987_Famas_f1_eot", "FAMAS F1 EoTech",6],
	["C1987_Famas_f1_sd", "FAMAS F1 SD",6],
	["C1987_Famas_f1_aim_sd", "FAMAS F1 AimPoint SD",6],
	["C1987_Famas_f1_eot_sd", "FAMAS F1 EoTech SD",6],
	["C1987_Famas_g2", "FAMAS G2",6],
	["C1987_Famas_g2_aim", "FAMAS G2 AimPoint",6],
	["C1987_Famas_g2_eot", "FAMAS G2 EoTech",6],
	["C1987_Famas_g2_sd", "FAMAS G2 SD",6],
	["C1987_Famas_g2_aim_sd", "FAMAS G2 AimPoint SD",6],
	["C1987_Famas_g2_eot_sd", "FAMAS G2 EoTech SD",6],
	["M16A2", "M16A2",6],
	["M16A2GL", "M16A2 M203",6],
	["m16a4_acg", "M16A4 ACOG",6],
	["M16A4_GL", "M16A4 M203",6],
	["M16A4_ACG_GL", "M16A4 M203 ACOG",6],
	["M24", "M24",6],
	["M40A3", "M40A3",6],
	["M240", "M240",10],
	["Mk_48", "Mk 48 Mod 0",10],
	["M249", "M249 SAW",10],
	["M4A1", "M4A1",6],
	["M4A1_Aim", "M4A1 CCO",6],
	["M4SPR", "Mk12 SPR",6],
	["M4A1_RCO_GL", "M4A1 ACOG GL",6],
	["M4A1_AIM_SD_camo", "M4A1 CCO SD",6],
	["M4A1_HWS_GL_SD_Camo", "M4A1 Holo SD",6],
	["M4A1_HWS_GL", "M4A1 Holo",6],
	["MP5SD", "MP5SD6",4],
	["MP5A5", "MP5A5",4],
	["PK", "PKM",8],
	["Pecheneg", "PKP",10],
	["SVD", "SVD",6],
	["SVD_CAMO", "SVD Camo",6],
	["G36C", "G36 C",6],
	["G36_C_SD_eotech", "G36C-SD",6],
	["G36a", "G36",6],
	["G36K", "G36 K",6],
	["MG36", "MG36",8],
	["AK_47_M", "AKM",6],
	["AK_47_S", "AKS",6],
	["AK_74", "AK-74",6],
	["AK_74_GL", "AK-74 GP-25",6],
	["AK_107_kobra", "AK-107",6],
	["AK_107_GL_kobra", "AK-107 GL",6],
	["AK_107_GL_pso", "AK107 GL PSO",6],
	["AK_107_pso", "AK-107 PSO",6],
	["AKS_74_kobra", "AKS-74 Kobra",6],
	["AKS_74_pso", "AKS-74 PSO",6],
	["AKS_74_U", "AKS-74U",6],
	["AKS_74_UN_kobra", "AKS-74UN Kobra",6],
	["RPK_74", "RPK-74",6],
	["bizon", "Bizon PP-19",4],
	["bizon_silenced", "Bizon PP-19 SD",4],
	["DMR", "DMR",6],
	["ksvk", "KSVK",6],
	["M1014", "M1014",6],
	["m107", "M107",8],
	["Saiga12K", "Saiga 12K",6],
	["VSS_vintorez", "VSS Vintorez",6],
	["MyM16A2", "My M16A2",6],
	["m8_carbine", "M8",6],
	["m8_carbineGL", "M8 + M320",6],
	["m8_compact", "M8 Compact",6],
	["m8_sharpshooter", "M8 Sharpshooter",6],
	["m8_SAW", "M8 Automatic Rifle",6],
	["huntingrifle", "CZ 550",6],
	["BAF_AS50_scoped", "AS50",8],
	["BAF_AS50_TWS", "AS50 TWS",8],
	["BAF_LRR_scoped", "L115A3 LRR",6],
	["BAF_LRR_scoped_W", "L115A2 LRR",6],
	["BAF_L85A2_RIS_Holo", "L85A2 Holo",6],
	["BAF_L85A2_UGL_Holo", "L85A2 Holo GL",6],
	["BAF_L85A2_RIS_SUSAT", "L85A2 SUSAT",6],
	["BAF_L85A2_UGL_SUSAT", "L85A2 SUSAT GL",6],
	["BAF_L85A2_RIS_ACOG", "L85A2 ACOG",6],
	["BAF_L85A2_UGL_ACOG", "L85A2 ACOG GL",6],
	["BAF_L85A2_RIS_CWS", "L85A2 AWS",6],
	["BAF_L86A2_ACOG", "L86A2 LSW",8],
	["BAF_L110A1_Aim", "L110A1",10],
	["BAF_L7A2_GPMG", "L7A2 GPMG",10],
	["M60A4_EP1", "M60E4",10],
	["Mk_48_DES_EP1", "Mk48 Mod 0 (camo)",10],
	["M249_TWS_EP1", "M249 TWS",10],
	["M249_m145_EP1", "M249 M145",10],
	["M24_des_EP1", "M24 desert",6],
	["SVD_des_EP1", "SVD (camo)",6],
	["SVD_NSPU_EP1", "SVD NSPU",6],
	["Sa58P_EP1", "Sa-58P",6],
	["Sa58V_EP1", "Sa-58V",6],
	["Sa58V_RCO_EP1", "Sa-58V ACOG",6],
	["Sa58V_CCO_EP1", "Sa-58V CCO",6],
	["M4A3_CCO_EP1", "M4A3 CCO",6],
	["M4A3_RCO_GL_EP1", "M4A3 ACOG GL",6],
	["AK_74_GL_kobra", "AK-74 GP-25 Kobra",6],
	["AKS_74", "AKS-74",6],
	["AKS_74_NSPU", "AKS-74 NSPU",6],
	["AKS_74_GOSHAWK", "AKS-74 Goshawk",6],
	["FN_FAL", "FN FAL",6],
	["FN_FAL_ANPVS4", "FN FAL AN/PVS-4",6],
	["G36C_camo", "G36C (camo)",6],
	["G36_C_SD_camo", "G36C SD (camo)",6],
	["G36A_camo", "G36A (camo)",6],
	["G36K_camo", "G36K (camo)",6],
	["MG36_camo", "MG36 (camo)",8],
	["M32_EP1", "M32",10],
	["M79_EP1", "M79",8],
	["Mk13_EP1", "Mk13",6],
	["LeeEnfield", "Lee Enfield",6],
	["m107_TWS_EP1", "M107 TWS",8],
	["M110_TWS_EP1", "M110 TWS",8],
	["M110_NVG_EP1", "M110 NV Scope",8],
	["M14_EP1", "M14 AIM",6],
	["m240_scoped_EP1", "M240 M145",10],
	["SCAR_L_CQC", "Mk16 CQC",6],
	["SCAR_L_CQC_Holo", "Mk16 CQC Holo",6],
	["SCAR_L_STD_Mk4CQT", "Mk16 Mk4CQ/T",6],
	["SCAR_L_STD_EGLM_RCO", "Mk16 EGLM ACOG",6],
	["SCAR_L_CQC_EGLM_Holo", "Mk16 EGLM Holo",6],
	["SCAR_L_STD_EGLM_TWS", "Mk16 EGLM TWS",6],
	["SCAR_L_STD_HOLO", "Mk16 Holo",6],
	["SCAR_L_CQC_CCO_SD", "Mk16 CCO SD",6],
	["SCAR_H_CQC_CCO", "Mk17 CCO",6],
	["SCAR_H_CQC_CCO_SD", "Mk17 CCO SD",6],
	["SCAR_H_STD_EGLM_Spect", "Mk17 EGLM RCO",6],
	["SCAR_H_LNG_Sniper", "Mk17 Sniper",6],
	["SCAR_H_LNG_Sniper_SD", "Mk17 Sniper SD",6],
	["SCAR_H_STD_TWS_SD", "Mk17 TWS SD",6],
	["AA12_PMC", "AA-12",8],
	["m8_carbine_pmc", "M8 CQC",6],
	["m8_compact_pmc", "M8 Compact CCO",6],
	["m8_holo_sd", "M8 Holo SD",6],
	["m8_tws_sd", "M8 TWS SD",6],
	["m8_tws", "M8 TWS",6],
	["CZ_750_S1_ACR", "CZ 750",6],
	["Evo_ACR", "CZ SCORPION EVO 3",6],
	["Evo_mrad_ACR", "CZ SCORPION EVO 3 (CCO)",6],
	["evo_sd_ACR", "CZ SCORPION EVO 3 (SD)",6],
	["CZ805_A1_ACR", "CZ 805 BREN A1",6],
	["CZ805_A1_GL_ACR", "CZ 805 BREN A1 G1",6],
	["CZ805_A2_ACR", "CZ 805 BREN A2",6],
	["CZ805_A2_SD_ACR", "CZ 805 BREN A2 (SD)",6],
	["CZ805_B_GL_ACR", "CZ 805 BREN B1 G1",6],
	["UK59_ACR", "UK-59",6]
];

globalMagazinesList = [
	["30Rnd_9x19_MP5SD", "MP5SD Mag.", 1],
	["30Rnd_9x19_MP5", "MP5 Mag.", 1],
	["30Rnd_545x39_AK", "30Rnd. AK", 1],
	["30Rnd_545x39_AKSD", "30Rnd. AK SD", 1],
	["75Rnd_545x39_RPK", "45Rnd. RPK-74", 1],
	["30Rnd_762x39_AK47", "AKM Mag.", 1],
	["20Rnd_556x45_Stanag", "20Rnd. STANAG", 1],
	["30Rnd_556x45_Stanag", "30Rnd. STANAG", 1],
	["30Rnd_556x45_StanagSD", "30Rnd. STANAG SD", 1],
	["30Rnd_556x45_G36", "G36 Mag..", 1],
	["30Rnd_556x45_G36SD", "30rnd G36 SD", 1],
	["200Rnd_556x45_M249", "200Rnd. M249 Belt", 2],
	["100Rnd_556x45_BetaCMag", "MG36 Mag.", 2],
	["5Rnd_762x51_M24", "5Rnd. M24", 1],
	["100Rnd_762x51_M240", "100Rnd. M240", 2],
	["10Rnd_762x54_SVD", "SVD Dragunov Mag.", 1],
	["100Rnd_762x54_PK", "PKM Mag.", 2],
	["60Rnd_762x54_DT", "DT-29 Mag.", 1],
	["64Rnd_9x19_Bizon", "Bizon Mag.", 1],
	["64Rnd_9x19_SD_Bizon", "Bizon SD Mag.", 1],
	["10Rnd_9x39_SP5_VSS", "10Rnd. VSS", 1],
	["20Rnd_9x39_SP5_VSS", "20Rnd. VSS", 1],
	["8Rnd_B_Saiga12_74Slug", "8Rnd. Saiga 12K Slug", 1],
	["8Rnd_B_Beneli_74Slug", "8Rnd. M1014 Slug", 1],
	["5Rnd_127x108_KSVK", "5RND. KSVK", 1],
	["10Rnd_127x99_m107", "10Rnd. M107", 1],
	["HandGrenade", "RGO Frag Grenade", 1],
	["HandGrenade_Stone", "Stone", 1],
	["HandGrenade_West", "M67 Frag Grenade", 1],
	["SmokeShell", "Smoke Grenade", 1],
	["SmokeShellRed", "Smoke Grenade (Red)", 1],
	["SmokeShellGreen", "Smoke Grenade (Green)", 1],
	["SmokeShellYellow", "Smoke Grenade (Yellow)", 1],
	["SmokeShellPurple", "Smoke Grenade (Purple)", 1],
	["SmokeShellBlue", "Smoke Grenade (Blue)", 1],
	["SmokeShellOrange", "Smoke Grenade (Orange)", 1],
	["Laserbatteries", "Laser Marker Battery", 1],
	["20Rnd_762x51_DMR", "DMR mag", 1],
	["5x_22_LR_17_HMR", "CZ 550 Magazine", 1],
	["5Rnd_127x99_as50", "5Rnd. 12.7x99 mm NATO", 1],
	["5Rnd_86x70_L115A1", "5Rnd. .338 Lapua Magnum", 1],
	["200Rnd_556x45_L110A1", "200Rnd. STANAG", 2],
	["BAF_L109A1_HE", "L109A2 Frag", 1],
	["20Rnd_762x51_B_SCAR", "Mk17 Mag.", 1],
	["20Rnd_762x51_SB_SCAR", "Mk17 SD Mag.", 1],
	["30Rnd_762x39_SA58", "SA58 Mag.", 1],
	["100Rnd_556x45_M249", "M249 Mag.", 2],
	["IR_Strobe_Target", "IR Target Strobe", 1],
	["IR_Strobe_Marker", "IR Marker Strobe", 1],
	["6Rnd_HE_M203", "6x40mm HE gnds", 2],
	["20Rnd_762x51_FNFAL", "FN FAL Mag.", 1],
	["10x_303", "Lee Enfield Mag.", 1],
	["8Rnd_B_Saiga12_Pellets", "8Rnd. Saiga 12K Pellets", 1],
	["8Rnd_B_Beneli_Pellets", "8Rnd. M1014 Pellets", 1],
	["20Rnd_B_AA12_Pellets", "20Rnd. AA12 Pellets", 1],
	["20Rnd_B_AA12_74Slug", "20Rnd. AA12 Slug", 1],
	["20Rnd_B_AA12_HE", "20Rnd. AA12 HE", 1],
	["10Rnd_762x51_CZ750", "CZ750 mag.", 1],
	["20Rnd_9x19_EVOSD", "EVO III SD mag.", 1],
	["20Rnd_9x19_EVO", "EVO III mag.", 1]
];

globalSpecialList = [
	["Binocular", "Binoculars",1],
	["Laserdesignator", "Laser Marker",1],
	["NVGoggles", "NV Goggles",1],
	["Kostey_photos", "Kostey's photos",1],
	["Kostey_map_case", "Kostey's map case",1],
	["Kostey_notebook", "Kostey's notebook",1],
	["CDF_dogtags", "CDF dogtags",1],
	["Moscow_Bombing_File", "Moscow Bombing File",1],
	["Cobalt_File", "Cobalt File",1],
	["ItemWatch", "Watch",1],
	["ItemCompass", "Compass",1],
	["ItemGPS", "GPS",1],
	["ItemRadio", "Radio",1],
	["ItemMap", "Map",1],
	["EvPhoto", "Evidence (Photos)",1],
	["EvMap", "Evidence (Map)",1],
	["EvMoscow", "Evidence (File1)",1],
	["EvKobalt", "Evidence (File2)",1],
	["EvMoney", "Evidence (Money)",1],
	["EvDogTags", "Evidence (Dog tags)",1],
	["Binocular_Vector", "Rangefinder",1],
	["LRTV_ACR", "Target locator",1]
];

globalLaunchersList = [
	["M136", "M136 Launcher",12],
	["Javelin", "FGM-148 Javelin",14],
	["Stinger", "FIM-92F Stinger",12],
	["RPG7V", "RPG-7V",10],
	["Strela", "Strela-2 9K32",12],
	["Igla", "Igla 9K38",12],
	["MetisLauncher", "Metis AT-13",12],
	["RPG18", "RPG18",10],
	["SMAW", "SMAW",12],
	["M47Launcher_EP1", "M47 Dragon",14],
	["MAAWS", "MAAWS",12],
	["BAF_NLAW_Launcher", "NLAW",12]
];

globalLauncherMagsList = [
	["M136", "M136", 6],
	["Javelin", "Javelin", 6],
	["AT13", "Metis-M 9K115-2", 6],
	["PG7V", "PG-7V", 2],
	["PG7VL", "PG-7VL", 2],
	["PG7VR", "PG-7VR", 3],
	["OG7", "OG-7(HE)", 2],
	["PG9_AT", "PG-9N(AT)", 3],
	["OG9_HE", "OG-9V(HE)", 3],
	["Stinger", "FIM-92F Stinger", 6],
	["Strela", "9K32 Strela", 6],
	["RPG18", "RPG18 Rocket", 6],
	["SMAW_HEDP", "SMAW-HEDP", 2],
	["SMAW_HEAA", "SMAW-HEAA", 2],
	["Igla", "Igla 9K38", 6],
	["TimeBomb", "Time bomb", 2],
	["Mine", "Mine", 2],
	["PipeBomb", "Satchel Charges", 2],
	["Dragon_EP1", "M47 missile", 6],
	["PMC_ied_v1", "IED", 2],
	["PMC_ied_v2", "IED 2", 2],
	["PMC_ied_v3", "IED 3", 2],
	["PMC_ied_v4", "IED 4", 2],
	["MAAWS_HEDP", "MAAWS HEDP rocket", 3],
	["MAAWS_HEAT", "MAAWS HEAT rocket", 3],
	["NLAW", "NLAW Rocket", 3],
	["BAF_ied_v1", "IED (garbage)", 2],
	["BAF_ied_v2", "IED (garbage large)", 2],
	["BAF_ied_v3", "IED (ground)", 2],
	["BAF_ied_v4", "IED (ground large)", 2]
];

globalPistolsList = [
	["CZ_75_P_07_DUTY", "CZ 75 DUTY",3],
	["CZ_75_D_COMPACT", "CZ 75 COMPACT",3],
	["CZ_75_SP_01_PHANTOM", "CZ 75 PHANTOM",3],
	["CZ_75_SP_01_PHANTOM_SD", "CZ 75 PHANTOM (SD)",3],
	["Sa61_EP1", "Sa-61",3],
	["UZI_EP1", "PDW",4],
	["UZI_SD_EP1", "PDW SD",4],
	["revolver_EP1", "Revolver",4],
	["revolver_gold_EP1", "Revolver gold",4],
	["glock17_EP1", "G17",3],
	["M9", "M9",3],
	["M9SD", "M9 SD",3],
	["Makarov", "Makarov PM",3],
	["MakarovSD", "Makarov SD",3],
	["Colt1911", "M1911",3]
];

globalPistolMagsList = [
	["7Rnd_45ACP_1911", "M1911 Mag.",1],
	["8Rnd_9x18_Makarov", "Makarov Mag.",1],
	["8Rnd_9x18_MakarovSD", "MakarovSD Mag.",1],
	["15Rnd_9x19_M9", "M9 Mag.",1],
	["15Rnd_9x19_M9SD", "M9SD Mag.",1],
	["1Rnd_HE_M203", "M203 HE",1],
	["FlareWhite_M203", "M203 Flare White",1],
	["FlareGreen_M203", "M203 Flare Green",1],
	["FlareRed_M203", "M203 Flare Red",1],
	["FlareYellow_M203", "M203 Flare Yellow",1],
	["1Rnd_Smoke_M203", "M203 Smoke",1],
	["1Rnd_SmokeRed_M203", "M203 Smoke Red",1],
	["1Rnd_SmokeGreen_M203", "M203 Smoke Green",1],
	["1Rnd_SmokeYellow_M203", "M203 Smoke Yellow",1],
	["1Rnd_HE_GP25", "GP-25 HE",1],
	["FlareWhite_GP25", "GP-25 Flare White",1],
	["FlareGreen_GP25", "GP-25 Flare Green",1],
	["FlareRed_GP25", "GP-25 Flare Red",1],
	["FlareYellow_GP25", "GP-25 Flare Yellow",1],
	["1Rnd_SMOKE_GP25", "GP-25 Smoke",1],
	["1Rnd_SmokeRed_GP25", "GP-25 Smoke Red",1],
	["1Rnd_SmokeGreen_GP25", "GP-25 Smoke Green",1],
	["1Rnd_SmokeYellow_GP25", "GP-25 Smoke Yellow",1],
	["10Rnd_B_765x17_Ball", "10Rnd. Sa-61 Mag.",1],
	["20Rnd_B_765x17_Ball", "20Rnd. Sa-61 Mag.",1],
	["30Rnd_9x19_UZI_SD", "PDW SD Mag.",1],
	["30Rnd_9x19_UZI", "PDW Mag.",1],
	["6Rnd_45ACP", ".45 ACP",1],
	["17Rnd_9x19_glock17", "G17 Mag.",1],
	["10Rnd_9x19_Compact", "Compact mag.",1],
	["18Rnd_9x19_Phantom", "Phantom mag.",1],
	["18Rnd_9x19_PhantomSD", "Phantom SD mag.",1]
];


// BuildingList: Building | Distance | No. Waypoints
globalBuildingList = [];

//middle of the base
BASEPOS = [3950,2750];

//get all buildings in a 60km radius
_allBuildings = nearestObjects [BASEPOS, ["house"], 60000];
{
	_building = _x;
	_bldPos = getPos _building;
	_dist = BASEPOS distance _bldPos;
	
	//ignore stuff that's very close
	if (_dist > 250) then
	{
		//look at the second AI waypoint
		_testLoc = _building buildingPos 1;
		
		//ignore the building if it has less than 2 waypoints
		if (_testLoc select 0 != 0 && _testLoc select 1 != 0 && _testLoc select 2 != 0) then
		{
			//count the number of waypoints in the building
			_i = 0;
			_testLoc = _building buildingPos 0;
			while {_testLoc select 0 != 0 && _testLoc select 1 != 0 && _testLoc select 2 != 0} do
			{
				_i = _i + 1;
				_testLoc = _building buildingPos _i;
			};
			
			//store the building in the global array
			globalBuildingList = globalBuildingList + [[_building, _dist, _i]];
		};
	};
}
foreach _allBuildings;

//run the task handler for each player
fnc_newMission = compile preprocessFile "tasks\newTask.sqf";
_nul = [player] execVM "tasks\taskHandler.sqf";

_nul = [] execVM "timeAcc.sqf";

if (isServer) then
{
	// Variable to change the average distance between mines in a minefield
	MINEDIST = 10;
	
	[10] execVM "environment\createMinefields.sqf";
	
	[6] execVM "environment\createAgents.sqf";
	
	// Active Combat
	[] execVM "ActiveCombat\ActiveCombatManager.sqf";
};