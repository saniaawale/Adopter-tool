var player = instance_create_layer(100, 300, "Instances", obj_player);


for (var i = 0; i < 3; i++) {
    var enemy = instance_create_layer(200 + i * 150, 200, "Instances", obj_enemy);
    array_push(global.enemies_list, enemy);
}