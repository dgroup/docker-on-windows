#### Docker on Windows
##### The pain
Unfortunately, there are a lot of developers who have to work in WinOS. I also have one workstation with WinOS.
The docker doesn't work properly on Win7, thus, we have to use a workaround with Vagrant box.
##### Installation
1. Install `VirtualBox-5.1.14-112924` (or later)
2. Install `vagrant_1.9.1.msi` (or later)
3. Run `create_dev_vm.bat`
##### Vagrant F.A.Q.
1. Basic commands
    ```shell
    vagrant init <box_name>                     # Create a new VM based on <box_name> (new Vagrantfile will be created)
    vagrant global-status                       # Display parameters for the all created VMs
    
    # All comannds below should be executed from the directory with Vagrantfile
    vagrant up                                  # Start up the local VM
    vagrant reload                              # Reboot VM
    vagrant ssh                                 # Connect to the local VM 
    vagrant snapshot save <snapshot_name>       # Create a snapshot of VM 
    vagrant snapshot restore <snapshot_name>    # Restory the VM to the particular snapshot 
    vagrant snapshot delete <snapshot_name>     # Delete particular snapshot of VM
    vagrant ssh-config                          # Show the ssh configuration (port, identity file, etc)
    vagrant suspend                             # Suspend the current state of VM
    vagrant destroy <VM_id>                     # Remove particular VM by id. You can detect the id by `vagrant global-status` command
    ```
2. How can I share the files across host `winOS` and guest Linux VM?
    Check the `config.vm.synced_folder` parameter in `Vagrantfile`.
    
3. How can I call the web applications inside of Docker containers hosted in guest Linux VM?
    Check the `config.vm.network "forwarded_port"` parameter in `Vagrantfile`.
     
##### Docker F.A.Q.
- Prepare environment
    ```bash
    docker start <container_name>               # start particular container
    docker start -i <container_name>            # start particular container in interactive mode
    docker stop <container_name>                # stop particular container
    docker ps                                   # display all running containers
    docker ps -a                                # display all existing containers (stopped)
    docker exec -it <container_name> /bin/bash  # join to the container via bash
    docker rm <container_name>                  # remove particular container
    docker rmi <image_name>                     # remove particular image
    docker pull <image_name>                    # download particular image from the remote repository (NC Artifactory, dockerhub, etc)
    ```
 - Monitoring
    ```bash
    # Display on-line information regarding system usage (CPU,RAM,IO) per container    
    docker stats $(docker ps --format '{{.Names}}')        
    docker stats $(docker ps | awk '{if(NR>1) print $NF}')
    ```