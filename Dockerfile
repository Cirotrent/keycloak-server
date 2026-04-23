FROM quay.io/keycloak/keycloak:26.6.0

# Copia il realm export dentro il container
COPY realm-export.json /opt/keycloak/data/import/

# Variabili base (override anche su Render)
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

ENV KC_BOOTSTRAP_ADMIN_USERNAME=admin
ENV KC_BOOTSTRAP_ADMIN_PASSWORD=admin

# Database (sarà sovrascritto da Render env vars)
ENV KC_DB=postgres

# IMPORTANTE: per Render serve proxy edge
ENV KC_PROXY=edge

# hostname pubblico (Render lo sovrascrive da env KC_HOSTNAME)
ENV KC_HOSTNAME=localhost

# build ottimizzata (OBBLIGATORIO per production mode)
RUN /opt/keycloak/bin/kc.sh build

# avvio con import automatico realm
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized", "--import-realm", "--http-enabled=true", "--hostname-strict=false","--http-port=8080"]
