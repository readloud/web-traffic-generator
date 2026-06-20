# AUTHOR(s): Russell Johnston <rujohns2@cisco.com>
#     

FROM python:alpine

LABEL com.cisco.author="Russell Johnston <rujohns2@cisco.com>"

WORKDIR /usr/src/app

ENV URL="https://google.ca" \
    SLEEP="5" \
    LOG="INFO"

COPY requirements.txt . / \
    main.py ./

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

CMD python ./main.py --sleep $SLEEP -l $LOG $URL
