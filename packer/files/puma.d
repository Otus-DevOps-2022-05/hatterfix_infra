#Run pumad,service
[Unit]
After = network.target

[Service]
Type=notify
WorkingDirectory=/opt/reddit
RemainAfterExit = yes
ExecStart = /usr/local/bin/puma -d
TimeoutSec=15
KillMode=process
Restart=on-failure


[Install]
WantedBy = multi-user.target
