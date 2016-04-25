Table of contents
=================

* [Join the \#ramp\-up channel on Puppet Community Slack](#join-the-ramp-up-channel-on-puppet-community-slack)
* [Before starting](#before-starting)
* [What you get from this control\-repo](#what-you-get-from-this-control-repo)
* [How to set it all up](#how-to-set-it-all-up)
  * [Copy this repo into your own Git server](#copy-this-repo-into-your-own-git-server)
    * [GitLab](#gitlab)
    * [Stash](#stash)
    * [GitHub](#github)
  * [Configure PE to use the control\-repo](#configure-pe-to-use-the-control-repo)
    * [Install PE](#install-pe)
    * [Get the control\-repo deployed on your master](#get-the-control-repo-deployed-on-your-master)
  * [Setup a webhook in your Git server](#setup-a-webhook-in-your-git-server)
  * [Test Code Manager](#test-code-manager)
* [Updating from a previous version of PE](#updating-from-a-previous-version-of-pe)
  * [Upgrading to PE2015\.3\.z from PE 2015\.2\.z](#upgrading-to-pe20153z-from-pe-20152z)
* [Appendix](#appendix)
  * [Test the zack/r10k webhook](#test-the-zackr10k-webhook)

# Join the #ramp-up channel on Puppet Community Slack

Our [Puppet Community Slack](http://slack.puppet.com) is a great way to interact with other Puppet users.  The #ramp-up channel is specifically for users talking about starting with PE and using this repository.

Other channels in the Puppet Community Slack are great for asking general Puppet questions as well.

# Before starting

This control-repo and the steps below are intended to be used during a new installation of PE.

The instructions are geared towards a new installation of PE2015.3.z.  However, the control-repo should work just fine on [PE2015.2.z](#upgrading-to-pe20153z-from-pe-20152z)

If you intend to use this control-repo on an existing installation then be warned that if you've already written or downloaded modules when you start using r10k it will remove all of the existing modules and replace them with what you define in your Puppetfile.  Please copy or move your existing modules to another directory to ensure you do not lose any work you've already started.

# What you get from this control-repo

As a result of following the instructions below you will receive the beginning of a best-practices installation of PE including...

 - A Git server
 - The ability to push code to your Git server and have it automatically deployed to your PE master
 - A config_version script to output the commit of code that your agent just applied
 - Optimal tuning of PE settings for this configuration
 - Working and example roles/profiles code

# How to set it all up

## Copy this repo into your own Git server

### GitLab

1. On a new server, install GitLab
 - https://about.gitlab.com/downloads/

2. After GitLab is installed you may sign into the web UI with the `root` user and password `5iveL!fe`

3. In the GitLab UI, make a user for yourself

4. From your laptop or development machine, make an SSH key to link with your user.
 - Note: this is used for your laptop to communicate with your GitLab server to push code
 - https://help.github.com/articles/generating-ssh-keys/
 - http://doc.gitlab.com/ce/ssh/README.html

5. In the GitLab UI, create a group called `puppet` ( this is case sensitive )
 - http://doc.gitlab.com/ce/workflow/groups.html

7. In the GitLab UI, add your user to the `puppet` group
 - Make sure to give your user at least master permissions so you can complete the below steps
 - Read more about permissions:
    - https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/permissions/permissions.md

8. In the GitLab UI, create a project called `control-repo` and set the Namespace to be the `puppet` group

10. On your laptop, clone this GitHub control repo
 - `git clone <repo URL>`
 - `cd control-repo`

14. On your laptop, remove the origin remote
 - `git remote remove origin`

15. On your latptop, add your internal repo as the origin remote
 - `git remote add origin <SSH URL of your GitLab repo>`

16. On your laptop, push the production branch of the repo from your machine up to your Git server
 - `git push origin production`

### Stash

Coming soon!

### GitHub

Coming soon!

## Configure PE to use the control-repo

### Install PE

1. Download the latest version of the PE installer for your platform
 - https://puppetlabs.com/download-puppet-enterprise
2. SSH into your Puppet master and copy the installer tarball into `/tmp`
2. Expand the tarball and `cd` into the directory
3. Run `puppet-enterprise-installer` to install

If you run into any issues or have more questions about the installer you can see our docs here:

http://docs.puppetlabs.com/pe/latest/install_basic.html

### Get the control-repo deployed on your master

At this point you have our control-repo code deployed into your Git server.  However, we have one final challenge: getting that code onto your Puppet master.  In the end state the master will pull code from the Git server via Code Manager, however, at this moment your Puppet master does not have credentials to get code from the Git server.

So, we will set up a deploy key in the Git server that will allow an SSH key we make to deploy the code and configure everything else.

1. On your Puppet master, make an SSH key for r10k to connect to GitLab
 - `/usr/bin/ssh-keygen -t rsa -b 2048 -C 'code_manager' -f /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa -q -N ''`
 - `cat /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub`
 - References:
    - https://help.github.com/articles/generating-ssh-keys/
    - http://doc.gitlab.com/ce/ssh/README.html
2. In the GitLab UI, create a deploy key on the `control-repo` project
 - Paste in the public key from above
3. Login to the PE console
4. Navigate to the **Nodes > Classification** page
 - Click on the **PE Master** group
 - Click the **Classes** tab
 - Add the `puppet_enterprise::profile::master`
    - Set the `r10k_remote` to the SSH URL from the front page of your GitLab repo
    - Set the `r10k_private_key` parameter to `/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa`
 - **Commit** your changes
5. On your Puppet master
 - Run:

    ~~~
    puppet agent -t
    r10k deploy environment -pv
    puppet agent -t
    ~~~

5. Navigate back to the **Nodes > Classification** page
 - Near the top of the page select "add a group"
 - Type `role::all_in_one_pe` for the group name
    - Click the **Add Group** button
 - Click the **add membership rules, classes and variables** link that appears
    - Below **Pin specific nodes to the group** type your master's FQDN into the box
       - Click **pin node**
 - Select the **Classes** tab
    - On the right hand side, click the **Refresh** link
       - Wait for this to complete
    - In the **add new classes** box type `role::all_in_one_pe`
       - Click **add class**
 - **Commit** your changes
8. On your Puppet master
 - Run:

    ~~~
    puppet agent -t
    echo 'code_manager_mv_old_code=true' > /opt/puppetlabs/facter/facts.d/code_manager_mv_old_code.txt
    puppet agent -t
    ~~~

9. Code Manager is configured and has been used to deploy your code

## Setup a webhook in your Git server

1. On your Puppet master
 - `cat /etc/puppetlabs/puppetserver/.puppetlabs/webhook_url.txt`
2. In your Git server's UI, add a webhook to the control-repo repository
 - You can paste the above webhook URL
3. Disable SSL verification on the webhook
 - Since Code Manager uses a self-signed cert from the Puppet CA it is not generally trusted
3. After you created the webhook use "test webhook" or similar functionality to confirm it works

## Test Code Manager

One of the components setup by this control-repo is that when you "push" code to your Git server, the git server will inform the Puppet master to deploy branch you just pushed.

1. In one terminal window, `tail -f /var/log/puppetlabs/puppetserver/puppetserver.log`
2. In a second terminal window
 - Add a new file, `touch test_file`
 - `git add test_file`
 - `git commit -m "adding a test_file"`
 - `git push origin production`
3. Allow the push to complete and then wait a few seconds for everything to sync over
 - `ls -l /etc/puppetlabs/code/environments/production`
    - Confirm test_file is present
4. In your first terminal window review the `puppetserver.log` to see the type of logging each sync will create

----
# Updating from a previous version of PE

## Upgrading to PE 2015.3.z from PE 2015.2.z

Remove `pe_r10k` from the PE master group in the console and instead add the following two parameters to the `puppet_enterprise::profile::master` class under the PE master group.

- `r10k_remote` = the SSH URL for your internal repo
- `r10k_private_key` = `/etc/puppetlabs/puppetserver/code_manager.key`

When upgrading the `puppet_enterprise::profile::master` class has the `file_sync_enabled` parameter set to `false`.  This parameter should be removed so that Code Manager can configure file sync.

Finally, you’ll need to `echo 'code_manager_mv_old_code=true' > /opt/puppetlabs/facter/facts.d/code_manager_mv_old_code.txt` so that my Puppet code will redeploy all of your code with Code Manager.

# Appendix

## Test the zack/r10k webhook

If you are using PE2015.2.z or if you've forced the use of the zack/r10k webhook then you'll want to test that it works.

One of the components setup by this control-repo is that when you "push" code to your Git server, the Git server will inform the Puppet master to run `r10k deploy environment -p`.

1. Edit README.md
 - Just add something to it
2. `git add README.md`
3. `git commit -m "edit README"`
4. `git push origin production`
5. Allow the push to complete and then give it few seconds to complete
 - Open `/etc/puppetlabs/code/environments/production/README.md` and confirm your change is present
