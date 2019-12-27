project(rime-charcode)
cmake_minimum_required(VERSION 2.8)

option(BUILD_WITH_ICU "Build by explicitly linking to ICU libraries" ON)

if (BUILD_WITH_ICU)
  find_package(ICU COMPONENTS uc)
endif()

find_package(Iconv)
if (ICONV_FOUND)
  include_directories(${ICONV_INCLUDE_DIRS})
endif()

find_package(Boost 1.46.0 REQUIRED COMPONENTS locale)
if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  link_directories(${Boost_LIBRARY_DIRS})
endif()

aux_source_directory(src charcode_src)

add_library(rime-charcode-objs OBJECT ${charcode_src})
if(BUILD_SHARED_LIBS)
  set_target_properties(rime-charcode-objs
    PROPERTIES
    POSITION_INDEPENDENT_CODE ON)
endif()

set(charcode_library rime-charcode)
set(plugin_name ${charcode_library} PARENT_SCOPE)
set(plugin_objs $<TARGET_OBJECTS:rime-charcode-objs> PARENT_SCOPE)
set(charcode_deps
  ${rime_library}
  ${rime_gears_library}
  ${Boost_LIBRARIES}
  ${ICONV_LIBRARIES}
  ${ICU_LIBRARIES})
set(plugin_deps ${charcode_deps} PARENT_SCOPE)
set(plugin_modules "charcode" PARENT_SCOPE)

if(BUILD_TEST AND NOT BUILD_MERGED_PLUGINS)
  add_subdirectory(test)
endif()
