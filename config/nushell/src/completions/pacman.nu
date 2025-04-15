# nu-version: 0.102.0

module pacman-completion-utils {
  # Common pacman flags
  export const PACMAN_FLAGS = ['-S', '--sync', '-R', '--remove', '-U', '--upgrade', '-Q', '--query', '-F', '--files', '-D', '--database', '-T', '--deptest', '-Syu', '-Syy', '-Scc']

  # Helper function to append token if non-empty
  def append-non-empty [token: string]: list<string> -> list<string> {
    if ($token | is-empty) { $in } else { $in | append $token }
  }

  # Split a string to list of args, taking quotes into account.
  export def args-split []: string -> list<string> {
    const WHITESPACES = [" " "\t" "\n" "\r"]
    mut current_token = ""
    mut result: list<string> = []

    for char in ($in | split chars) {
      if ($char in $WHITESPACES) {
        $result = $result | append-non-empty $current_token
        $current_token = ""
      } else {
        $current_token = $current_token + $char
      }
    }
    $result = $result | append-non-empty $current_token
    $result
  }
}

# Complete available packages for installation
def "nu-complete pacman packages" [] {
  ^pacman -Sl | lines | split column -n 2 repo package | get package
}

# Complete installed packages for removal or query
def "nu-complete pacman installed-packages" [] {
  ^pacman -Q | lines | split column -n 2 name version | get name
}

# Complete pacman commands
def "nu-complete pacman commands" [] {
  [
    { value: "-S", description: "Install packages" },
    { value: "-R", description: "Remove packages" },
    { value: "-U", description: "Upgrade a package file" },
    { value: "-Q", description: "Query the package database" },
    { value: "-F", description: "Search for a file in the package database" },
    { value: "-D", description: "Manage the package database" },
    { value: "-T", description: "Check for package dependencies" },
    { value: "-Syu", description: "Synchronize and update system" },
    { value: "-Syy", description: "Force refresh all package databases" },
    { value: "-Scc", description: "Clear package cache" }
  ]
}

# Complete pacman options
def "nu-complete pacman options" [] {
  [
    { value: "--noconfirm", description: "Skip confirmation prompts" },
    { value: "--needed", description: "Skip already installed packages" },
    { value: "--overwrite", description: "Overwrite conflicting files" },
    { value: "--asdeps", description: "Mark packages as dependencies" },
    { value: "--asexplicit", description: "Mark packages as explicitly installed" },
    { value: "--print", description: "Print the targets instead of performing the operation" }
  ]
}

# Pacman command with package completion
export extern "pacman" [
  command?: string@"nu-complete pacman commands",  # Pacman command
  ...packages: string@"nu-complete pacman packages",  # Packages to operate on
  --noconfirm,                                     # Skip confirmation prompts
  --needed,                                        # Skip already installed packages
  --overwrite: string,                             # Overwrite conflicting files
  --asdeps,                                        # Mark packages as dependencies
  --asexplicit,                                    # Mark packages as explicitly installed
  --print                                          # Print the targets instead of performing the operation
]