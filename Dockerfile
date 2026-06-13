FROM python:3.12-slim

# Pin to 0.65.x: 1.0+ renamed canned_queries → queries and removed the
# /database/query-name URL route, breaking the clean per-query endpoints.
RUN pip install --no-cache-dir "datasette==0.65.2"

WORKDIR /data
COPY deitydb.sqlite .
COPY metadata.yaml .

EXPOSE 8080

CMD ["datasette", "serve", "deitydb.sqlite", \
     "--metadata", "metadata.yaml", \
     "--host", "0.0.0.0", \
     "--port", "8080", \
     "--cors"]
