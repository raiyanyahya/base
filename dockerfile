from ubuntu:18.04
LABEL maintainer="Raiyan Yahya <raiyanyahyadeveloper@gmail.com>"

RUN apt update -y &&  apt-get update -y
RUN apt-get install --no-install-recommends -y sudo wget git python3-pip curl zsh wget nano lsof software-properties-common && \
        rm -rf /var/lib/apt/lists/* && \
	apt-get clean && \
        apt-get autoclean && \
        apt-get autoremove

RUN useradd -m -s /bin/zsh --home /home/devuser -G sudo devuser && echo "devuser:devuser" | chpasswd
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

USER devuser
ENV TERM xterm
WORKDIR /home/devuser
#RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> .zshrc

CMD ["zsh"]
