# Install

```bash
# it would be better to make special virtualenv
# for example with virtualenvwrapper
mkvirtualenv vms-lab

# install ansible and all required python packages
pip install -r requirements.txt

# install ansible collection
ansible-galaxy collection install -r ansible-requirements.yml
```