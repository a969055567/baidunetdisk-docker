 FROM jlesage/baseimage-gui:debian-9


# FROM jlesage/baseimage-gui:ubuntu-22.04-v4

ENV VERSION=4.17.7
ENV URI=https://7f6a3e-3031625748.antpcdn.com:19001/b/pkg-ant.baidu.com/issue/netdisk/LinuxGuanjia/$VERSION/baidunetdisk_${VERSION}_amd64.deb

ENV DISPLAY=":1"
ENV ENABLE_CJK_FONT=1
ENV TZ=Asia/Shanghai

# RUN sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list && \
# sed -i "s@http://security.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list

# RUN  cat  /etc/apt/sources.list 

RUN  mv  /etc/apt/sources.list /etc/apt/sources.list_bak 

COPY . .
ADD sources.list /etc/apt/

RUN     apt-get update 
RUN     apt-get install -y --no-install-recommends wget                  
RUN     apt-get install -y --no-install-recommends desktop-file-utils    
RUN     apt-get install -y --no-install-recommends libasound2-dev        
RUN     apt-get install -y --no-install-recommends locales               
RUN     apt-get install -y --no-install-recommends fonts-wqy-zenhei         
RUN     apt-get install -y --no-install-recommends libgtk-3-0            
RUN     apt-get install -y --no-install-recommends libnotify4            
RUN     apt-get install -y --no-install-recommends libnss3               
RUN     apt-get install -y --no-install-recommends libxss1               
RUN     apt-get install -y --no-install-recommends libxtst6              
RUN     apt-get install -y --no-install-recommends xdg-utils             
RUN     apt-get install -y --no-install-recommends libatspi2.0-0         
RUN     apt-get install -y --no-install-recommends libuuid1                
RUN     apt-get install -y --no-install-recommends libappindicator3-1    
RUN     apt-get install -y --no-install-recommends libsecret-1-0         
RUN     rm -rf /var/lib/apt/lists/*

COPY . .
ADD  baidunetdisk_4.17.7_amd64.deb  /defaults/baidunetdisk.deb 



RUN  apt-get install -y /defaults/baidunetdisk.deb \
    && rm /defaults/baidunetdisk.deb 

RUN \
    APP_ICON_URL='https://raw.githubusercontent.com/KevinLADLee/baidunetdisk-docker/master/logo.png' && \
    install_app_icon.sh "$APP_ICON_URL"

COPY rootfs/ /

ENV APP_NAME="BaiduNetdisk" \
    S6_KILL_GRACETIME=8000

WORKDIR /config

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/downloads"]
