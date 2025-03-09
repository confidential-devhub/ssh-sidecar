FROM quay.io/fedora/fedora:40

RUN dnf install -y less wget curl openssh-server
RUN mkdir /var/run/sshd

RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -P ""

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
&& sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config \
&& sed -ri 's/^StrictModes\s+.*/StrictModes no/' /etc/ssh/sshd_config \
&& echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
&& echo "GatewayPorts yes" >> /etc/ssh/sshd_config

#ssh-keygen -t ed25519 -f debug-ssh -P "" -C ""
COPY debug-ssh.pub /root/.ssh/authorized_keys

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-De"]
