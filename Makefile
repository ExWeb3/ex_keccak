CFLAGS = -g -O3 -Wall -Wno-format-truncation
CXXFLAGS = --std=c++17 -g -O3 -Wall -Wno-format-truncation

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS += -I"$(ERLANG_PATH)" -Ic_src -fPIC
CXXFLAGS += -I"$(ERLANG_PATH)" -Ic_src -fPIC
# LDFLAGS += -llzo2

LIB_NAME = priv/keccak_nif.so

NIF_SRC = c_src/keccak_nif.c c_src/sha3.c

all: $(LIB_NAME)

$(LIB_NAME): $(NIF_SRC)
	mkdir -p priv
	$(CC) $(CFLAGS) -shared $^ $(LDFLAGS) -o $@

clean:
	rm -f $(LIB_NAME)

.PHONY: all clean