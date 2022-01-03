ARG BUILD_DATE="2022-01-03T07:23:34Z"
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
