ARG BUILD_DATE="2021-12-28T07:24:13Z"
ARG VERSION="7.16.2"

FROM elasticsearch:7.16.2

RUN set -xe && \
  bin/elasticsearch-plugin install  --batch ingest-attachment && \
  osVer="CentOS_$(rpm --eval '%{centos_ver}')"; \
  case "$osVer" in \
    CentOS_7) \
       yum update -y && \
       yum clean all && \
       rm -rf /tmp/* \
          /var/log/*.log \
       ;; \
    *) \
       dnf update -y && \
       dnf clean all && \
       rm -rf /tmp/* \
          /var/cache/dnf/* \
          /var/log/*.log \
       ;; \
  esac; \
