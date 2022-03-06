import gym
import time
import numpy as np
# from stable_baselines import A2C

desired_state = np.array([0.4679, 0, 0])
# model = A2C.load("a2c_float")

def sigmoid(value):
    return 1.0 / (1.0 + np.exp(-value))


# def a2c_actor(observation):
#     action, state = model.predict(observation)
#     return action


def pd_actor(observation, weights=np.array([-10.0, -2.5, 20.0])):
    '''
    This is functionally similar to, and technically not a PD controller.
    :param observation: tuple containing syringe, goal, current depth, and velocity
    :param weights: weights for s^2, 1, and s terms in controller
    :return: motor control output
    '''
    plunger, goal_pos, pos, vel = observation
    obs = np.array([plunger, goal_pos - pos, vel])
    thing = weights * (obs - desired_state)
    return np.sum(thing)

if __name__ == "__main__":
    env = gym.make('float_env:floater-v0')
    observation = env.reset()
    action = 0.0
    re = 0.0
    while True:
        obs, reward, done, dic = env.step(action)
        if done:
            break
        re = re + reward
        action = pd_actor(obs)
        env.render()
        time.sleep(0.002)
    print(re)

