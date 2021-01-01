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

Also you need a configuration file for some of scripts with a name `MyAdm.cfg`. It's just a plain JSON like and it can looks like:

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
