## Docker commands to set up container:
```
docker build -t rl-gymnasium .

docker run -dp 8888:8888 rl-gymnasium
```

To run a shell in the container:

`docker exec -it <mycontainer> sh`

## SAMPLE JUPYTER NOTEBOOK CODE:
```
import gymnasium as gym
from IPython import display
import matplotlib.pyplot as plt
%matplotlib inline

env = gym.make('CartPole-v1', render_mode='rgb_array')

observation, info = env.reset(seed=42)
for _ in range(1000):
    plt.imshow(env.render())
    display.clear_output(wait=True)
    display.display(plt.gcf())
    
    action = env.action_space.sample()
    
    observation, reward, terminated, truncated, info = env.step(action)

    if terminated or truncated:
        observation, info = env.reset()
env.close()
```

## Additional Resources
- [Gymnasium Github](https://github.com/Farama-Foundation/Gymnasium)
- [README formatting](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

## Future Work
- add Kubernetes support for scalability
- add separate container for RL tools
- full example of training and running a prediction model
