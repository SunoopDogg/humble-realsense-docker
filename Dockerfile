FROM osrf/ros:humble-desktop


ENV DEBIAN_FRONTEND=noninteractive

CMD ["/bin/bash"]

# Register the server's public key
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | tee /etc/apt/keyrings/librealsense.pgp > /dev/null

# Add the server to the list of repositories
RUN echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo focal main" | sudo tee /etc/apt/sources.list.d/librealsense.list
RUN sudo apt-get update

# print console sudo apt-cache search librealsense2
RUN sudo apt-cache showpkg librealsense2

# RUN sudo apt-get install -y librealsense2=2.54.1-0~realsense.9590 \
#     # librealsense2-dkms=1.3.0-0~realsense.a9590 \
#     librealsense2-dev=2.54.1-0~realsense.9590 \
#     librealsense2-dbg=2.54.1-0~realsense.9590 \
#     librealsense2-gl=2.54.1-0~realsense.9590 \
#     # libssl1.1 (>= 1.1.1) but it is not installable
#     # libssl1.1 \
#     librealsense2-utils=2.54.1-0~realsense.9590 \