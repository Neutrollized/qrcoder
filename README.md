# QRCoder

Not happy with some of the options out there, I decided to make my own

**NOTE:** GCS bucket needs to have fine grained control


## Setup
```console
python -m venv .venv
source venv/bin/activate
pip install -r requirements.txt
```

Exec `devserver.sh` to run the app locally.  You can then access it locally at **http://127.0.0.1:80** (or whatever you set the `--host` and `--port` values to)


## Docker
```console
docker build -t qrcoder:latest .
```
