FROM osrf/ros:noetic-desktop

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y curl

# Register the server's public key
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null

# Add the server to the list of repositories
RUN echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
    sudo tee /etc/apt/sources.list.d/librealsense.list
RUN sudo apt-get update

# RUN sudo apt-cache showpkg librealsense2 | grep 2.50.0

# Install the libraries
RUN sudo apt-get install -y librealsense2=2.50.0-0~realsense0.6128 \
    librealsense2-gl=2.50.0-0~realsense0.6128 \
    librealsense2-utils=2.50.0-0~realsense0.6128 \
    librealsense2-net=2.50.0-0~realsense0.6128 \
    librealsense2-dbg=2.50.0-0~realsense0.6128 \
    librealsense2-dev=2.50.0-0~realsense0.6128

# Install ROS package
RUN sudo apt-get install -y ros-$ROS_DISTRO-realsense2-camera

# Source environment
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

# Clean up
RUN sudo rm -rf /var/lib/apt/lists/*
WORKDIR /
CMD ["bash"]