_pos = _this select 0;

_pos set [2, 0.5];

_trg = createTrigger["EmptyDetector", _pos]; 
_trg setTriggerArea [1.5 ,1.5 ,3 , false];
_trg setTriggerActivation ["ANY", "PRESENT", False];
_trg setTriggerTimeout [0, 0, 0, false];

waitUntil {triggeractivated _trg};

_bomb = 'R_OG9_HE' createVehicle (_pos);