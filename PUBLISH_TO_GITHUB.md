# Publishing CSC303 labs to GitHub

This folder is **ready for Git** but was not pushed automatically. GitHub access and the destination repository belong to the repository owner.

## Option A — Git commands (SSH)

1. Sign in to GitHub, visit https://github.com/new, and create a repository named `CSC303-Mobile-Application-Development-Labs` (or another name).
2. Choose **Private** first if you are unsure whether every part of the manual is licensed for public distribution.
3. For an **existing local directory**, do **not** initialize the new GitHub repository with a README, `.gitignore`, or license, because these files are already present here.
4. Open a terminal or Git Bash, enter the extracted `CSC303-Mobile-Application-Development-Labs` directory, and run:

```bash
git --version
ssh -T git@github.com
git init -b main
git add .
git status
git commit -m "docs: publish CSC303 Flutter lab manual and source packages"
git remote add origin git@github.com:YOUR_GITHUB_USERNAME/CSC303-Mobile-Application-Development-Labs.git
git push -u origin main
```

Replace `YOUR_GITHUB_USERNAME` and adjust the repository name if needed. The `ssh -T` greeting can report successful authentication while returning status 1; that is normal for GitHub's SSH test. If the SSH setup is not configured, follow GitHub's official SSH guide or use GitHub CLI.

## Option B — GitHub CLI (`gh`)

With GitHub CLI installed and authenticated, run in this repository directory:

```bash
git init -b main
git add .
git commit -m "docs: publish CSC303 Flutter lab manual and source packages"
gh auth login
gh repo create CSC303-Mobile-Application-Development-Labs --private --source=. --remote=origin --push
```

Change `--private` to `--public` only after checking content ownership and permissions.

## Future updates

```bash
git add .
git commit -m "fix: update lab instructions"
git push
```

## Troubleshooting

- **Permission denied (publickey):** Your SSH key is not available to the GitHub account, or the repository belongs to a different account.
- **Repository not found:** Check the owner, name, and access rights.
- **Remote origin already exists:** Run `git remote -v` instead of adding a second `origin`.
- **Non-fast-forward rejection:** The remote already has commits; fetch and reconcile changes before retrying. Do **not** force-push.
- **Rejected secrets:** Review files and remove confidential data before pushing; do not bypass protection for live credentials.

Official source: https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github
