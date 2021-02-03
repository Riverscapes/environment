### WSL Environment Bootstrapping

Feb 2, 2021 attempt to quickly bootstrap a linux environment for use with windows WSL2


### Method

1. Follow the [instructions for installing WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10#install-your-linux-distribution-of-choice)
2. Install Windows Terminal and Ubuntu 20.04 from the windows store
3. Load up an Ubuntu window in the windows Terminal
5. Go and make the Network speed improvment:](https://github.com/microsoft/WSL/issues/4901): 
   1. Windows search for "View network connections"
   2. Find the vEthernet (WSL) one and click properties then the configure button
   3. Advanced tab: disable "Large Send Offload Version 2" for both ipv4 and ipv6
5. Now , in the Windows Terminal Ubuntu  Run this:

```
sh -c "$(wget https://raw.githubusercontent.com/MattReimer/environment/master/bootstrap.sh -O -)"
```
 *It will take a while and there will be prompts. When you drop into the oh-my-zsh prompt and it hangs type 'exit' and press enter to finish the install*

6. copy your ssh keys and other config from appropriate places

```bash
cp -fr /mnt/c/Users/MyName/.ssh ~/.ssh
# your id_rsa files need stronger permissions
chmod 600 ~/.ssh/id_rsa*
# then any other config files you may need
cp -fr /mnt/c/path/to/.aws ~/.aws
cp -fr /mnt/c/path/to/.riverscapes ~/.riverscapes
```

#### Now switch to VSCode

1. Make sure you have the Remote-WSL extension installed. 
2. Look for the little green menubar icon in the bottom left of the window. 
3. Connect to a New Remote-WSL: New Window Using Distro. 
4. You may have to choose zsh as your default terminal

#### Optional:

1. In `Docker --> Settings --> Resources --> WSL Integrations` Check the box to allow Docker access from inside your WSL integration


--------------

### How do I?

***NB: All wsl commands should be run in powershell*** 

1. **See what versions of WSL I have running?**

```
wsl --list --verbose
```

2. Shutdown all my WSL2

```
wsl --shutdown
```

2. **Delete my WSL and start over? WARNING!!! Unrecoverable!!!!**

```
 wsl --unregister Ubuntu-20.04
```

Now when you click on the ubuntu item in your start menu it will give you a new install

3. **Limit the RAM my WSL uses**

Create a file in your windows user root `C:\Users\MYACCT\.wslconfig` and paste in the following (this also enables a swap space. DO NOT PUT THE SWAP ON AN SSD. Just ignore that line if you don't want a swap):

```
[wsl2]
memory=6GB
swalFile=E:\\wsl2-swal.vhdx
```

3. **I deleted files in WSL but my C:\ doesn't show any change:**

This one's a bit tricky because the folder to look in shifts around. You need to match the pattern below

```bash
# this is the folder that contains the VM file. You will need to search for it a little
cd $env:LOCALAPPDATA\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState
wsl --shutdown
optimize-vhd -Path .\ext4.vhdx -Mode full
```

--------------------------------------

### Resources

* <https://nickjanetakis.com/blog/3-gotchas-with-wsl-2-around-disk-space-memory-usage-and-performance>
* <https://gist.github.com/noygal/6b7b1796a92d70e24e35f94b53722219>
* <https://docs.microsoft.com/en-us/windows/wsl/install-win10#install-your-linux-distribution-of-choice>