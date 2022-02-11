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

OLD_ROOT_PATH=/old_root

CTR_ROOT_DIR=$PWD/ctr_root
NEW_ROOT_DIR=$PWD/new_root
OLD_ROOT_DIR=$NEW_ROOT_DIR/$OLD_ROOT_PATH

echo "* Setting hostname"
hostname my-first-container

echo "* Mounting root"
mount --bind "$NEW_ROOT_DIR" "$NEW_ROOT_DIR"
cd "$NEW_ROOT_DIR"

echo "* Pivoting root"
pivot_root . "$OLD_ROOT_DIR"

echo "* Mounting proc"
mount -t proc proc /proc

echo "* Unmounting old root"
umount -l "$OLD_ROOT_PATH"

echo "You're in!"
exec /bin/sh
