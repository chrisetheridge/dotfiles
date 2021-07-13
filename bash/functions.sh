function git-delete-branches() {
git branch --merged >/tmp/merged-branches && \
  vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches
}