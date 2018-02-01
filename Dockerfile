FROM alpine
LABEL zwindler.dynhost.version="0.1"
LABEL maintainer="zwindler"

RUN apk add --no-cache curl bind-tools && mkdir -p /usr/local/dynhost
COPY dynhost /usr/local/dynhost/dynhost

#If dynhost.cfg was specified at docker run, should superseed any ENV
#If not, ENV statements should be used
#HOST DYNHOST.VOTREDOMAIN.FR
#LOGIN VOTREDOMAINOVH-LOGIN
#PASSWORD VOTREMDP
ENV LOG_FILE /usr/local/dynhost/dynhost.log
ENV PATH /usr/local/dynhost:$PATH

#Run script. 
ENTRYPOINT ["/usr/local/dynhost/dynhost", "/usr/local/dynhost/conf.d/dynhost.cfg"]
