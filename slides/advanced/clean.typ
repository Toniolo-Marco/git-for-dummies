The `git clean` command is a destructive command that is normally used to remove *untracked files*. Files deleted after its use will not be recoverable via git; therefore it needs the `-f` option to be executed.

Multiple options can be combined with this command in order to achieve the desired result; below is the list:


```bash
➜ git clean                 # Alone will always produce this output
    fatal: clean.requireForce is true and -f not given: refusing to clean
➜ git clean -n              # To preview files that will be deleted
➜ git clean --dry-run       # Same as -n
➜ git clean -d              # Remove untracked directories in addition to untracked files
➜ git clean -e  <expr>      # Exclude files matching the given pattern from being removed.
➜ git clean -X              # Remove only files ignored by Git.
➜ git clean -x              # Deletes all untracked files, including those ignored by Git.
➜ git clean -i              # Interactive Mode
➜ git clean -f              # Actually execute git clean
➜ git clean -ff             # Execute git clean recursively in sub-directories
➜ git clean -q              # Suppress the output
```