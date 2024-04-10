#!/usr/bin/env bash

nix-collect-garbage -d
sudo nix-store --verify --check-contents --repair
