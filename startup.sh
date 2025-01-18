#!/bin/bash
# Set environment variables
export ROS_DOMAIN_ID=13 # Not necessary while LOCALHOST_ONLY is true
export ROS_LOCALHOST_ONLY=1
# Entrypoint provided by ros-base image; sets a couple other environment variables and sources the ros setup script
source /ros_entrypoint.sh
# Run CMD directive
exec "$@"