#!/bin/bash

download_addr_tar="https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2"

sublime_source=$1

if [ -z $sublime_source ]; then
    sublime_source=./sublime_text_3_build_3126_x64.tar.bz2
fi

if [ -z `which subl | grep subl` ]; then
    if [ ! -e $sublime_source ]; then
        wget $download_addr_tar
        sublime_source=./sublime_text_3_build_3126_x64.tar.bz2
    fi

    # tar -jxvf sublime_text_3_build_3126_x64.tar.bz2 
    tar -jxvf $sublime_source
    mv sublime_text_3 /opt/sublime_text
    if [ ! -e /usr/bin/subl ]; then
        touch /usr/bin/subl 
        echo -e "#!/bin/bash" >> /usr/bin/subl
        echo -e 'exec /opt/sublime_text/sublime_text "$@"' >> /usr/bin/subl
        chmod 755 /usr/bin/subl
    fi

    if which git
    then
        echo ".................Git has installed."
    else
        echo "It seems that you do not installed git."
        echo -n "Do you want to install it? [Y/y]: "

        read git_input

        if [ $git_input == 'Y' ] || [ $git_input == 'y' ]; then
            sudo apt-get update >> /dev/null
            sudo apt-get install -y git >> /dev/null
        else
            echo ''
            echo "******** skipping setup chinese environment for sublime text *********"
        fi
    fi

    if which git
    then
        git clone https://github.com/lyfeyaj/sublime-text-imfix.git
        cd sublime-text-imfix && ./sublime-imfix
        cd ../ && rm -rf sublime-text-imfix
    fi
else
    echo "sublime_text has installed."
fi
