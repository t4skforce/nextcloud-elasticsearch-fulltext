FROM elasticsearch:6.8.18

ARG BUILD_DATE="2021-10-06T06:23:35Z"
ARG VERSION="6.8.18"

RUN set -xe && \
  bin/elasticsearch-plugin install  --batch ingest-attachment && \
  osVer="CentOS_$(rpm --eval '%{centos_ver}')"; \
  case "$osVer" in \
    CentOS_7) \
       yum update -y && \
       yum-config-manager --add-repo https://download.opensuse.org/repositories/home:/Alexander_Pozdnyakov/$osVer/ && \
       rpm --import https://build.opensuse.org/projects/home:Alexander_Pozdnyakov/public_key && \
       yum update -y && \
       yum install tesseract tesseract-langpack-* -y && \
       yum clean all && \
       ;; \
    *) 
       dnf update -y && \
       dnf install dnf-plugins-core -y && \
       dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/Alexander_Pozdnyakov/$osVer/ && \
       rpm --import https://build.opensuse.org/projects/home:Alexander_Pozdnyakov/public_key && \
       dnf update -y && \
       dnf install tesseract tesseract-langpack-* -y && \
       dnf clean all && \
       ;; \
  esac; \
  rm -rf /tmp/* \
     /var/cache/dnf/* \
     /var/log/*.log
