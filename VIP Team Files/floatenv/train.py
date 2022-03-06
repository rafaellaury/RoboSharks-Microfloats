from stable_baselines.common.policies import MlpPolicy
from stable_baselines.common import make_vec_env
from stable_baselines import PPO2, A2C
from stable_baselines.common.env_checker import check_env
import gym

env = gym.make('float_env:floater-v0')

model = A2C(MlpPolicy, env, verbose=1)
model.learn(total_timesteps=5000000)
model.save("a2c_float")