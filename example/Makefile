#: Remove files created by example programs
clean: clean
	rm -f copying || true

#=============================================================
# Whatever else it is you want to do, it should be handled by the 
# by the main (parent) Makefile. So reissue make from there.
all %:
	$(MAKE) -C .. $@
