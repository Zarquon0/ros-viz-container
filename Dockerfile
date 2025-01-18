# Source bas image, which includes ROS base packages
FROM ros:humble-ros-base-jammy

# Set up user home directory
# User name can be replaced during build with --build-arg CONT_USER=<desired_name>
ARG CONT_USER
ARG USER_UID
RUN useradd -m -u ${USER_UID} -G sudo ${CONT_USER}
WORKDIR /home/${CONT_USER}
USER root

# Add ROS desktop packages
RUN apt update -y && apt upgrade -y
RUN apt install -y software-properties-common
RUN add-apt-repository universe
RUN apt update
RUN apt install -y ros-humble-desktop

# Add VNC + desktop environment for VNC (openbox)
# Requires xstartup file, which specifies what the VNC server should run on startup
RUN apt install -y tigervnc-standalone-server
RUN apt install -y openbox
ENV DISPLAY=:1

# Install Gazebo and bridge
RUN apt install -y \
    ros-humble-ros-gz \
    ros-humble-ros-ign-bridge

# Install additional ros tools
RUN apt install -y ros-humble-teleop-twist-keyboard
#<MORE>

# Enable sudo for user without password
RUN echo "${CONT_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Source startup script and run bash
COPY startup.sh /
RUN chmod +x /startup.sh
USER ${CONT_USER}
ENTRYPOINT [ "/startup.sh" ]
CMD [ "/bin/bash" ]