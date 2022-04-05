FROM python:3.10.4-slim as builder

WORKDIR /opt
COPY requirements.txt /opt/

RUN apt update && apt upgrade -y
RUN pip3 install -r /opt/requirements.txt

FROM python:3.10.4-slim
## ビルド用イメージ内でPythonモジュールをビルドした際のキャッシュを利用する

WORKDIR /opt

## Pythonモジュールで使用するライブラリをコピー
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/share/ /usr/local/share/
COPY --from=builder /opt /opt/

CMD ["/bin/bash"]