# words-matter-scene-text-for-image-classification

This repository contains the code for the following paper: 

*  Sezer Karaoglu, Ran Tao, Theo Gevers, Arnold W. M. Smeulders, *Words Matter: Scene Text for Image Classification and Retrieval*, in IEEE Transactions on Multimedia, 2017 ([PDF](https://ivi.fnwi.uva.nl/isis/publications/2016/KaraogluTMM2016/KaraogluTMM2016.pdf))

If you find our work useful, please consider citing:
```
@article{karaoglu2017words,
  title={Words matter: Scene text for image classification and retrieval},
  author={Karaoglu, Sezer and Tao, Ran and Gevers, Theo and Smeulders, Arnold WM},
  journal={IEEE Transactions on Multimedia},
  volume={19},
  number={5},
  pages={1063--1076},
  year={2017},
  publisher={IEEE}
}
```

**Contact**: sezerkaraoglu@gmail.com, rantao.mail@gmail.com

- - - -
### Usage

**[Dataset]**: The Con-Text dataset used in this work can be found here https://staff.fnwi.uva.nl/s.karaoglu/datasetWeb/Dataset.html 

'Finegrained_ImageNames.mat' is the list of images in the Con-Text dataset.


**[Text detection]**: The code in the folder 'text_detection/' is for generating word bounding box proposals. See 'text_detection/demo.m'. 


**[Generate textual representation]**: Refer to 'EncodeTextualConTextScript.m' for how to generate representations of the textual contents in images. Both the CPU version ('EncodeTextual.m') and the GPU version ('EncodeTextualGPU.m') are provided. To generate the representations of the textual contents, the word recognition model provided by Jaderberg et al (http://www.robots.ox.ac.uk/~vgg/research/text/) is required. Go to folder 'NIPS2014DLW-Jaderberg/' and run 'download.sh' to download the word recognition model. 


**[Generate visual representation]**: Refer to 'deep_visual_features/extract_googlenet_feat.py' for how to extract googlenet features. Caffe (https://github.com/BVLC/caffe) is needed.


**[Fine tune googlenet on the Con-Text dataset]**: See folder 'finetune_googlenet/'.




