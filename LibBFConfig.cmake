# - Try to find BitForge's includes/libs
# Once done this will define
#
#  LibBitForge_FOUND - system has LibBitForge
#  LibBitForge_INCLUDE_DIR - the LibBitForge include directory

if (NOT (LibBitForge_INCLUDE_DIR AND LibBitForge_LIBRARIES))
	set(LibBitForge_FOUND FALSE)

	find_path(LibBitForge_INCLUDE_DIR bf/bf.h HINTS /usr/include/ /usr/local/include)
	find_library(LibBitForge_LIBRARIES bf HINTS /usr/lib/ /usr/local/lib)

	if(${LibBitForge_INCLUDE_DIR})
		mark_as_advanced(LibBitForge_INCLUDE_DIR LibBitForge_LIBRARIES)
	endif()
endif()
 
