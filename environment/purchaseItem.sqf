_unit = _this select 1;
_item = _this select 3;

_unit addWeapon (_item select 0);

hint format ["You bought %1", _item select 1];