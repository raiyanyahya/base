from ubuntu:latest
LABEL maintainer="Raiyan Yahya <raiyanyahyadeveloper@gmail.com>"



#need this to generate the locale
ENV DEBIAN_FRONTEND noninteractive

#Update system
RUN apt update -y && apt install software-properties-common -y && apt-get update -y

# Installing build dependencies
RUN apt-get install -y sudo wget git python3-pip curl zsh wget nano lsof


# Prepare environment UTF-8
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Add a dev user and make zsh default
RUN useradd -m -s /bin/zsh --home /home/devuser -G sudo devuser && echo "devuser:devuser" | chpasswd

RUN rm -rf /var/lib/apt/lists/* && \
	apt-get clean && \
	apt-get autoclean && \
	apt-get autoremove
	
USER devuser
ENV TERM xterm
WORKDIR /home/devuser
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
RUN export PATH="$HOME/.local/bin:$PATH"

CMD ["zsh"]
