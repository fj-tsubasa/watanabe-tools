#/bin/bash

# Create a test file
echo "NOT modified tar file " >> testfile1
touch prevent_error_tarball

# Create Dockerfile for test
dockerfile=Dockerfile

# Add testfile in Dockerfile
cat >$dockerfile <<EOF
FROM quay.io/libpod/alpine
ADD testfile1 /tmp
# ADD prevent_error_tarball /tmp
WORKDIR /tmp
EOF

# Build from Dockerfile 
echo "================================="
echo "podman build -t testimg -f $dockerfile"
echo "================================="
podman build -t testimg -f $dockerfile 
echo "================================="
echo
echo "================================="
echo "# podman run -d --name testcnt testimg sleep 60"
echo "================================="
podman run -d --name testcnt testimg sleep 60 
echo "================================="
echo

# Export built container as tarball
echo "================================="
echo "# podman export -o testcnt.tar testcnt"
echo "================================="
podman export -o testcnt.tar testcnt
podman rm -fa
echo "================================="
echo

echo "================================="
echo "# tar -tvf testcnt.tar testcnt"
echo "================================="
tar -tvf testcnt.tar | grep tmp/
echo "================================="
echo

echo "================================="
echo "# tar --delete -f testcnt.tar tmp/testfile1"
echo "================================="
tar --delete -f testcnt.tar tmp/testfile1
echo
echo "================================="
echo "# tar -tvf testcnt.tar testcnt"
echo "================================="
tar -tvf testcnt.tar | grep tmp/ 
echo "================================="
