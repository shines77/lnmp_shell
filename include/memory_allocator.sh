#!/bin/bash

Install_Jemalloc()
{
    Echo_Blue "[+] Installing ${Jemalloc_Ver} ..."
    cd ${cur_dir}/src
    tar jxf ${Jemalloc_Ver}.tar.bz2
    cd ${Jemalloc_Ver}
    ./configure
    make && make install
    ldconfig
}

Install_TCMalloc()
{
    Echo_Blue "[+] Installing ${TCMalloc_Ver} ..."
    if [ "${Is_64bit}" = "y" ]; then
        Tar_Cd ${Libunwind_Ver}.tar.gz ${Libunwind_Ver}
        CFLAGS=-fPIC ./configure
        make CFLAGS=-fPIC
        make CFLAGS=-fPIC install
    fi
    Tar_Cd ${TCMalloc_Ver}.tar.gz ${TCMalloc_Ver}
    if [ "${Is_64bit}" = "y" ]; then
        ./configure
    else
        ./configure --enable-frame-pointers
    fi
    make && make install
    ldconfig
}

# Default choice is not install memory allocator

Install_MemoryAllocator()
{
    if [ "${SelectMalloc}" = "2" ]; then
        Install_Jemalloc
    elif [ "${SelectMalloc}" = "3" ]; then
        Install_TCMalloc
    fi
}
