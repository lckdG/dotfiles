return {
    "sphamba/smear-cursor.nvim",
    opts = {
        smear_between_buffers = false,
        smear_insert_mode = true,

        stiffness = 0.5,
        damping = 0.95,
        trailing_stiffness = 0.5,

        stiffness_insert_mode = 0.5,
        damping_insert_mode = 0.95,
        trailing_insert_mode = 0.5,

        matrix_pixel_threshold = 0.5,
        distance_stop_animating = 0.25,
        time_interval = 7,
    }
}
