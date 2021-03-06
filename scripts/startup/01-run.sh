#!/bin/bash

export APEX_HOME=$ORACLE_BASE/product/apex
export ORDS_HOME=$ORACLE_BASE/product/ords
export JAVA_HOME=$ORACLE_BASE/product/java/latest
export SCRIPT_DIR=$SCRIPTS_ROOT
export FILES_DIR=/tmp/files
export PATH=$JAVA_HOME/bin:$PATH

echo "##### Install dependencies if required #####"
if [ ! -d $JAVA_HOME ]; then
  JAVA_DIR_NAME=`tar -tzf $FILES_DIR/$INSTALL_FILE_JAVA | head -1 | cut -f1 -d"/"`
  mkdir -p $ORACLE_BASE/product/java
  tar zxf $FILES_DIR/$INSTALL_FILE_JAVA --directory $ORACLE_BASE/product/java
  ln -s $ORACLE_BASE/product/java/$JAVA_DIR_NAME $JAVA_HOME
fi

# Extract files
echo "##### Extracting files if required ####"

if [ ! -d $APEX_HOME ]; then
    echo "##### Unpacking APEX files #####"
  unzip -q $FILES_DIR/$INSTALL_FILE_APEX -d $ORACLE_BASE/product
  chown -R oracle:oinstall $APEX_HOME
fi

if [ ! -d $ORDS_HOME ]; then
  echo "##### Unpacking ORDS files #####"
  mkdir -p $ORDS_HOME
  unzip -q $FILES_DIR/$INSTALL_FILE_ORDS -d $ORDS_HOME
  chown -R oracle:oinstall $ORDS_HOME
fi

# Run ORDS
echo "##### Starting ORDS #####"
if [ $UID = "0" ]; then
  runuser oracle -m -s /bin/bash -c ". $SCRIPT_DIR/package/runOrds.sh"
else
  . $SCRIPT_DIR/package/runOrds.sh
fi