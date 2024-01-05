source ~/.xinitrc
# Add maven to path
export M2_HOME='/opt/apache-maven-3.8.6'
export PATH="$M2_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export MAVEN_OPTS="-Dconfig.file=$HOME/Source/darwin/localFiles/local.conf"
export EDITOR=nvim
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export MANPAGER='nvim +Man!'
export QT_QPA_PLATFORMTHEME="qt5ct"
