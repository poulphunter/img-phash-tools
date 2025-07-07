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
