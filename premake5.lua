project "GLFW"
  kind "StaticLib"
  language "C"

  targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

  files {
    "include/GLFW/glfw3.h",
    "include/GLFW/glfw3native.h",
    "src/glfw_config.h",
    "src/context.c",
    "src/init.c",
    "src/input.c",
    "src/monitor.c",
    "src/vulkan.c",
    "src/window.c"
  }

  filter "system:macosx"
    buildoptions { "-std=c11" }
    pic "On"
    systemversion "latest"
    staticruntime "On"

    files {
      "src/cocoa_init.m",
      "src/cocoa_monitor.m",
      "src/cocoa_window.m",
      "src/cocoa_time.c",
      "src/posix_thread.c",
      "src/nsgl_context.m",
      "src/egl_context.c",
      "src/osmesa_context.c",
      "src/cocoa_joystick.m"
    }

    defines {
      "_GLFW_COCOA"
    }

    linkoptions { "-framework Cocoa -framework CoreVideo -framework IOKit -framework OpenGL" }

  filter "system:linux"
    pic "On"
    systemversion "latest"
    staticruntime "On"

    files {
      "src/x11_init.c",
      "src/x11_monitor.c",
      "src/x11_window.c",
      "src/xkb_unicode.c",
      "src/posix_time.c",
      "src/posix_thread.c",
      "src/glx_context.c",
      "src/egl_context.c",
      "src/osmesa_context.c",
      "src/linux_joystick.c"
    }

    defines {
      "_GLFW_X11"
    }

  filter "system:windows"
    systemversion "latest"
    staticruntime "On"
        
    files {
      "src/win32_init.c",
      "src/win32_joystick.c",
      "src/win32_monitor.c",
      "src/win32_time.c",
      "src/win32_thread.c",
      "src/win32_window.c",
      "src/wgl_context.c",
      "src/egl_context.c",
      "src/osmesa_context.c"
    }

    defines { 
      "_GLFW_WIN32",
      "_CRT_SECURE_NO_WARNINGS"
    }

  filter { "system:windows", "configurations:Release" }
    buildoptions "/MT"