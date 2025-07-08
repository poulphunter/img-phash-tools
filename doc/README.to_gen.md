# Image perceptual tools

Based on perceptual hash, it bring some commands line tools.  

Compatibility with python >= 3.9 <= 3.14  

## Features  

- dupimg : find duplicate images based on perceptual hash in a directory.
- imgphash : print perceptual hash of a given image file name.
- qsimg : quick sort images in a directory based the perceptual distance between a reference image.
- simg : return the distance matrix between images of a directory based on the perceptual distance.


## Install

From PyPI
```
pip install img-phash-tools
```

From source  
```
pip install -r requirements.txt
pip install .
```

## dupimg

```
dupimg_cli_replace
```

## imgphash

```
imgphash_cli_replace
```

## qsimg

```
qsimg_cli_replace
```

## simg

```
simg_cli_replace
```

## Usage examples

### Sort images by similarities from a reference image and show results in a folder  

For the following example, you need demo images generated with pytest:
```
pip install -r requirements.dev.txt
pip install -r requirements.txt
pip install .
pytest
```
Now you have images in `/tests/datas` directory.  

You can use the following demo script:
```
./scripts/demo/show_qsimg_sort.sh $(pwd)"/tests/datas" $(pwd)"/tests/datasSort" --reference $(pwd)"/tests/datas/imageBlackCircle1.png" --mode averageHash --max-files 3 --max-dist 30
```
`$(pwd)` is used to pass an absolute directory.  
It's easier for symlink generation.

`imageBlackCircle1.png` is used to sort images, so the distance will be 0 to this image.  
`--max-dist 30` limit the distance to 30
`--max-files 3` limit the number of files out to 3

You can now see the similar images:
![./doc/demo_show_qsimg_sort.png](./doc/demo_show_qsimg_sort.png){width=600}  
  

## Dev  
Install used dev tools with:  
```
pip install -r requirements.dev.txt
```

### Info  
colorMomentHash is not functional, it's a test.  

### Scripts  
All you need is into
```
./scripts/install.dev.sh
```
It will create main venv and venv for each python version we need to tests.  

You can now run lint and check scripts:
```
./scripts/lint.sh
./scripts/tests.sh
```
Before publishing you can test locally a CI:
```
./scripts/CI_all.sh
```
### Tests  
It use pytest, CLI commands are not fully tested.  

It seems to have different results for colorMomentHash and marrHildrethHash between Debian/Ubuntu (latest at 2025-07).  
It may be caused by an update in Ubuntu version (Ubuntu python version > Debian python version).  

You can run it with this command:
```
./scripts/tests.sh
```

### Coverage  
It does not find error raising tests but it's actually near 100%.  

You can run it with this command:
```
./scripts/tests_coverage.sh
```
