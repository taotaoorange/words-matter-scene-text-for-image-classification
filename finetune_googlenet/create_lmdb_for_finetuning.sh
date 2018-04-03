#!/usr/bin/env sh
# Create lmdb inputs

TOOLS=/home/rtao1/fast-rcnn/caffe-fast-rcnn/build/tools

TRAIN_DATA_ROOT=../Con-Text/JPEGImages/
VAL_DATA_ROOT=../Con-Text/JPEGImages/

TRAIN_TXT=../prepare_data_for_fine_tuning_googlenet/train_lmdb_split_0.txt
VAL_TXT=../prepare_data_for_fine_tuning_googlenet/val_lmdb_split_0.txt

TRAIN_LMDB=train_lmdb_split_0
VAL_LMDB=val_lmdb_split_0


# Set RESIZE=true to resize the images to 256x256. Leave as false if images have
# already been resized using another tool.
RESIZE=true
if $RESIZE; then
  RESIZE_HEIGHT=256
  RESIZE_WIDTH=256
else
  RESIZE_HEIGHT=0
  RESIZE_WIDTH=0
fi


echo "Creating train lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    --shuffle \
    $TRAIN_DATA_ROOT \
    $TRAIN_TXT \
    $TRAIN_LMDB

echo "Creating val lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    --shuffle \
    $VAL_DATA_ROOT \
    $VAL_TXT \
    $VAL_LMDB


echo "Done."
