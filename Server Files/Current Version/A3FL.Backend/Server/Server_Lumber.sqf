/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

["Server_Lumber_TreeRespawn",
{
	private _treeCount = count(nearestObjects [(getMarkerPos "LumberJack_Rectangle"), ["Land_A3PL_Tree3"],190]);
	for "_i" from 1 to (50 - _treeCount) do {
		private _randPos = ["LumberJack_Rectangle"] call CBA_fnc_randPosArea;
		private _tree = createVehicle ["Land_A3PL_Tree3", _randPos, [], 0, "CAN_COLLIDE"];
		_tree setDir (random 360);
	};
},true] call Server_Setup_Compile;