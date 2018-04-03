__author__ = 'rantao' # code not cleaned

import numpy as np

import sys
sys.path.insert(0, '/home/rtao1/fast-rcnn/caffe-fast-rcnn/python/')

import caffe
import os
import pdb
import datetime

import argparse

def parse_args():
		
		"""Parse input arguments."""
		parser = argparse.ArgumentParser(description='extract googlenet features')
		
		parser.add_argument('--caffemodel', dest='caffe_model_path')
		parser.add_argument('--prototxt', dest='prototxt')
		parser.add_argument('--layer', dest='layer_name')
		parser.add_argument('--imagedir', dest='image_dir')
		parser.add_argument('--featuredir', dest='feature_dir')
		parser.add_argument('--gpuid', dest='gpu_id', type=int)
		
		args = parser.parse_args()
		
		return args


if __name__ == '__main__':

	args = parse_args()

	caffe.set_device(args.gpu_id)
	caffe.set_mode_gpu()

	net = caffe.Net(args.prototxt, args.caffe_model_path, caffe.TEST)


	transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
	transformer.set_transpose('data', (2,0,1)) # eg, from (227,227,3) to (3,227,227)
	transformer.set_mean('data', np.round(np.load('imagenet_models/ilsvrc_2012_mean.npy').mean(1).mean(1))) # mean pixel, note there is discrepancy between 'mean image' in training and 'mean pixel' in testing
	transformer.set_raw_scale('data', 255)  # the reference model operates on images in [0,255] range instead of [0,1]
	transformer.set_channel_swap('data', (2,1,0))  # the reference model has channels in BGR order instead of RGB

	counter = 0
	for f in os.listdir(args.image_dir):
		if f.endswith(".jpg"):
			# pdb.set_trace()
			image = caffe.io.load_image(args.image_dir + f)
			transformed_image = transformer.preprocess('data', image)
			net.blobs['data'].data[...] = transformed_image
			output = net.forward()
			feat = output[args.layer_name].copy()

			np.savetxt(args.feature_dir + f + '.txt', feat, fmt='%f')

			counter = counter + 1
			print counter