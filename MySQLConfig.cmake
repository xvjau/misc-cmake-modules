# - Try to find the MySQL client library
# based upon GpgmeConfig.
# Once done this will define
#
#  MYSQL_FOUND - system has MySQL
#  MYSQL_INCLUDE_DIR - the MySQL include directory
#  MYSQL_LIBRARY - Link these to use MySQL
# MYSQL_LIBRARY_DIR - Link directories

if ( MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY AND MYSQL_LIBRARY_DIR )

    # Already in cache
    set(MYSQL_FOUND TRUE)

else()

    execute_process(COMMAND mysql_config --libs RESULT_VARIABLE RET OUTPUT_VARIABLE str_libs OUTPUT_STRIP_TRAILING_WHITESPACE)
    if (NOT ${RET} EQUAL 0)
        return()
    endif()

    execute_process(COMMAND mysql_config --cflags RESULT_VARIABLE RET OUTPUT_VARIABLE str_includes OUTPUT_STRIP_TRAILING_WHITESPACE)
    if (NOT ${RET} EQUAL 0)
        return()
    endif()

    string(FIND ${str_libs} " " pos)
    if(${pos} EQUAL -1)
        string(LENGTH ${str_libs} pos)
    endif()

    while(${pos} GREATER 0)
        math(EXPR length "${pos} - 1")
        math(EXPR next "${pos} + 1")
        string(LENGTH ${str_libs} strlength)
        math(EXPR strlength "${strlength} - 1")

        string(SUBSTRING ${str_libs} 1 1 prefix)

        if (length GREATER strlength OR length EQUAL strlength)
            string(SUBSTRING ${str_libs} 2 -1 value)
            set(pos -1)
        else()
            string(SUBSTRING ${str_libs} 2 ${length} value)

            string(SUBSTRING ${str_libs} ${next} -1 str_libs)
            string(FIND ${str_libs} " " pos)
        endif()

        string(STRIP ${value} value)

        if (${prefix} STREQUAL "L")
            list(APPEND MYSQL_LIBRARY_DIR ${value})
        elseif(${prefix} STREQUAL "l")
            list(APPEND MYSQL_LIBRARY ${value})
        endif()
    endwhile()

    string(FIND ${str_includes} " " pos)
    if(${pos} EQUAL -1)
        string(LENGTH ${str_includes} pos)
    endif()

    while(${pos} GREATER 0)
        math(EXPR length "${pos} - 1")
        math(EXPR next "${pos} + 1")
        string(LENGTH ${str_includes} strlength)
        math(EXPR strlength "${strlength} - 1")

        string(SUBSTRING ${str_includes} 1 1 prefix)

        if (length GREATER strlength OR length EQUAL strlength)
            string(SUBSTRING ${str_includes} 2 -1 value)
            set(pos -1)
        else()
            string(SUBSTRING ${str_includes} 2 ${length} value)

            string(SUBSTRING ${str_includes} ${next} -1 str_includes)
            string(FIND ${str_includes} " " pos)
        endif()

        string(STRIP ${value} value)

        if (${prefix} STREQUAL "I")
            list(APPEND MYSQL_INCLUDE_DIR ${value})
        endif()
    endwhile()

    mark_as_advanced(
        MYSQL_LIBRARY
        MYSQL_INCLUDE_DIR
        MYSQL_LIBRARY_DIR
    )

endif()
