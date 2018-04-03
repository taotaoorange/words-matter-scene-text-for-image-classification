#!/usr/bin/env sh

TOOLS=/home/rtao1/caffe/build/tools

$TOOLS/caffe train --solver solver_split0.prototxt --weights ../imagenet_models/bvlc_googlenet.caffemodel --gpu 0