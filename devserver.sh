#!/bin/sh
source .venv/bin/activate
python -m flask --app src/main run --host "0.0.0.0" --port "80" --debug
