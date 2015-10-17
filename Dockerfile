#
# config-nginx-etc-client
#
# A simple update client that works with the [M2i3 Config Server](https://github.com/M2i3/config-server)
#

FROM ubuntu:trusty
MAINTAINER Jean-Marc Lagace <jean-marc@m2i3.com>

# ensure the right locale 
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8 && apt-get install -y wget

ADD /bin/ /usr/lib/nginx-etc-update/
RUN chmod +x /usr/lib/nginx-etc-update/

ENV REFRESH_DELAY 10 
ENV CONFIG_URL    "REPLACE ME"

# Cleanup afterward (to make the image as slim as possible)
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Trigger the script in /etc/nginx (that's the only place the script will work anyway)
WORKDIR /etc/nginx/
CMD ["/usr/lib/nginx-etc-update/do-nginx-etc-refresh"]