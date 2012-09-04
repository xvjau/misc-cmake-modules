# - Try to find Apache's includes/libs and apr
# Once done this will define
#
#  ApacheAPR_FOUND - system has ApacheAPR
#  ApacheAPR_INCLUDE_DIR - the ApacheAPR include directory
#  ApacheAPR_LINK_FLAGS - Link flags to use ApacheAPR

if (NOT (ApacheAPR_INCLUDE_DIR OR ApacheAPR_LINK_FLAGS ))
	set(ApacheAPR_FOUND FALSE)

	execute_process(COMMAND apr-1-config --includedir RESULT_VARIABLE __apache_apr_ret OUTPUT_VARIABLE ApacheAPR_INCLUDE_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(${__apache_apr_ret})
		execute_process(COMMAND apr-1-config --link-ld RESULT_VARIABLE __apache_apr_ret OUTPUT_VARIABLE ApacheAPR_LINK_FLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
		if(${__apache_apr_ret})
			set(ApacheAPR_FOUND TRUE)
		endif()
	endif()

	find_path(ApacheINCLUDE_DIR httpd.h HINTS /usr/include/apache2)

	if(${ApacheAPR_FOUND})
		mark_as_advanced(ApacheAPR_INCLUDE_DIR ApacheAPR_LINK_FLAGS)
	endif()
endif()
