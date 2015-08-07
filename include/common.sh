
#!/bin/bash

Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo $(Color_Text "$1" "31")
}

Echo_Green()
{
  echo $(Color_Text "$1" "32")
}

Echo_Yellow()
{
  echo $(Color_Text "$1" "33")
}

Echo_Blue()
{
  echo $(Color_Text "$1" "34")
}

Check_Is_Root_Account()
{
#   // Check whether the logon user is a root account?
    if [ $(id -u) != "0" ]; then
        Echo_Red "Error: You must logon a root account to run this script, please use root account to install the lnamp."
        exit 1
    fi
}
