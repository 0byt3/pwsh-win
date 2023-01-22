PowerShell Core Install
=========

Install PowerShel Core on Windows.

Requirements
------------

The following collections are required:
  - ansible.windows
  - community.windows

Role Variables
--------------

- add_ssh_pwsh_subsystem: true or false to indicate whether to add PowerShell Core to sshd_config file to support PowerShell remoting over
SSH. The default is false.

- set_pwsh_as_ssh_default_shell: true or false to indicate whether to make PowerShell Core the default shell for SSH. The default is false.

- working_dir: Path to a directory to copy the MSI for installation. The default is %SystemDrive%\osd\installers .

Example Playbook
----------------

Example 1:

    - hosts: windowsservers
      roles:
        - "pwsh-win"

Example 2:

    - hosts: windowsservers
      vars:
        working_dir: "C:\\deploy"
      roles:
        - "pwsh-win"

Example 3:

    - hosts: windowsservers
      roles:
        - role: "openssh-server-win"
          vars:
            working_dir: "C:\\deploy"

License
-------

MIT

Author Information
------------------

Eric R under Coast Mountains School District 82
