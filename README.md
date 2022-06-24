# bootstrap
Bootstrap has been designed to automate the configuration of your development
environment.

# Windows 10
## Prerequisites
1. Administrative privileges to your computer.
2. [PowerShell](https://en.wikipedia.org/wiki/PowerShell)
3. Credentials to a [git-based](https://en.wikipedia.org/wiki/Git) source conde repository system
5. Internet access

## TL;DR
### Installation
#### Download bootstrap
1. Download and unzip [bootstrap-windows.zip](https://github.com/Traap/bootstrap-w10/archive/refs/tags/v1.0.0.0.zip)
2. Use Windows File Explorer to unzip [bootstrap-windows.zip](https://github.com/Traap/bootstrap-w10/archive/refs/tags/v1.0.0.0.zip)
3. cd to/extracted/files

#### Install Development Tools
1. Run PowerShell as Administrator
2. Change directory to the location bootstrap was downloaded and unzipped.
3. Run install.cmd script.

```PowerShell
.\install.cmd
```

#### Configure Git and Clone Repositories
1. A new shell must be started to refresh your path and environment.
2. Run PowerShell as Administrator
3. Change directory to the location bootstrap was downloaded and unzipped.
4. Validate your Bitbucket credentials with your Browser.
5. Run clone.cmd script.

```PowerShell
.\clone.cmd
```

#### Optional Remove Installation
1. Run a Power Shell as an Administrator.
2. Change directory to the location bootstrap was downloaded and unzipped.
3. Run uninstall.cmd shell script.

```PowerShell
.\uninstall.cmd
```

# Customize programs and repositories installed and cloned.
[With great power comes great responsibility](https://en.wikipedia.org/wiki/With_great_power_comes_great_responsibility)
you have been notified!

The installation process downloads and installs development tools using
[Chocolatey](https://community.chocolatey.org/packages). The command line tool
*choco* is installed and used.
[install.json](https://github.com/Traap/bootstrap-windows/blob/master/install.json)
is tailored to meet a your specific needs. The json snippet below shows *Ruby*
will be installed.

```json
{
  "ruby": {
    "use": true,
    "name: "ruby.install"
  }
}
```

## File names
[install.ps1](https://github.com/Traap/bootstrap-windows/blob/master/install.ps1)
installs Ruby when *use* is *true*.  Ruby is not installed when *use* is *false*.
This pattern is repeated throughout: [install.json](https://github.com/Traap/bootstrap-windows/blob/master/install.json)

### Development tool installation
#### install.cmd
A command script that runs
[install.ps1](https://github.com/Traap/bootstrap-windows/blob/master/install.ps1)
with the *install* option.

```cmd
@echo off
powershell powershell.exe -executionpolicy bypass -file .\install.ps1 install
```

#### uninstall.cmd
A command script that runs
[install.ps1](https://github.com/Traap/bootstrap-windows/blob/master/bootsrap.ps1)
with the *uninstall* option.

```cmd
@echo off
PowerShell powershell.exe -ExecutionPolicy Bypass -File .\install.ps1 uninstall
```

#### install.ps1
A PowerShell script that installs or uninstalls programs defined in
[install.json](https://github.com/Traap/bootstrap-windows/blob/master/install.json).

### install.json
A JSON file that identifies all development tools installed or uninstalled.

### Cloning Repositories and customizing ${HOME}/.gitconfig
#### clone.cmd

```cmd
@echo off
PowerShell powershell.exe -ExecutionPolicy Bypass -File .\clone.ps1 install
```

#### clone.ps1
A PowerShell script that initialized your *$HOME/.gitconfig* file, and clones
repositories defined in
[clone.json](https://github.com/Traap/bootstrap-windows/blob/master/clone.json).

#### clonse.json
Aut minimum, *$HOME/.gitconfig* personalilization is needed.

```json
{
  "gitconfig": {
    "use": false,
    "email": "ga.cj.howard@gmail.com",
    "global": true,
    "user": "Traap1234"
  },
  "repositories": {
    "use": true,
    "repos": [
      {
        "url": "https://bitbucket.org/CanaryMedical/clinic-pc-app.git",
        "use": true
      },
      {
        "url": "https://bitbucket.org/CanaryMedical/clinic-server.git",
        "use": true
      }
    ]
  }
}
```

You are encouraged to review the _visualcode_ section.  The addons are listed
alphebitically.  These addons are popular for Azure, CSharp, Docker, Git, Json,
PowerShell, Ruby, and XML development and testing.

