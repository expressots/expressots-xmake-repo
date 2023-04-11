package("scylladb")
    set_homepage("https://github.com/scylladb/cpp-driver")
    set_description("Scylla C/C++ Driver")

    add_urls("https://github.com/scylladb/cpp-driver/archive/refs/tags/$(version).tar.gz",
             "https://github.com/scylladb/cpp-driver.git")
    add_versions("2.16.2b", "25f89d4676f9c9ec8e889c2213d2b3e1e87a71e59c16f66fdd180807bb11b052")

    add_deps("cmake")

    on_install(function (package)
      local configs = {}
      table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
      table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
      import("package.tools.cmake").install(package, configs)
      -- 1. Move current include to include-tmp
      os.mv(path.join(package:installdir(), "include"), path.join(package:installdir(), "include-tmp"))

      -- 2. Create a new include directory
      os.mkdir(path.join(package:installdir(), "include"))

      -- 3. Move the include-tmp to include/scylladb
      os.mv(path.join(package:installdir(), "include-tmp"), path.join(package:installdir(), "include", "scylladb"))
    end)

    on_test(function (package)
      -- TODO: Assert later
      assert(true)
    end)
