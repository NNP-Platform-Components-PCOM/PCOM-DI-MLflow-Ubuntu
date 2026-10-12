# syntax=docker/dockerfile:1.7
#
# PCOM-DI-MLflow-Ubuntu
# MLflow 2.16.2 tracking server — NNP Data Ingestion namespace.

FROM python:3.11-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION="2.16.2-v1"

LABEL org.opencontainers.image.title="pcom-di-mlflow-ubuntu" \
      org.opencontainers.image.description="MLflow 2.16.2 tracking server for NNP Data Ingestion." \
      org.opencontainers.image.vendor="Nubo Native Platform" \
      org.opencontainers.image.source="https://github.com/NNP-Platform-Components-PCOM/PCOM-DI-MLflow-Ubuntu" \
      org.opencontainers.image.url="https://github.com/NNP-Platform-Components-PCOM/PCOM-DI-MLflow-Ubuntu" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}"

RUN pip install --no-cache-dir mlflow[extras]==2.16.2 boto3 psycopg2-binary

RUN mkdir -p /mlflow/artifacts

EXPOSE 5000

CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "5000", \
     "--backend-store-uri", "sqlite:////mlflow/mlflow.db", \
     "--default-artifact-root", "/mlflow/artifacts"]
