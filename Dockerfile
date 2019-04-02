FROM nodered/node-red-docker

ENTRYPOINT ["/bootstrap/scripts/docker_entrypoint.sh"]
CMD ["npm", "start", "--", "--userDir", "/data"]

VOLUME /bootstrap/etc

COPY . /bootstrap
