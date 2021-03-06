

#ifndef GHCompatibilityMacros_h
#define GHCompatibilityMacros_h

#ifdef API_UNAVAILABLE
    #define GH_API_UNAVAILABLE(x) API_UNAVAILABLE(x)
#else
    #define GH_API_UNAVAILABLE(x)
#endif // API_UNAVAILABLE

#if __has_warning("-Wunguarded-availability-new")
    #define GH_CAN_USE_AT_AVAILABLE 1
#else
    #define GH_CAN_USE_AT_AVAILABLE 0
#endif

#if ((__IPHONE_OS_VERSION_MAX_ALLOWED && __IPHONE_OS_VERSION_MAX_ALLOWED < 100000) || (__MAC_OS_VERSION_MAX_ALLOWED && __MAC_OS_VERSION_MAX_ALLOWED < 101200) ||(__WATCH_OS_MAX_VERSION_ALLOWED && __WATCH_OS_MAX_VERSION_ALLOWED < 30000) ||(__TV_OS_MAX_VERSION_ALLOWED && __TV_OS_MAX_VERSION_ALLOWED < 100000))
    #define GH_CAN_INCLUDE_SESSION_TASK_METRICS 0
#else
    #define GH_CAN_INCLUDE_SESSION_TASK_METRICS 1
#endif

#endif /* GHCompatibilityMacros_h */
