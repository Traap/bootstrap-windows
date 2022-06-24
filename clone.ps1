# {{{ Mandatory first block.  A valid parameter must be provided.

param (
  [Parameter(Mandatory=$true)]
  [ValidateSet("install", "uninstall")]
  [string]$Command
)

$StartTime = Get-Date

# -------------------------------------------------------------------------- }}}
# {{{ Say something.

function Invoke-Write-Host {
  param ([System.Object]$Argument, [System.String]$Message)

  # Tell them what we will and will not do.
  if ($Argument.use) {
    $Msg = [System.String]::Concat($Argument.name, " will be ", $Command)
  }
  else {
    $Msg = [System.String]::Concat($Argument.name, " will not be ", $Command)
  }
  Write-Host $Msg
}

# -------------------------------------------------------------------------- }}}
# {{{ Read Configuration file.

$Config = Get-Content -Raw 'clone.json' | ConvertFrom-Json

# ------------------------------------------------------------------------- }}}
# {{{ Git Config

Invoke-Write-Host $Config.gitConfig, "Git config"

if ($Config.gitConfig.use -and $Command -eq "Install") {
  if ($Config.gitConfig.global) {
    $Target = "--global"
  }
  else {
    $Target = "--local"
  }

  Invoke-Expression "git config $Target user.name  $($Config.gitconfig.user)"
  Invoke-Expression "git config $Target user.email $($Config.gitconfig.email)"
}
else {
  if ($Config.gitConfig.use -and $Command -eq "Uninstall") {
    Write-Host "Removing .gitconfig is currently not supported."
  }
}

# ------------------------------------------------------------------------- }}}
# {{{ Clone Repositories

Invoke-Write-Host $Config.gitConfig, "Repositories"
if ($Config.repositories.use -and $Command -eq "Install") {
  Write-Host "Repositories will be cloned."
  foreach ($Repo in $Config.repositories.repos) {
    if ($Repo.use) {
      Invoke-Expression "git clone $($Repo.url)"
    }
  }
}
else {
  if ($Config.gitConfig.use -and $Command -eq "Uninstall") {
    Write-Host "Removing git repositories is not currently not supported."
  }
}

# ------------------------------------------------------------------------- }}}
# {{{ Record execution time.

Write-Host
Write-Host "$Command took $((Get-Date).Subtract($StartTime))"

# ------------------------------------------------------------------------- }}}
