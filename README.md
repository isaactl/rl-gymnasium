Docker commands to set up container:

docker build -t rl-gymnasium

docker run -dp 8888:8888 rl-gymnasium


To run a shell in the container:

docker exec -it <mycontainer> sh
