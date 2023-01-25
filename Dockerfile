# BASE
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Ubuntu packages
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		python3 \
		python3-pip \
		xvfb \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Install pip
RUN python3 -m pip install --upgrade pip

# Install Jupyter pre-requisites

# Install Jupyter notebook
COPY requirements_jn.txt /tmp/
RUN python3 -m pip install -r /tmp/requirements_jn.txt

# Install Gymnasium

# Add directory
RUN mkdir /ds

# Enable jupyter widgets
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

ENV DEBIAN_FRONTEND teletype

# Jupyter notebook with virtual frame buffer for rendering
CMD cd /ds \
    && xvfb-run -s "-screen 0 1400x900x24" \
    /usr/local/bin/jupyter notebook \
    --port=8888 --ip=0.0.0.0 --allow-root
