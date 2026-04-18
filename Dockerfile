FROM cm2network/steamcmd:root

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        wine \
        wine32:i386 \
        wine64 \
        xvfb \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh "/entrypoint.sh"
RUN chmod +x "/entrypoint.sh" \
 && chown -R "${USER}:${USER}" "${HOMEDIR}" "/entrypoint.sh"

USER ${USER}

EXPOSE 30000/udp

CMD ["bash", "/entrypoint.sh"]
