FROM python:3.9-alpine

WORKDIR /app

COPY requirements.txt .

RUN apk update && apk add python3-dev gcc libc-dev libffi-dev

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_RUN_HOST=0.0.0.0

EXPOSE 5000

ENTRYPOINT [ "python3" ]

CMD ["-m", "flask", "run", "--host=0.0.0.0" ]