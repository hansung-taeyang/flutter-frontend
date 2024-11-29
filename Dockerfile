FROM ubuntu:latest AS build
# Flutter SDK를 설치하기 위한 필수 도구 설치

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    ca-certificates git unzip curl xz-utils libglu1-mesa zip &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 flutter
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"
RUN flutter doctor

WORKDIR /app
COPY . .
RUN echo 'const address = "54.180.237.192:80";' > lib/const/server_address.dart
RUN flutter pub get
RUN flutter build web

# NGINX 설정
FROM nginx:alpine
COPY --from=build  /app/build/web /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf

# NGINX를 실행
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
