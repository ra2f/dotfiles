# Dotfiles

Personal configuration files for bash and other utilities.

# How to use

```shell
curl -fsSL https://raw.githubusercontent.com/ra2f/dotfiles/main/install/install | bash
```

## Git

## Initialization

```
git config --global user.name "FirstName LastName"
git config --global user.email "<email@example.com>"
echo "email@example.com $(cat ~/.ssh/id_ed25519.pub)" \
  > ~/.config/git/allowed_signers
```

### Maintenance

Marks a repository, so that git in the background will do maintenance tasks
periodically.

```sh
git maintenance start
```
