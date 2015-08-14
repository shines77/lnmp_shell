
#!/bin/bash

# Check the variant whether is a number?

function Check_Integer()
{
    if [ $# -lt 1 ]; then
        echo "Error: No input args."
        exit 1
    else
        # Filter integer numbers [0-9]
        local tmp=`echo $1 | sed 's/[0-9]//g'`
        # Filter integer sign
        tmp=`echo ${tmp} | sed 's/-//g'`
        tmp=`echo ${tmp} | sed 's/+//g'`
        [ -n "${tmp}" ] && { echo "Error: Args '"$1"' must be a integer!"; exit 1; }
    fi
}

# If the input argument is not a integer, will be return 0.

function Get_Integer()
{
    if [ $# -lt 1 ]; then
        echo "0"
        exit 1
    else
        # Filter integer numbers [0-9]
        local tmp=`echo $1 | sed 's/[0-9]//g'`
        # Filter integer sign
        tmp=`echo ${tmp} | sed 's/-//g'`
        tmp=`echo ${tmp} | sed 's/+//g'`
        [ -n "${tmp}" ] && { echo "0"; exit 1; }
        [ ! -n "${tmp}" ] && { echo $1; exit 0; }
    fi
}

# Get a integer ABS() value

function Integer_ABS()
{
    if [ $# -lt 1 ]; then
        echo "0"
    else
        local tmp=`echo $1 | sed 's/-//g'`
        tmp=`echo ${tmp} | sed 's/+//g'`
        echo ${tmp}
    fi
}

# Randomize number and randomize password

function Random_Number()
{
    local Min=$1
    local Max=$2
    local Temp=${Max}
    local RndNum=${RANDOM}*32768+${RANDOM}
    local RetNum=0
    Min=$(Get_Integer ${Min})
    if [ ${Min} -lt 0 ]; then
        Min=${Min}
        # Min=$(Integer_ABS ${Min})
    fi
    Max=$(Get_Integer ${Max})
    if [ ${Max} -lt 0 ]; then
        Max=${Max}
        # Max=$(Integer_ABS ${Max})
    fi
    if [ ${Min} -gt ${Max} ]; then
        Temp=${Max}
        Max=${Min}
        Min=${Temp}
    fi
    if [ $# -ge 3 ]; then
        echo "["${Min},${Max}"]:"
    fi
    if [ ${Min} -eq ${Max} ]; then
        ((RetNum=Min));
    else
        ((RetNum=RndNum%(Max-Min+1)+Min));
    fi
    echo ${RetNum}
}

# Generate the randomize password of specified length

function Generate_Random_Password()
{
    local Password_Chars_Default="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~#=!@$"
    local Password_Chars=$1
    local Length_Min=14
    local Length_Max=14
    local Chars_Length=14
    local Len=1
    local Password=""
    if [ $# -eq 0 ]; then
        # When args = 0
        Password_Chars=${Password_Chars_Default}
    elif [ $# -eq 2 ]; then
        # When args = 2
        Length_Min=$2
        Length_Max=$2
        Chars_Length=$2
    elif [ $# -ge 3 ]; then
        # When args >= 3
        Length_Min=$2
        Length_Max=$3
        Chars_Length=$(Random_Number $Length_Min $Length_Max)
    fi
    # The password minimum length is 4.
    if [ ${Chars_Length} -lt 4 ]; then
        Chars_Length=4
    fi
    while [ "${Len}" -le "${Chars_Length}" ];
    do
        Password="${Password}${Password_Chars:$((${RANDOM}%${#Password_Chars})):1}"
        let Len+=1
    done

    if [ $# -ge 4 ]; then
        # When args >= 4
        Password="${Chars_Length}|${Password}"
    fi

    echo "${Password}"
}

function Random_Password_Base64()
{
    local Password_Chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~#"
    local Password=$(Generate_Random_Password ${Password_Chars} $@)
    echo "${Password}"
}

function Random_Password_Wide()
{
    local Password_Chars="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz~!@#$%^&*()+="
    local Password=$(Generate_Random_Password ${Password_Chars} $@)
    echo "${Password}"
}

function Random_Password()
{
    local Password=$(Random_Password_Base64 $@)
    echo "${Password}"
}

function Test_System_Random()
{
    local i=0
    local out=""
    for i in {1..10};
    do
        out=$RANDOM;
        echo $i,"System RANDOM [1-100000]",$out;
    done;
}

function Test_Random_Number()
{
    local i=0
    local out=""
    local RndRange=$(Random_Number 0 1000)
    echo "Random Number is [0-1000]: "$RndRange
    echo ""
    for i in {1..10};
    do
        out=$(Random_Number 2 "9999");
        echo $i,"Random_Number [2-9999]",$out;
    done;
}

function Test_Random_Password()
{
    local RndPassword=""
    echo "Random_Password_Base64():"
    echo ""
    RndPassword=$(Random_Password)
    echo "Random Password is [length = default]: "$RndPassword
    RndPassword=$(Random_Password 12)
    echo "Random Password is [length = 12]:      "$RndPassword
    RndPassword=$(Random_Password 12 14 1)
    echo "Random Password is [length = 12-14]:   "$RndPassword
    echo ""

    echo "Random_Password_Wide():"
    echo ""
    RndPassword=$(Random_Password_Wide)
    echo "Random Password is [length = default]: "$RndPassword
    RndPassword=$(Random_Password_Wide 12)
    echo "Random Password is [length = 12]:      "$RndPassword
    RndPassword=$(Random_Password_Wide 12 14 1)
    echo "Random Password is [length = 12-14]:   "$RndPassword
}

# Test Random functions

function Test_Random()
{
    Test_System_Random
    echo ""
    Test_Random_Number
    echo ""
    Test_Random_Password
    echo ""
}

# About shell Echo_RGBs()

Color_Text()
{
    echo -e "\e[0;$2m$1\e[0m"
}

Echo_Red()
{
    Color_Text "$1" "31"
}

# Check whether the logon user is a root account?

Check_Is_Root_Account()
{
    if [ $(id -u) != "0" ]; then
        Echo_Red "Error: You must logon a root account to run this lnamp script, please try again."
        exit 1
    fi
}

Echo_Green()
{
    Color_Text "$1" "32"
}

Echo_Yellow()
{
    Color_Text "$1" "33"
}

Echo_Blue()
{
    Color_Text "$1" "34"
}

Echo_Magenta()
{
    Color_Text "$1" "35"
}

Echo_Cyan()
{
    Color_Text "$1" "36"
}

# About shell Echo_RGBs_Ex()

Color_Text_Ex()
{
    echo -e "$1\e[0;$4m$2\e[0m$3"
}

Echo_Red_Ex()
{
    Color_Text_Ex "$1" "$2" "$3" "31"
}

Echo_Green_Ex()
{
    Color_Text_Ex "$1" "$2" "$3" "32"
}

Echo_Yellow_Ex()
{
    Color_Text_Ex "$1" "$2" "$3" "33"
}

Echo_Blue_Ex()
{
    Color_Text_Ex "$1" "$2" "$3" "34"
}

Echo_Magenta_Ex()
{
    Color_Text_Ex "$1" "$2" "$3" "35"
}

Echo_Cyan_Ex()
{
    Color_Text_Ex "$1" "$2" "$3" "36"
}

# About shell Echo_RGBs_Blod()

Color_Text_Blod()
{
    echo -e "\e[1;$2m$1\e[0m"
}

Echo_Red_Blod()
{
    Color_Text_Blod "$1" "31"
}

Echo_Green_Blod()
{
    Color_Text_Blod "$1" "32"
}

Echo_Yellow_Blod()
{
    Color_Text_Blod "$1" "33"
}

Echo_Blue_Blod()
{
    Color_Text_Blod "$1" "34"
}

Echo_Magenta_Blod()
{
    Color_Text_Blod "$1" "35"
}

Echo_Cyan_Blod()
{
    Color_Text_Blod "$1" "36"
}

# About shell Echo_RGBs_Blod_Ex()

Color_Text_Blod_Ex()
{
    echo -e "$1\e[1;$4m$2\e[0m$3"
}

Echo_Red_Blod_Ex()
{
    Color_Text_Blod_Ex "$1" "$2" "$3" "31"
}

Echo_Green_Blod_Ex()
{
    Color_Text_Blod_Ex "$1" "$2" "$3" "32"
}

Echo_Yellow_Blod_Ex()
{
    Color_Text_Blod_Ex "$1" "$2" "$3" "33"
}

Echo_Blue_Blod_Ex()
{
    Color_Text_Blod_Ex "$1" "$2" "$3" "34"
}

Echo_Magenta_Blod_Ex()
{
    Color_Text_Blod_Ex "$1" "$2" "$3" "35"
}

Echo_Cyan_Blod_Ex()
{
    Color_Text_Blod_Ex "$1" "$2" "$3" "36"
}

# About shell Echo_RGBs_HalfLight()

Color_Text_HL()
{
    echo -e "\e[2;$2m$1\e[0m"
}

Echo_Red_HL()
{
    Color_Text_HL "$1" "31"
}

Echo_Green_HL()
{
    Color_Text_HL "$1" "32"
}

Echo_Yellow_HL()
{
    Color_Text_HL "$1" "33"
}

Echo_Blue_HL()
{
    Color_Text_HL "$1" "34"
}

Echo_Magenta_HL()
{
    Color_Text_HL "$1" "35"
}

Echo_Cyan_HL()
{
    Color_Text_HL "$1" "36"
}

# About shell Echo_RGBs_HalfLight_Ex()

Color_Text_HL_Ex()
{
    echo -e "$1\e[2;$4m$2\e[0m$3"
}

Echo_Red_HL_Ex()
{
    Color_Text_HL_Ex "$1" "$2" "$3" "31"
}

Echo_Green_HL_Ex()
{
    Color_Text_HL_Ex "$1" "$2" "$3" "32"
}

Echo_Yellow_HL_Ex()
{
    Color_Text_HL_Ex "$1" "$2" "$3" "33"
}

Echo_Blue_HL_Ex()
{
    Color_Text_HL_Ex "$1" "$2" "$3" "34"
}

Echo_Magenta_HL_Ex()
{
    Color_Text_HL_Ex "$1" "$2" "$3" "35"
}

Echo_Cyan_HL_Ex()
{
    Color_Text_HL_Ex "$1" "$2" "$3" "36"
}

# This is a echo color test

Echo_Color_Test()
{
    echo ""
    Echo_Red "This is Red color."
    Echo_Red_HL "This is Red HL color."
    Echo_Red_Blod "This is Red blod color."
    echo ""

    Echo_Green "This is Green color."
    Echo_Green_HL "This is Green HL color."
    Echo_Green_Blod "This is Green blod color."
    echo ""

    Echo_Blue "This is Blue color."
    Echo_Blue_HL "This is Blue HL color."
    Echo_Blue_Blod "This is Blue blod color."
    echo ""

    Echo_Yellow "This is Yellow color."
    Echo_Yellow_HL "This is Yellow HL color."
    Echo_Yellow_Blod "This is Yellow blod color."
    echo ""

    Echo_Magenta "This is Magenta color."
    Echo_Magenta_HL "This is Magenta HL color."
    Echo_Magenta_Blod "This is Magenta blod color."
    echo ""

    Echo_Cyan "This is Cyan color."
    Echo_Cyan_HL "This is Cyan HL color."
    Echo_Cyan_Blod "This is Cyan blod color."
    echo ""
}

# This is a echo color extend mode test

Echo_Color_Ex_Test()
{
    local prefix_text=" |  <<<      "
    local suffix_text="      >>>  | "
    echo ""
    Echo_Red_Ex "${prefix_text}" "This is Red color.         " "${suffix_text}"
    Echo_Red_HL_Ex "${prefix_text}" "This is Red HL color.      " "${suffix_text}"
    Echo_Red_Blod_Ex "${prefix_text}" "This is Red blod color.    " "${suffix_text}"
    echo ""

    Echo_Green_Ex "${prefix_text}" "This is Green color.       " "${suffix_text}"
    Echo_Green_HL_Ex "${prefix_text}" "This is Green HL color.    " "${suffix_text}"
    Echo_Green_Blod_Ex "${prefix_text}" "This is Green blod color.  " "${suffix_text}"
    echo ""

    Echo_Blue_Ex "${prefix_text}" "This is Blue color.        " "${suffix_text}"
    Echo_Blue_HL_Ex "${prefix_text}" "This is Blue HL color.     " "${suffix_text}"
    Echo_Blue_Blod_Ex "${prefix_text}" "This is Blue blod color.   " "${suffix_text}"
    echo ""

    Echo_Yellow_Ex "${prefix_text}" "This is Yellow color.      " "${suffix_text}"
    Echo_Yellow_HL_Ex "${prefix_text}" "This is Yellow HL color.   " "${suffix_text}"
    Echo_Yellow_Blod_Ex "${prefix_text}" "This is Yellow blod color. " "${suffix_text}"
    echo ""

    Echo_Magenta_Ex "${prefix_text}" "This is Magenta color.     " "${suffix_text}"
    Echo_Magenta_HL_Ex "${prefix_text}" "This is Magenta HL color.  " "${suffix_text}"
    Echo_Magenta_Blod_Ex "${prefix_text}" "This is Magenta blod color." "${suffix_text}"
    echo ""

    Echo_Cyan_Ex "${prefix_text}" "This is Cyan color.        " "${suffix_text}"
    Echo_Cyan_HL_Ex "${prefix_text}" "This is Cyan HL color.     " "${suffix_text}"
    Echo_Cyan_Blod_Ex "${prefix_text}" "This is Cyan blod color.   " "${suffix_text}"
    echo ""
}
