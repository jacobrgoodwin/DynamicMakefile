CXX       := g++
CXXFLAGS  := -std=c++17 \
             -Wall -Wextra -Wpedantic \
             -Wshadow -Wconversion -Wformat=2 \
             -fstack-protector-strong -D_FORTIFY_SOURCE=2 \
             -O2 -flto -fno-omit-frame-pointer \
             -g \
             -Iinclude
LDFLAGS   := -flto -pthread

TARGET    := myapp
SRCDIR    := src
BUILDDIR  := build
BINDIR    := bin

SOURCES   := $(shell find $(SRCDIR) -type f -name '*.cpp')
OBJECTS   := $(patsubst $(SRCDIR)/%.cpp,$(BUILDDIR)/%.o,$(SOURCES))
DEPS      := $(OBJECTS:.o=.d)

.PHONY: all clean dirs

all: dirs $(BINDIR)/$(TARGET)

dirs:
	@mkdir -p $(BUILDDIR) $(BINDIR)

$(BINDIR)/$(TARGET): $(OBJECTS)
	$(CXX) $(LDFLAGS) $^ -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

-include $(DEPS)

clean:
	rm -rf $(BUILDDIR) $(BINDIR)
