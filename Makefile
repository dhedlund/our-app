PROJECT = our

DEPS = cowboy eredis_pool
dep_cowboy = pkg://cowboy 0.9.0
dep_eredis_pool = https://github.com/dhedlund/eredis_pool erlang.mk

include erlang.mk
