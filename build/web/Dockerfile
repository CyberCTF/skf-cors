# Overlay of the vendored app/Dockerfile (unchanged upstream), built with app/ as its context.
# One difference: it creates /ctf owned by the lab user, for the per-player flag.

### Static layers

FROM alpine:3.7 AS skf-alpine37
LABEL Glenn ten Cate <glenn.ten.cate@owasp.org>

# Installing needed binaries and deps. Then removing unneeded deps:
RUN apk update --no-cache && apk add python3 python3-dev py3-pip bash git dos2unix

### Dynamic layers
FROM skf-alpine37
LABEL Glenn ten Cate <glenn.ten.cate@owasp.org>

RUN addgroup -g 1000 app 
RUN adduser -u 1000 -G app -D -h /home/app app
RUN rm -rf /var/cache/apk/APKINDEX*

COPY ./ /home/app/CORS

# Switching to the new app location:
WORKDIR /home/app/CORS

RUN chown -R app:app /home/app/CORS

# Switching to the limited user
# Overlay: the flag folder /ctf, owned by the lab user so the flag init (which runs as that user) can write it.
RUN mkdir -p /ctf && chown app:app /ctf

USER app

# Installing needed binaries and deps
RUN pip3 install --no-cache-dir  --user -r requirements.txt 

# Fixing Windows line endings for our students:
RUN find . -name "*.sh" -o -name "*.py" -o -name "*.css" -o -name "*.js" | xargs dos2unix

# Setting chmod +x on the scripts:
RUN find . -name "*.sh" -o -name "*.py" | xargs chmod +x

# Starting the actual application:
ENTRYPOINT [ "python3", "./CORS.py" ]
