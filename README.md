# Install

```bash
# it would be better to make special virtualenv
# for example with virtualenvwrapper
# --system-site-packages required due to we need to have access to system python-apt package
mkvirtualenv vms-lab --system-site-packages

# install ansible and all required python packages
pip install -r requirements.txt

# install ansible collection
ansible-galaxy collection install -r ansible-requirements.yml
```