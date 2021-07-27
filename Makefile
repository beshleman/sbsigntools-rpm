.PHONY: all docker-shell docker-% print-%

# GIT repo dependencies
BUILDROOT=/root/rpmbuild
XCP_NG_VER := 8.2
DOCKER_IMAGE := xcp-ng/xcp-ng-build-env:$(XCP_NG_VER)
DOCKER_ARGS := 	-v$(PWD)/SOURCES:$(BUILDROOT)/SOURCES/ 	\
				-v$(PWD)/SPECS:$(BUILDROOT)/SPECS/ 		\
				-v$(PWD):/source/						\
				-w $(BUILDROOT) 						\
				-it $(DOCKER_IMAGE)

all:
	rpmbuild -ba $(BUILDROOT)/SPECS/uefistored.spec
	cp $(BUILDROOT)/RPMS/x86_64/* /source/

docker-all:
	docker run $(DOCKER_ARGS) make -C /source/ all

docker-shell:
	docker run $(DOCKER_ARGS) bash

docker-%:
	docker run $(DOCKER_ARGS) bash -c "cd /source/ && $(notdir $(MAKE)) $* $(MAKEFLAGS)"

print-%:
	@:$(info $($*))
