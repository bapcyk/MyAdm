# MyAdm - Visual scripts for devops

## Usage

Open Playground and run some visual scripts set (all of them are successors of the `MyAbstractScript`):

```
MyWindowsScript1 new run.
```


or

```
MyKubeScript1 new run.
```

etc.

Also you need a configuration file for some of scripts with a name `MyAdm.cfg` which should be placed in the current working directory (where is Pharo.exe). It's just a plain JSON like and it can looks like:

```
{
  "MyKubeScript1": {
  	"sshAddr": "XX.XX.XX.XX",
  	"sshUser": "XXX",
  	"sshBin": "C:\\WINDOWS\\System32\\OpenSSH\\ssh.exe",
  	"remoteBin": "/home/XXX/bin"
  }
}
```

Interesting parameter here is a `remoteBin`. It is a folder on the remote system (where SSH will connect) where is located `kubectl` command, for example.

## UI

Toolbar buttons execute commands and open a new window with the command's output. If SHIFT key is pressed while the toolbar's button is clicking then the previous window will be closed.
