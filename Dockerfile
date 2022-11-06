FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates

# Extras
RUN apk add --no-cache curl

# Timezone (TZ)
RUN apk update && apk add --no-cache tzdata
ENV TZ=US/Eastern
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Bash shell & dependancies
RUN apk add --no-cache bash busybox-suid su-exec

#Set Slinger env variables
ENV SLINGER_CONF=/config
ENV SLINGER_APP=/usr/src/app

#Add Slinger dependancies
RUN apk add py3-pip
RUN apk add py3-netifaces
RUN pip3 install --upgrade pip
RUN pip3 install flask

# Download the source code
RUN apk add --no-cache git
RUN git clone https://github.com/harpua555/Slinger.git $SLINGER_APP
#COPY . $SLINGER_APP
WORKDIR $SLINGER_APP

# Create working directories for Slinger
RUN mkdir $SLINGER_CONF
RUN chmod a+rwX $SLINGER_CONF

# Configure container volume mappings
VOLUME $SLINGER_CONF

# Set executable permissions
RUN chmod +x entrypoint.sh

# Set port 55059 in slinger config!
EXPOSE 55059

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]
