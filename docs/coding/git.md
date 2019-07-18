## My first patch
Linux kernel不是pr维护，而是patch mail。

### Edit ~/.gitconfig
```conf
[sendemail]
  smtpuser = username@mail.com
  smtpserver = smtp.mail.com
  smtpencryption = tls
  smtpserverport = 587
  #smtppass =  ;using git send-email; prompts for password
  
```
### Generate Patch file

`git format-patch HEAD~`
`git format-patch HEAD~<number of commits to convert to patches>` turn multiple commits into patch files. These patch files will be emailed to the [Linux Kernel Mailing List (lkml)](https://lkml.org/). They can be applied with `git am <patchfile>`

### Send email
`git send-email`
don't forget to install git-mail git core

## Multiple accounts on Github

```bash
ssh-keygen -t rsa -C "your_name@home_email.com"
ssh-keygen -t rsa -C "your_name@company_email.com"
cd ~/.ssh/
touch config
vim config

# Home account
Host home.github.com
  HostName github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa_home

# Company account
Host company.github.com
  HostName github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa_company

git clone git@home.github.com:xxxxx/xx.git
# 或者更改.git/config中url字段
```

不行的话，执行

```bash
ssh-add -D
ssh-add -s
ssh-add -l
```

## 从历史的提交建立新分支的方法：

方法一： checkout到历史提交，然后checkout -b。
方法二： reset到历史提交，checkout -b，然后再reset到原来的版本。
方法三： git branch `<branch> <start point>`

## 将某个历史版本全部拉到工作区和暂存区：

方法一： 可能的需求是为了将过去删除掉的修改重新应用到最新的版本，这时可以先回到历史版本处建立分支，然后回到原来的最新的版本，进行merge分支的操作。
方法二： reset加上hard参数到需要的历史版本，然后再reset加上soft参数回来。

## 将历史版本的某文件版本拉到当前工作区或者暂存区进行处理：

方法一： git reset HEAD~2 foo.py，直接拉到暂存区。
方法二： git checkout HEAD~2 foo.py，拉到工作区和暂存区。

## 已经有添加到暂存区的文件修改，之后又进行了修改。想要都撤销掉，变为和仓库中的版本相同（仓库覆盖工作和暂存）：

方法一：1、git reset HEAD file 清空暂存区的提交，变为和仓库中的版本相同。2、git checkout  --  file 以暂存区为蓝本，覆盖掉工作区。
方法二：git checkout HEAD --  file 。

## 方法一：git reset --hard HEAD 重设HEAD，hard参数覆盖工作区和暂存区。

方法二：强制切换到其他分支丢弃更改，然后再切回来。

## 撤销当前工作区的文件修改，变为和暂存区相同（暂存覆盖工作）：

方法一：git checkout -- file 暂存区覆盖工作区(以暂存区为蓝本，覆盖掉工作区)。

## 撤销添加到暂存区的文件修改，将修改退回到工作区（暂存先覆盖工作，然后仓库覆盖暂存）：

方法一：1、git checkout  --  file 以暂存区为蓝本，覆盖掉工作区。 2、git reset HEAD file 清空暂存区的提交，变为和仓库中的版本相同。

## 清空暂存区文件修改：

方法一：git reset -- file 清空暂存区的文件修改。

## 清空暂存区：

方法一：git reset HEAD file 清空暂存区。

## checkout文件层面的操作：

主要对暂存区和工作区起作用，一般有暂存区覆盖工作区的行为特征。

## reset文件层面的操作：

主要对暂存区起作用。
https://zhuanlan.zhihu.com/p/31154756