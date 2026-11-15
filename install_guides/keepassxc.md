# KeePassXC

## Installation

`yay -S --noconfirm keepassxc`

## Pass masterpassword

### First time pass init (optional)

If you already have pass initialized, you can skip this step.

First create a gpg key: `gpg --full-generate-key`

> Select `RSA and RSA` > `key does not expire`
> Change keysize to `4096`.
> You can enter real info, or just "gobbeldygook."

After the creating, look at this section:

```
pub   rsa4096 YYYY-MM-DD [SC]
     <gpg-key>
```

Copy the `gpg-key`, and run: `pass init <gpg-key>`

### Saving the password

Save the master password with `pass insert keepassxc/example-master`

And remember to update `~/.config/hypr/conf/keybindings/bind.lua` to use the same `pass` "path":

```lua
BindDsp(
	MainMod,
	"K",
	jumpOrLaunch({
		l = "pass show keepassxc/exmaple-master | keepassxc --pw-stdin --keyfile ~/.config/keepassxc/Passwords.keyx ~/keepassxc/Passwords.kdbx",
		c = "org.keepassxc.KeePassXC",
		p = "KeePassXC",
		i = "keepassxc",
	})
)
```

## Browser integration

Works natively on vanilla browsers. Just remember to enable "Browser integration" in the KeePassXC settings.

### Zen browser

Run `ln -s ~/.mozilla/native-messaging-hosts ~/.zen/native-messaging-hosts`, and try syncing
