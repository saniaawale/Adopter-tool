

if (array_length(waypoints1)> 0) {
    // Get the current target waypoint
    var target = waypoints1[0];
    var target_x = target[0];
    var target_y = target[1];

    // Check if the player is close to the waypoint
    if (point_distance(x, y, target_x, target_y) > 2) {
        // Move towards the target waypoint
        move_towards_point(target_x, target_y, player_speed);
    } else {
        // Remove the waypoint when reached
        array_delete(waypoints1,0,1)
    }
} else {
    // No waypoints left; stop the player
    speed = 0;
}
