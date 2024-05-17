<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/EMPCPlatformStarterKitsImage.png" width=350/>
	</p>
  <h3>PSK Convenience Images</h3>
  <h1>twdps/gha-container-base-image</h1>
  <img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/ThoughtWorks-DPS/gha-container-base-image/.github%2Fworkflows%2Fdevelopment-build.yaml"> <img alt="GitHub Release" src="https://img.shields.io/github/v/release/ThoughtWorks-DPS/gha-container-base-image"> <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</div>
<br />

Within most teams or organizations, every job container image will require a certain amount of common configuration regardless of the purpose for which it is built.  

Packages that typically fall into this set of shared executor requirements include things like:  
- tool for accessing secrets (such as Vault, chamber, 1password, teller)  
- standard shell (bash, zsh)  
- multi-language support (locales)  
- common dependencies for installing packages (curl, wget, unzip, common build dependencies)

The psk gha-container-base-image is an example of such a common base container. You will see the psk specific tools and configuration, but this can readily be adapted to any organizational requirements.  

Build job specific container images starting from the base image.  

See release notes for detailed version information.  

**signature**. Images are signed using `cosign`. You can verify an image using the twdps public key found [here](https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/cosign.pub).  
```bash
cosign verify --key cosign.pub twdps/gha-container-base-image:0.1.0
```  

**software bill of materials**. For each published image, an SBOM is generated using [syft](https://github.com/anchore/syft) and uploaded to the container registry tagged using the manifest id and .spdx extension. You can pull the sbom using the oras tool as follows:  

fetch image manifest:  
```
docker image inspect --format='{{index .RepoDigests 0}}' twdps/gha-container-base-image:0.1.0
```
twdps/gha-container-base-image:0.1.0@sha256:9d8e8eef60900fcf207e3b258b4ce13b4cdb1765f0f7ca3022fd685cd53b8a14

download sbom:  
```
oras pull docker.io/twdps/gha-container-base-image:0.1.0:sha256-9d8e8eef60900fcf207e3b258b4ce13b4cdb1765f0f7ca3022fd685cd53b8a14.spdx
```

Review `.snyk` for current vulnerability status.  
