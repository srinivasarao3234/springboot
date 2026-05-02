#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Apache Maven Wrapper startup script for Unix, version 3.2.0
#
# Optional ENV vars
# MAVEN_OPTS - parameters passed to the Java VM when running Maven
#     e.g. to debug Maven itself, use
#     set MAVEN_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000"
# ----------------------------------------------------------------------------

set -e

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false;
darwin=false;
mingw=false;
case "`uname`" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true ;;
  MINGW*) mingw=true ;;
esac

if [ -z "$MAVEN_PROJECTBASEDIR" ]; then
  PRG="$0"

  # need this for relative symlinks
  while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
      PRG="$link"
    else
      PRG="`dirname "$PRG"`/$link"
    fi
  done

  saveddir=`pwd`

  MAVEN_PROJECTBASEDIR=`dirname "$PRG"`

  while [ ! -d "$MAVEN_PROJECTBASEDIR/.mvn" ]; do
    MAVEN_PROJECTBASEDIR=`cd "$MAVEN_PROJECTBASEDIR/.." && pwd`
    if [ "$MAVEN_PROJECTBASEDIR" = "/" ]; then
      MAVEN_PROJECTBASEDIR=`dirname "$PRG"`
      break
    fi
  done

  cd "$saveddir"
fi

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

# If a specific java binary isn't specified search for the standard 'java' binary
if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    JAVACMD="$JAVA_HOME/bin/java"
  else
    JAVACMD="`which java`"
  fi
fi

if [ ! -x "$JAVACMD" ] ; then
  echo "Error: JAVA_HOME is not defined correctly." >&2
  echo "  We cannot execute $JAVACMD" >&2
  exit 1
fi

WRAPPER_JAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_PROPERTIES="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.properties"

if [ ! -f "$WRAPPER_JAR" ]; then
  if [ ! -f "$WRAPPER_PROPERTIES" ]; then
    echo "Error: Cannot find $WRAPPER_PROPERTIES" >&2
    exit 1
  fi
  WRAPPER_URL=`sed -n '/^wrapperUrl=/ s/.*=//p' "$WRAPPER_PROPERTIES"`
  if [ -z "$WRAPPER_URL" ]; then
    echo "Error: Property 'wrapperUrl' not found in $WRAPPER_PROPERTIES" >&2
    exit 1
  fi

  echo "Downloading Maven Wrapper..."
  echo "From: $WRAPPER_URL"
  echo "To:   $WRAPPER_JAR"

  mkdir -p "`dirname "$WRAPPER_JAR"`"

  if which wget > /dev/null 2>&1; then
    wget -O "$WRAPPER_JAR" "$WRAPPER_URL"
  elif which curl > /dev/null 2>&1; then
    curl -o "$WRAPPER_JAR" "$WRAPPER_URL"
  elif which perl > /dev/null 2>&1; then
    perl -e 'use LWP::Simple; getstore($ARGV[0], $ARGV[1]);' "$WRAPPER_URL" "$WRAPPER_JAR"
  elif which python > /dev/null 2>&1; then
    python -c 'import sys,urllib; urllib.urlretrieve(sys.argv[1], sys.argv[2])' "$WRAPPER_URL" "$WRAPPER_JAR"
  else
    echo "Error: No tool found to download the Maven Wrapper (wget, curl, perl, python)" >&2
    exit 1
  fi
fi

exec "$JAVACMD" \
  $MAVEN_OPTS \
  -classpath "$WRAPPER_JAR" \
  "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" \
  org.apache.maven.wrapper.MavenWrapperMain \
  "$@"
