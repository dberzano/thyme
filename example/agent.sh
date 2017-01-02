#!/bin/bash
echo 'Using the proxy'
mkdir -p /tmp
export ALIEN_USER=aliprod
file=/tmp/proxy.$$.`date +%s`
cat >$file <<EOF
-----BEGIN CERTIFICATE-----
YABBAYABBA
-----END CERTIFICATE-----
-----BEGIN RSA PRIVATE KEY-----
YABBAYABBA
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
YABBAYABBA
-----END CERTIFICATE-----

EOF
chmod 0400 $file
export X509_USER_PROXY=$file;
echo USING $X509_USER_PROXY
echo "=== env ==="
env
echo WOULD EXECUTE -- /cvmfs/alice.cern.ch/bin/alienv --alien-version v2-19-276 -alien -c ALIEN_DEBUG='-d:Trace' alien proxy-info
echo WOULD EXECUTE -- /cvmfs/alice.cern.ch/bin/alienv --alien-version v2-19-276 -alien -c ALIEN_DEBUG='-d:Trace' alien RunAgent
echo "=== sleep 100 ==="
sleep 100


rm -rf $file
