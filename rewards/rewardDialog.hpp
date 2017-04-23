// Desc: A respawn selection dialog
// By: Dr Eyeball
// Version: 1.0 (May 2007)
//-----------------------------------------------------------------------------
// SPWN_ is the unique prefix associated with all unique classes for this dialog.

//-----------------------------------------------------------------------------
// IDD's & IDC's
//-----------------------------------------------------------------------------
#define SPWN_IDD_Dialog 389

#define REWARD_IDC_VehicleList 901

#define REWARD_IDC_VehicleDescription 1001
#define REWARD_IDC_Picture 1002
#define REWARD_IDC_Credits 1003

#define REWARD_IDC_ReRollDescription 1101
#define REWARD_IDC_ReRollButton 1102

#define REWARD_IDC_TaxiDescription 1103
#define REWARD_IDC_TaxiButton 1104

onLoad="uiNamespace setVariable ['SPWN_display', _this select 0]";
onUnLoad="uiNamespace setVariable ['SPWN_display', nil]";

//-----------------------------------------------------------------------------
// Personalisation - Custom modifications to the standard control classes
//-----------------------------------------------------------------------------

class REWARD_Button: RscButton
{
 w = 0.075;
 h = Dlg_CONTROLHGT;
};

class REWARD_BaselineButton: REWARD_Button
{
 w = 0.15;
 y = 1.0-Dlg_CONTROLHGT; // last row
};

class REWARD_CaptionText: RscText
{
};

class REWARD_CaptionTextNoBackground : RscText
{
colorBackground[] = {Dlg_Color_Gray_3, 0};
};

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class REWARD_Dialog
{
 idd = REWARD_IDD_Dialog;

 movingEnable = true;
 controlsBackground[] = { REWARD_Background, Vehicle_Frame, Other_Frame };

 class REWARD_Background: Dlg_FullBackground
 {
   colorBackground[] = {Dlg_Color_Gray_3, 0.7};
 };

 class Vehicle_Frame: Dlg_FullBackgroundFrame
 {
   text = " Vehicle Menu ";
   x = 0.01;
   h = 0.62;
   w = 0.98;
 };
 
 class Other_Frame: Dlg_FullBackgroundFrame
 {
   text = " Other Functions Menu ";
   x = 0.01;
   y = 0.64;
   h = 0.31;
   w = 0.98;
 };

 //---------------------------------------------
 objects[] = 
 { 
 };

 controls[] = 
 {
	REWARD_VehicleDescription,
	REWARD_Credits,
	
	REWARD_BuyButton,
	REWARD_ExitButton,

	REWARD_VehicleList,
	
	REWARD_ReRollDescription,
	REWARD_ReRollButton,
	
	REWARD_TaxiDescription,
	REWARD_TaxiButton,

	REWARD_Picture
 };
 //---------------------------------------------
 // captions
 class REWARD_Caption: REWARD_CaptionText
 {
   idc = REWARD_IDC_Credit;
   x = 0.35;
   y = 0.03;
   w = 0.1;
   text = "Reward Selection";
 };
 class REWARD_Credits : RscTextCenter
 {
	idc = REWARD_IDC_Credits;
	x = 0.75;
	y = 0.03;
	w = 0.2;
	text = "0";
 };
 class REWARD_VehicleDescription : REWARD_CaptionText
 {
	idc = REWARD_IDC_VehicleDescription;
	x = 0.02;
	y = 0.1;
	w = 0.4;
	h = 0.45;
	text = "Vehicle Description";
 };
 class REWARD_ReRollDescription : REWARD_CaptionTextNoBackground
 {
	idc = REWARD_IDC_ReRollDescription;
	x = 0.02;
	y = 0.70;
	w = 0.4;
	text = "ReRoll Current Tasks";
 };
 class REWARD_TaxiDescription : REWARD_CaptionTextNoBackground
 {
	idc = REWARD_IDC_TaxiDescription;
	x = 0.02;
	y = 0.75;
	w = 0.4;
	text = "Hail a Taxi";
 };
 //---------------------------------------------
 // Controls
 class REWARD_VehicleList: MyRscCombo
 {
	idc = REWARD_IDC_VehicleList;
	x = 0.02;
	y = 0.035;
	w = 0.51;
	//h = 0.90;
	
	onLBSelChanged = "[_this] call REWARD_changeVehicleDescription";
 };
 //---------------------------------------------
 // Pictures
 class REWARD_Picture: RscPicture
 {
	idc = REWARD_IDC_Picture
	x = 0.45;
	y = 0.1;
	w = 0.5;
	h = 0.5;
	text = "textures\Bike.paa";
 };
 
 //---------------------------------------------
 // Buttons
 class REWARD_BuyButton: REWARD_Button
 {
     idc = REWARD_IDC_BuyButton;
     x = 0.34;
	 y = 0.57;
     text = "Buy";
     action = "[] call REWARD_BuyButton";
 };
 class REWARD_ExitButton: REWARD_Button
 {
     idc = REWARD_IDC_ExitButton;
     x = 0.91;
	 y = 0.96;
     text = "Exit";
     action = "[] call REWARD_ExitButton";
 };
 class REWARD_ReRollButton: REWARD_Button
 {
     idc = REWARD_IDC_ReRollButton;
     x = 0.2;
	 y = 0.70;
     text = "Re Roll";
     action = "[] call REWARD_ReRollButton";
 };
 class REWARD_TaxiButton: REWARD_Button
 {
     idc = REWARD_IDC_TaxiButton;
     x = 0.2;
	 y = 0.75;
     text = "OK";
     action = "[] call REWARD_TaxiButton";
 };
 //---------------------------------------------
};