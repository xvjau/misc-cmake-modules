misc-cmake-modules
==================

For example, these modules could be put into some 'global' directory like:

    /usr/local/share/misc-cmake-modules

This directory could be put into some global enviroment variable like adding to you ~/.bashrc

    export MISC_CMAKE_MODULES='/usr/local/share/misc-cmake-modules'

and then putting the following in you project files:

    find_package(SQLite3 HINTS $ENV{MISC_CMAKE_MODULES})

### CheckForCPP11.cmake

Checks whether C++11 is available in the compiler.

    find_package(CheckForCPP11 HINTS $ENV{MISC_CMAKE_MODULES})
    
    if ( CPP11 )
        message(STATUS "Using C++ 11")
        add_definitions(${CPP11_DEFS})
    else()
        message(STATUS "Not using C++ 11 - falling back to boost.org")
        find_package(Boost)
        if ( ${Boost_INCLUDE_DIRS} )
            include_directories(${Boost_INCLUDE_DIRS})
            add_definitions(-DUSE_BOOST)
        endif()
    endif()


### FreeApache-apr.cmake

Find includes and link flags for Apache APR-1.


### FreeTDSConfig.cmake

Find FreeTDS for MSSQL and Sybase connectivity.


### PCHSupportConfig.cmake

Checks wheter the compiler supports pre-compiled headers.


### SQLite3Config.cmake

Includes and link libraries for SQLite 3.



