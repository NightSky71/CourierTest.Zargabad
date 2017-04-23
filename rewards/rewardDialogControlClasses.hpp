// Desc: The top section contains the standard dialog #define constants, used for 
// controls, styles & fonts. The bottom section contains the standard base dialog 
// control class definitions, from which you can inherit.
//
// Notes: There are many slightly different versions of this file around.
// By: public code taken from various sources: BIS pbo's, tutorials, WIKI & other scripts
// Colors and coeff's referenced from quickmap.hpp, by mi2slow & Vienna.
//
// Version: 0.01 alpha (May 2007, Dr Eyeball)
//-----------------------------------------------------------------------------

// Constants to standardize and help simplify positioning and sizing
#define Dlg_ROWS 36 // determines default text and control height
#define Dlg_COLS 90 // guide for positioning controls

// (Calculate proportion, then /100 to represent as percentage)
#define Dlg_CONTROLHGT ((100/Dlg_ROWS)/100)
#define Dlg_COLWIDTH ((100/Dlg_COLS)/100)

#define Dlg_ROWHGT_MOD 1.0
#define Dlg_TEXTHGT_MOD 1.0
#define Dlg_ROWSPACING 0.01

#define Dlg_ROWHGT (Dlg_CONTROLHGT/Dlg_ROWHGT_MOD)
#define Dlg_TEXTHGT (Dlg_ROWHGT/Dlg_TEXTHGT_MOD)

//-----------------------------------------------------------------------------
// Fonts
#define FontM "TahomaB"
#define FontHTML "TahomaB"
//"CourierNewB64" "TahomaB" "Bitstream" "Zeppelin32"

//-----------------------------------------------------------------------------
// Control Types 
#define CT_STATIC 0 
#define CT_BUTTON 1 
#define CT_EDIT 2 
#define CT_SLIDER 3 
#define CT_COMBO 4 
#define CT_LISTBOX 5 
#define CT_TOOLBOX 6 
#define CT_CHECKBOXES 7 
#define CT_PROGRESS 8 
#define CT_HTML 9 
#define CT_STATIC_SKEW 10 
#define CT_ACTIVETEXT 11 
#define CT_TREE 12 
#define CT_STRUCTURED_TEXT 13 
#define CT_CONTEXT_MENU 14 
#define CT_CONTROLS_GROUP 15 
#define CT_3DSTATIC 20
#define CT_3DACTIVETEXT 21
#define CT_3DLISTBOX 22
#define CT_3DHTML 23
#define CT_3DSLIDER 24
#define CT_3DEDIT 25
#define CT_XKEYDESC 40 
#define CT_XBUTTON 41 
#define CT_XLISTBOX 42 
#define CT_XSLIDER 43 
#define CT_XCOMBO 44 
#define CT_ANIMATED_TEXTURE 45 
#define CT_OBJECT 80 
#define CT_OBJECT_ZOOM 81 
#define CT_OBJECT_CONTAINER 82 
#define CT_OBJECT_CONT_ANIM 83 
#define CT_LINEBREAK 98 
#define CT_USER 99 
#define CT_MAP 100 
#define CT_MAP_MAIN 101 

//-----------------------------------------------------------------------------
// Static styles 
#define ST_POS 0x0F 
#define ST_HPOS 0x03 
#define ST_VPOS 0x0C 

#define ST_LEFT 0x00 
#define ST_RIGHT 0x01 
#define ST_CENTER 0x02 
#define ST_DOWN 0x04 
#define ST_UP 0x08 

#define ST_VCENTER 0x0c 
#define ST_TYPE 0xF0 

#define ST_SINGLE 0 
#define ST_MULTI 16 
#define ST_TITLE_BAR 32 
#define ST_PICTURE 48 
#define ST_FRAME 64 
#define ST_BACKGROUND 80 
#define ST_GROUP_BOX 96 
#define ST_GROUP_BOX2 112 
#define ST_HUD_BACKGROUND 128 
#define ST_TILE_PICTURE 144 
#define ST_WITH_RECT 160 
#define ST_LINE 176 

//-----------------------------------------------------------------------------
// standard base dialog control class definitions
//-----------------------------------------------------------------------------
class RscText
{
 type = CT_STATIC;
 idc = -1;
 style = ST_MULTI;

 colorBackground[] = {Dlg_Color_Gray_5,1};
 colorText[] = {Dlg_Color_White,1};
 font = FontM;

 sizeEx = Dlg_TEXTHGT;
 h = Dlg_CONTROLHGT;
 
 lineSpacing = 1;

 text = "";
};
class RscTextCenter
{
 type = CT_STATIC;
 idc = -1;
 style = ST_CENTER;

 colorBackground[] = {Dlg_Color_Gray_5,1};
 colorText[] = {Dlg_Color_White,1};
 font = FontM;

 sizeEx = 1.5*Dlg_TEXTHGT;
 h = 1.5*Dlg_CONTROLHGT;
 
 lineSpacing = 1;

 text = "";
};
//-------------------------------------
class RscFrame: RscText
{
 style = ST_FRAME;
 x = 0.0;
 y = 0.0;
 w = 1.0;
 h = 1.0;
};
//-------------------------------------
class RscActiveText
{
 type = CT_ACTIVETEXT;
 idc = -1;
 style = ST_LEFT;

 color[] = {Dlg_Color_White,1};
 colorActive[] = {Dlg_Color_Red,1};
 font = FontM;

 sizeEx = Dlg_TEXTHGT;

 soundEnter[] = {"ui\ui_over", 0.2, 1};
 soundPush[] = {, 0.2, 1};
 soundClick[] = {"ui\ui_ok", 0.2, 1};
 soundEscape[] = {"ui\ui_cc", 0.2, 1};
 default = false;
};
//-------------------------------------
class RscButton
{
 type = CT_BUTTON;
 idc = -1;
 style = ST_CENTER;

 colorText[] = {Dlg_Color_White,1};
 colorDisabled[] = {Dlg_Color_Aqua,0.1};
 colorBackground[] = {Dlg_Color_Gray_2,1};
 colorBackgroundActive[] = {Dlg_Color_Yellow,0.4};
 colorBackgroundDisabled[] = {Dlg_Color_Red,0.1};
 colorFocused[] = {Dlg_Color_Black,1};
 colorShadow[] = {Dlg_Color_Pink,0.2};
 colorBorder[] = {Dlg_Color_White,0.2};
 font = FontHTML;

 sizeEx = Dlg_TEXTHGT;

 offsetX = 0;
 offsetY = 0;
 offsetPressedX = 0;
 offsetPressedY = 0;
 borderSize = 0.001;
 soundEnter[] = {"ui\ui_ok", 0.2, 1};

 soundPush[] = {, 0.2, 1};
 soundClick[] = {"ui\ui_ok", 0.2, 1};
 soundEscape[] = {"ui\ui_cc", 0.2, 1};
 default = false;
 text = "";
 action = "";
};
//-------------------------------------
class RscEdit
{
 type = CT_EDIT;
 idc = -1;
 style = ST_LEFT;

 colorText[] = {Dlg_Color_Black,1};
 colorSelection[] = {Dlg_Color_Gray_5,1};
 font = FontHTML;

 sizeEx = Dlg_TEXTHGT;

 autocomplete = false;
 text = "";
};
//-------------------------------------
class RscLB_LIST
{
 // type = defined in derived class
 idc = -1;
 style = ST_LEFT;

 color[] = {Dlg_Color_White,1};
 colorText[] = {Dlg_Color_White,1};
 colorSelect[] = {Dlg_Color_White,1};
 colorSelect2[] = {Dlg_Color_White,1};
 colorScrollbar[] = {Dlg_Color_White,1};
 colorBackground[] = {Dlg_Color_Gray_4,1};
 colorSelectBackground[] = {Dlg_Color_Gray_2,1};
 colorSelectBackground2[] = {Dlg_Color_Gray_4,0.75};
 font = FontHTML;

 sizeEx = Dlg_TEXTHGT;
 h = Dlg_CONTROLHGT;
 rowHeight = Dlg_CONTROLHGT;

 soundSelect[] = {"ui\ui_cc", 0.2, 1}; // unchecked
 soundExpand[] = {"ui\ui_cc", 0.2, 1}; // unchecked
 soundCollapse[] = {"ui\ui_cc", 0.2, 1}; // unchecked
 
 
};
//-------------------------------------
class RscListBox: RscLB_LIST
{
 type = CT_LISTBOX;

 onLBSelChanged = "";
 onLBDblClick = "";
};
//-------------------------------------
class RscCombo: RscLB_LIST
{
 type = CT_COMBO;

 wholeHeight = 0.3;
};

//-------------------------------------
class ScrollBar
{
color[] = {Dlg_Color_White,1};
colorActive[] = {1,1,1,1};
colorDisabled[] = {1,1,1,0.3};
thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
border = "\ca\ui\data\ui_border_scroll_ca.paa";
shadow = 0;
scrollSpeed = 0.06;
width = 0;
height = 0;
autoScrollEnabled = 0;
autoScrollSpeed = -1;
autoScrollDelay = 5;
autoScrollRewind = 0;
};
//-------------------------------------
class MyRscCombo {
		idc = -1;
		type = CT_COMBO;
		style = ST_LEFT;

		x = 0.1;
		y = 0.1;
		w = 0.2;
		h = 0.035;
    
		font = "TahomaB";
		sizeEx = 0.025;
  
		rowHeight = 0.025;
		wholeHeight = 9 * 0.025; // 3 lines to display + 1 line of the unelapsed control
		
		color[] = {Dlg_Color_White,1};
		colorText[] = {Dlg_Color_White,1};
		colorSelect[] = {Dlg_Color_White,1};
		colorSelect2[] = {Dlg_Color_White,1};
		colorBackground[] = {Dlg_Color_Gray_4,1};
		colorSelectBackground[] = {Dlg_Color_Gray_2,1};
		colorSelectBackground2[] = {Dlg_Color_Gray_4,0.75};

		soundSelect[] = {"", 0.0, 1};
		soundExpand[] = {"", 0.0, 1};
		soundCollapse[] = {"", 0.0, 1};
		
		
		maxHistoryDelay = 1.0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;

		colorScrollbar[] = {0.95, 0.95, 0.95, 1};
		period = 1;

		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		
		class ScrollBar : Scrollbar{};
		
	};
	

//-------------------------------------
class RscObject
{
   type = CT_OBJECT;

   scale = 1.0;
   direction[] = {0, 0, 1};
   up[] = {0, 1, 0};
};
//-------------------------------------
class Rsc3DStatic
{
   type = CT_3DSTATIC;
   style = ST_LEFT;

   color[] = {Dlg_Color_Black,1};
   font = FontHTML;

   size = 0.04;

   selection = "display";
   angle = 0;
};
//-------------------------------------
class RscPicture
{
   type = CT_STATIC;
   idc = -1;
   style = ST_PICTURE;

   colorBackground[] = {0, 0, 0, 0};
   colorText[] = {Dlg_Color_White, 1};
   font = Zeppelin32;

   sizeEx = Dlg_TEXTHGT;
 text = "";
};

//=============================================================================
// Some common class definitions - most dialogs need a background
class Dlg_FullBackground: RscText
{
 colorBackground[] = {Dlg_Color_DarkCyan,1};
 x = 0.0;
 y = 0.0;
 w = 1.0;
 h = 1.0;
};
//-------------------------------------
class Dlg_FullBackgroundFrame: RscFrame
{
 text = " Selection Dialog ";
 x = 0.0;
 y = 0.0;
 w = 1.0;
 h = 1.0;
};