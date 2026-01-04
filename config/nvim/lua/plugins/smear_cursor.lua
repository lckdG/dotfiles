return {
    "sphamba/smear-cursor.nvim",
    opts = {
        smear_between_buffers = false,
        smear_insert_mode = true,

        stiffness = 0.9,
        damping = 0.95,
        trailing_stiffness = 0.6,

        stiffness_insert_mode = 0.8,
        damping_insert_mode = 0.95,
        trailing_insert_mode = 0.6,

        matrix_pixel_threshold = 0.5,
        distance_stop_animating = 0.25,
        time_interval = 7,
    }
}
