#!/bin/bash

busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("正在重新加载 gnome-shell ...")'