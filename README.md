# manage-samba-dialog
Facilitates adding/removing samba share folders using dialog interface

# Tutorial

## What you need to begin
You need both samba and dialog installed before you begin. 

Download this script by

```
git clone https://github.com/gunitinug/manage-samba-dialog.git
```

Of course, you need git to do this.

You need to start samba server beforehand. On a Debian-based distro this is done by

```
sudo systemctl start smbd.service
```

Run the program by

```
cd /path/to/manage-samba-dialog
chmod +x ./manage-samba.sh
./manage-samba.sh
```

## Main menu
We will create a public writable shared folder from main menu.
![Main menu](http://pennowebdesign.com/pics_for_manage_samba/main%20menu.png)

## Select shared folder
We will select /home/loganmint/my-scripts/test/ as our shared folder.
![Select shared folder](http://pennowebdesign.com/pics_for_manage_samba/select%20directory.png)

## Fill in form to create shared folder
We are filling in form. You can see that Share name is set to test.
![Fill in form to create shared folder](http://pennowebdesign.com/pics_for_manage_samba/add%20shared%20folder%20form.png)

## Confirm to execute commands
Enter Yes and command is executed. You can see a dialogue saying it has been successfully applied.
![Confirm 1](http://pennowebdesign.com/pics_for_manage_samba/confirm%201.png)
![Success 1](http://pennowebdesign.com/pics_for_manage_samba/success%201.png)
![Confirm 2](http://pennowebdesign.com/pics_for_manage_samba/confirm%202.png)
![Success 2](http://pennowebdesign.com/pics_for_manage_samba/success%202.png)
You can see that both commands are successfully applied. Now the shared folder test is created without errors.

## List shares
It would be good to check our test shared folder is indeed present. We can choose List shares from main menu for this.
![Main menu 2](http://pennowebdesign.com/pics_for_manage_samba/main%20menu%202.png)
Here is the output. You can see test folder is indeed present.
![List shares](http://pennowebdesign.com/pics_for_manage_samba/list%20shares.png)

## Delete share
For demonstration purposes, let's delete the test shared folder that we have just created. After deletion, it won't be shared any more.
You can choose Delete share from main menu.
![Main menu 3](http://pennowebdesign.com/pics_for_manage_samba/main%20menu%203.png)

## Fill in form to delete shared folder
To do so we simply fill in a form with Share name. Here we filled in test.
![Delete share form](http://pennowebdesign.com/pics_for_manage_samba/delete%20share%20form.png)

## Confirm delete command
We confirm the commands to delete test folder.
![Delete confirm 1](http://pennowebdesign.com/pics_for_manage_samba/delete%20share%20confirm.png)
After confirming the first time it tells you it is a success.
![Delete success 1](http://pennowebdesign.com/pics_for_manage_samba/success%203.png)
Second command is also a success.
![Delete confirm 2](http://pennowebdesign.com/pics_for_manage_samba/delete%20share%20confirm%202.png)
![Delete success 2](http://pennowebdesign.com/pics_for_manage_samba/success%204.png)
Now we know that test shared folder is removed from sharing (the folder itself is not deleted).

## Done
In this tutorial, we have created a shared folder, confirmed its presence using list shares, then deleted it. Hope you will find this useful. 

