.PHONY: all docker-shell docker-% print-%

# Any RPMs that need installing in the build environment
DEPS := deps/binutils-2.36-28.base.xcpng8.2.1.x86_64.rpm
DEPS += help2man

# GIT repo dependencies
BUILDROOT=/root/rpmbuild
XCP_NG_VER := 8.2
DOCKER_IMAGE := xcp-ng/xcp-ng-build-env:$(XCP_NG_VER)
DOCKER_ARGS := 	-v$(PWD)/SOURCES:$(BUILDROOT)/SOURCES/ 	\
				-v$(PWD)/SPECS:$(BUILDROOT)/SPECS/ 		\
				-v$(PWD)/test-certs:/test-certs/ 		\
				-v$(PWD):/source/						\
				-w $(BUILDROOT) 						\
				-e PROJECT_NAME=$(shell basename $(shell pwd))		\
				-it $(DOCKER_IMAGE)

SPEC := $(BUILDROOT)/SPECS/$(PROJECT_NAME).spec

ifneq ($(DEPS),)
all: install_deps
endif

all:
	yum-builddep -y $(SPEC)
	rpmbuild -ba $(SPEC)
	cp $(BUILDROOT)/RPMS/x86_64/* /source/

.PHONY: install_deps
install_deps:
	yum install -y $(DEPS)

docker-all:
	docker run $(DOCKER_ARGS) make -C /source/ all

docker-shell:
	docker run $(DOCKER_ARGS) bash

docker-%:
	docker run $(DOCKER_ARGS) bash -c "cd /source/ && $(notdir $(MAKE)) $* $(MAKEFLAGS)"

print-%:
	@:$(info $($*))
