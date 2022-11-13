FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive
RUN echo "===> Installing system dependencies..." && \
    BUILD_DEPS="curl unzip" && \
    apt-get update && apt-get install --no-install-recommends -y \
    python3 python3-pip wget \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libnspr4 libnss3 lsb-release xdg-utils libxss1 libdbus-glib-1-2 libgbm1 \
    $BUILD_DEPS \
    nano
    xvfb && \
    \
    \
    echo "===> Installing geckodriver and firefox..." && \
    #GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-linux64.tar.gz && \
    tar -zxf geckodriver-v0.32.0-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-v0.32.0-linux64.tar.gz && \
    apt-get install -y firefox && \
    \
    \
    #echo "===> Installing phantomjs..." && \
    #wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    #tar -jxf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    #cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
    #rm phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    #\
    #\
    echo "===> Installing python dependencies..." && \
    pip3 install selenium==3.141.0 pyvirtualdisplay==2.2 && \
    \
    \
    echo "===> Remove build dependencies..." && \
    apt-get remove -y $BUILD_DEPS && rm -rf /var/lib/apt/lists/*


ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONUNBUFFERED=1

ENV APP_HOME /usr/src/app
WORKDIR /$APP_HOME

COPY . $APP_HOME/

CMD tail -f /dev/null
# CMD python3 example.py
