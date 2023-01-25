# BASE
FROM ubuntu:22.04

# Disable dialog boxes temporarily
ENV DEBIAN_FRONTEND noninteractive

# Ubuntu packages
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		python3 \
		python3-pip \
		xvfb \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Update pip
RUN python3 -m pip install --upgrade pip

# Install Jupyter notebook
COPY requirements_jn.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements_jn.txt

# Install Gymnasium
COPY requirements_gymnasium.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements_gymnasium.txt

# Add directory
RUN mkdir /ds

# Enable jupyter widgets
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# reset env flag to maintain scalability
ENV DEBIAN_FRONTEND teletype

# Jupyter notebook with virtual frame buffer for rendering
CMD cd /ds \
    && xvfb-run -s "-screen 0 1400x900x24" \
    /usr/local/bin/jupyter notebook \
    --port=8888 --ip=0.0.0.0 --allow-root
