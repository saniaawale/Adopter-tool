// Ensure this code is identical for obj_player1, obj_player2, and obj_player3

// Check if there are waypoints in the array
if (array_length(waypoints3)> 0) {
    // Get the current waypoint
    var target = waypoints3[0];
    var target_x = target[0];
    var target_y = target[1];

    // Move towards the waypoint
    if (point_distance(x, y, target_x, target_y) > 2) {
        move_towards_point(target_x, target_y, player_speed);
    } else {
        // If close enough to the waypoint, remove it from the array
        array_delete(waypoints3,0, 1);
    }
} else {
    // Stop moving when there are no waypoints
    speed = 0;
}
