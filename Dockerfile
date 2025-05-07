# ---------------------------
#  n8n + IMAP support
# ---------------------------
# Base image officielle
FROM n8nio/n8n:latest

# -------------------------------------------------
# 1) Passer root pour installer dépendances système
# -------------------------------------------------
USER root

# apk : utilitaire zip (tu l’avais déjà) + ca-certificates au cas où
RUN apk update && \
    apk add --no-cache zip ca-certificates

# -------------------------------------------------
# 2) Installer les libs Node.js utilisées par le Code node
#    → imap-simple : connexion IMAP
#    → mailparser  : parsing RFC 822 / pièces jointes
# -------------------------------------------------
RUN npm install -g imap-simple mailparser

# -------------------------------------------------
# 3) Autoriser n8n à « require » ces modules dans
#    les Code nodes (sandbox).
#    Sans ça, tu auras l’erreur “Module not allowed”.
# -------------------------------------------------
ENV NODE_FUNCTION_ALLOW_EXTERNAL=imap-simple,mailparser

# -------------------------------------------------
# 4) Revenir à l’utilisateur non-root (sécurité)
# -------------------------------------------------
USER node
