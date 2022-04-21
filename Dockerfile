FROM nodered/node-red

ENTRYPOINT ["/bootstrap/scripts/docker_entrypoint.sh"]
CMD ["npm", "start", "--", "--userDir", "/data"]

COPY . /bootstrap
