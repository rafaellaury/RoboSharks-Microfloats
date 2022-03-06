from gym import spaces
import gym
from gym.envs.classic_control import rendering
import numpy as np
import math


class FloatEnv(gym.Env):
    metadata = {'render.modes': ['human']}
    g = 9.81
    water_density = 1025  # kg/m^3
    shell_vol = 0.0088  # m^3, No fluid in bladder
    bladder_max = 0.0002899  # Extra volume in m^3 from fully inflated bladder
    drag_c = 0.85  # drag coefficient
    drag_area = 0.01204  # frontal area
    infl_c = 20.22 * 1e-6 / 60  # change in m^2 / s when inflating
    defl_c = math.sqrt(1.45839 / 0.841) * 3785.412 * 0.021 * 1e-6 / 60  # constant term when deflating bladder
    drag_term = drag_c * drag_area * water_density * 0.5
    mass = 9.17  # Mass in kg
    tau = 1  # Timestep between control outputs
    update_frequency = 1  # How many timesteps between observation
    bladder_steady_state = mass / water_density - shell_vol

    def __init__(self, scale=1, random_start=False):
        """
        Initialize the float environment
        :param scale: int,  maximum depth of the simulator
        :param random_start: boolean, random state if true, preset at surface if false
        :param tf: function, transfer function between motor control signal and plunger position
        """
        super(FloatEnv, self).__init__()
        self.viewer = None
        self.action_space = spaces.Discrete(3)
        self.observation_space = spaces.Box(low=np.array([0.0, -np.inf, -np.inf, -np.inf]),
                                            high=np.array([1.0, np.inf, np.inf, np.inf]))
        self.scale = scale
        self.random_start = random_start
        self.vel = 0
        self.pos = 0
        self.depth_goal = 0
        self.bladder_vol = 0
        self.end_time = 1000.0

    def reset(self):
        """
        Resets the environment and generates a random depth goal
        :return: three element 1D np array with syringe position, distance from depth goal, and velocity
        """
        self.time = 0.0
        if self.random_start:
            self.vel = np.random.uniform(-0.05, 0.05)
            self.pos = np.random.uniform(0.0, 1.0) * self.scale
            self.depth_goal = np.random.uniform(0.0, 1.0) * self.scale
            self.bladder_vol = np.random.uniform(0.0, self.bladder_max)
        else:
            self.vel = 0.0
            self.pos = 0.0
            self.depth_goal = 0.5 * self.scale
            self.bladder_vol = 0.0
        return np.array([self.bladder_vol, self.depth_goal, self.pos, self.vel])

    def step(self, action):
        """
        Observable step by the control program in float
        :param action: float, value from -1 to 1 representing control signal
        :return: state as np array, reward as float, done as boolean, empty dic
        """
        reward = 0
        for steps in range(self.update_frequency):
            reward = reward + self.step_invis(float(action))
        state = np.array([self.bladder_vol, self.depth_goal, self.pos, self.vel])
        done = self.time >= self.end_time
        return state, reward, done, {}

    def step_invis(self, action):
        """
        Function representing changes not sampled by control program on the float
        :param action: float representing control signal
        :return: reward of state multiplied by timestep
        """
        self.bladder_vol = np.clip(self.bladder_vol + self.transfer(action), 0, self.bladder_max)
        volume = self.shell_vol + self.bladder_vol
        grav = self.mass * self.g
        buoyancy = volume * self.water_density * self.g
        drag = self.drag_term * self.vel * abs(self.vel)
        force = grav - buoyancy - drag
        # print(grav, buoyancy + drag, self.vel, self.pos)
        self.vel = self.vel + (force/self.mass) * self.tau / self.update_frequency
        self.pos = self.pos + self.vel * self.tau / self.update_frequency
        if self.pos < 0:
            self.pos = 0
            self.vel = 0
        self.time = self.time + self.tau / self.update_frequency
        return self.reward()

    def reward(self):
        return np.exp(-abs(self.pos - self.depth_goal))

    def transfer(self, action):
        """
        Represents the relationship between motor control signal and change in volume. Can be replaced with
        a better function when it can be determined what the real function looks like. The change in time is multiplied
        by the instantaneous change in volume in cubic meters/min.
        :param action: float representing control signal
        :return: float representing change in volume of float in m^3 over the timestep
        """
        if action == 0:  # pump oil into bladder, reducing downwards acceleration
            return self.infl_c * self.tau / self.update_frequency
        elif action == 1:
            return 0
        else:  # allow water pressure to remove oil from bladder
            return -self.defl_c * np.sqrt(self.pos + 0.1) * self.tau / self.update_frequency

    def set_goal(self, new_goal):
        """
        Set the target depth
        :param new_goal: Numerical value representing target depth
        :return:
        """
        self.depth_goal = new_goal

    def set_end_time(self, length):
        """
        Sets the end time of the episode.
        :param length: length in seconds of episode
        :return:
        """
        self.end_time = length

    def render(self, mode='human', close=False):
        """
        renders the model environment
        :param mode: defines render mode
        :param close:
        :return: renders the scene
        """
        screen_width = 400
        screen_height = 600
        surface = 520
        float_h = max(int(200.0 / self.scale), 20)
        float_w = max(int(75.0 / self.scale), 5)
        line = surface - int(self.depth_goal * 100 / self.scale)

        if self.viewer is None:
            self.viewer = rendering.Viewer(screen_width, screen_height)
            self.water = rendering.FilledPolygon([(0, 0), (0, surface), (screen_width, surface), (screen_width, 0)])
            self.water.set_color(0.8, 0.9, 1.0)
            self.target = rendering.Line((0, line), (screen_width, line))
            self.target.set_color(1.0, 0, 0)
            self.viewer.add_geom(self.water)
            self.viewer.add_geom(self.target)
            l, r, t, b = -float_w / 2, float_w / 2, float_h / 2, -float_h / 2
            float = rendering.FilledPolygon([(l, b), (l, t), (r, t), (r, b)])
            self.ftrans = rendering.Transform()
            float.add_attr(self.ftrans)
            float.set_color(0.5, 0.5, 0.5)
            self.viewer.add_geom(float)

        self.ftrans.set_translation(screen_width/2, surface - float_h/2 - int(self.pos * 100 / self.scale))

        return self.viewer.render(return_rgb_array=mode == 'rgb_array')

    def close(self):
        """
        Close the graphics window
        :return:
        """
        if self.viewer:
            self.viewer.close()