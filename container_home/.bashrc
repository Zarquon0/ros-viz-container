# Add aliases for starting and killing the VNC server
alias startvnc="vncserver :1 -localhost no -SecurityTypes None --I-KNOW-THIS-IS-INSECURE -geometry 1920x1080 -depth 24"
alias killvnc="vncserver -kill :1"
# This startvnc command is not actually insecure because it is being executed within a container that is only exposed to localhost on your host computer