FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive

# Register the server's public key
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null

# Add the server to the list of repositories
RUN echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
    sudo tee /etc/apt/sources.list.d/librealsense.list
RUN sudo apt-get update

# RUN sudo apt-cache showpkg librealsense2 | grep 2.54.1

# Install the libraries
RUN sudo apt-get install -y librealsense2=2.54.1-0~realsense.9591 \
    librealsense2-gl=2.54.1-0~realsense.9591 \
    librealsense2-utils=2.54.1-0~realsense.9591 \
    librealsense2-dbg=2.54.1-0~realsense.9591 \
    librealsense2-dev=2.54.1-0~realsense.9591

# Create a ROS2 workspace
WORKDIR /root/ros2_ws/src

# Clone the ROS2 RealSense wrapper repository
RUN git clone https://github.com/IntelRealSense/realsense-ros.git -b 4.54.1
WORKDIR /root/ros2_ws

# Install the dependencies
RUN sudo apt-get install -y python3-rosdep
RUN sudo rosdep init || true 
RUN rosdep update
RUN rosdep install -i --from-path src --rosdistro $ROS_DISTRO --skip-keys=librealsense2 -y

# Build
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build

# Source environment
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /root/ros2_ws/install/local_setup.bash" >> ~/.bashrc 

# Clean up
RUN sudo rm -rf /var/lib/apt/lists/*
WORKDIR /
CMD ["bash"]