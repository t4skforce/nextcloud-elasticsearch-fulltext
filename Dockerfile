FROM elasticsearch:

ARG BUILD_DATE=""
ARG VERSION=""

RUN set -xe && \
  bin/elasticsearch-plugin install  --batch ingest-attachment && \
  dnf update -y && \
  dnf install dnf-plugins-core -y && \
  dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/Alexander_Pozdnyakov/CentOS_$(rpm --eval '%{centos_ver}')/ && \
  rpm --import https://build.opensuse.org/projects/home:Alexander_Pozdnyakov/public_key && \
  dnf update -y && \
  dnf install tesseract tesseract-langpack-* -y && \
  dnf clean all && \
  rm -rf /tmp/* \
     /var/cache/dnf/* \
     /var/log/*.log
