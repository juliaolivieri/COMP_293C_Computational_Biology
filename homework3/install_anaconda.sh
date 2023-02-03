#!/usr/bin/env bash

# download anaconda installer
cd ~
mkdir applications
cd applications
wget https://repo.continuum.io/archive/Anaconda3-2022.10-Linux-x86_64.sh 
bash Anaconda3-2022.10-Linux-x86_64.sh 

# add to bashrc
echo 'PATH="/bin/:$PATH"' >> ~/.bashrc
echo 'export PATH="~/anaconda3/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
