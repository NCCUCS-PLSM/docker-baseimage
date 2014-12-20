#!/bin/bash
set -e
source /build/buildconfig
set -x

JDK_DOWNLOAD_URL=http://www.java.net/download/jdk7u80/archive/b03/binaries/jdk-7u80-ea-bin-b03-linux-x64-19_nov_2014.tar.gz
JDK_INSTALL_BASEDIR=/usr/lib/jvm
INSTALL_COMMANDS="java javac javadoc javah javap jps" 

if [[ $JDK_DOWNLOAD_URL =~ .+/(.+-([0-9])u([0-9]+)-.+)$ ]]; 
then 
  JDK_FILENAME=${BASH_REMATCH[1]} ; 
  JDK_MAJOR_VERION=${BASH_REMATCH[2]} ;
  JDK_MINOR_VERSION=${BASH_REMATCH[3]} ;
else 
  echo "Error finding jdk filename"; 
fi

JCE_DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jce/${JDK_MAJOR_VERION}/jce_policy-${JDK_MAJOR_VERION}.zip

if [[ $JCE_DOWNLOAD_URL =~ .+/(.+)$ ]]; 
then 
  JCE_FILENAME=${BASH_REMATCH[1]} ; 
else 
  echo "Error finding jce filename"; 
fi

$minimal_apt_get_install unzip wget
JAVA_INSTALL_DIR=java-${JDK_MAJOR_VERION}-oracle-amd64
JAVA_UNTAR_DIR=jdk1.${JDK_MAJOR_VERION}.0_${JDK_MINOR_VERSION}
wget --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" $JDK_DOWNLOAD_URL
mkdir -p ${JDK_INSTALL_BASEDIR}
tar -zxf $JDK_FILENAME
mv ${JAVA_UNTAR_DIR} ${JDK_INSTALL_BASEDIR}/${JAVA_INSTALL_DIR}
rm -rf $JDK_FILENAME

JCE_UNZIP_DIR=UnlimitedJCEPolicyJDK${JDK_MAJOR_VERION}
wget --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" $JCE_DOWNLOAD_URL
unzip $JCE_FILENAME
mv ${JCE_UNZIP_DIR}/*.jar ${JDK_INSTALL_BASEDIR}/${JAVA_INSTALL_DIR}/jre/lib/security 
rm -rf ${JCE_FILENAME} ${JCE_UNZIP_DIR} 

add_java_bin_link() {
  update-alternatives --install /usr/local/bin/${1} $1 ${JDK_INSTALL_BASEDIR}/${JAVA_INSTALL_DIR}/bin/${1} 1${JDK_MAJOR_VERION}${JDK_MINOR_VERSION}
}

for COMMAND in $INSTALL_COMMANDS
do
  update-alternatives --install /usr/local/bin/${COMMAND} $COMMAND ${JDK_INSTALL_BASEDIR}/${JAVA_INSTALL_DIR}/bin/${COMMAND} 1${JDK_MAJOR_VERION}${JDK_MINOR_VERSION}
done

echo "export JAVA_HOME=${JDK_INSTALL_BASEDIR}/${JAVA_INSTALL_DIR};" >> ~/.bashrc
