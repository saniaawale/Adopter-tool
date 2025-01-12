if (!instance_exists(obj_dataCarrier)) {
	instance_create_depth(0,0,0,obj_dataCarrier)
	
}



if (instance_exists(obj_dataCarrier)) {
obj_dataCarrier.mana = mana
obj_dataCarrier.p_health = p_health;
obj_dataCarrier.targetEnter = targetEnter;
obj_dataCarrier.gems = gems;
obj_dataCarrier.gems_collected = gems_collected
}