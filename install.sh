#!/bin/sh
echo "Install"
mkdir ~/.rake
git clone https://github.com/charly-palencia/mbe_generator.git

mv mbe_generator/*  ~/.rake
rm -rf mbe_generator

cd ~/.rake
mv Rakefile mbe_generator.rake
