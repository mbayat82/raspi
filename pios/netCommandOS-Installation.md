1. Change Root Password
sudo passwd root

2. Superuser 
su -

3. Install pyenv
sudo curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
exec "$SHELL"
pyenv install 3.11.0

3. Install pipenv
 pip3 install pipenv --break-system-packages

4. Clone Github & Activate pipenv
cd && git clone https://github.com/mbayat82/netCommanDOS.git && cd netCommanDOS
pipenv install

5. Run
pipenv run python3 netCommanDOS.py