gitWrapper() {
    if [ "$1" = "push" ] && [ "$2" = "--force" ] || [ "$2" = "-f" ]; then
        echo 'You should use "git push --force-with-lease" instead of "git push --force" to push to remote.'
        return
    fi

    git "$@"
}