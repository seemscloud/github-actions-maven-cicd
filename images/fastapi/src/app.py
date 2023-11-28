from fastapi import FastAPI
from elasticapm.contrib.starlette import make_apm_client, ElasticAPM
import os

apm_server = os.getenv('APM_SERVER') or 'apm:8200'
service_name = os.getenv('SERVICE_NAME') or 'fastapi'
env_name = os.getenv('ENV_NAME') or 'staging'

apm = make_apm_client({
    'SERVER_URL': apm_server,
    'SERVICE_NAME': service_name,
    'ENVIRONMENT': env_name,
    'SERVER_TIMEOUT': '5s',
    'ENABLED': 'true',
    'LOG_LEVEL': 'trace',
    'LOG_FILE_SIZE': '100mb'
})

app = FastAPI()
app.add_middleware(ElasticAPM, client=apm)


@app.get('/')
def read_root():
    return 'fastapi'
