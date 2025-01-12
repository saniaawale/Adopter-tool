




if (instance_exists(obj_dataCarrier)) {
	targetEnter = obj_dataCarrier.targetEnter;
	gems = obj_dataCarrier.gems;
	p_health = obj_dataCarrier.p_health
	gems_collected = obj_dataCarrier.gems_collected
	mana = obj_dataCarrier.mana
	
	instance_destroy(obj_dataCarrier);
	
	if (instance_exists(targetEnter)){
		x = targetEnter.x  ;
		y = targetEnter.y  ;
	}
	
	
}