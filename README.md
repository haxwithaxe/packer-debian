# Description
Builds a Debian VM base image. This is meant to work in conjunction with a torrent client downloading the latest installers and to produce up to date base images rather than static baseline images. It uses ansible pull to do any specialized configuration.

# Setup
1. Download the installer ISO and verify the checksum however you want. I have the ISOs downloaded automatically via bittorrent based on the RSS feed generated by [this](https://github.com/haxwithaxe/debian-feed).
1. Adjust `build.sh` to suit your environment.
1. Run `build.sh` periodically to produce up to date VM base images.

## Settings
* `ARCH` - The installer/target CPU architecture to use.
* `DISTRO` - Leave this set to `debian`.
* `VERSION` - The installer version. Leave off the secondary and tertiary version numbers to just use the latest of a given version. This can be set with the `VERSION` environment variable. If it's set to `latest` then it will use the highest version installer it can find in `ISO_DIR` for `ISO_URL` and set `VERSION` to the version it detects in the ISO filename.
* `ISO_DIR` - This is where the installer ISOs are stored.
* `ISO_URL` - The exact location of the local copy of the installer ISO. Don't mess with this unless you want to use the same ISO every time.

* `ISO_CHECKSUM` - The checksum of the installer ISO. Because the ISO is downloaded via bittorrent it's been verified as correctly downloaded and it's safe to trust the checksum calculated in the script. Again don't mess with this unless you want to use the same ISO every time and want to save a few seconds on every run.
* `DEST_DIR` - The directory where the base image is stored.
* `DEST_IMG` - The path to the final base image. This includes a timestamp in the filename for output versioning.
* `IMAGE_NAME` - The initial output filename from packer.
* `BUILD_DIR` - The packer build directory. This is removed at the beginning of each run.
* `ANSIBLE_VAULT_PASSWORD_FILE` - The location of the ansible vault password file used by `scripts/ansible.sh`.
* `MAX_AGE` - The maximum number of days to keep versions of a base image in days.
