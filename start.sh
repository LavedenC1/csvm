#!/bin/bash

vncserver -kill :1 2>/dev/null || true
sleep 1

vncserver :1 -rfbport 8444
