# {{{ Mandatory first block.  A valid parameter must be provided.

param (
  [Parameter(Mandatory=$true)]
  [ValidateSet("install", "uninstall")]
  [string]$Command
)

$StartTime = Get-Date

# -------------------------------------------------------------------------- }}}
# {{{ Run a choco command.
#
#     $Argument
#       Chocolatey package name to [install|uninstall].
#
#     $Command
#       [install|uninstall].
#       Mandatory command line argument.
#       See Mandatory first block.
#
#     $ChocoCommand
#       choco [install|uninstall] and options.
#       See Read configuration file.

function Invoke-Choco-Command {
  param ([System.Object]$Argument)
  $ProgramCmd = [System.String]::Concat($ChocoCommand, " ", $Argument.name)

  # Tell them what we will and will not do.
  if ($Argument.use) {
    $Msg = [System.String]::Concat($Argument.name, " will be ", $Command)
  }
  else {
    $Msg = [System.String]::Concat($Argument.name, " will not be ", $Command)
  }
  Write-Host $Msg

  # Do the work.
  if ($Argument.use) {

    if ($Command -eq "Install") {
      Invoke-Expression $ProgramCmd
      foreach ($Package in $Argument.packages) {
        $PackageCmd = [System.String]::Concat($ChocoCommand, " ", $Package.name)
        Invoke-Expression $PackageCmd
      }
    }

    else {
      foreach ($Package in $Argument.packages) {
        $PackageCmd = [System.String]::Concat($ChocoCommand, " ", $Package.name)
        Invoke-Expression $PackageCmd
      }
      Invoke-Expression $ProgramCmd
    }

  }
}

# -------------------------------------------------------------------------- }}}
# {{{ Read Configuration file.

$Config = Get-Content -Raw 'install.json' | ConvertFrom-Json
$ChocoCommand = `
[System.String]::Concat( `
  "choco ", $Command, " --confirm --limit-output --no-progress" `
)


# ------------------------------------------------------------------------- }}}
# {{{ Install Chocolatey

if ($Command -eq "Install") {
  if ($Config.chocolatey.use) {
    Write-Host "Chocolatey will be $Command."
    $InstallURL = 'https://chocolatey.org/install.ps1'
    Set-ExecutionPolicy Bypass -Scope Process -Force; `
      iex ((New-Object System.Net.WebClient).DownloadString($InstallURL))
  }
  else {
    Write-Host "Chocolatey will not be $Command."
  }
}

# ------------------------------------------------------------------------- }}}
# {{{ Git

Invoke-Choco-Command $Config.git

# ------------------------------------------------------------------------- }}}
# {{{ Dbeaver

Invoke-Choco-Command $Config.dbeaver

# ------------------------------------------------------------------------- }}}
# {{{ Docker

Invoke-Choco-Command $Config.docker

# ------------------------------------------------------------------------- }}}
# {{{ Ruby

Invoke-Choco-Command $Config.ruby

# ------------------------------------------------------------------------- }}}
# {{{ Visual Code

Invoke-Choco-Command $Config.visualcode

# ------------------------------------------------------------------------- }}}
# {{{ Visual Studio

Invoke-Choco-Command $Config.visualstudio

# ------------------------------------------------------------------------- }}}
# {{{ Uninstall Chocolatey.  Must be the last block.
#
#     This will remove Chocolatey and all packages, software, and
#     configurations in the Chocolatey Installation folder from your machine.
#
#     This function does not attempt to adjust the Windows Registry.
#
#     https://community.chocolatey.org/courses/installation/uninstalling

if ($Command -eq "Uninstall") {
  if ($Config.chocolatey.use) {
    Write-Host "Chocolatey will be $Command."

    # Delete the Chocolatey directory.
    Remove-Item -Recurse -Force "$env:ChocolateyInstall"
  }
  else {
    Write-Host "Chocolatey will not be $Command."
  }
}

# ------------------------------------------------------------------------- }}}
# {{{ Record execution time.

Write-Host
Write-Host "$Command took $((Get-Date).Subtract($StartTime))"

# ------------------------------------------------------------------------- }}}
