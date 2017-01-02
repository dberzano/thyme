FROM centos:centos7
RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
    chmod +x /tmp/get-pip.py                                     && \
    /tmp/get-pip.py                                              && \
    rm -f /tmp/get-pip.py
RUN pip install pika
