# - Try to find the Gpgme library
# Once done this will define
#
#  Gpgme_FOUND - system has Gpgme
#  Gpgme_INCLUDE_DIR - the Gpgme include directory
#  Gpgme_LIBRARIES - Link these to use Gpgme

if ( Gpgme_INCLUDE_DIR AND Gpgme_LIBRARIES )

	# Already in cache
	set(GPGME_FOUND TRUE)

else()

	execute_process(COMMAND gpgme-config --libs RESULT_VARIABLE RET OUTPUT_VARIABLE str_libs OUTPUT_STRIP_TRAILING_WHITESPACE)
	if (NOT ${RET} EQUAL 0)
		return()
	endif()

	execute_process(COMMAND gpgme-config --cflags RESULT_VARIABLE RET OUTPUT_VARIABLE str_includes OUTPUT_STRIP_TRAILING_WHITESPACE)
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
			list(APPEND GPGME_LIBRARY_DIRS ${value})
		elseif(${prefix} STREQUAL "l")
			list(APPEND GPGME_LIBRARIES ${value})
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
			list(APPEND GPGME_INCLUDE_DIRS ${value})
		endif()
	endwhile()
endif()