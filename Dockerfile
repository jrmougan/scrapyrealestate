FROM python:3.9-slim-bullseye
LABEL org.opencontainers.image.source=https://github.com/jrmougan/scrapyrealestate

# Adding git, bash and openssh to the image
RUN apt-get update && apt-get install bash curl -y

# Change localtime
RUN cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN echo "Europe/Madrid" > /etc/timezone

# Copy script
RUN mkdir /scrapyrealestate/
ADD . /scrapyrealestate/
WORKDIR /scrapyrealestate/scrapyrealestate/

# upgrade pip and install requirements
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN playwright install
RUN playwright install-deps

EXPOSE 8080

CMD ["python", "./main.py"]