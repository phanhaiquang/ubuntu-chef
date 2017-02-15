Bring up a Ubuntu server automatically by Chef

If you don't change Cheffile, just need steps from 1 -> 3

1) Prepare deploy user
============

  sudo adduser deploy

  sudo vi /etc/sudoers
    root          ALL=(ALL) NOPASSWD: ALL         --> comment out the legacy 'root...' setting & replace by these lines
    deploy        ALL=(ALL) NOPASSWD: ALL
  (if it is not work, put the lines at END of file)

  sudo su deploy
  ssh-keygen -t rsa

  Below steps are to enable ssh (without password) so that everything could run automatically

    sudo cp /root/.ssh/authorized_keys /home/deploy/.ssh/
    sudo chown deploy /home/deploy/.ssh/authorized_keys
    sudo chgrp deploy /home/deploy/.ssh/authorized_keys
    <copy content of ~/.ssh/id_rsa.pub to /home/deploy/.ssh/authorized_keys>

  Copy deploy ~/.ssh/id_rsa.pub to github repo as deploy key
  This is enable `deploy` user (in server) to access your repo,

  Note: This repo is to bring up server only. It does not cover application deployment
  (by capistrano or mina)

2) Install chef-solo on server
============

  ./bin/prepare.rb ./mynodes/<node>.json
  Logfile is saved in 'tmp' folder

3) Update template & node settings
============

   This repo is used for one of my Rails application. It installs
     - locale & timezone
     - change hostname as same as application name
     - install nodejs, redis, postgres, imagemagick, nginx
     - switch to `upstart` & config puma, sidekiq, nginx,...
     - config everything automatically

   To adapt with your project, you may need to change
     - ./mynodes/sample.json
     - ./site-cookbooks/base/templates/* files

   There are many documents to explain how to prepare these files.
   If you concern how my repo works, please create a 'issue' in this repo.
   I will try to response.

4) Bring up server (install everything to server)
============

  ./bin/cook.rb ./mynodes/<node>.json
  Logfile is saved in 'tmp' folder

  At the end, you may need to reboot server by executing 'sudo reboot' on server
  (this is needed before I switched to `upstart`)

4) Prepare cookbooks on local
============

If you use this repo to bring up a server, you don't need this step.
Because they were passed through below steps.

But if you want to re-create the chef-repo, below steps should be done
BEFORE you start steps 1), 2) & 3)

Detail doc: https://matschaffer.github.io/knife-solo/

a) Install knife-solo as a `gem`
============

  First, we need `knife-solo` tool. This tool is used to send cookbooks from
  client to server, as well as send commands (from local to server) to run,
  and show messages (from server to local)

  gem install knife-solo
  gem install knife-solo_data_bag

b) Init a new chef repo
============

  Init new repo
    knife solo init <ubuntu-chef>

  Install chef-solo on server (this is included in ./bin/prepare.rb script)
    knife solo prepare deploy@<ip-addr-of-server>

  Check if install is ok or no
    knife ssl check http://<ip-addr-of-server>>:443
       if failed, copy /var/opt/opscode/nginx/ca/<ip-addr-of-server>.crt to ./.chef/trusted_certs folder
       by below command
         scp root@<ip-addr-of-server>:/var/opt/opscode/nginx/ca/<ip-addr-of-server>.crt ./chef/trusted_certs
       in the case you could not copy due to permission, then copy deploy@128.199.110.22:/home/deploy/128.199.110.22.crt
         scp deploy@<ip-addr-of-server>:/home/deploy/<ip-addr-of-server>.crt ./chef/trusted_certs
       verify the connection
          knife ssl check http://<ip-addr-of-server>:443

c) Install cookbook
============

   Cookbooks are listed in Cheffile. Its func is as same as Gemfile in Ruby On Rails

   Command:
     librarian-chef install --verbose|egrep "Conflict|Performing"
     --> we install & check if there is any 'Conflict' between cookbooks

   In the case of conflict, run with less cookbooks in Cheffile to realize issues
   Note: make sure to install all cookbooks before "cook" step. Although "cook" step includes
   librarian-chef step, but if dependancies conflict happens, it will take a lot of time to resolve.

d) Create your own cookbooks
============

  Will back to explain this part in future :)
  Right now, please refer to 'site-cookbooks/base' folder for my created cookbooks

e) Bring up the server
============

   knife solo cook -VV deploy@<ip-addr-of-server>.json | tee knife-solo.log
   Logfile is saved to "knife-solo.log"

