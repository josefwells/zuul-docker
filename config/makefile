.PHONY: all

OWNERS:=zuul nodepool

zuul_FILELIST:= \
	./var/lib/zuul/.ssh/id_rsa \
	./var/lib/zuul/.ssh/id_rsa.pub \
	./var/lib/zuul/.ssh/known_hosts \
	./etc/zuul/zuul.conf \
	./etc/zuul/main.yaml \
	./etc/zuul/zuul.pem

nodepool_FILELIST:= \
	./var/lib/nodepool/.ssh/id_rsa \
	./var/lib/nodepool/.ssh/id_rsa.pub \
	./etc/nodepool/nodepool.yaml

all: $(addsuffix .tar.gz,${OWNERS})

.SECONDEXPANSION:

%.tar.gz: $${%_FILELIST}
	@rm -f $@
	tar -czf $@ $^

clean:
	rm -Rf $(addsuffix .tar.gz,${OWNERS}) secrets
	git clean -dxf
