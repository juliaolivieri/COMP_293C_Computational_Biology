# Helpful commands for the project

## Copying files between local computer and the cluster

### Mac

To copy the file `foobar.txt` from your local computer to the cluster, follow these steps:

1. Open Terminal.
1. Use `cd` to navigate to the directory where `foobar.txt` is located. Note: On a Mac, dragging a file into the Terminal will give you its fill path.
1. We'll use the `scp` command to copy the file. If we want to copy it into the directory `~/COMP_293C` on the cluster, you could run the following command:
   ```
   scp foobar.txt <your cluster username>@ecs-cluster.serv.pacific.edu:~/COMP_293C
   ```
   So, for example, I would use:
   ```
   scp foobar.txt jolivieri@ecs-cluster.serv.pacific.edu:~/COMP_293C
   ```
1. You should be prompted for your cluster password. Enter it. 
1. The file should now be present in `~/COMP_293C` on the cluster.

To copy the file `foobar.txt` from `~/COMP_293C` on the cluster to your local computer:
1. Open Terminal. 
1. Log into the cluster.
1. Use `cd` to navigate to the directory where `foobar.txt` is located (in this case, `~/COMP_293C`).
1. Run the following command:
   ```
   scp  <your cluster username>@ecs-cluster.serv.pacific.edu:~/COMP_293C/foobar.txt .
   ```
   So, for example, I would use:
   ```
   scp  jolivieri@ecs-cluster.serv.pacific.edu:~/COMP_293C/foobar.txt .
   ```
1. You should be prompted for your cluster password. Enter it. 
1. The file should now be present on your local computer. 
