#!/bin/bash

mkdir dist src includes;
mv doc.org README.org
cd dist; cmake ..; cd ..;
rm README.md start.sh;
