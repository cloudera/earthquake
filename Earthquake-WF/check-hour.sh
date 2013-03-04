#!/bin/bash -e

#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

earthquakeMin="$1"

curl http://earthquake.usgs.gov/earthquakes/feed/csv/all/hour -o "hour.txt" -s -S -f

numLines=`cat hour.txt | wc -l`
if [ $numLines \< 2 ]
then
    echo "isLarger=false"
else
    largest=`tail -n +2 hour.txt | cut -f 5 -d "," | sort -n | tail -n -1`
    compare=`echo $largest '>=' $earthquakeMin | bc -l`
    if [ "$compare" == "1" ]
    then
        echo "largest=$largest"
        echo "isLarger=true"
    else
        echo "isLarger=false"
    fi
fi
