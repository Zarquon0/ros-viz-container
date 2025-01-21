# ros-viz-container
## About
This repository contains files that can be used to build and run an Ubuntu container optimized for ROS development, visualization, and simulation. Once built, the container will have ROS (humble) desktop, ignition gazebo, and the ROS-gazebo bridge installed (other desired tools may be added to the Dockerfile). GUI applications (such as gazebo) can be visualized over a TigerVNC server. Additionally, the created workspace in the container mounts a local directory, meaning all files created within the container are automatically saved on the container's host (this also makes it easier to use GitHub with such files, as this may be done without setting up git within the container).
## Usage
Steps for setup:
1.  Run `git clone git@github.com:Zarquon0/ros-viz-container.git && cd ros-viz-container`
2.  Check that docker and docker-compose are up to date on your system (`docker --version` and `docker-compose --version` - 27.4.1 and 2.32.4 respectively are up to date as of this writing)
3.  If on Mac or Linux, run `export USER=$(whoami) && export UID=$(id -u)`. This just sets a couple of environment variables used in the build process. NOTE: will not work on Windows; Windows users will need to perform the equivalent commands for their respective shell.
4.  Run `docker-compose build` to build the container. If this fails on the `FROM` directive, try pulling the base ros image first with `docker pull ros:humble-ros-base-jammy`.
5.  Run `docker-compose up -d` to start the container. Then attach to the container with `docker attach viz_robox` (this is the container's name). NOTE: if you would like to open another terminal window for the container, run `docker exec -it viz_robox bash` in another window. Then source the startup file with `source /startup.sh` in the container.

Steps for GUI application usage:
1. Install a VNC viewer on your host (TigerVNC viewer is recommended to match the TigerVNC server that runs on the container, but any viewer should work in theory). Install instructions may be found here: https://sourceforge.net/projects/tigervnc/files/stable/1.14.1/.
2. Run `startvnc` in the container
3. Open up the VNC viewer and listen on `localhost:5901`. This should open a blank, black window on your host. GUI applications you run within the container should appear there
4. To shut off the VNC server, run `killvnc` within the container

Additional usage notes:
1. All files created within /home/\<user\>/ in the container will be saved in the ./container_home folder on your host
2. On entering the container, you will be signed in as an automatically generated user in the container (not as root). This user may, however, use `sudo` without needing a password
3. Additional packages that you might want to install may be installed via the Dockerfile in the appropriate space indicated by comments
4. Openbox is the window management software used to render GUI applications (within the VNC). It was chosen for its simplicity. If a different window manager is desired, that manager's installation may be added to the Dockerfile and appropriate edits to the ./container_home/.vnc/xstartup may be made
5. The container may be removed by exitting it and running `docker-compose down`
