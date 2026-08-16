# Use the official FUXA Docker image
FROM frangoteam/fuxa:1.3.4

# run script in to include ENV BASE_PATH var
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Start FUXA
ENTRYPOINT ["/run.sh"]
