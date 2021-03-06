#/bin/bash

# Copyright (c) 2022, ninckblokje
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.

# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

echo "Starting my first container..."

CGROUP_ROOT=/sys/fs/cgroup
MFC_CGROUP=$CGROUP_ROOT/mfc
MFC_CGROUP_MEMORY_MAX=2097152
PID=$BASHPID

echo "* Preparing cgroups for PID $PID (requires root)"
sudo mkdir -p "$MFC_CGROUP"
echo $MFC_CGROUP_MEMORY_MAX | sudo tee "$MFC_CGROUP/memory.max" > /dev/null
echo $MFC_CGROUP_MEMORY_MAX | sudo tee "$MFC_CGROUP/memory.swap.max" > /dev/null
echo $PID | sudo tee "$MFC_CGROUP/cgroup.procs" > /dev/null

echo "* Unsharing"
unshare --cgroup --ipc --mount --net --pid --time --user --uts --map-root-user --fork $PWD/mfc-bootstrap.sh

echo "Done"
