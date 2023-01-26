FROM ubuntu


ENV DEBIAN_FRONTEND=nonintercative

RUN apt-get update && apt-get install -y \
	software-properties-common \
	unzip \
	curl \
	xvfb \
	git
	
RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub -o /tmp/google.pub \
    && cat /tmp/google.pub | apt-key add -; rm /tmp/google.pub \
    && echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list \
    && mkdir -p /usr/share/desktop-directories \
    && apt-get -y update && apt-get install -y google-chrome-stable

# Disable the SUID sandbox so that chrome can launch without being in a privileged container
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome \
    && echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --no-sandbox --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome \
    && chmod 755 /opt/google/chrome/google-chrome
 

RUN apt-get update && apt-get install -y \
    python-setuptools \
    python3-pip



COPY ./ /app/

WORKDIR /app/


	
RUN python3 -m pip install pytest

RUN python3 -m pip install webdriver-manager

RUN python3 -m pip install selenium

RUN python3 -m pip install pytest-html

RUN python3 pytest -v -s 






