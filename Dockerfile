FROM python:3.12-slim

RUN pip install --no-cache-dir datasette

WORKDIR /data
COPY deitydb.sqlite .
COPY metadata.yaml .

EXPOSE 8080

CMD ["datasette", "serve", "deitydb.sqlite", \
     "--metadata", "metadata.yaml", \
     "--host", "0.0.0.0", \
     "--port", "8080", \
     "--cors"]
