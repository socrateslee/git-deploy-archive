# git-deploy-archive
Using git archive to deploy several (or part of) projects.

## Install

```
sudo curl -o `git --exec-path`/git-deploy-archive "https://raw.githubusercontent.com/socrateslee/git-deploy-archive/master/git-deploy-archive.sh"
sudo chmod +x `git --exec-path`/git-deploy-archive
```

## Usage

```
git deploy-archive
git deploy-archive --cfg <config-file>
```

## .git-deploy-archive file
.git-deploy-archive file is a simple configuration file, each line of the file contains 1) remote repo address, 2) treeish, 3) file or directory path to extract, 4) optional local path prefix for content extracted. A sample file is as below:

```
# basic
git@your-repo.com:test master src

# extract a config.json from another repo to config/
git@your-repo.com:conf tag_1.2.0 config.json config

# extract a static/dist folder, and rename prefix from static/dist to dist
git@your-repo.com:frontend master static/dist static_files dist
```

__NOTE__

- [github doesn't support git archive](http://www.gilesorr.com/blog/git-archive-github.html)
- gitlab(ssh address) do support git archive.
