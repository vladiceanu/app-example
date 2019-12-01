FROM python:2.7-alpine

RUN pip install --upgrade pip flask==1.1.1 flask-log-request-id==0.10.1 urllib3==1.25.7
COPY app/app.py /app/app.py

WORKDIR /app
EXPOSE 8080

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]