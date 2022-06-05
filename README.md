# DeepDRiD-Project



## Overview

./baseline.py Resnet50+ABM主程序

./baseline_all.py 使用其他预训练模型主程序

./pre_processing.py  基于Ben's preprocessing的预处理，因结果相差不大没用在最后的实验里

./dataset.py 数据集类

./models/resnet50.py  在CANet[^1]基础上修改的Resnet50+BAM模型（包含单输入Resnet50+BAM，双输入Resnet50+BAM+融合两幅图像的结果，双输入+BAM+CBAM），但排列组合试了多种网络结构/数据增强/loss/学习率调整方法，都和只使用Resnet50相差不大



## Preparation

### prerequisites

- Python 3.9.12
- Pytorch 1.8.1
- CUDA 10.1

### Data Preparation

- DeepDRiD：原始regular-fundus-training.csv文件中部分数据image_id中的左右和其对应的标签对应有误，需手动进行处理

### Pretrained Model

- ResNet: [ResNet50](https://download.pytorch.org/models/resnet50-19c8e357.pth), [ResNet101](https://download.pytorch.org/models/resnet101-5d3b4d8f.pth)
- EfficientNet: [EfficientNet-b1](https://github.com/lukemelas/EfficientNet-PyTorch/releases/download/1.0/efficientnet-b1-f1951068.pth), [EfficientNet-b3](https://github.com/lukemelas/EfficientNet-PyTorch/releases/download/1.0/efficientnet-b3-5fb5a3c3.pth), [EfficientNet-b4](https://github.com/lukemelas/EfficientNet-PyTorch/releases/download/1.0/efficientnet-b4-6ed6700e.pth)
- [DenseNet121](https://download.pytorch.org/models/densenet121-a639ec97.pth)
- [InceptionV3](https://download.pytorch.org/models/inception_v3_google-1a9a5a14.pth)



## Result

### Backbone

Use all model  pre-trained on ImageNet


| Method          | Imagesize | Parms    | Val_Acc | Kappa  |
| --------------- | --------- | -------- | ------- | ------ |
| ResNet-50       | 256 × 256 | 23510081 | 69.25   | 0.8135 |
| ResNet-101      | 256 × 256 | 42510405 | 67.25   | 0.8087 |
| DenseNet121     | 256 × 256 | 6958981  | 57.50   | 0.5952 |
| InceptionV3     | 512 × 512 | 25122509 | 63.75   | 0.7968 |
| EfficientNet-b1 | 256 × 256 | 6519589  | 71.00   | 0.8347 |
| EfficientNet-b3 | 256 × 256 | 10703917 | 68.25   | 0.8160 |
| EfficientNet-b4 | 256 × 256 | 17557581 | 67.75   | 0.8159 |
| ViT             | 256 × 256 | 85802501 | 54.25   | 0.5766 |

### Loss

| Method          | Loss   | Val_Acc | Kappa  |
| --------------- | ------ | ------- | ------ |
| ResNet-50       | CE     | 69.25   | 0.8135 |
| ResNet-50       | CE+SL1 | 69.50   | 0.8237 |
| EfficientNet-b1 | CE     | 71.00   | 0.8347 |
| EfficientNet-b1 | CE+SL1 | 71.25   | 0.8353 |
### Pretrained

| Method          | Pretrain       | Val_Acc | Kappa  |
| --------------- | -------------- | ------- | ------ |
| EfficientNet-b1 | ImageNet       | 71.00   | 0.8347 |
| EfficientNet-b1 | APTOS(5epoch)  | 71.25   | 0.8357 |
| EfficientNet-b1 | APTOS(50epoch) | 71.75   | 0.8362 |
### CBAM

| Method                               | Loss   | Val_Acc | Kappa  |
| ------------------------------------ | ------ | ------- | ------ |
| ResNet-50                            | CE+SL1 | 69.25   | 0.8135 |
| ResNet-50 + CBAM                     | CE+SL1 | 67.25   | 0.8087 |
| ResNet-50 + SBAM                     | CE+SL1 | 69.00   | 0.8132 |
| ResNet-50 + Cross-CBAM               | CE+SL1 | 69.50   | 0.8347 |
| ResNet-50 + Cross-CBAM(LR_Scheduler) | CE+SL1 | 71.00   | 0.8443 |




[^1]: X. Li, X. Hu, L. Yu, L. Zhu, C. -W. Fu and P. -A. Heng, "CANet: Cross-Disease Attention Network for Joint Diabetic Retinopathy and Diabetic Macular Edema Grading," in IEEE Transactions on Medical Imaging, vol. 39, no. 5, pp. 1483-1493, May 2020, doi: 10.1109/TMI.2019.2951844.

