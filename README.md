# AUC.CDT (Contract Development Toolkit)
## Version : 1.8.0

AUC.CDT is a toolchain for WebAssembly (WASM) and a set of tools to facilitate smart contract development for the AUC platform. In addition to being a general purpose WebAssembly toolchain, [AUC](https://github.com/Osasion/auc) specific optimizations are available to support building EOSIO smart contracts.  This new toolchain is built around [Clang 9](https://github.com/Osasion/auc.llvm), which means that AUC.CDT has the most currently available optimizations and analyses from LLVM, but as the WASM target is still considered experimental, some optimizations are incomplete or not available.

### New Introductions
As of this release two new repositories are under the suite of tools provided by **AUC.CDT**.  These are the [Ricardian Template Toolkit](https://github.com/Osasion/ricardian-template-toolkit) and the [Ricardian Specification](https://github.com/Osasion/ricardian-spec).  The **Ricardian Template Toolkit** is a set of libraries to facilitate smart contract writers in crafting their Ricardian contracts.  The Ricardian specification is the working specification for the above mentioned toolkit.  Please note that both projects are **alpha** releases and are subject to change.

### Attention
- Please see the [Upgrading Guide 1.2 to 1.3](https://eosio.github.io/eosio.cdt/latest/upgrading/1.2-to-1.3) and [Upgrading Guide 1.5 to 1.6](https://eosio.github.io/eosio.cdt/latest/upgrading/1.5-to-1.6) to be aware of any breaking changes.
- There is currently a known issue that a minimum of 2 CPU cores is required for using AUC.CDT

## Binary Releases
AUC.CDT currently supports Mac OS X brew, Linux x86_64 Debian packages, and Linux x86_64 RPM packages.

**If you have previously installed AUC.CDT, run the `uninstall` script (it is in the directory where you cloned AUC.CDT) before downloading and using the binary releases.**

### Mac OS X Brew Install
```sh
brew tap auc/ auc.cdt
brew install auc.cdt
```

### Mac OS X Brew Uninstall
```sh
brew remove auc.cdt
```

### Debian Package Install
```sh
wget https://github.com/Osasion/eosio.cdt/releases/download/v1.8.0/eosio.cdt_1.8.0-1-ubuntu-18.04_amd64.deb
sudo apt install ./eosio.cdt_1.8.0-1-ubuntu-18.04_amd64.deb
```

### Debian Package Uninstall
```sh
sudo apt remove auc.cdt
```

### RPM Package Install
```sh
wget https://github.com/Osasion/eosio.cdt/releases/download/v1.8.0/eosio.cdt-1.8.0-1.el7.x86_64.rpm
sudo yum install ./eosio.cdt-1.8.0-1.el7.x86_64.rpm
```

### RPM Package Uninstall
```sh
sudo yum remove auc.cdt
```

## Guided Installation or Building from Scratch
```sh
git clone --recursive https://github.com/Osasion/auc.cdt
cd eosio.cdt
mkdir build
cd build
cmake ..
make -j8
```

From here onward you can build your contracts code by simply exporting the `build` directory to your path, so you don't have to install globally (makes things cleaner).
Or you can install globally by running this command:

```sh
sudo make install
```

### Uninstall after manual installation

```sh
sudo rm -fr /usr/local/auc.cdt
sudo rm -fr /usr/local/lib/cmake/auc.cdt
sudo rm /usr/local/bin/auc-*
```

## Installed Tools
---
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

## Contributing

[Contributing Guide](./CONTRIBUTING.md)

[Code of Conduct](./CONTRIBUTING.md#conduct)

## License

[MIT](./LICENSE)

## Important

See [LICENSE](./LICENSE) for copyright and license terms.

All repositories and other materials are provided subject to the terms of this [IMPORTANT](./IMPORTANT.md) notice and you must familiarize yourself with its terms.  The notice contains important information, limitations and restrictions relating to our software, publications, trademarks, third-party resources, and forward-looking statements.  By accessing any of our repositories and other materials, you accept and agree to the terms of the notice.
# auc.cdt
