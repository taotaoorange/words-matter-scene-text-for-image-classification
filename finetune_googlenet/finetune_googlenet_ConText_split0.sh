#!/usr/bin/env sh

TOOLS=/home/rtao1/fast-rcnn/caffe-fast-rcnn/build/tools

$TOOLS/caffe train --solver solver_split0.prototxt --weights ../imagenet_models/bvlc_googlenet.caffemodel --gpu 0