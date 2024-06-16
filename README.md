# pcb-devc ![CI](https://github.com/EffectiveRange/pcb-devc/actions/workflows/release.yml/badge.svg)

This docker container aggregates everything that can be used for KiCAD PCB project CI (test and release). It can be easily integrated by using the [devcontainers](https://github.com/devcontainers/ci) CI action.
The docker images are available under [https://hub.docker.com/repository/docker/effectiverange/devc-pcb/tags](https://hub.docker.com/repository/docker/effectiverange/devc-pcb/tags)
The image depends on the kicad-cli docker base image, and also incorporates all dependencies and tooling necessary for a successful PCB release (including KiCAD 3D models).
The main entry point is:
- `pcb-build`, for using in a CI step (or locally)
- `pcb-create-release`, for updating version references in the project, and creating and pushing those changes/tags to the remote

# pcb-build 
This script is used to automate the process of building a Printed Circuit Board (PCB) project using KiCad. It performs various tasks such as exporting Gerber files, running ERC and DRC checks, creating a Bill of Materials (BOM), and generating 3D models.

## Usage
### Description
The script takes as input the path to the KiCad project or the directory containing the project files. Optionally, you can also specify the name of the pcb.json file. If not specified, the script will look for a `pcb.json` file in the same directory as the project files.

## The script performs the following tasks:

 - Searches for .kicad_pcb files in the specified directory.
 - Verifies the existence of the necessary files.
 - Determines the layers to export from pcb.json, also uses a the default 2 layer board KiCAD layers,so extra layers neeed to be specified only on top of that.
 - Runs ERC (Electrical Rules Check) and DRC (Design Rules Check) using kicad-cli.
 - Exports Gerber and drill files for the PCB. (Currently for JLCPCB Fab house, but can be easily ectended)
 - Exports the schematic to a PDF file.
 - Creates an Interactive BOM (Bill of Materials).
 - Exports the .kicad_pcb file.
 - Creates a BOM in .xlsx format. (The only mandatory field now is `MPN`, can be parametrized later on)
 - Exports 3D models of the PCB in .wrl and .step formats.


# pcb-create-release
This script is used to automate the process of creating a new release for a Printed Circuit Board (PCB) project using KiCad. It handles versioning, commits, and tags in the project's Git repository.

## Usage
### Help
```bash
usage: pcb-create-release [-h] (-M | -m | -p | -r) [-C C] [--publish] [pcbfile]

positional arguments:
  pcbfile      The pcb defintion file (default: pcb.json)

options:
  -h, --help   show this help message and exit
  -M, --major  create a major release (default: False)
  -m, --minor  create a minor release (default: False)
  -p, --patch  create a patch release (default: False)
  -r, --re     create a re-release with the current version (default: False)
  -C C         path to KiCad project dir (default: ./)
  --publish    push the commit and tag to the remote branch (default: False)
```

### Description
The script takes as input several command line arguments to determine the type of release (major, minor, patch, or re-release), the path to the KiCad project directory, and an optional pcb definition file. If the --publish flag is provided, the script will also push the new release to the remote Git repository.

## The script performs the following tasks:

- Parses the current version from the pcb definition file (`pcb.json`).
- Calculates the next version based on the release type.
- Bumps the version in the pcb definition file (replaces all date and version texts in the project files).
- Commits the changes to the Git repository with a message indicating the version bump.
- Creates a new Git tag for the new version.
- If the --publish flag is provided, pushes the new commit and tag to the remote Git repository (one-by-one, so that the ordering is enforced for concurrency grouping).