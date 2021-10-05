FROM elasticsearch:6.8.18

ARG BUILD_DATE="2021-10-05T16:27:44Z"
ARG VERSION="6.8.18"

RUN set -xe && \
  bin/elasticsearch-plugin install  --batch ingest-attachment && \
  yum update -y && \
  #dnf install dnf-plugins-core -y && \
  yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/Alexander_Pozdnyakov/CentOS_$(rpm --eval '%{centos_ver}')/ && \
  rpm --import https://build.opensuse.org/projects/home:Alexander_Pozdnyakov/public_key && \
  yum update -y && \
  yum install tesseract tesseract-langpack-* -y && \
  yum clean all && \
  rm -rf /tmp/* \
     /var/cache/dnf/* \
     /var/log/*.log
