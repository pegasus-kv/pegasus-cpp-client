#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

cd `dirname $0`
DSN_ROOT=../../rdsn

if [ ! -d "$DSN_ROOT" ]; then
  echo "ERROR: DSN_ROOT not set"
  exit 1
fi

TMP_DIR=./tmp
rm -rf $TMP_DIR

mkdir -p $TMP_DIR
$DSN_ROOT/thirdparty/output/bin/thrift --gen cpp:moveable_types -out $TMP_DIR rrdb.thrift

sed 's/#include "dsn_types.h"/#include <dsn\/service_api_cpp.h>/' $TMP_DIR/rrdb_types.h > ../include/rrdb/rrdb_types.h
sed 's/#include "rrdb_types.h"/#include <rrdb\/rrdb_types.h>/' $TMP_DIR/rrdb_types.cpp > ../base/rrdb_types.cpp

rm -rf $TMP_DIR

echo
echo "You should manually modify these files:"
echo "  src/include/rrdb/rrdb.code.definition.h"
echo "  src/include/rrdb/rrdb.client.h"
echo
echo "done"
