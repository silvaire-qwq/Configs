#!/bin/env bash

sudo pkill fcitx5
fcitx5-remote -r
fcitx5 --replace
