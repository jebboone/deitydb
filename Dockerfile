FROM python:3.12-slim

# Pin to 0.65.x: 1.0+ renamed canned_queries → queries and removed the
# /database/query-name URL route, breaking the clean per-query endpoints.
RUN pip install --no-cache-dir "datasette==0.65.2" \
 && adduser --disabled-password --gecos '' datasette

WORKDIR /data
COPY deitydb.sqlite .
COPY metadata.yaml .
COPY VERSION .

COPY templates/ /templates/
COPY static/    /static_files/
COPY plugins/   /plugins/

EXPOSE 8080

USER datasette

CMD ["datasette", "serve", "deitydb.sqlite", \
     "--metadata", "metadata.yaml", \
     "--template-dir", "/templates", \
     "--static", "custom:/static_files", \
     "--plugins-dir", "/plugins", \
     "--setting", "sql_time_limit_ms", "2000", \
     "--setting", "max_returned_rows", "2000", \
     "--host", "0.0.0.0", \
     "--port", "8080", \
     "--cors"]
