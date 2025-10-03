% wrapper function for projectile_traj
function fun = projectile_target_traj(x)
    fun = projectile_traj(x(1), x(2)) - target_traj(x(2));
end