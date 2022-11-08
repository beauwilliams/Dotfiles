all: lua/init.lua

lua/%.lua: fnl/%.fnl
	fennel --compile $< > $@
