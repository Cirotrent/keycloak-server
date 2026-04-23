
FROM quay.io/keycloak/keycloak:25.0.6

COPY realm-export.json /opt/keycloak/data/import/

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

ENTRYPOINT ["sh", "-c", "/opt/keycloak/bin/kc.sh start --optimized --import-realm"]
