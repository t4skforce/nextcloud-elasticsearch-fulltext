ARG BUILD_DATE="2021-10-07T06:23:44Z"
ARG VERSION="7.14.1"

FROM elasticsearch:${VERSION}

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
       rm -rf /tmp/* \
          /var/log/*.log \
       ;; \
    *) \
       dnf update -y && \
       dnf install dnf-plugins-core -y && \
       dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/Alexander_Pozdnyakov/$osVer/ && \
       rpm --import https://build.opensuse.org/projects/home:Alexander_Pozdnyakov/public_key && \
       dnf update -y && \
       dnf install tesseract tesseract-langpack-* -y && \
       dnf clean all && \
       rm -rf /tmp/* \
          /var/cache/dnf/* \
          /var/log/*.log \
       ;; \
  esac; \
