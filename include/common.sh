
#!/bin/bash

# About shell Echo_RGBs()

Color_Text()
{
    echo -e "\e[0;$2m$1\e[0m"
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

Echo_Magenta()
{
    echo $(Color_Text "$1" "35")
}

Echo_Cyan()
{
    echo $(Color_Text "$1" "36")
}

# About shell Echo_RGBs_Ex()

Color_Text_Ex()
{
    echo -e "$1\e[0;$4m$2\e[0m$3"
}

Echo_Red_Ex()
{
    echo $(Color_Text_Ex "$1" "$2" "$3" "31")
}

Echo_Green_Ex()
{
    echo $(Color_Text_Ex "$1" "$2" "$3" "32")
}

Echo_Yellow_Ex()
{
    echo $(Color_Text_Ex "$1" "$2" "$3" "33")
}

Echo_Blue_Ex()
{
    echo $(Color_Text_Ex "$1" "$2" "$3" "34")
}

Echo_Magenta_Ex()
{
    echo $(Color_Text_Ex "$1" "$2" "$3" "35")
}

Echo_Cyan_Ex()
{
    echo $(Color_Text_Ex "$1" "$2" "$3" "36")
}

# About shell Echo_RGBs_Blod()

Color_Text_Blod()
{
    echo -e "\e[1;$2m$1\e[0m"
}

Echo_Red_Blod()
{
    echo $(Color_Text_Blod "$1" "31")
}

Echo_Green_Blod()
{
    echo $(Color_Text_Blod "$1" "32")
}

Echo_Yellow_Blod()
{
    echo $(Color_Text_Blod "$1" "33")
}

Echo_Blue_Blod()
{
    echo $(Color_Text_Blod "$1" "34")
}

Echo_Magenta_Blod()
{
    echo $(Color_Text_Blod "$1" "35")
}

Echo_Cyan_Blod()
{
    echo $(Color_Text_Blod "$1" "36")
}

# About shell Echo_RGBs_Blod_Ex()

Color_Text_Blod_Ex()
{
    echo -e "$1\e[1;$4m$2\e[0m$3"
}

Echo_Red_Blod_Ex()
{
    echo $(Color_Text_Blod_Ex "$1" "$2" "$3" "31")
}

Echo_Green_Blod_Ex()
{
    echo $(Color_Text_Blod_Ex "$1" "$2" "$3" "32")
}

Echo_Yellow_Blod_Ex()
{
    echo $(Color_Text_Blod_Ex "$1" "$2" "$3" "33")
}

Echo_Blue_Blod_Ex()
{
    echo $(Color_Text_Blod_Ex "$1" "$2" "$3" "34")
}

Echo_Magenta_Blod_Ex()
{
    echo $(Color_Text_Blod_Ex "$1" "$2" "$3" "35")
}

Echo_Cyan_Blod_Ex()
{
    echo $(Color_Text_Blod_Ex "$1" "$2" "$3" "36")
}

# About shell Echo_RGBs_HalfLight()

Color_Text_HL()
{
    echo -e "\e[2;$2m$1\e[0m"
}

Echo_Red_HL()
{
    echo $(Color_Text_HL "$1" "31")
}

Echo_Green_HL()
{
    echo $(Color_Text_HL "$1" "32")
}

Echo_Yellow_HL()
{
    echo $(Color_Text_HL "$1" "33")
}

Echo_Blue_HL()
{
    echo $(Color_Text_HL "$1" "34")
}

Echo_Magenta_HL()
{
    echo $(Color_Text_HL "$1" "35")
}

Echo_Cyan_HL()
{
    echo $(Color_Text_HL "$1" "36")
}

# About shell Echo_RGBs_HalfLight_Ex()

Color_Text_HL_Ex()
{
    echo -e "$1\e[2;$4m$2\e[0m$3"
}

Echo_Red_HL_Ex()
{
    echo $(Color_Text_HL_Ex "$1" "$2" "$3" "31")
}

Echo_Green_HL_Ex()
{
    echo $(Color_Text_HL_Ex "$1" "$2" "$3" "32")
}

Echo_Yellow_HL_Ex()
{
    echo $(Color_Text_HL_Ex "$1" "$2" "$3" "33")
}

Echo_Blue_HL_Ex()
{
    echo $(Color_Text_HL_Ex "$1" "$2" "$3" "34")
}

Echo_Magenta_HL_Ex()
{
    echo $(Color_Text_HL_Ex "$1" "$2" "$3" "35")
}

Echo_Cyan_HL_Ex()
{
    echo $(Color_Text_HL_Ex "$1" "$2" "$3" "36")
}

# This is a echo color test

Echo_Color_Test()
{
    Echo_Red "This is Red color."
    Echo_Red_Blod "This is Red blod color."

    Echo_Green "This is Green color."
    Echo_Green_Blod "This is Green blod color."

    Echo_Blue "This is Blue color."
    Echo_Blue_Blod "This is Blue blod color."

    Echo_Yellow "This is Yellow color."
    Echo_Yellow_Blod "This is Yellow blod color."

    Echo_Magenta "This is Magenta color."
    Echo_Magenta_Blod "This is Magenta blod color."

    Echo_Cyan "This is Cyan color."
    Echo_Cyan_Blod "This is Cyan blod color."
}

# Check whether the logon user is a root account?

Check_Is_Root_Account()
{
    if [ $(id -u) != "0" ]; then
        Echo_Red "Error: You must logon a root account to run this script, please use root account to install the lnamp."
        exit 1
    fi
}
