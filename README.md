# Introduction

SSH server sidecar helper to use for securely connecting to CoCo pod.

- Generate SSH key pair

The following command will create debug-ssh.pub and debug-ssh.

```sh
ssh-keygen -t ed25519 -f debug-ssh -P "" -C ""
```

- Build the container image

Run the following command to generate the image.
Note down the host key fingerprint. You'll need to use this to verify the connection. 

For the current image, the host key fingerprint is shown below

```sh
docker build --progress=plain --no-cache -t quay.io/bpradipt/ssh-server -f Dockerfile .

[snip]
#8 0.160 The key fingerprint is:
#8 0.160 SHA256:PwPXQLwarrwxW7tOVT6tAhEkpo/Nae2F+mH5oWqM6sE root@buildkitsandbox
```

- Connect to the server

```sh
ssh -i debug-ssh root@<ip>
```
