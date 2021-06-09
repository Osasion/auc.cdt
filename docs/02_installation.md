---
content_title: Binary Releases
---

AUC.CDT currently supports Mac OS X brew, Linux x86_64 Debian packages, and Linux x86_64 RPM packages.

**If you have previously installed AUC.CDT, run the `uninstall` script (it is in the directory where you cloned AUC.CDT) before downloading and using the binary releases.**

## Mac OS X Brew Install

```sh
brew tap auc/auc.cdt
brew install auc.cdt
```

## Mac OS X Brew Uninstall

```sh
brew remove eosio.cdt
```

## Debian Package Install

```sh
wget https://github.com/Osasion/eosio.cdt/releases/download/v1.8.0/eosio.cdt_1.8.0-1-ubuntu-18.04_amd64.deb
sudo apt install ./eosio.cdt_1.8.0-1-ubuntu-18.04_amd64.deb
```

## Debian Package Uninstall

```sh
sudo apt remove eosio.cdt
```

## RPM Package Install

```sh
wget https://github.com/Osasion/eosio.cdt/releases/download/v1.8.0/eosio.cdt-1.8.0-1.el7.x86_64.rpm
sudo yum install ./eosio.cdt-1.8.0-1.el7.x86_64.rpm
```

## RPM Package Uninstall

```sh
sudo yum remove auc.cdt
```

# Guided Installation or Building from Scratch

```sh
git clone --https://github.com/Osasion/auc.cdt
cd auc.cdt
mkdir build
cd build
cmake ..
make -j8
```

From here onward you can build your contracts code by simply exporting the `build` directory to your path, so you don't have to install globally (makes things cleaner).
Or you can install globally by running this command

```sh
sudo make install
```

## Uninstall after manual installation

```sh
sudo rm -fr /usr/local/eosio.cdt
sudo rm -fr /usr/local/lib/cmake/eosio.cdt
sudo rm /usr/local/bin/eosio-*
```

# Installed Tools

* auc-cpp
* auc-cc
* auc-ld
* auc-init
* auc-abidiff
* auc-wasm2wast
* auc-wast2wasm
* auc-ranlib
* auc-ar
* auc-objdump
* auc-readelf

The following tools are not installed after brew install, you get them when you build the repository and install it from scratch, [see here](#guided-installation-or-building-from-scratch):

* auc-abidiff
* auc-ranlib
* auc-ar
* auc-objdump
* auc-readelf

License
[MIT](../LICENSE)
