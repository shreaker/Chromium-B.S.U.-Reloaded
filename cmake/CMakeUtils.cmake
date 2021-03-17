macro(store_cache_variable variable)
    set(_${variable} ${${variable}})
endmacro()

macro(load_cache_variable variable type)
    if(DEFINED _${variable})
        set(${variable} ${_${variable}} CACHE ${type} "" FORCE)
        unset(_${variable})
    else()
        unset(${variable} CACHE)
    endif()
endmacro()
