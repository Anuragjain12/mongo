FROM mongo:latest

ENV MONGO_USER=mongodb \
    MONGO_DATA_DIR=/var/lib/mongodb \
    MONGO_LOG_DIR=/var/log/mongodb

//COPY entrypoint.sh /sbin/entrypoint.sh
//RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 27017/tcp
VOLUME ["${MONGO_DATA_DIR}"]
//ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/bin/mongod"]
