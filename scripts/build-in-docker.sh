#!/bin/bash
#
# Copyright (c) 2016,2017 the Server Mechanic Team.
# Server Mechanic (http://server-mechanic.org)
#
# This file is part of Server Mechanic.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#

PROJECT_DIR=$(cd `dirname $0`/..; pwd)

cd $PROJECT_DIR
docker build -t mechanic-build -f $PROJECT_DIR/build-container/Dockerfile $PROJECT_DIR/build-container
docker run --rm \
	-e FIX_UID=$(id --user $USER) \
	-e FIX_GID=$(id --group $USER) \
	-v $PROJECT_DIR:/build \
	mechanic-build \
	/bin/bash -xc "cd /build && make clean compile integration-tests && chown -R \$FIX_UID.\$FIX_GID /build"
