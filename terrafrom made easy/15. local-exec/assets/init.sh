#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable --now nginx
