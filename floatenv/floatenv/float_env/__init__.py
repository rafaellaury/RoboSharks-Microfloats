from gym.envs.registration import register

register(
    id = 'float-v0',
    entry_point='float_env.envs:FloatEnv',
    kwargs= {'scale': 1, 'random_start': True}
)