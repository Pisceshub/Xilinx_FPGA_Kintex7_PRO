# python_work
## create a new repository on the command line   
```
git init
git add README.md 
git commit -m "first commit"  
git branch -M main  
git remote add origin git@github.com:Pisceshub/python_work.git 
git push -u origin main  
```

## push an existing repository from the command line   



```
git remote add origin git@github.com:Pisceshub/- python_work.git  
git branch -M main  
git push -u origin main  
```

## git study command :


### 0. Frequently used：
```
git pull origin main
git merge origin/main --allow-unrelated-histories

git add .
git commit -m "first commit"
git push -u origin main 
git clone  git@github.com:Pisceshub/- python_work.git  python_pro 
```


### 1. git create repository
```
git init  # will create a new .git
git init  newrepo # will create a new newrepo,which include data and resources of the repository
```
### 2. git add file
``` 
git add .
git add *.c  # .c files
git add README # README files
...
```

### 3. git commit 
```
git commit -m "first commit" # '__' that need to notes commit information

```

### 4. git clone repository
```dotnetcli
git clone <repo>  <directory> 
```
### 5. git info
```
git config --list 
# change information :
git config -e    # for the current repository
git config -e --global   # for the global repository

git config --global user.name "your github name "
git config --global user.email your_github_email@runoob.com
```

more information reference to [git base operate](https://www.runoob.com/git/git-basic-operations.html)

###  合并：
```
git merge origin/main --allow-unrelated-histories

```

### ssh公钥问题：Could not open a connection to your authentication agent.
- translate: 无法打开到您的身份验证代理的连接。

```
ssh-agent bash
ssh-add -D
ssh-add C:/Users/Xugx/.ssh/id_rsa

net stop sshd
net start sshd 
```

这是一个测试
```
git add .
git commit -m "first commit"
git push  origin main 
```
 
在其他vscode中使用如下更新

```
git add .
git commit -m "first commit"
git pull origin main
git merge origin/main  --allow-unrelated-histories
```

```
the embedded repository and will not know how to obtain it.        
hint: If you meant to add a submodule, use:
hint: 
hint:   git submodule add <url> DL
hint: 
hint: If you added this path by mistake, you can remove it from the      
hint: index with:
hint: 
hint:   git rm --cached DL
hint: 
hint: See "git help submodule" for more information.
```

git rm --cached .env
git rm -r --cached .
git add .gitignore
