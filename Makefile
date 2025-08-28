CC = gcc
CFLAGS = -g -Wall -Wextra -Isrc
LDFLAGS = -lpthread

SRCS = $(wildcard src/*.c)

OBJS_DIR = obj
OBJS = $(patsubst src/%.c, $(OBJS_DIR)/%.o, $(SRCS))
TARGET = test

DEBUG_CFLAGS = $(CFLAGS) -DEVENT_MANAGER_DEBUG
DEBUG_OBJS_DIR = obj_debug
DEBUG_OBJS = $(patsubst src/%.c, $(DEBUG_OBJS_DIR)/%.o, $(SRCS))
DEBUG_TARGET = test_debug

.PHONY: all debug clean

all: $(TARGET)

debug: $(DEBUG_TARGET)

$(TARGET): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

$(DEBUG_TARGET): $(DEBUG_OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

$(OBJS_DIR)/%.o: src/%.c | $(OBJS_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(DEBUG_OBJS_DIR)/%.o: src/%.c | $(DEBUG_OBJS_DIR)
	$(CC) $(DEBUG_CFLAGS) -c $< -o $@

$(OBJS_DIR) $(DEBUG_OBJS_DIR):
	mkdir -p $@

clean:
	rm -rf $(TARGET) $(DEBUG_TARGET) $(OBJS_DIR) $(DEBUG_OBJS_DIR)