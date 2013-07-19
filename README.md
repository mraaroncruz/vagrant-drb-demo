## ((Vagrant + Distributed Ruby)) Demo Example Bootstrap Framework
This was a short demo following a talk given at [viennarb](https://github.com/vienna-rb) about [vagrant](http://vagrantup.com) by [cypher](https://github.com/cypher) on Thursday the 18th of July 2013 at [sektor 5](http://www.sektor5.at/)  
I demonstrated how to create an incredibly simple distributed logger using DRuby and just as easily test it on multiple VMs using vagrant.

## How to use
__Init your boxes__  
The Vagrant is a vagrant init file which creates a server machine where you will run the server.rb file. You will need to change the constant at the top to point at the box name that you have downloaded. For example if you run

    vagrant box add precise64 https://dl.dropbox.com/u/14292474/vagrantboxes/precise64-ruby-1.9.3-p194.box

you would have to change the constant to  `BOX = "precise64"`   

__Run your boxes__  
To run vagrant you just need to run `vagrant up`  
This will import your box and instantiate 1 server VM and 3 client VMs  
You can change the client VM count by instead running `CLIENT_COUNT=10 vagrant up`

__Run the drb server__  
SSH into your server machine `vagrant ssh server` run `cd /vagrant && ruby server.rb` and you should have your drb server running on `33.33.33.100:3030`. The IP address was chosen in the Vagrantfile.

__Log with the simple client__  
In your clients you can now run `ruby simple_server.rb` from the `/vagrant` directory which will print out a hello world message to the server machine's log file. (On the server or host machine you can run `tail -f /vagrant/dev.log` to see a stream of the log)

### Or create a distributed Rails logger
__Install the client gem in your computer__  
on the host machine (your machine, not a VM) cd into the `drb_logger_client` directory and `rake install` (you may have to run `bundle install` as well). This will make your gem available to your client machines (sometimes I have had permission issues in my guests writing a new gem)

__Install client gem on guest client machines__  
SSH into each of client via `vagrant ssh cli_2` which would ssh into the second client box  
After this you would need to `cd /vagrant` which will take you to the directory of the Vagrantfile on the host machine mounted in the client machine (vagrant does this by default)  
Run `gem install drb_logger_client/pkg/drb_logger_client-0.0.1.gem` which will install the client gem on your client.

__Install rails__  
in each of the client machines run `cp -rf /vagrant/rails_app ~` to copy the rails app to your home directory. This again helps when rails trys create files on the host operating system without proper permissions.  

    gem install bundler && rbenv rehash && cd ~/rails_app && bundle install && bundle exec rails s

This may fail and if it does, it is because I am stupid and forgot to ask for no database drivers to be installed when I created the rails app or because you don't have a c compiler installed in you client so I recommend this

    sudo apt-get -y install build-essential sqlite3 libsqlite3-dev

The only thing I have done to the rails app is to change the default logger in `rails_app/config/environments/development.rb` and I added a simple controller, action and route to that controller and action.

If you had errors and installed the packages above, you should be able to run  

    gem install bundler && rbenv rehash && cd ~/rails_app && bundle install && bundle exec rails s

again and your rails apps will be running.

__Make it LOG!__  
In the Vagrantfile we forwarded the default rails port `3000` on our client machines to 4001-400(number of client instances) on our host (your main operating system)  
Now you can visit in your normal browser `http://localhost:4001` or `http://localhost:4002` and if you are still tailing that log, you will see an `OHAI` message and the IP address of the machine that you hit.

### Fuck you that's complicated
I hope you aren't saying this. Once you do it and play around a little bit, this will make a ton of sense. Pretty much, vagrant always will mount the directory you ran `vagrant up` from on `/vagrant` in your guest boxes. That way you have access to your dynamic dev environment in that folder. The permissions thing is what makes everything complicated :(

### Let me know if you are having problems or questions on the Issues page
I don't know how great this works on Windows. Good luck and I will probably not be able to debug any problems with that  
Besides that, I will do my best to make this work and make sense to you

### Thank you [Viennarb](https://github.com/vienna-rb) for letting me present this!!!

### License == MIT
