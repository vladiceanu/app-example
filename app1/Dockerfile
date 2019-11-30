FROM python:2.7-alpine

RUN pip install --upgrade pip flask==1.1.1 flask-log-request-id==0.10.1
COPY app/script.py /app/script.py

WORKDIR /app
EXPOSE 8080

ENTRYPOINT [ "python" ]
CMD [ "script.py" ]
