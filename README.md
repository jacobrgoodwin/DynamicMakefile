# Dynamic C++17 Makefile

This project includes a flexible, dynamic GNU Makefile designed for small-to-mid-size C++17 projects. It automatically discovers source files, manages dependencies, and supports a robust set of compiler and linker flags for startup-friendly development.

## Prerequisites

* GNU Make (v4.0+)
* A C++17‑capable compiler (e.g., `g++`, `clang++`)
* A Unix‑like shell environment (Linux, macOS, WSL)

## Directory Layout

```
/ (project root)
├── Makefile       # The dynamic build script
├── include/       # Header files (optional)
├── src/           # C++ source files (*.cpp)
├── build/         # Auto-generated object & dependency files
└── bin/           # Final executable output
```

## Usage

From the project root:

```bash
# Build everything (create build/ and bin/, compile, link)
make

# Build in parallel (e.g. use all 8 cores)
make -j8

# Clean all generated files
make clean
```

You can also preview commands without executing:

```bash
make -n
```

Or override variables at runtime:

```bash
# Use clang++ instead of g++
make CXX=clang++

# Add AddressSanitizer and debug info
make CXXFLAGS="-std=c++17 -O0 -g -fsanitize=address" -j4

# Change the output executable name
target=my_new_app make
```

## Makefile Variables

The top of `Makefile` defines several configurable variables:

* `CXX` — C++ compiler (default: `g++`)
* `CXXFLAGS` — Compiler flags (default includes C++17, warnings, optimizations, LTO, hardening, debug info)
* `LDFLAGS` — Linker flags (default enables LTO and threading support)
* `TARGET` — Name of the final executable (default: `myapp`)
* `SRCDIR`, `BUILDDIR`, `BINDIR` — Source, build, and binary directories

## Makefile Targets

* `all` — The default: builds directories, compiles sources, links executable.
* `dirs` — Creates `build/` and `bin/` directories.
* `$(BINDIR)/$(TARGET)` — Links object files into the final binary.
* `$(BUILDDIR)/%.o` — Compiles each `.cpp` to `.o` and generates `.d` dependency files.
* `clean` — Removes `build/` and `bin/` directories and their contents.

## Dependency Tracking

The Makefile uses `-MMD -MP` flags to generate `.d` files alongside each object. These are auto-included, so when a header changes only the affected targets rebuild.

## Customization

* **Release vs Debug**: Remove `-g` and adjust `-O2` to `-O3` (or lower for faster builds).
* **Sanitizers**: Add `-fsanitize=address,undefined` under `CXXFLAGS` for debug.
* **Additional Includes**: Add `-Ithird_party/libfoo/include` to `CXXFLAGS`.
* **Libraries**: Append `-lboost_system -lpthread` to `LDFLAGS` as needed.

> *This README was generated alongside the project’s Makefile to help new contributors get started quickly.*
