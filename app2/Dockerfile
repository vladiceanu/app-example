FROM python:2.7-alpine

RUN pip install --upgrade pip flask flask-log-request-id
COPY app/script.py /app/script.py

WORKDIR /app
EXPOSE 8080

ENTRYPOINT [ "python" ]
CMD [ "script.py" ]